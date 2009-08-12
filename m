From: "Mike Sumner" <msumner828@btinternet.com>
Subject: frequent head unloads
Date: Wed, 12 Aug 2009 11:05:28 +0100
Message-ID: <op.uyjnnefmv46o6b@localhost>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp804.mail.ird.yahoo.com ([217.146.188.64]:40426 "HELO
	smtp804.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932364AbZHLKMJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Aug 2009 06:12:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is the info for my new SONY VAIO FW31E

It was doing an unload cycle every 15 seconds.

I have found that the setting does not stick on re-boot or after suspend.   
Any suggestions?

Thanks for your work,
regards, mike sumner

root@vaio:/home/mike# hdparm -B 254 /dev/sda

/dev/sda:
  setting Advanced Power Management level to 0xfe (254)
  APM_level      = 254
root@vaio:/home/mike# smartctl -a /dev/sda | grep 193
193 Load_Cycle_Count        0x0032   100   100   000    Old_age    
Always       -       2082
root@vaio:/home/mike# dmidecode
# dmidecode 2.9
SMBIOS 2.4 present.
17 structures occupying 707 bytes.
Table at 0xBDF2E010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
         Vendor: American Megatrends Inc.
         Version: R2050Y0
         Release Date: 11/07/2008
         Address: 0xF0000
         Runtime Size: 64 kB
         ROM Size: 2048 kB
         Characteristics:
                 PCI is supported
                 PNP is supported
                 BIOS is upgradeable
                 BIOS shadowing is allowed
                 ESCD support is available
                 Boot from CD is supported
                 Selectable boot is supported
                 EDD is supported
                 8042 keyboard services are supported (int 9h)
                 CGA/mono video services are supported (int 10h)
                 ACPI is supported
                 USB legacy is supported
                 AGP is supported
                 Smart battery is supported
                 BIOS boot specification is supported
                 Function key-initiated network boot is supported
                 Targeted content distribution is supported
         BIOS Revision: 20.50
         Firmware Revision: 20.50

Handle 0x0001, DMI type 1, 27 bytes
System Information
         Manufacturer: Sony Corporation
         Product Name: VGN-FW31E
         Version: C601DGEE
         Serial Number: 28288161-5011103
         UUID: 5C360280-466A-11DE-82F5-001DBAB8C031
         Wake-up Type: Power Switch
         SKU Number: N/A
         Family: N/A

Handle 0x0002, DMI type 2, 10 bytes
Base Board Information
         Manufacturer: Sony Corporation
         Product Name: VAIO
         Version: N/A
         Serial Number: N/A

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
         Manufacturer: Sony Corporation
         Type: Notebook
         Lock: Not Present
         Version: N/A
         Serial Number: N/A
         Asset Tag: N/A
         Boot-up State: Safe
         Power Supply State: Safe
         Thermal State: Safe
         Security Status: None
         OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
         Socket Designation: N/A
         Type: Central Processor
         Family: <OUT OF SPEC>
         Manufacturer: GenuineIntel
         ID: 7A 06 01 00 FF FB EB BF
         Version: Intel(R) Core(TM)2 Duo CPU     T6400  @ 2.00GHz
         Voltage: 1.1 V
         External Clock: 200 MHz
         Max Speed: 2000 MHz
         Current Speed: 2000 MHz
         Status: Populated, Enabled
         Upgrade: None
         L1 Cache Handle: 0x0005
         L2 Cache Handle: 0x0006
         L3 Cache Handle: 0x0007
         Serial Number: N/A
         Asset Tag: N/A
         Part Number: N/A

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
         Socket Designation: L1 Cache
         Configuration: Enabled, Socketed, Level 1
         Operational Mode: Write Back
         Location: Internal
         Installed Size: 128 KB
         Maximum Size: 128 KB
         Supported SRAM Types:
                 Other
         Installed SRAM Type: Other
         Speed: Unknown
         Error Correction Type: Single-bit ECC
         System Type: Other
         Associativity: 8-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
         Socket Designation: L2 Cache
         Configuration: Enabled, Socketed, Level 2
         Operational Mode: Write Back
         Location: Internal
         Installed Size: 2048 KB
         Maximum Size: 2048 KB
         Supported SRAM Types:
                 Other
         Installed SRAM Type: Other
         Speed: Unknown
         Error Correction Type: Single-bit ECC
         System Type: Unified
         Associativity: 8-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
         Socket Designation: L3 Cache
         Configuration: Disabled, Not Socketed, Level 3
         Operational Mode: Unknown
         Location: Unknown
         Installed Size: 0 KB
         Maximum Size: 0 KB
         Supported SRAM Types:
                 Unknown
         Installed SRAM Type: Unknown
         Speed: Unknown
         Error Correction Type: Unknown
         System Type: Unknown
         Associativity: Unknown

Handle 0x0008, DMI type 11, 5 bytes
OEM Strings
         String 1: 0000035248
         String 2: FNC-EXTB
         String 3: 7X3C25D1DAA6BD7ADE05D18DC5C60
         String 4: Reserved
         String 5: Reserved

Handle 0x0009, DMI type 16, 15 bytes
Physical Memory Array
         Location: System Board Or Motherboard
         Use: System Memory
         Error Correction Type: None
         Maximum Capacity: 2048 GB
         Error Information Handle: Not Provided
         Number Of Devices: 2

Handle 0x000A, DMI type 19, 15 bytes
Memory Array Mapped Address
         Starting Address: 0x00000000000
         Ending Address: 0x000FFFFFFFF
         Range Size: 4 GB
         Physical Array Handle: 0x0009
         Partition Width: 0

Handle 0x000B, DMI type 17, 21 bytes
Memory Device
         Array Handle: 0x0009
         Error Information Handle: Not Provided
         Total Width: 64 bits
         Data Width: 64 bits
         Size: 2048 MB
         Form Factor: SODIMM
         Set: None
         Locator: SODIMM1
         Bank Locator: Bank 0
         Type: DDR2
         Type Detail: Unknown

Handle 0x000C, DMI type 20, 19 bytes
Memory Device Mapped Address
         Starting Address: 0x00000000000
         Ending Address: 0x0007FFFFFFF
         Range Size: 2 GB
         Physical Device Handle: 0x000B
         Memory Array Mapped Address Handle: 0x000A
         Partition Row Position: Unknown
         Interleave Position: Unknown
         Interleaved Data Depth: Unknown

Handle 0x000D, DMI type 17, 21 bytes
Memory Device
         Array Handle: 0x0009
         Error Information Handle: Not Provided
         Total Width: 64 bits
         Data Width: 64 bits
         Size: 2048 MB
         Form Factor: SODIMM
         Set: None
         Locator: SODIMM2
         Bank Locator: Bank 1
         Type: DDR2
         Type Detail: Unknown

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
         Starting Address: 0x00080000000
         Ending Address: 0x000FFFFFFFF
         Range Size: 2 GB
         Physical Device Handle: 0x000D
         Memory Array Mapped Address Handle: 0x000A
         Partition Row Position: Unknown
         Interleave Position: Unknown
         Interleaved Data Depth: Unknown

Handle 0x000F, DMI type 32, 20 bytes
System Boot Information
         Status: No errors detected

Handle 0x0010, DMI type 127, 4 bytes
End Of Table

root@vaio:/home/mike# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
         Model Number:       TOSHIBA MK4058GSX
         Serial Number:      49N5P9ZWT
         Firmware Revision:  FF012A
         Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II  
Extensions, SATA Rev 2.5, SATA Rev 2.6
Standards:
         Supported: 8 7 6 5
         Likely used: 8
Configuration:
         Logical         max     current
         cylinders       16383   16383
         heads           16      16
         sectors/track   63      63
         --
         CHS current addressable sectors:   16514064
         LBA    user addressable sectors:  268435455
         LBA48  user addressable sectors:  781422768
         Logical  Sector size:                   512 bytes
         Physical Sector size:                   512 bytes
         device size with M = 1024*1024:      381554 MBytes
         device size with M = 1000*1000:      400088 MBytes (400 GB)
         cache/buffer size  = 8192 KBytes
Capabilities:
         LBA, IORDY(can be disabled)
         Queue depth: 32
         Standby timer values: spec'd by Standard, no device specific  
minimum
         R/W multiple sector transfer: Max = 16  Current = 16
         Advanced power management level: 254
         DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3  
udma4 *udma5
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    SMART feature set
                 Security Mode feature set
            *    Power Management feature set
            *    Write cache
            *    Look-ahead
            *    Host Protected Area feature set
            *    WRITE_BUFFER command
            *    READ_BUFFER command
            *    NOP cmd
            *    DOWNLOAD_MICROCODE
            *    Advanced Power Management feature set
                 SET_MAX security extension
            *    48-bit Address feature set
            *    Device Configuration Overlay feature set
            *    Mandatory FLUSH_CACHE
            *    FLUSH_CACHE_EXT
            *    SMART error logging
            *    SMART self-test
            *    General Purpose Logging feature set
            *    WRITE_{DMA|MULTIPLE}_FUA_EXT
            *    64-bit World wide name
            *    IDLE_IMMEDIATE with UNLOAD
            *    Gen1 signaling speed (1.5Gb/s)
            *    Native Command Queueing (NCQ)
            *    Host-initiated interface power management
            *    Phy event counters
            *    Idle-Unload when NCQ is active
                 DMA Setup Auto-Activate optimization
                 Device-initiated interface power management
            *    Software settings preservation
            *    SMART Command Transport (SCT) feature set
            *    SCT Error Recovery Control (AC3)
            *    SCT Features Control (AC4)
            *    SCT Data Tables (AC5)
Security:
         Master password revision code = 65534
                 supported
         not     enabled
         not     locked
                 frozen
         not     expired: security count
         not     supported: enhanced erase
         152min for SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 50000391b238443d
         NAA             : 5
         IEEE OUI        : 000039
         Unique ID       : 1b238443d
Checksum: correct
root@vaio:/home/mike# smartctl -a /dev/sda
smartctl version 5.38 [x86_64-unknown-linux-gnu] Copyright (C) 2002-8  
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     TOSHIBA MK4058GSX
Serial Number:    49N5P9ZWT
Firmware Version: FF012A
User Capacity:    400,088,457,216 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Wed Aug 12 10:52:47 2009 BST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                         was never started.
                                         Auto Offline Data Collection:  
Disabled.
Self-test execution status:      (   0) The previous self-test routine  
completed
                                         without error or no self-test has  
ever
                                         been run.
Total time to complete Offline
data collection:                 ( 120) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection  
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 160) minutes.
SCT capabilities:              (0x0039) SCT Status supported.
                                         SCT Feature Control supported.
                                         SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED   
WHEN_FAILED RAW_VALUE
   1 Raw_Read_Error_Rate     0x000b   100   100   050    Pre-fail   
Always       -       0
   2 Throughput_Performance  0x0005   100   100   050    Pre-fail   
Offline      -       0
   3 Spin_Up_Time            0x0027   100   100   001    Pre-fail   
Always       -       1425
   4 Start_Stop_Count        0x0032   100   100   000    Old_age    
Always       -       86
   5 Reallocated_Sector_Ct   0x0033   100   100   050    Pre-fail   
Always       -       0
   7 Seek_Error_Rate         0x000b   100   100   050    Pre-fail   
Always       -       0
   8 Seek_Time_Performance   0x0005   100   100   050    Pre-fail   
Offline      -       0
   9 Power_On_Hours          0x0032   100   100   000    Old_age    
Always       -       47
  10 Spin_Retry_Count        0x0033   101   100   030    Pre-fail   
Always       -       0
  12 Power_Cycle_Count       0x0032   100   100   000    Old_age    
Always       -       82
191 G-Sense_Error_Rate      0x0032   100   100   000    Old_age    
Always       -       169
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age    
Always       -       1
193 Load_Cycle_Count        0x0032   100   100   000    Old_age    
Always       -       2082
194 Temperature_Celsius     0x0022   100   100   000    Old_age    
Always       -       37 (Lifetime Min/Max 20/48)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age    
Always       -       0
197 Current_Pending_Sector  0x0032   100   100   000    Old_age    
Always       -       0
198 Offline_Uncorrectable   0x0030   100   100   000    Old_age    
Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age    
Always       -       0
220 Disk_Shift              0x0002   100   100   000    Old_age    
Always       -       79
222 Loaded_Hours            0x0032   100   100   000    Old_age    
Always       -       37
223 Load_Retry_Count        0x0032   100   100   000    Old_age    
Always       -       0
224 Load_Friction           0x0022   100   100   000    Old_age    
Always       -       0
226 Load-in_Time            0x0026   100   100   000    Old_age    
Always       -       375
240 Head_Flying_Hours       0x0001   100   100   001    Pre-fail   
Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


SMART Selective self-test log data structure revision number 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

root@vaio:/home/mike# smartctl -a /dev/sda | grep 193
193 Load_Cycle_Count        0x0032   100   100   000    Old_age    
Always       -       2082
root@vaio:/home/mike#


-- 
Mike Sumner  Dip Arb (RFS), F. Arbor. A
Telephone 01507 568735
http://www.msumner.co.uk
