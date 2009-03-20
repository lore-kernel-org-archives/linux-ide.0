From: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?=
	<vladimir.dashevsky@gmail.com>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Fri, 20 Mar 2009 18:31:03 +0300
Message-ID: <49C3B6B7.6030108@gmail.com>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org> <49C36816.306@gmail.com> <49C39933.4020501@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040909070505020204050509"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:37645 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbZCTPc4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Mar 2009 11:32:56 -0400
Received: by ewy9 with SMTP id 9so777707ewy.37
        for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2009 08:32:52 -0700 (PDT)
In-Reply-To: <49C39933.4020501@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040909070505020204050509
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Tejun!

I will write some comment later. 
Now I send dmidecode output.



--------------040909070505020204050509
Content-Type: text/plain;
 name="dmi_data"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmi_data"

# dmidecode 2.9
SMBIOS 2.5 present.
38 structures occupying 1584 bytes.
Table at 0x7FEDF000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: 6.00   
	Release Date: 02/25/2008
	Address: 0xE2DA0
	Runtime Size: 119392 bytes
	ROM Size: 2048 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		USB legacy is supported
		Smart battery is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Supermicro
	Product Name: X7SBi
	Version: 0123456789
	Serial Number: 0123456789
	UUID: 53D1A494-D663-A0E7-890B-00304862E142
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Supermicro
	Product Name: X7SBi
	Version: PCB Version
	Serial Number: 0123456789

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Supermicro
	Type: Other
	Lock: Not Present
	Version: 0123456789
	Serial Number: 0123456789
	Asset Tag:  
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: CPU 1
	Type: Central Processor
	Family: Unknown
	Manufacturer: Intel
	ID: FD 06 00 00 FF FB EB BF
	Version: 00000000000000000000000000000000
	Voltage: 1.8 V
	External Clock: Unknown
	Max Speed: 3300 MHz
	Current Speed: 2200 MHz
	Status: Populated, Enabled
	Upgrade: Socket LGA775
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 16 KB
	Maximum Size: 16 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Enabled, Socketed, Level 3
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A1
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: COM 1
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
	External Reference Designator: Parallel
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000C, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot #1 - J5B1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000D, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIe Slot #1 - J7C1
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	ID: 4
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000E, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: ADI1886

Handle 0x000F, DMI type 11, 5 bytes
OEM Strings
	String 1: This is the Intel 965
	String 2: Customer Reference Board

Handle 0x0010, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x0011, DMI type 15, 29 bytes
System Event Log
	Area Length: 176 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x00000086
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x0012, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 8 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0013, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0012
	Error Information Handle: 0xFF01
	Total Width: 40968 bits
	Data Width: 41024 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: J6G1
	Bank Locator: DIMM 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Kingston                                        
	Serial Number: D132F5F5
	Asset Tag: 00000730
	Part Number: 393930353331362D3030352E4130344C4600

Handle 0x0014, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0012
	Error Information Handle: 0xFF01
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: 1
	Locator: J6G2
	Bank Locator: DIMM 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 48spaces                                        
	Serial Number: 01234567
	Asset Tag: 01234567
	Part Number: 012345678901234567890123456789012345

Handle 0x0015, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0012
	Error Information Handle: 0xFF01
	Total Width: 41992 bits
	Data Width: 42048 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: J6H1
	Bank Locator: DIMM 2
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Kingston                                        
	Serial Number: D0321BF6
	Asset Tag: 00000730
	Part Number: 393930353331362D3030352E4130344C4600

Handle 0x0016, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0012
	Error Information Handle: 0xFF01
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: 1
	Locator: J6H2
	Bank Locator: DIMM 3
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 48spaces                                        
	Serial Number: 01234567
	Asset Tag: 01234567
	Part Number: 012345678901234567890123456789012345

Handle 0x0017, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x0012
	Partition Width: 0

Handle 0x0018, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0013
	Memory Array Mapped Address Handle: 0x0017
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0019, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x0003FFFFC00
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 kB
	Physical Device Handle: 0x0014
	Memory Array Mapped Address Handle: 0x0017
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x001A, DMI type 23, 13 bytes
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x001B, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Enabled
	Front Panel Reset Status: Unknown

Handle 0x001C, DMI type 25, 9 bytes
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x001D, DMI type 26, 20 bytes
Voltage Probe
	Description: Voltage Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x001E, DMI type 27, 12 bytes
Cooling Device
	Temperature Probe Handle: 0x001F
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x001F, DMI type 28, 20 bytes
Temperature Probe
	Description: Temperature Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0020, DMI type 29, 20 bytes
Electrical Current Probe
	Description: Electrical Current Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0021, DMI type 30, 6 bytes
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x0022, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0023, DMI type 126, 4 bytes
Inactive

Handle 0x0024, DMI type 127, 4 bytes
End Of Table

Handle 0x0025, DMI type 127, 4 bytes
End Of Table



--------------040909070505020204050509--
