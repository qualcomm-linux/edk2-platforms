/** @file
  Platform PEI driver

  Copyright (c) 2022 Loongson Technology Corporation Limited. All rights reserved.<BR>

  SPDX-License-Identifier: BSD-2-Clause-Patent

  @par Glossary:
    - Mem - Memory
**/

//
// The package level header files this module uses
//
#include <PiPei.h>
//
// The Library classes this module consumes
//
#include <Library/DebugLib.h>
#include <Library/HobLib.h>
#include <Library/IoLib.h>
#include <Library/MemoryAllocationLib.h>
#include <Library/BaseMemoryLib.h>
#include <Library/PcdLib.h>
#include <Library/PeimEntryPoint.h>
#include <Library/PeiServicesLib.h>
#include <Library/ResourcePublicationLib.h>
#include <Guid/MemoryTypeInformation.h>
#include <Library/QemuFwCfgLib.h>
#include <Library/MmuLib.h>
#include <Guid/FdtHob.h>
#include <libfdt.h>
#include <Ppi/MasterBootMode.h>

#include "Platform.h"

/* TODO */
EFI_MEMORY_TYPE_INFORMATION mDefaultMemoryTypeInformation[] = {
  { EfiReservedMemoryType,  0x004 },
  { EfiRuntimeServicesData, 0x024 },
  { EfiRuntimeServicesCode, 0x030 },
  { EfiBootServicesCode,    0x180 },
  { EfiBootServicesData,    0xF00 },
  { EfiMaxMemoryType,       0x000 }
};

//
// Module globals
//
CONST EFI_PEI_PPI_DESCRIPTOR  mPpiListBootMode = {
  (EFI_PEI_PPI_DESCRIPTOR_PPI | EFI_PEI_PPI_DESCRIPTOR_TERMINATE_LIST),
  &gEfiPeiMasterBootModePpiGuid,
  NULL
};

STATIC EFI_BOOT_MODE  mBootMode = BOOT_WITH_FULL_CONFIGURATION;

/**
  Create Reserved type memory range hand off block.

  @param  MemoryBase    memory base address.
  @param  MemoryLimit  memory length.

  @return  VOID
**/
VOID
AddReservedMemoryBaseSizeHob (
  EFI_PHYSICAL_ADDRESS        MemoryBase,
  UINT64                      MemorySize
  )
{
  BuildResourceDescriptorHob (
    EFI_RESOURCE_MEMORY_RESERVED,
    EFI_RESOURCE_ATTRIBUTE_PRESENT     |
    EFI_RESOURCE_ATTRIBUTE_INITIALIZED |
    EFI_RESOURCE_ATTRIBUTE_UNCACHEABLE |
    EFI_RESOURCE_ATTRIBUTE_TESTED,
    MemoryBase,
    MemorySize
    );
}
/**
  Create system type  memory range hand off block.

  @param  MemoryBase    memory base address.
  @param  MemoryLimit  memory length.

  @return  VOID
**/
VOID
AddMemoryBaseSizeHob (
  EFI_PHYSICAL_ADDRESS        MemoryBase,
  UINT64                      MemorySize
  )
{
  BuildResourceDescriptorHob (
    EFI_RESOURCE_SYSTEM_MEMORY,
    EFI_RESOURCE_ATTRIBUTE_PRESENT |
    EFI_RESOURCE_ATTRIBUTE_INITIALIZED |
    EFI_RESOURCE_ATTRIBUTE_UNCACHEABLE |
    EFI_RESOURCE_ATTRIBUTE_WRITE_COMBINEABLE |
    EFI_RESOURCE_ATTRIBUTE_WRITE_THROUGH_CACHEABLE |
    EFI_RESOURCE_ATTRIBUTE_WRITE_BACK_CACHEABLE |
    EFI_RESOURCE_ATTRIBUTE_TESTED,
    MemoryBase,
    MemorySize
    );
}

/**
  Create  memory range hand off block.

  @param  MemoryBase    memory base address.
  @param  MemoryLimit  memory length.

  @return  VOID
**/
VOID
AddMemoryRangeHob (
  EFI_PHYSICAL_ADDRESS        MemoryBase,
  EFI_PHYSICAL_ADDRESS        MemoryLimit
  )
{
  AddMemoryBaseSizeHob (MemoryBase, (UINT64) (MemoryLimit - MemoryBase));
}
/**
  Create  memory type information hand off block.

  @param  VOID

  @return  VOID
**/
VOID
MemMapInitialization (
  VOID
  )
{
  DEBUG ((DEBUG_INFO, "==%a==\n", __func__));
  //
  // Create Memory Type Information HOB
  //
  BuildGuidDataHob (
    &gEfiMemoryTypeInformationGuid,
    mDefaultMemoryTypeInformation,
    sizeof (mDefaultMemoryTypeInformation)
    );
}
/** Get the UART base address of the console serial-port from the DT.

  This function fetches the node referenced in the "stdout-path"
  property of the "chosen" node and returns the base address of
  the console UART.

  @param [in]   Fdt                   Pointer to a Flattened Device Tree (Fdt).
  @param [out]  SerialConsoleAddress  If success, contains the base address
                                      of the console serial-port.

  @retval EFI_SUCCESS             The function completed successfully.
  @retval EFI_NOT_FOUND           Console serial-port info not found in DT.
  @retval EFI_INVALID_PARAMETER   Invalid parameter.
**/
STATIC
EFI_STATUS
EFIAPI
GetSerialConsolePortAddress (
  IN  CONST VOID    *Fdt,
  OUT       UINT64  *SerialConsoleAddress
  )
{
  CONST CHAR8   *Prop;
  INT32         PropSize;
  CONST CHAR8   *Path;
  INT32         PathLen;
  INT32         ChosenNode;
  INT32         SerialConsoleNode;
  INT32         Len;
  CONST CHAR8   *NodeStatus;
  CONST UINT64  *RegProperty;

  if ((Fdt == NULL) || (fdt_check_header (Fdt) != 0)) {
    return EFI_INVALID_PARAMETER;
  }

  // The "chosen" node resides at the root of the DT. Fetch it.
  ChosenNode = fdt_path_offset (Fdt, "/chosen");
  if (ChosenNode < 0) {
    return EFI_NOT_FOUND;
  }

  Prop = fdt_getprop (Fdt, ChosenNode, "stdout-path", &PropSize);
  if (PropSize < 0) {
    return EFI_NOT_FOUND;
  }

  // Determine the actual path length, as a colon terminates the path.
  Path = ScanMem8 (Prop, ':', PropSize);
  if (Path == NULL) {
    PathLen = AsciiStrLen (Prop);
  } else {
    PathLen = Path - Prop;
  }

  // Aliases cannot start with a '/', so it must be the actual path.
  if (Prop[0] == '/') {
    SerialConsoleNode = fdt_path_offset_namelen (Fdt, Prop, PathLen);
  } else {
    // Lookup the alias, as this contains the actual path.
    Path = fdt_get_alias_namelen (Fdt, Prop, PathLen);
    if (Path == NULL) {
      return EFI_NOT_FOUND;
    }

    SerialConsoleNode = fdt_path_offset (Fdt, Path);
  }

  NodeStatus = fdt_getprop (Fdt, SerialConsoleNode, "status", &Len);
  if ((NodeStatus != NULL) && (AsciiStrCmp (NodeStatus, "okay") != 0)) {
    return EFI_NOT_FOUND;
  }

  RegProperty = fdt_getprop (Fdt, SerialConsoleNode, "reg", &Len);
  if (Len != 16) {
    return EFI_INVALID_PARAMETER;
  }

  *SerialConsoleAddress = fdt64_to_cpu (ReadUnaligned64 (RegProperty));

  return EFI_SUCCESS;
}

/** Get the Rtc base address from the DT.

  This function fetches the node referenced in the "loongson,ls7a-rtc"
  property of the "reg" node and returns the base address of
  the RTC.

  @param [in]   Fdt                   Pointer to a Flattened Device Tree (Fdt).
  @param [out]  RtcBaseAddress  If success, contains the base address
                                      of the Rtc.

  @retval EFI_SUCCESS             The function completed successfully.
  @retval EFI_NOT_FOUND           RTC info not found in DT.
  @retval EFI_INVALID_PARAMETER   Invalid parameter.
**/
STATIC
EFI_STATUS
EFIAPI
GetRtcAddress (
  IN  CONST VOID    *Fdt,
  OUT       UINT64  *RtcBaseAddress
  )
{
  INT32             Node;
  INT32             Prev;
  CONST CHAR8       *Type;
  INT32             Len;
  CONST UINT64      *RegProp;
  EFI_STATUS         Status;

  if ((Fdt == NULL) || (fdt_check_header (Fdt) != 0)) {
    return EFI_INVALID_PARAMETER;
  }

  Status = EFI_NOT_FOUND;
  for (Prev = 0;; Prev = Node) {
    Node = fdt_next_node (Fdt, Prev, NULL);
    if (Node < 0) {
      break;
    }

    //
    // Check for memory node
    //
    Type = fdt_getprop (Fdt, Node, "compatible", &Len);
    if ((Type)
      && (AsciiStrnCmp (Type, "loongson,ls7a-rtc", Len) == 0))
    {
      //
      // Get the 'reg' property of this node. For now, we will assume
      // two 8 byte quantities for base and size, respectively.
      //
      RegProp = fdt_getprop (Fdt, Node, "reg", &Len);
      if ((RegProp != 0)
        && (Len == (2 * sizeof (UINT64))))
      {
       *RtcBaseAddress = SwapBytes64 (RegProp[0]);
        Status = RETURN_SUCCESS;
        DEBUG ((DEBUG_INFO, "%a Len %d RtcBase %llx\n",__func__, Len, *RtcBaseAddress));
        break;
      } else {
        DEBUG ((DEBUG_ERROR, "%a: Failed to parse FDT rtc node\n",
          __FUNCTION__));
        break;
      }
    }
  }

  return Status;
}
/**
  Misc Initialization.

  @param  VOID

  @return  VOID
**/
VOID
MiscInitialization (
  VOID
  )
{
  DEBUG ((DEBUG_INFO, "==%a==\n", __func__));
  //
  // Creat CPU HOBs.
  //
  BuildCpuHob (PcdGet8 (PcdPrePiCpuMemorySize), PcdGet8 (PcdPrePiCpuIoSize));
}
/**
  add fdt hand off block.

  @param  VOID

  @return  VOID
**/
VOID
AddFdtHob (VOID)
{
  VOID    *Base;
  VOID    *NewBase;
  UINTN   FdtSize;
  UINTN   FdtPages;
  UINT64  *FdtHobData;
  UINT64  *UartHobData;
  UINT64  SerialConsoleAddress;
  UINT64  RtcBaseAddress;
  RETURN_STATUS  Status;

  Base = (VOID*)(UINTN)PcdGet64 (PcdDeviceTreeBase);
  ASSERT (Base != NULL);

  Status = GetSerialConsolePortAddress (Base, &SerialConsoleAddress);
  if (RETURN_ERROR (Status)) {
    return;
  }
  UartHobData = BuildGuidHob (&gEarly16550UartBaseAddressGuid, sizeof *UartHobData);
  ASSERT (UartHobData != NULL);
  *UartHobData = SerialConsoleAddress;

  Status = GetRtcAddress(Base, &RtcBaseAddress);
  if (RETURN_ERROR (Status)) {
    return;
  }
  Status =  PcdSet64S (PcdRtcBaseAddress, RtcBaseAddress);
  if (RETURN_ERROR (Status)) {
    return;
  }

  FdtSize = fdt_totalsize (Base) + PcdGet32 (PcdDeviceTreePadding);
  FdtPages = EFI_SIZE_TO_PAGES (FdtSize);
  NewBase = AllocatePages (FdtPages);
  ASSERT (NewBase != NULL);
  fdt_open_into (Base, NewBase, EFI_PAGES_TO_SIZE (FdtPages));

  FdtHobData = BuildGuidHob (&gFdtHobGuid, sizeof *FdtHobData);
  ASSERT (FdtHobData != NULL);
  *FdtHobData = (UINTN)NewBase;
}

/**
  Fetch the size of system memory from QEMU.

  @param  VOID

  @return  VOID
**/
VOID
SystemMemorySizeInitialization (
  VOID
  )
{
  UINT64        RamSize;
  RETURN_STATUS PcdStatus;

  QemuFwCfgSelectItem (QemuFwCfgItemRamSize);
  RamSize= QemuFwCfgRead64 ();
  DEBUG ((DEBUG_INFO, "%a: QEMU reports %dM system memory\n", __FUNCTION__,
    RamSize/1024/1024));

  //
  // If the fw_cfg key or fw_cfg entirely is unavailable, no change to PCD.
  //
  if (RamSize == 0) {
    return;
  }

  //
  // Otherwise, set RamSize to PCD.
  //
  PcdStatus =  PcdSet64S (PcdRamSize, RamSize);
  ASSERT_RETURN_ERROR (PcdStatus);
}

/**
  Perform Platform PEI initialization.

  @param  FileHandle      Handle of the file being invoked.
  @param  PeiServices     Describes the list of possible PEI Services.

  @return EFI_SUCCESS     The PEIM initialized successfully.
**/
EFI_STATUS
EFIAPI
InitializePlatform (
  IN       EFI_PEI_FILE_HANDLE  FileHandle,
  IN CONST EFI_PEI_SERVICES     **PeiServices
  )
{
  EFI_STATUS Status;

  DEBUG ((DEBUG_INFO, "Platform PEIM Loaded\n"));

  Status = PeiServicesSetBootMode (mBootMode);
  ASSERT_EFI_ERROR (Status);

  Status = PeiServicesInstallPpi (&mPpiListBootMode);
  ASSERT_EFI_ERROR (Status);

  SystemMemorySizeInitialization ();
  PublishPeiMemory ();
  PeiFvInitialization ();
  InitializeRamRegions ();
  MemMapInitialization ();
  MiscInitialization ();
  AddFdtHob ();
  ConfigureMmu ();

  return EFI_SUCCESS;
}
