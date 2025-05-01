#;*****************************************************************************
#; Copyright (C) 2021-2025 Advanced Micro Devices, Inc. All rights reserved.
#; SPDX-License-Identifier: BSD-2-Clause-Patent
#;
#;******************************************************************************
#
## @file
# Smbios Platform description.
#
##

[PcdsFixedAtBuild]
  #****************************************************************************
  # COMMON SMBIOS
  #****************************************************************************
  #
  # IPMI Interface Type
  #
  # 0 - Unknown
  # 1 - KCS
  # 2 - SMIC
  # 3 - BT
  # 4 - SSIF
  gAmdPlatformPkgTokenSpaceGuid.PcdIpmiInterfaceType|1

  # SMBIOS Type 4 Processor Information
  gEfiAmdAgesaPkgTokenSpaceGuid.PcdAmdSmbiosSerialNumberSocket0|"Default String"
  gEfiAmdAgesaPkgTokenSpaceGuid.PcdAmdSmbiosSerialNumberSocket1|"Default String"
  gEfiAmdAgesaPkgTokenSpaceGuid.PcdAmdSmbiosAssetTagSocket0|"Default String"
  gEfiAmdAgesaPkgTokenSpaceGuid.PcdAmdSmbiosAssetTagSocket1|"Default String"
  gEfiAmdAgesaPkgTokenSpaceGuid.PcdAmdSmbiosPartNumberSocket0|"Default String"
  gEfiAmdAgesaPkgTokenSpaceGuid.PcdAmdSmbiosPartNumberSocket1|"Default String"

  # AMD SMBIOS Type 8 record
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8Number|6

  # AMD SMBIOS Type 9 record
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType9SlotCharacteristics1.Provides33Volts|1
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType9SlotCharacteristics2.BifurcationSupported|1

  # Port #0
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[0].Type8Data.InternalReferenceDesignator|0x01
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[0].Type8Data.InternalConnectorType|PortConnectorTypeNone
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[0].Type8Data.ExternalReferenceDesignator|0x02
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[0].Type8Data.ExternalConnectorType|PortConnectorTypeUsb
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[0].Type8Data.PortType|PortTypeUsb
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[0].Designator.IntDesignatorStr|"J110"
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[0].Designator.ExtDesignatorStr|"USB-Rear 1"

  # Port #1
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[1].Type8Data.InternalReferenceDesignator|0x01
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[1].Type8Data.InternalConnectorType|PortConnectorTypeNone
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[1].Type8Data.ExternalReferenceDesignator|0x02
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[1].Type8Data.ExternalConnectorType|PortConnectorTypeUsb
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[1].Type8Data.PortType|PortTypeUsb
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[1].Designator.IntDesignatorStr|"J111"
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[1].Designator.ExtDesignatorStr|"USB-Rear 2"

  # Port #2
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[2].Type8Data.InternalReferenceDesignator|0x01
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[2].Type8Data.InternalConnectorType|PortConnectorTypeNone
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[2].Type8Data.ExternalReferenceDesignator|0x02
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[2].Type8Data.ExternalConnectorType|PortConnectorTypeUsb
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[2].Type8Data.PortType|PortTypeUsb
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[2].Designator.IntDesignatorStr|"J44"
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[2].Designator.ExtDesignatorStr|"USB-Front 1"

  # Port #3
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[3].Type8Data.InternalReferenceDesignator|0x01
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[3].Type8Data.InternalConnectorType|PortConnectorTypeNone
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[3].Type8Data.ExternalReferenceDesignator|0x02
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[3].Type8Data.ExternalConnectorType|PortConnectorTypeUsb
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[3].Type8Data.PortType|PortTypeUsb
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[3].Designator.IntDesignatorStr|"J44"
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[3].Designator.ExtDesignatorStr|"USB-Front 2"

  # Port #4
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[4].Type8Data.InternalReferenceDesignator|0x01
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[4].Type8Data.InternalConnectorType|PortConnectorTypeNone
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[4].Type8Data.ExternalReferenceDesignator|0x02
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[4].Type8Data.ExternalConnectorType|PortConnectorTypeRJ45
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[4].Type8Data.PortType|PortTypeNetworkPort
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[4].Designator.IntDesignatorStr|"J106"
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[4].Designator.ExtDesignatorStr|"LAN"

  # Port #5
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[5].Type8Data.InternalReferenceDesignator|0x01
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[5].Type8Data.InternalConnectorType|PortConnectorTypeNone
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[5].Type8Data.ExternalReferenceDesignator|0x02
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[5].Type8Data.ExternalConnectorType|PortConnectorTypeDB15Female
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[5].Type8Data.PortType|PortTypeVideoPort
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[5].Designator.IntDesignatorStr|{0}
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType8.SmbiosPortConnectorRecords[5].Designator.ExtDesignatorStr|"VGA"

  # AMD SMBIOS Type 41 record
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType41Number|1
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType41.SmbiosOnboardDevExtInfos[0].ReferenceDesignation|0x01
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType41.SmbiosOnboardDevExtInfos[0].DeviceType|OnBoardDeviceExtendedTypeEthernet
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType41.SmbiosOnboardDevExtInfos[0].DeviceEnabled|1
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType41.SmbiosOnboardDevExtInfos[0].DeviceTypeInstance|1
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType41.SmbiosOnboardDevExtInfos[0].VendorId|0x14E4
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType41.SmbiosOnboardDevExtInfos[0].DeviceId|0x165F
  gAmdPlatformPkgTokenSpaceGuid.PcdAmdSmbiosType41.SmbiosOnboardDevExtInfos[0].RefDesignationStr|"Onboard Ethernet"

[PcdsDynamicDefault]
  #****************************************************************************
  # BASIC SMBIOS
  #****************************************************************************
  #
  # SMBIOS Type 0 BIOS Information Strings
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0StringBiosReleaseDate|"$(RELEASE_DATE)"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0StringBiosVersion|"$(FIRMWARE_VERSION_STR)"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.SystemBiosMajorRelease|0xFF
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.SystemBiosMinorRelease|0xFF
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.EmbeddedControllerFirmwareMajorRelease|0xFF
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.EmbeddedControllerFirmwareMinorRelease|0xFF
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.ExtendedBiosSize.Size|32
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.ExtendedBiosSize.Unit|0x00
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BiosCharacteristics.PlugAndPlayIsSupported|0
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BiosCharacteristics.EDDSpecificationIsSupported|0
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BiosCharacteristics.Floppy525_12IsSupported|0
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BiosCharacteristics.Floppy35_720IsSupported|0
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BiosCharacteristics.Floppy35_288IsSupported|0
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BiosCharacteristics.PrintScreenIsSupported|0
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BiosCharacteristics.Keyboard8042IsSupported|0
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BiosCharacteristics.SerialIsSupported|0
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BiosCharacteristics.PrinterIsSupported|0
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BiosCharacteristics.CgaMonoIsSupported|0
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BIOSCharacteristicsExtensionBytes[0]|0x01
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0BiosInformation.BIOSCharacteristicsExtensionBytes[1]|0x0C
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType0StringVendor|"AMD Corporation"

  # SMBIOS Type 1 System Information Strings
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType1StringFamily|$(AMD_PROCESSOR)
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType1StringProductName|$(PLATFORM_CRB)
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType1SystemInformation.Uuid|{GUID("8dc4291c-f3ca-4858-8c53-6adc6713eb34")}
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType1StringManufacturer|"AMD Corporation"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType1StringSerialNumber|"Default String"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType1StringVersion|"Default String"

  # SMBIOS Type 2 Baseboard Information Strings
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType2StringManufacturer|"AMD Corporation"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType2StringProductName|$(PLATFORM_CRB)
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType2StringVersion|"Default String"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType2StringAssetTag|"Default String"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType2StringLocationInChassis|"Default String"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType2StringSerialNumber|"Default String"

  # SMBIOS Type 3 System Enclosure Information Strings
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType3StringManufacturer|"AMD Corporation"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType3StringVersion|"Default String"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType3StringAssetTag|"Default String"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType3StringSKUNumber|"Default String"
  gSmbiosFeaturePkgTokenSpaceGuid.PcdSmbiosType3StringSerialNumber|"Default String"

  # SMBIOS Type 11 OEM Strings
  gAmdPlatformPkgTokenSpaceGuid.PcdType11OemStringsCount|1
  gAmdPlatformPkgTokenSpaceGuid.PcdType11OemStrings|{"Default String"}

  # SMBIOS Type 12 System Configuration Information
  gAmdPlatformPkgTokenSpaceGuid.PcdType12SystemCfgOptionsCount|1
  gAmdPlatformPkgTokenSpaceGuid.PcdType12SystemCfgOptions|{"Default String"}

[Components.X64]
  MdeModulePkg/Universal/SmbiosDxe/SmbiosDxe.inf
  SystemInformation/SmbiosFeaturePkg/SmbiosBasicDxe/SmbiosBasicDxe.inf
  AmdPlatformPkg/Universal/SmbiosCommonDxe/SmbiosCommonDxe.inf {
    <LibraryClasses>
      PciSegmentLib|MdePkg/Library/PciSegmentLibSegmentInfo/BasePciSegmentLibSegmentInfo.inf
      PciSegmentInfoLib|AgesaPkg/Addendum/PciSegments/PciExpressPciSegmentInfoLib/PciExpressPciSegmentInfoLib.inf
  }
