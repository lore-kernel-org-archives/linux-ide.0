From: Monika Schilling <ms@mschilling.com>
Subject: New entry for storage-fixup.conf: Belinea home.pc 1xs = Pegatron Cape 7
Date: Sun, 11 Apr 2010 08:04:24 +0100
Message-ID: <201004110804.28068.ms@mschilling.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60690 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0DKHE6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 03:04:58 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

my "Belinea home.pc 1xs" (which actually is a "Pegatron Cape 7") needed taming 
with storage-fixup:

  # Reported drive model: ST9160310AS
  # Belinea home.pc 1xs = Pegatron Cape 7
  rule belinea-homepc1xs
  dmi system-manufacturer         To Be Filled By O.E.M.
  dmi system-product-name         To Be Filled By O.E.M.
  ata model                       ST9160310AS
  act hdparm -B 254 $DEV


Here comes the requested information for including into storage-fixup.conf.
Unfortunately dmidecode brings to light a lot of the string "To Be Filled By 
O.E.M." instead of adapted text.

At the boot screen I see the string "IPP71-CP", which is only revealed by the 
openSUSE 11.2 specific command "hwinfo --bios".

Regards, Monika

----------------------

cape7:~ # date
Sun Apr 11 07:41:52 WEST 2010
cape7:~ #
cape7:~ # 
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
        Advanced power management level: 254
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
cape7:~ #
cape7:~ # 
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
cape7:~ #  
cape7:~ #  
cape7:~ # hwinfo --bios
01: None 00.0: 10105 BIOS
  [Created at bios.186]
  Unique ID: rdCR.lZF+r4EgHp4
  Hardware Class: bios
  BIOS Keyboard LED Status:
    Scroll Lock: off
    Num Lock: off
    Caps Lock: off
  Base Memory: 639 kB
  PnP BIOS: @@@0000
  BIOS: extended read supported
  MP spec rev 1.4 info:
    OEM id: "TEMPLATE"
    Product id: "IPP71-CP"
    1 CPUs (0 disabled)
  BIOS32 Service Directory Entry: 0xf0010
  SMBIOS Version: 2.5
  BIOS Info: #0
    Vendor: "American Megatrends Inc."
    Version: "1800"
    Date: "04/13/2009"
    Start Address: 0xf0000
    ROM Size: 1024 kB
    Features: 0x0537000000017f8bde90
      ISA supported
      PCI supported
      PnP supported
      APM supported
      BIOS flashable
      BIOS shadowing allowed
      ESCD supported
      CD boot supported
      Selectable boot supported
      BIOS ROM socketed
      EDD spec supported
      1.2MB Floppy supported
      720kB Floppy supported
      2.88MB Floppy supported
      Print Screen supported
      8042 Keyboard Services supported
      Serial Services supported
      Printer Services supported
      CGA/Mono Video supported
      ACPI supported
      USB Legacy supported
      AGP supported
      LS-120 boot supported
      ATAPI ZIP boot supported
      BIOS Boot Spec supported
  System Info: #1
    Manufacturer: "To Be Filled By O.E.M."
    Product: "To Be Filled By O.E.M."
    Version: "To Be Filled By O.E.M."
    Serial: "To Be Filled By O.E.M."
    UUID: undefined, but settable
    Wake-up: 0x06 (Power Switch)
  Board Info: #2
    Manufacturer: "To be filled by O.E.M."
    Product: "To be filled by O.E.M."
    Version: "To be filled by O.E.M."
    Serial: "MS1C94D17W00138"
    Asset Tag: "To Be Filled By O.E.M."
    Type: 0x0a (Motherboard)
    Features: 0x09
      Hosting Board
      Replaceable
    Location: "To Be Filled By O.E.M."
    Chassis: #3
  Chassis Info: #3
    Manufacturer: "To Be Filled By O.E.M."
    Version: "To Be Filled By O.E.M."
    Serial: "To Be Filled By O.E.M."
    Asset Tag: "To Be Filled By O.E.M."
    Type: 0x03 (Desktop)
    Bootup State: 0x03 (Safe)
    Power Supply State: 0x03 (Safe)
    Thermal State: 0x03 (Safe)
    Security Status: 0x03 (None)
  Processor Info: #4
    Socket: "CPU 1"
    Socket Type: 0x0f (Socket 478)
    Socket Status: Populated
    Type: 0x03 (CPU)
    Family: 0x01 (Other)
    Manufacturer: "Intel"
    Version: "Intel(R) Atom(TM) CPU  230   @ 1.60GHz"
    Serial: "To Be Filled By O.E.M."
    Asset Tag: "To Be Filled By O.E.M."
    Part Number: "To Be Filled By O.E.M."
    Processor ID: 0xbfe9fbff000106c2
    Status: 0x01 (Enabled)
    Voltage: 1.2 V
    External Clock: 133 MHz
    Max. Speed: 1600 MHz
    Current Speed: 1600 MHz
    L1 Cache: #5
    L2 Cache: #6
    L3 Cache: #7
  Cache Info: #5
    Designation: "L1-Cache"
    Level: L1
    State: Enabled
    Mode: 0x01 (Write Back)
    Location: 0x00 (Internal, Not Socketed)
    ECC: 0x04 (Parity)
    Type: 0x04 (Data)
    Associativity: 0x01 (Other)
    Max. Size: 24 kB
    Current Size: 24 kB
    Supported SRAM Types: 0x0001 (Other)
    Current SRAM Type: 0x0001 (Other)
  Cache Info: #6
    Designation: "L2-Cache"
    Level: L2
    State: Enabled
    Mode: 0x01 (Write Back)
    Location: 0x00 (Internal, Not Socketed)
    ECC: 0x05 (Single-bit)
    Type: 0x05 (Unified)
    Associativity: 0x07 (8-way Set-Associative)
    Max. Size: 512 kB
    Current Size: 512 kB
    Supported SRAM Types: 0x0001 (Other)
    Current SRAM Type: 0x0001 (Other)
  Cache Info: #7
    Designation: "L3-Cache"
    Level: L3
    State: Disabled
    Mode: 0x03 (Unknown)
    Location: 0x00 (Internal, Not Socketed)
    ECC: 0x02 (Unknown)
    Type: 0x02 (Unknown)
    Associativity: 0x02 (Unknown)
    Supported SRAM Types: 0x0002 (Unknown)
    Current SRAM Type: 0x0002 (Unknown)
  Type 5 Record: #8
    Data 00: 05 12 08 00 06 04 03 03 0b 0c 00 00 05 02 01 09
    Data 10: 00 04
  Type 6 Record: #9
    Data 00: 06 0c 09 00 01 68 00 00 05 8a 8a 00
    String 1: "DIMM0"
  Port Connector: #10
    Type: 0x10 (USB)
    Internal Designator: "J2A2"
    External Designator: "USB1"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #11
    Type: 0x10 (USB)
    Internal Designator: "J2A2"
    External Designator: "USB2"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #12
    Type: 0x1d (Audio Port)
    Internal Designator: "J6A1"
    External Designator: "Audio Mic In"
    External Connector: 0x1f (Mini-jack [headphones])
  Port Connector: #13
    Type: 0x1d (Audio Port)
    Internal Designator: "J6A1"
    External Designator: "Audio Line In"
    External Connector: 0x1f (Mini-jack [headphones])
  Port Connector: #14
    Type: 0x1d (Audio Port)
    Internal Designator: "J6A1"
    External Designator: "Audio Line Out"
    External Connector: 0x1f (Mini-jack [headphones])
  Port Connector: #15
    Type: 0x10 (USB)
    Internal Designator: "J5A1"
    External Designator: "USB3"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #16
    Type: 0x10 (USB)
    Internal Designator: "J5A1"
    External Designator: "USB4"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #17
    Type: 0x1f (Network Port)
    Internal Designator: "J5A1"
    External Designator: "LAN"
    External Connector: 0x0b (RJ-45)
  Port Connector: #18
    Type: 0xff (Other)
    Internal Designator: "J2H1 - DC_IN"
    Internal Connector: 0xff (Other)
  On Board Devices: #19
    Video: "To Be Filled By O.E.M."
  Language Info: #20
    Languages: en|US|iso8859-1
    Current: en|US|iso8859-1
  Type 15 Record: #21
    Data 00: 0f 23 15 00 04 00 00 00 02 00 02 00 00 00 00 00
    Data 10: 6a 04 6c 04 00 06 02 ff ff ff ff ff ff ff ff ff
    Data 20: ff ff ff
  Physical Memory Array: #22
    Use: 0x03 (System memory)
    Location: 0x03 (Motherboard)
    Slots: 1
    Max. Size: 4 GB
    ECC: 0x03 (None)
  Memory Array Mapping: #23
    Memory Array: #22
    Partition Width: 1
    Start Address: 0x00000000
    End Address: 0x00000400
  Memory Device: #24
    Location: "DIMM0"
    Bank: "BANK0"
    Manufacturer: "Manufacturer0"
    Serial: "SerNum0"
    Asset Tag: "AssetTagNum0"
    Part Number: "PartNum0"
    Memory Array: #22
    Form Factor: 0x09 (DIMM)
    Type: 0x0f (SDRAM)
    Type Detail: 0x0080 (Synchronous)
    Data Width: 64 bits
    Size: 1 GB
  Inactive Record: #25
    Data 00: 7e 13 19 00 00 00 00 00 00 00 00 00 18 00 17 00
    Data 10: 01 00 00
  Type 32 Record: #26
    Data 00: 20 14 1a 00 00 00 00 00 00 00 00 00 00 00 00 00
    Data 10: 00 00 00 00
  Config Status: cfg=no, avail=yes, need=no, active=unknown
cape7:~ #  
