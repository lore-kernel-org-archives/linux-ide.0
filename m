From: Monika Schilling <ms@mschilling.com>
Subject: New entry for storage-fixup.conf: Belinea home.pc 1xs = Pegatron Cape 7 - Corrected and completed version
Date: Sun, 11 Apr 2010 12:36:21 +0100
Message-ID: <201004111236.24103.ms@mschilling.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51602 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab0DKLgh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 07:36:37 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello again,


I would like to correct and complement my mail from a few hours ago.


CORRECTION

I made the mistake to run "hdparm -I /dev/sda" after storage fixup had already 
done its job. In short the value of "Advanced power management level" without 
storage-fixup is 128.


COMPLETIONS

The Belinea home.pc 1xs = Pegatron Cape 7 is a nettop.

Without storage-fixup the "load cycle count" under idle condition increased by 
19 in 10 minutes, that is about 114 per hour. Setting the disk APM level to 
254 resulted in no more increase. 


Regards, Monika


Below you will find :

- Output of smarctl -a /dev/sda
- Output of dmidecode
- Output of hdparm -I /dev/sda (without storage-fixup!)
- Protocol of my measurement of the increase of Load_Cycle_Count

==========================================================================
Output of smarctl -a /dev/sda
==========================================================================
cape7:~ # smartctl -a /dev/sda
smartctl 5.39 2009-08-08 r2872~ [i686-pc-linux-gnu] (openSUSE RPM)
Copyright (C) 2002-9 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Momentus 5400.5 series
Device Model:     ST9160310AS
Serial Number:    5SV6KCWH
Firmware Version: 0303
User Capacity:    160.041.885.696 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 4
Local Time is:    Sun Apr 11 11:47:36 2010 WEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED
See vendor-specific Attribute list for marginal Attributes.

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                        was completed without error.
                                        Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                        without error or no self-test has ever
                                        been run.
Total time to complete Offline
data collection:                 ( 723) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                        Auto Offline data collection on/off 
support.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        (  62) minutes.
Conveyance self-test routine
recommended polling time:        (   2) minutes.
SCT capabilities:              (0x103f) SCT Status supported.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  
WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   116   100   006    Pre-fail  
Always       -       108967314
  3 Spin_Up_Time            0x0003   099   099   000    Pre-fail  
Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   
Always       -       92
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  
Always       -       0
  7 Seek_Error_Rate         0x000f   060   060   030    Pre-fail  
Always       -       1267627
  9 Power_On_Hours          0x0032   100   100   000    Old_age   
Always       -       96
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   
Always       -       92
184 Unknown_Attribute       0x0032   100   100   099    Old_age   
Always       -       0
187 Reported_Uncorrect      0x0032   100   100   000    Old_age   
Always       -       0
188 Unknown_Attribute       0x0032   098   096   000    Old_age   
Always       -       51
189 High_Fly_Writes         0x003a   100   100   000    Old_age   
Always       -       0
190 Airflow_Temperature_Cel 0x0022   051   045   045    Old_age   Always   
In_the_past 49 (Lifetime Min/Max 41/49)
191 G-Sense_Error_Rate      0x0032   100   100   000    Old_age   
Always       -       0
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   
Always       -       8
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   
Always       -       1871
194 Temperature_Celsius     0x0022   049   055   000    Old_age   
Always       -       49 (0 20 0 0)
195 Hardware_ECC_Recovered  0x001a   062   050   000    Old_age   
Always       -       108967314
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   
Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   
Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  
LBA_of_first_error
# 1  Extended offline    Completed without error       00%         3         -
# 2  Short offline       Completed without error       00%         2         -

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

cape7:~ #  
==========================================================================
Output of dmidecode
==========================================================================
cape7:~ # dmidecode
# dmidecode 2.10
SMBIOS 2.5 present.
28 structures occupying 1290 bytes.
Table at 0x000FBA00.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: American Megatrends Inc.
        Version: 1800
        Release Date: 04/13/2009
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 1024 kB
        Characteristics:
                ISA is supported
                PCI is supported
                PNP is supported
                APM is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                BIOS ROM is socketed
                EDD is supported
                5.25"/1.2 MB floppy services are supported (int 13h)
                3.5"/720 kB floppy services are supported (int 13h)
                3.5"/2.88 MB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                AGP is supported
                LS-120 boot is supported
                ATAPI Zip drive boot is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
        BIOS Revision: 8.15

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: To Be Filled By O.E.M.
        Product Name: To Be Filled By O.E.M.
        Version: To Be Filled By O.E.M.
        Serial Number: To Be Filled By O.E.M.
        UUID: E0DD7A77-8DFE-D511-92CC-00248CA78567
        Wake-up Type: Power Switch
        SKU Number: To Be Filled By O.E.M.
        Family: To Be Filled By O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
        Manufacturer: To be filled by O.E.M.
        Product Name: To be filled by O.E.M.
        Version: To be filled by O.E.M.
        Serial Number: MS1C94D17W00138
        Asset Tag: To Be Filled By O.E.M.
        Features:
                Board is a hosting board
                Board is replaceable
        Location In Chassis: To Be Filled By O.E.M.
        Chassis Handle: 0x0003
        Type: Motherboard
        Contained Object Handles: 0

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
        Manufacturer: To Be Filled By O.E.M.
        Type: Desktop
        Lock: Not Present
        Version: To Be Filled By O.E.M.
        Serial Number: To Be Filled By O.E.M.
        Asset Tag: To Be Filled By O.E.M.
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000000
        Height: Unspecified
        Number Of Power Cords: 1
        Contained Elements: 0

Handle 0x0004, DMI type 4, 40 bytes
Processor Information
        Socket Designation: CPU 1
        Type: Central Processor
        Family: Other
        Manufacturer: Intel
        ID: C2 06 01 00 FF FB E9 BF
        Version: Intel(R) Atom(TM) CPU  230   @ 1.60GHz
        Voltage: 1.2 V
        External Clock: 133 MHz
        Max Speed: 1600 MHz
        Current Speed: 1600 MHz
        Status: Populated, Enabled
        Upgrade: Socket 478
        L1 Cache Handle: 0x0005
        L2 Cache Handle: 0x0006
        L3 Cache Handle: 0x0007
        Serial Number: To Be Filled By O.E.M.
        Asset Tag: To Be Filled By O.E.M.
        Part Number: To Be Filled By O.E.M.
        Core Count: 1
        Core Enabled: 1
        Thread Count: 2
        Characteristics:
                64-bit capable

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L1-Cache
        Configuration: Enabled, Not Socketed, Level 1
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 24 kB
        Maximum Size: 24 kB
        Supported SRAM Types:
                Other
        Installed SRAM Type: Other
        Speed: Unknown
        Error Correction Type: Parity
        System Type: Data
        Associativity: Other

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L2-Cache
        Configuration: Enabled, Not Socketed, Level 2
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 512 kB
        Maximum Size: 512 kB
        Supported SRAM Types:
                Other
        Installed SRAM Type: Other
        Speed: Unknown
        Error Correction Type: Single-bit ECC
        System Type: Unified
        Associativity: 8-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L3-Cache
        Configuration: Disabled, Not Socketed, Level 3
        Operational Mode: Unknown
        Location: Internal
        Installed Size: 0 kB
        Maximum Size: 0 kB
        Supported SRAM Types:
                Unknown
        Installed SRAM Type: Unknown
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unknown
        Associativity: Unknown

Handle 0x0008, DMI type 5, 18 bytes
Memory Controller Information
        Error Detecting Method: 64-bit ECC
        Error Correcting Capabilities:
                None
        Supported Interleave: One-way Interleave
        Current Interleave: One-way Interleave
        Maximum Memory Module Size: 2048 MB
        Maximum Total Memory Size: 2048 MB
        Supported Speeds:
                70 ns
                60 ns
        Supported Memory Types:
                DIMM
                SDRAM
        Memory Module Voltage: 3.3 V
        Associated Memory Slots: 1
                0x0009
        Enabled Error Correcting Capabilities:
                None

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
        Socket Designation: DIMM0
        Bank Connections: 6 8
        Current Speed: Unknown
        Type: DIMM SDRAM
        Installed Size: 1024 MB (Double-bank Connection)
        Enabled Size: 1024 MB (Double-bank Connection)
        Error Status: OK

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J2A2
        Internal Connector Type: None
        External Reference Designator: USB1
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J2A2
        Internal Connector Type: None
        External Reference Designator: USB2
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J6A1
        Internal Connector Type: None
        External Reference Designator: Audio Mic In
        External Connector Type: Mini Jack (headphones)
        Port Type: Audio Port

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J6A1
        Internal Connector Type: None
        External Reference Designator: Audio Line In
        External Connector Type: Mini Jack (headphones)
        Port Type: Audio Port

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J6A1
        Internal Connector Type: None
        External Reference Designator: Audio Line Out
        External Connector Type: Mini Jack (headphones)
        Port Type: Audio Port

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J5A1
        Internal Connector Type: None
        External Reference Designator: USB3
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J5A1
        Internal Connector Type: None
        External Reference Designator: USB4
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J5A1
        Internal Connector Type: None
        External Reference Designator: LAN
        External Connector Type: RJ-45
        Port Type: Network Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: J2H1 - DC_IN
        Internal Connector Type: Other
        External Reference Designator: Not Specified
        External Connector Type: None
        Port Type: Other

Handle 0x0013, DMI type 10, 6 bytes
On Board Device Information
        Type: Video
        Status: Enabled
        Description:   To Be Filled By O.E.M.

Handle 0x0014, DMI type 13, 22 bytes
BIOS Language Information
        Installable Languages: 1
                en|US|iso8859-1
        Currently Installed Language: en|US|iso8859-1

Handle 0x0015, DMI type 15, 35 bytes
System Event Log
        Area Length: 4 bytes
        Header Start Offset: 0x0000
        Header Length: 2 bytes
        Data Start Offset: 0x0002
        Access Method: Indexed I/O, one 16-bit index port, one 8-bit data port
        Access Address: Index 0x046A, Data 0x046C
        Status: Invalid, Not Full
        Change Token: 0x00000000
        Header Format: No Header
        Supported Log Type Descriptors: 6
        Descriptor 1: End of log
        Data Format 1: OEM-specific
        Descriptor 2: End of log
        Data Format 2: OEM-specific
        Descriptor 3: End of log
        Data Format 3: OEM-specific
        Descriptor 4: End of log
        Data Format 4: OEM-specific
        Descriptor 5: End of log
        Data Format 5: OEM-specific
        Descriptor 6: End of log
        Data Format 6: OEM-specific

Handle 0x0016, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 4 GB
        Error Information Handle: Not Provided
        Number Of Devices: 1

Handle 0x0017, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x000000003FF
        Range Size: 1 kB
        Physical Array Handle: 0x0016
        Partition Width: 0

Handle 0x0018, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x0016
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 1024 MB
        Form Factor: DIMM
        Set: None
        Locator: DIMM0
        Bank Locator: BANK0
        Type: SDRAM
        Type Detail: Synchronous
        Speed: Unknown
        Manufacturer: Manufacturer0
        Serial Number: SerNum0
        Asset Tag: AssetTagNum0
        Part Number: PartNum0

Handle 0x0019, DMI type 126, 19 bytes
Inactive

Handle 0x001A, DMI type 32, 20 bytes
System Boot Information
        Status: No errors detected

Handle 0x001B, DMI type 127, 4 bytes
End Of Table

cape7:~ # 
==========================================================================
Output of hdparm -I /dev/sda (without storage-fixup!)
==========================================================================
cape7:~ # hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       ST9160310AS
        Serial Number:      5SV6KCWH
        Firmware Revision:  0303
        Transport:          Serial
Standards:
        Used: unknown (minor revision code 0x0029)
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
        LBA48  user addressable sectors:  312581808
        Logical/Physical Sector size:           512 bytes
        device size with M = 1024*1024:      152627 MBytes
        device size with M = 1000*1000:      160041 MBytes (160 GB)
        cache/buffer size  = 8192 KBytes
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: 128
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
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
           *    WRITE_DMA_QUEUED_FUA_EXT
           *    64-bit World wide name
           *    IDLE_IMMEDIATE with UNLOAD
           *    Write-Read-Verify feature set
           *    WRITE_UNCORRECTABLE_EXT command
           *    {READ,WRITE}_DMA_EXT_GPL commands
           *    Gen1 signaling speed (1.5Gb/s)
           *    Gen2 signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Phy event counters
                Device-initiated interface power management
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Long Sector Access (AC1)
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
                unknown 206[12] (vendor specific)
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
                supported: enhanced erase
        54min for SECURITY ERASE UNIT. 54min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 5000c50015f151d4
        NAA             : 5
        IEEE OUI        : 000c50
        Unique ID       : 015f151d4
Checksum: correct
cape7:~ # 
==========================================================================
Protocol of my measurement of increase of Load_Cycle_Count
==========================================================================
cape7:~ # cat ~/tmp/measure-LoadCycleCount
#!/bin/bash
hdparm -I /dev/sda | grep 'Advanced power management level'

date --rfc-3339=seconds; smartctl -a /dev/sda | grep Load_Cycle_Count
echo "Please do not load the system during the following 10 minutes!"

sleep 600

date --rfc-3339=seconds; smartctl -a /dev/sda | grep Load_Cycle_Count
cape7:~ #
cape7:~ #
cape7:~ # ./tmp/measure-LoadCycleCount
        Advanced power management level: 128
2010-04-11 11:09:35+01:00
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   
Always       -       1848
Please do not load the system during the following 10 Minutes!
2010-04-11 11:19:35+01:00
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   
Always       -       1867
cape7:~ #

...

cape7:~ # tail -n 8 /etc/storage-fixup.conf
# Reported drive model: ST9160310AS
# Belinea home.pc 1xs = Pegatron Cape 7
rule belinea-homepc1xs
dmi system-manufacturer         To Be Filled By O.E.M.
dmi system-product-name         To Be Filled By O.E.M.
ata model                       ST9160310AS
act hdparm -B 254 $DEV

cape7:~ # 
cape7:~ # 
cape7:~ # storage-fixup
storage-fixup: belinea-homepc1xs: executing hdparm -B 254 /dev/sda

/dev/sda:
 setting Advanced Power Management level to 0xfe (254)
 APM_level      = 254
cape7:~ #
cape7:~ #
cape7:~ # ./tmp/measure-LoadCycleCount
        Advanced power management level: 254
2010-04-11 11:21:16+01:00
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   
Always       -       1871
Please do not load the system during the following 10 minutes!
2010-04-11 11:31:17+01:00
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   
Always       -       1871
cape7:~ #
==========================================================================
