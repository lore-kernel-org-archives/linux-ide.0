From: Tejun Heo <tj@kernel.org>
Subject: Re: Drives which perform frequent head unloads under Linux
Date: Wed, 01 Oct 2008 04:10:36 +0900
Message-ID: <48E279AC.6000708@kernel.org>
References: <d212b62f0809062304p639731c9k2e0f36bfb3e619d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42740 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbYI3TMB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Sep 2008 15:12:01 -0400
In-Reply-To: <d212b62f0809062304p639731c9k2e0f36bfb3e619d7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Omar A <aliencoder@gmail.com>
Cc: linux-ide@vger.kernel.org

Omar A wrote:
> Please note that I changed the settings manually using hdparam -B 254
> and -S 0, but I was looking for a more permanent fix.  Will try to
> edit the config file as well
> Output below..
> 
> 
> Output from dmidecode:
> 
> # dmidecode 2.9
> SMBIOS 2.4 present.
> 43 structures occupying 1896 bytes.
> Table at 0x000F7670.
> 
> Handle 0xDA00, DMI type 218, 251 bytes
> OEM-specific Type
>     Header and Data:
>         DA FB 00 DA B2 00 0D 5F 1F 37 40 7D 00 00 00 00
>         00 7E 00 02 00 00 00 40 00 04 00 01 00 41 00 04
>         00 00 00 65 00 05 00 00 00 66 00 05 00 01 00 5E
>         00 06 00 01 00 5F 00 06 00 00 00 89 01 07 00 00
>         00 8A 01 07 00 01 00 42 00 08 00 01 00 43 00 08
>         00 00 00 55 00 09 00 00 00 6D 00 09 00 01 00 2D
>         00 0A 00 02 00 6E 00 0A 00 01 00 2E 00 0A 00 00
>         00 11 01 0B 00 00 00 10 01 0B 00 01 00 F0 00 0C
>         00 01 00 ED 00 0C 00 00 00 41 01 0D 00 01 00 40
>         01 0D 00 00 00 47 01 0E 00 01 00 46 01 0E 00 00
>         00 4A 01 0F 00 00 00 4B 01 0F 00 01 00 52 01 10
>         00 01 00 53 01 10 00 00 00 80 01 11 00 01 00 7F
>         01 11 00 00 00 94 01 12 00 00 00 93 01 12 00 01
>         00 86 01 13 00 01 00 85 01 13 00 00 00 82 01 14
>         00 01 00 81 01 14 00 00 00 9B 01 15 00 00 00 9C
>         01 15 00 01 00 FF FF 00 00 00 00
> 
> Handle 0xDA01, DMI type 218, 239 bytes
> OEM-specific Type
>     Header and Data:
>         DA EF 01 DA B2 00 0D 5F 1F 37 40 9D 01 15 00 02
>         00 9E 01 15 00 03 00 8B 01 16 00 00 00 8C 01 16
>         00 01 00 EA 00 17 00 00 00 EB 00 17 00 01 00 EC
>         00 17 00 02 00 28 00 18 00 00 00 29 00 18 00 01
>         00 2A 00 18 00 02 00 2B 00 19 00 00 00 2C 00 1A
>         00 00 00 E7 00 1B 00 01 00 E6 00 1B 00 00 00 0E
>         01 1C 00 01 00 0F 01 1C 00 00 00 9B 00 1D 00 01
>         00 9C 00 1D 00 00 00 4D 01 1E 00 01 00 4C 01 1E
>         00 00 00 01 01 1F 00 00 00 02 01 1F 00 01 00 04
>         01 1F 00 02 00 37 01 20 00 00 00 38 01 20 00 01
>         00 D9 01 21 00 01 00 D8 01 21 00 00 00 EA 01 22
>         00 00 00 EB 01 22 00 01 00 76 01 76 01 01 00 75
>         01 75 01 01 00 13 02 13 02 01 00 14 02 14 02 00
>         00 01 F0 01 F0 00 00 02 F0 02 F0 00 00 03 F0 03
>         F0 00 00 04 F0 04 F0 00 00 FF FF 00 00 00 00
> 
> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
>     Vendor: Dell Inc.
>     Version: A00
>     Release Date: 05/05/2008
>     Address: 0xF0000
>     Runtime Size: 64 kB
>     ROM Size: 2048 kB
>     Characteristics:
>         ISA is supported
>         PCI is supported
>         PC Card (PCMCIA) is supported
>         PNP is supported
>         BIOS is upgradeable
>         BIOS shadowing is allowed
>         Boot from CD is supported
>         Selectable boot is supported
>         3.5"/720 KB floppy services are supported (int 13h)
>         Print screen service is supported (int 5h)
>         8042 keyboard services are supported (int 9h)
>         Serial services are supported (int 14h)
>         Printer services are supported (int 17h)
>         CGA/mono video services are supported (int 10h)
>         ACPI is supported
>         USB legacy is supported
>         AGP is supported
>         Smart battery is supported
>         BIOS boot specification is supported
>         Function key-initiated network boot is supported
>         Targeted content distribution is supported
>     BIOS Revision: 0.0
>     Firmware Revision: 0.0
> 
> Handle 0x0100, DMI type 1, 27 bytes
> System Information
>     Manufacturer: Dell Inc.
>     Product Name: Inspiron 1318
>     Version: Not Specified
>     Serial Number: 9D0D6G1
>     UUID: 44454C4C-4400-1030-8044-
> B9C04F364731
>     Wake-up Type: Power Switch
>     SKU Number: Not Specified
>     Family:
> 
> Handle 0x0200, DMI type 2, 9 bytes
> Base Board Information
>     Manufacturer: Dell Inc.
>     Product Name: 0C236D
>     Version:
>     Serial Number: .9D0D6G1.CN70166881026W.
> 
> Handle 0x0300, DMI type 3, 13 bytes
> Chassis Information
>     Manufacturer: Dell Inc.
>     Type: Portable
>     Lock: Not Present
>     Version: Not Specified
>     Serial Number: 9D0D6G1
>     Asset Tag: Not Specified
>     Boot-up State: Safe
>     Power Supply State: Safe
>     Thermal State: Safe
>     Security Status: None
> 
> Handle 0x0400, DMI type 4, 40 bytes
> Processor Information
>     Socket Designation: Microprocessor
>     Type: Central Processor
>     Family: <OUT OF SPEC>
>     Manufacturer: Intel
>     ID: FD 06 00 00 FF FB EB BF
>     Version: Not Specified
>     Voltage: 3.3 V
>     External Clock: 166 MHz
>     Max Speed: 2000 MHz
>     Current Speed: 2000 MHz
>     Status: Populated, Enabled
>     Upgrade: None
>     L1 Cache Handle: 0x0700
>     L2 Cache Handle: 0x0701
>     L3 Cache Handle: Not Provided
>     Serial Number: Not Specified
>     Asset Tag: Not Specified
>     Part Number: Not Specified
>     Core Count: 2
>     Core Enabled: 2
>     Thread Count: 2
>     Characteristics:
>         64-bit capable
> 
> Handle 0x0700, DMI type 7, 19 bytes
> Cache Information
>     Socket Designation: Not Specified
>     Configuration: Enabled, Not Socketed, Level 1
>     Operational Mode: Write Back
>     Location: Internal
>     Installed Size: 32 KB
>     Maximum Size: 32 KB
>     Supported SRAM Types:
>         Unknown
>     Installed SRAM Type: Unknown
>     Speed: Unknown
>     Error Correction Type: None
>     System Type: Data
>     Associativity: 4-way Set-associative
> 
> Handle 0x0701, DMI type 7, 19 bytes
> Cache Information
>     Socket Designation: Not Specified
>     Configuration: Enabled, Not Socketed, Level 2
>     Operational Mode: Varies With Memory Address
>     Location: Internal
>     Installed Size: 2048 KB
>     Maximum Size: 2048 KB
>     Supported SRAM Types:
>         Pipeline Burst
>     Installed SRAM Type: Pipeline Burst
>     Speed: 15 ns
>     Error Correction Type: None
>     System Type: Unified
>     Associativity: Other
> 
> Handle 0x0804, DMI type 8, 9 bytes
> Port Connector Information
>     Internal Reference Designator: USB
>     Internal Connector Type: None
>     External Reference Designator: Not Specified
>     External Connector Type: Access Bus (USB)
>     Port Type: USB
> 
> Handle 0x0806, DMI type 8, 9 bytes
> Port Connector Information
>     Internal Reference Designator: MONITOR
>     Internal Connector Type: None
>     External Reference Designator: Not Specified
>     External Connector Type: DB-15 female
>     Port Type: Video Port
> 
> Handle 0x080B, DMI type 8, 9 bytes
> Port Connector Information
>     Internal Reference Designator: FireWire
>     Internal Connector Type: None
>     External Reference Designator: Not Specified
>     External Connector Type: IEEE 1394
>     Port Type: Firewire (IEEE P1394)
> 
> Handle 0x080D, DMI type 8, 9 bytes
> Port Connector Information
>     Internal Reference Designator: Ethernet
>     Internal Connector Type: None
>     External Reference Designator: Not Specified
>     External Connector Type: RJ-45
>     Port Type: Network Port
> 
> Handle 0x0A00, DMI type 10, 6 bytes
> On Board Device Information
>     Type: Video
>     Status: Enabled
>     Description: Intel Crestline Graphics
> 
> Handle 0x0A01, DMI type 10, 6 bytes
> On Board Device Information
>     Type: Sound
>     Status: Enabled
>     Description: IDT 9228
> 
> Handle 0x0B00, DMI type 11, 5 bytes
> OEM Strings
>     String 1: Dell System
>     String 2: 5[0003]
>     String 3: 13[PP25L]
> 
> Handle 0x0D00, DMI type 13, 22 bytes
> BIOS Language Information
>     Installable Languages: 1
>         en|US|iso8859-1
>     Currently Installed Language: en|US|iso8859-1
> 
> Handle 0x1000, DMI type 16, 15 bytes
> Physical Memory Array
>     Location: System Board Or Motherboard
>     Use: System Memory
>     Error Correction Type: None
>     Maximum Capacity: 4 GB
>     Error Information Handle: Not Provided
>     Number Of Devices: 2
> 
> Handle 0x1100, DMI type 17, 27 bytes
> Memory Device
>     Array Handle: 0x1000
>     Error Information Handle: Not Provided
>     Total Width: 64 bits
>     Data Width: 64 bits
>     Size: 1024 MB
>     Form Factor: DIMM
>     Set: None
>     Locator: DIMM_A
>     Bank Locator: Not Specified
>     Type: DDR
>     Type Detail: Synchronous
>     Speed: 667 MHz (1.5 ns)
>     Manufacturer: AD00000000000000
>     Serial Number: 00003022
>     Asset Tag: 000827
>     Part Number: HYMP112S64CP6-Y5
> 
> Handle 0x1101, DMI type 17, 27 bytes
> Memory Device
>     Array Handle: 0x1000
>     Error Information Handle: Not Provided
>     Total Width: 64 bits
>     Data Width: 64 bits
>     Size: 2048 MB
>     Form Factor: DIMM
>     Set: None
>     Locator: DIMM_B
>     Bank Locator: Not Specified
>     Type: DDR
>     Type Detail: Synchronous
>     Speed: 667 MHz (1.5 ns)
>     Manufacturer: CE00000000000000
>     Serial Number: 75866A0B
>     Asset Tag: 510822
>     Part Number: M4 70T5663QZ3-CE6
> 
> Handle 0x1301, DMI type 19, 15 bytes
> Memory Array Mapped Address
>     Starting Address: 0x00000000000
>     Ending Address: 0x000BFFFFFFF
>     Range Size: 3 GB
>     Physical Array Handle: 0x1000
>     Partition Width: 0
> 
> Handle 0x1401, DMI type 20, 19 bytes
> Memory Device Mapped Address
>     Starting Address: 0x00000000000
>     Ending Address: 0x0007FFFFFFF
>     Range Size: 2 GB
>     Physical Device Handle: 0x1100
>     Memory Array Mapped Address Handle: 0x1301
>     Partition Row Position: 1
>     Interleave Position: 1
>     Interleaved Data Depth: 8
> 
> Handle 0x1411, DMI type 126, 19 bytes
> Inactive
> 
> Handle 0x1402, DMI type 20, 19 bytes
> Memory Device Mapped Address
>     Starting Address: 0x00000000000
>     Ending Address: 0x0007FFFFFFF
>     Range Size: 2 GB
>     Physical Device Handle: 0x1101
>     Memory Array Mapped Address Handle: 0x1301
>     Partition Row Position: 1
>     Interleave Position: 2
>     Interleaved Data Depth: 8
> 
> Handle 0x1412, DMI type 20, 19 bytes
> Memory Device Mapped Address
>     Starting Address: 0x00080000000
>     Ending Address: 0x000BFFFFFFF
>     Range Size: 1 GB
>     Physical Device Handle: 0x1101
>     Memory Array Mapped Address Handle: 0x1301
>     Partition Row Position: 1
> 
> Handle 0x1500, DMI type 21, 7 bytes
> Built-in Pointing Device
>     Type: Touch Pad
>     Interface: Bus Mouse
>     Buttons: 2
> 
> Handle 0x1600, DMI type 22, 26 bytes
> Portable Battery
>     Location: Sys. Battery Bay
>     Manufacturer: Sanyo
>     Name: DELL UM2307A
>     Design Capacity: 78000 mWh
>     Design Voltage: 11100 mV
>     SBDS Version: 1.0
>     Maximum Error: 0%
>     SBDS Serial Number: 01FD
>     SBDS Manufacture Date: 2007-10-04
>     SBDS Chemistry: LION
>     OEM-specific Information: 0x00000001
> 
> Handle 0x1B00, DMI type 27, 12 bytes
> Cooling Device
>     Type: Fan
>     Status: OK
>     OEM-specific Information: 0x0000DD00
> 
> Handle 0x1C00, DMI type 28, 20 bytes
> Temperature Probe
>     Description: CPU Internal Temperature
>     Location: Processor
>     Status: OK
>     Maximum Value: 127.0 deg C
>     Minimum Value 0.0 deg C
>     Resolution: 1.000 deg C
>     Tolerance: 0.5 deg C
>     Accuracy: Unknown
>     OEM-specific Information: 0x0000DC00
> 
> Handle 0x2000, DMI type 32, 11 bytes
> System Boot Information
>     Status: No errors detected
> 
> Handle 0xB000, DMI type 176, 5 bytes
> OEM-specific Type
>     Header and Data:
>         B0 05 00 B0 01
> 
> Handle 0xB100, DMI type 177, 12 bytes
> OEM-specific Type
>     Header and Data:
>         B1 0C 00 B1 02 00 00 00 00 00 00 00
> 
> Handle 0xB200, DMI type 178, 6 bytes
> OEM-specific Type
>     Header and Data:
>         B2 06 00 B2 99 99
> 
> Handle 0xD000, DMI type 208, 10 bytes
> OEM-specific Type
>     Header and Data:
>         D0 0A 00 D0 01 04 FE 00 86 02
> 
> Handle 0xD800, DMI type 216, 9 bytes
> OEM-specific Type
>     Header and Data:
>         D8 09 00 D8 01 03 01 F0 03
>     Strings:
>         Intel Corp.
> 
>         1566
> 
> 
> Handle 0xD900, DMI type 217, 8 bytes
> OEM-specific Type
>     Header and Data:
>         D9 08 00 D9 01 02 01 03
>     Strings:
>         US-101
>         Proprietary
> 
> Handle 0xDB00, DMI type 219, 9 bytes
> OEM-specific Type
>     Header and Data:
>         DB 09 00 DB 03 01 02 03 FF
>     Strings:
>         System Device Bay
>         Floppy, Battery, CD-ROM, CD-RW, DVD, DVD+RW, DVD+/-RW, Hard
> Disk, BLU-RAY
>         DVD+/-RW
> 
> Handle 0xDC00, DMI type 220, 22 bytes
> OEM-specific Type
>     Header and Data:
>         DC 16 00 DC 01 F0 00 00 02 F0 00 00 00 00 03 F0
>         04 F0 00 00 00 00
> 
> Handle 0xDD00, DMI type 221, 19 bytes
> OEM-specific Type
>     Header and Data:
>         DD 13 00 DD 00 00 00 00 00 00 00 00 00 00 00 00
>         00 00 00
> 
> Handle 0xD400, DMI type 212, 37 bytes
> OEM-specific Type
>     Header and Data:
>         D4 25 00 D4 74 00 75 00 00 10 2D 2E 5C 00 78 BF
>         40 5D 00 78 BF 00 08 00 1D DF 00 03 00 1D DF 00
>         FF FF 00 00 00
> 
> Handle 0xD401, DMI type 212, 17 bytes
> OEM-specific Type
>     Header and Data:
>         D4 11 01 D4 74 00 75 00 03 40 49 4A FF FF 00 00
>         00
> 
> Handle 0xDE00, DMI type 222, 16 bytes
> OEM-specific Type
>     Header and Data:
>         DE 10 00 DE 01 02 FF FF 00 00 00 00 00 00 00 01
> 
> Handle 0x7F00, DMI type 127, 4 bytes
> End Of Table
> 
> hdparm output:
> /dev/sda:
> 
> ATA device, with non-removable media
>     Model Number:       WDC WD2500BEVS-75UST0
>     Serial Number:      WD-WXE708HR3348
>     Firmware Revision:  01.01A01
> Standards:
>     Supported: 8 7 6 5
>     Likely used: 8
> Configuration:
>     Logical        max    current
>     cylinders    16383    16383
>     heads        16    16
>     sectors/track    63    63
>     --
>     CHS current addressable sectors:   16514064
>     LBA    user addressable sectors:  268435455
>     LBA48  user addressable sectors:  488397168
>     device size with M = 1024*1024:      238475 MBytes
>     device size with M = 1000*1000:      250059 MBytes (250 GB)
> Capabilities:
>     LBA, IORDY(can be disabled)
>     Queue depth: 32
>     Standby timer values: spec'd by Standard, with device specific minimum
>     R/W multiple sector transfer: Max = 16    Current = 8
>     Advanced power management level: 254
>     Recommended acoustic management value: 128, current value: 254
>     DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>          Cycle time: min=120ns recommended=120ns
>     PIO: pio0 pio1 pio2 pio3 pio4
>          Cycle time: no flow control=120ns  IORDY flow control=120ns
> Commands/features:
>     Enabled    Supported:
>        *    SMART feature set
>             Security Mode feature set
>        *    Power Management feature set
>        *    Write cache
>        *    Look-ahead
>        *    Host Protected Area feature set
>        *    WRITE_BUFFER command
>        *    READ_BUFFER command
>        *    NOP cmd
>        *    DOWNLOAD_MICROCODE
>        *    Advanced Power Management feature set
>             SET_MAX security extension
>        *    Automatic Acoustic Management feature set
>        *    48-bit Address feature set
>        *    Device Configuration Overlay feature set
>        *    Mandatory FLUSH_CACHE
>        *    FLUSH_CACHE_EXT
>        *    SMART error logging
>        *    SMART self-test
>        *    General Purpose Logging feature set
>        *    WRITE_{DMA|MULTIPLE}_FUA_EXT
>        *    64-bit World wide name
>        *    IDLE_IMMEDIATE with UNLOAD
>        *    Segmented DOWNLOAD_MICROCODE
>        *    SATA-I signaling speed (1.5Gb/s)
>        *    Native Command Queueing (NCQ)
>        *    Host-initiated interface power management
>        *    Phy event counters
>             DMA Setup Auto-Activate optimization
>             Device-initiated interface power management
>        *    Software settings preservation
>        *    SMART Command Transport (SCT) feature set
>        *    SCT Long Sector Access (AC1)
>        *    SCT LBA Segment Access (AC2)
>        *    SCT Error Recovery Control (AC3)
>        *    SCT Features Control (AC4)
>        *    SCT Data Tables (AC5)
>             unknown 206[12] (vendor specific)
>             unknown 206[13] (vendor specific)
> Security:
>     Master password revision code = 65534
>         supported
>     not    enabled
>     not    locked
>         frozen
>     not    expired: security count
>     not    supported: enhanced erase
>     92min for SECURITY ERASE UNIT.
> Logical Unit WWN Device Identifier: 50014ee25720269e
>     NAA        : 5
>     IEEE OUI    : 14ee
>     Unique ID    : 25720269e
> Checksum: correct
> 
> 
> smartctl output
> 
> smartctl 5.39 2008-05-08 21:56 [i686-pc-linux-gnu] (local build)
> Copyright (C) 2002-8 by Bruce Allen, http://smartmontools.sourceforge.net
> 
> === START OF INFORMATION SECTION ===
> Model Family:     Western Digital Scorpio family
> Device Model:     WDC WD2500BEVS-75UST0
> Serial Number:    WD-WXE708HR3348
> Firmware Version: 01.01A01
> User Capacity:    250,059,350,016 bytes
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   8
> ATA Standard is:  Exact ATA specification draft version not indicated
> Local Time is:    Sun Sep  7 00:49:55 2008 CDT
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> 
> === START OF READ SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
> 
> General SMART Values:
> Offline data collection status:  (0x00)    Offline data collection activity
>                     was never started.
>                     Auto Offline Data Collection: Disabled.
> Self-test execution status:      (   0)    The previous self-test
> routine completed
>                     without error or no self-test has ever
>                     been run.
> Total time to complete Offline
> data collection:          (9180) seconds.
> Offline data collection
> capabilities:              (0x7b) SMART execute Offline immediate.
>                     Auto Offline data collection on/off support.
>                     Suspend Offline collection upon new
>                     command.
>                     Offline surface scan supported.
>                     Self-test supported.
>                     Conveyance Self-test supported.
>                     Selective Self-test supported.
> SMART capabilities:            (0x0003)    Saves SMART data before entering
>                     power-saving mode.
>                     Supports SMART auto save timer.
> Error logging capability:        (0x01)    Error logging supported.
>                     General Purpose Logging supported.
> Short self-test routine
> recommended polling time:      (   2) minutes.
> Extended self-test routine
> recommended polling time:      ( 110) minutes.
> Conveyance self-test routine
> recommended polling time:      (   5) minutes.
> SCT capabilities:            (0x303f)    SCT Status supported.
>                     SCT Feature Control supported.
>                     SCT Data Table supported.
> 
> SMART Attributes Data Structure revision number: 16
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
> UPDATED  WHEN_FAILED RAW_VALUE
>   1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail
> Always       -       0
>   3 Spin_Up_Time            0x0003   188   188   021    Pre-fail
> Always       -       1600
>   4 Start_Stop_Count        0x0032   100   100   000    Old_age
> Always       -       22
>   5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
> Always       -       0
>   7 Seek_Error_Rate         0x000e   100   253   051    Old_age
> Always       -       0
>   9 Power_On_Hours          0x0032   100   100   000    Old_age
> Always       -       13
>  10 Spin_Retry_Count        0x0012   100   253   051    Old_age
> Always       -       0
>  11 Calibration_Retry_Count 0x0012   100   253   051    Old_age
> Always       -       0
>  12 Power_Cycle_Count       0x0032   100   100   000    Old_age
> Always       -       21
> 192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
> Always       -       3
> 193 Load_Cycle_Count        0x0032   200   200   000    Old_age
> Always       -       141
> 194 Temperature_Celsius     0x0022   108   104   000    Old_age
> Always       -       39
> 196 Reallocated_Event_Count 0x0032   200   200   000    Old_age
> Always       -       0
> 197 Current_Pending_Sector  0x0012   200   200   000    Old_age
> Always       -       0
> 198 Offline_Uncorrectable   0x0010   100   253   000    Old_age
> Offline      -       0
> 199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age
> Always       -       0
> 200 Multi_Zone_Error_Rate   0x0008   100   253   051    Old_age
> Offline      -       0
> 240 Head_Flying_Hours       0x0032   100   100   000    Old_age
> Always       -       14
> 241 Unknown_Attribute       0x0032   200   200   000    Old_age
> Always       -       858998242602
> 242 Unknown_Attribute       0x0032   200   200   000    Old_age
> Always       -       61985358
> 
> SMART Error Log Version: 1
> No Errors Logged
> 
> SMART Self-test log structure revision number 1
> Num  Test_Description    Status                  Remaining
> LifeTime(hours)  LBA_of_first_error
> # 1  Short offline       Completed without error       00%         4         -
> # 2  Short offline       Completed without error       00%         1         -
> # 3  Short offline       Completed without error       00%         0         -
> # 4  Short offline       Completed without error       00%         0         -
> 
> SMART Selective self-test log data structure revision number 1
>  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
>     1        0        0  Not_testing
>     2        0        0  Not_testing
>     3        0        0  Not_testing
>     4        0        0  Not_testing
>     5        0        0  Not_testing
> Selective self-test flags (0x0):
>   After scanning selected spans, do NOT read-scan remainder of disk.
> If Selective self-test is pending on power-up, resume after 0 minute delay.
> 
> Cheers
> 
> 
> --
> Am I the Alien?? I guess we will never know :-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
added

-- 
tejun
