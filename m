From: Tejun Heo <htejun@gmail.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP	drive
Date: Tue, 13 Mar 2007 21:14:48 +0900
Message-ID: <45F695B8.5030006@gmail.com>
References: <45F6964D0200002D000156EC@emea5-mh.id5.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020802020907040902030900"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:43956 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965719AbXCMMPD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 08:15:03 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2469356nfa
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 05:15:00 -0700 (PDT)
In-Reply-To: <45F6964D0200002D000156EC@emea5-mh.id5.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislav Brabec <sbrabec@novell.com>
Cc: jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020802020907040902030900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Stanislav Brabec wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> [libata]
>>> And, as the device requires custom high level driver, libata fails
>>> miserably.  Would it be worth to try support these devices?  Or are
>>> they just too outdated to put the effort in?
>> What SCSI peripheral device type does it report, when booted under libata?
> 
> Internal IOMEGA ZIP 100 IDE (manufactured by NEC).
> 
> ata1.01: ATAPI, max PIO2, CDB intr
> ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
>          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> ata1: soft resetting port
> ata1.01: configured for PIO2
> ata1: EH complete
> ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
>          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> ata1.01: configured for PIO2
> ata1: EH complete
> ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
>          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> ata1: soft resetting port
> ... and so on
> 
> For more see
> https://bugzilla.novell.com/show_bug.cgi?id=232086
> (complete ide-floppy and libata logs are there)

I'm attaching full dmesg with libata here just in case.

It seems ide-floppy needs some special handlings in interrupt handling
too like delaying data transfer by several ticks after device indicates
readiness.  Apart from separate high level driver, we might have to
modify libata HSM implementation if we're gonna support these devices.

Can someone more knowledgeable explain what needs to be done differently
from standard ATAPI for these devices?

Thanks.

-- 
tejun

--------------020802020907040902030900
Content-Type: text/x-log;
 name="sata.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata.log"

Linux version 2.6.20.1-default (root@utx) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #1 SMP Thu Feb 22 21:41:49 CET 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000002fef0000 end: 000000002fff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000002fff0000 size: 0000000000008000 end: 000000002fff8000 type: 3
copy_e820_map() start: 000000002fff8000 size: 0000000000008000 end: 0000000030000000 type: 4
copy_e820_map() start: 00000000fff80000 size: 0000000000080000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff8000 (ACPI data)
 BIOS-e820: 000000002fff8000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
767MB LOWMEM available.
Entering add_active_range(0, 0, 196592) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   196592
  HighMem    196592 ->   196592
early_node_map[1] active PFN ranges
    0:        0 ->   196592
On node 0 totalpages: 196592
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1503 pages used for memmap
  Normal zone: 190993 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v000 AMI                                   ) @ 0x000fc3c0
ACPI: RSDT (v001 AMIINT          0x00000011 MSFT 0x00000097) @ 0x2fff0000
ACPI: FADT (v001 AMIINT          0x00000011 MSFT 0x00000097) @ 0x2fff0030
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 40000000 (gap: 30000000:cff80000)
Detected 1338.095 MHz processor.
Built 1 zonelists.  Total pages: 195057
Kernel command line: root=/dev/sda1 vga=0x31a resume=/dev/sda5 splash=silent
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (0160c000)
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 772536k/786368k available (1708k kernel code, 13248k reserved, 719k data, 192k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe15000 - 0xfffff000   (1960 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf0800000 - 0xff7fe000   ( 239 MB)
    lowmem  : 0xc0000000 - 0xefff0000   ( 767 MB)
      .init : 0xc0366000 - 0xc0396000   ( 192 kB)
      .data : 0xc02ab3af - 0xc035f354   ( 719 kB)
      .text : 0xc0100000 - 0xc02ab3af   (1708 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2678.90 BogoMIPS (lpj=5357803)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 1c20)
CPU0: AMD Athlon(tm) Processor stepping 04
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb21, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 *12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 8000-9fff
  MEM window: dfe00000-dfefffff
  PREFETCH window: d7c00000-dfcfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3241k freed
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1172434137.792:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xd8000000, mapped to 0xf0880000, using 5120k, total 32768k
vesafb: mode is 1280x1024x16, linelength=2560, pages=11
vesafb: protected mode interface info at c000:4d22
vesafb: pmi: set display start = c00c4d90, set palette = c00c4dca
vesafb: pmi: ports = 9810 9816 9854 9838 983c 985c 9800 9804 98b0 98b2 98b4 
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
NET: Registered protocol family 1
Using IPI No-Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Time: tsc clocksource has been installed.
Freeing unused kernel memory: 192k freed
SCSI subsystem initialized
ACPI: Processor [CPU1] (supports 16 throttling states)
dc395x: Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
dc395x: Used settings: AdapterID=07, Speed=0(20.0MHz), dev_mode=0x57
dc395x:                AdaptMode=0x0f, Tags=4(16), DelayReset=1s
dc395x: Connectors:  Termination: Auto Low High 
dc395x: Performing initial SCSI bus reset
scsi0 : Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
libata version 2.00 loaded.
pata_via 0000:00:11.1: version 0.2.1
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xFF00 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFF08 irq 15
scsi1 : pata_via
ata1.00: ATA-7, max UDMA/100, 312581808 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATAPI, max PIO2, CDB intr
ata1.00: configured for UDMA/100
ata1.01: configured for PIO2
scsi2 : pata_via
ata2.00: ATAPI, max UDMA/66
ata2.01: ATAPI, max UDMA/33
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
scsi 1:0:0:0: Direct-Access     ATA      ST3160812A       3.AA PQ: 0 ANSI: 5
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 1:0:0:0: Attached scsi disk sda
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
         res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1: soft resetting port
sd 1:0:0:0: Attached scsi generic sg0 type 0
ata1.00: configured for UDMA/33
ata1.01: configured for PIO2
ata1: EH complete
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
         res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1: soft resetting port
ata1.00: configured for UDMA/33
ata1.01: configured for PIO2
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
         res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1: soft resetting port
ata1.00: configured for UDMA/33
ata1.01: configured for PIO2
ata1: EH complete
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
         res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1: soft resetting port
ata1.00: configured for UDMA/33
ata1.01: configured for PIO2
ata1: EH complete
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
scsi 2:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-4160B A306 PQ: 0 ANSI: 5
scsi 2:0:0:0: Attached scsi generic sg1 type 5
scsi 2:0:1:0: CD-ROM            TEAC     CD-W540E         1.0K PQ: 0 ANSI: 5
scsi 2:0:1:0: Attached scsi generic sg2 type 5
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/64:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
spurious 8259A interrupt: IRQ7.
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 2:0:0:0: Attached scsi CD-ROM sr0
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: (BMDMA stat 0x65)
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 254 in
         res 51/54:03:00:00:00/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: (BMDMA stat 0x65)
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 254 in
         res 51/54:03:00:00:00/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr1: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
sr 2:0:1:0: Attached scsi CD-ROM sr1
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
lp0: using parport0 (interrupt-driven).
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ieee80211_crypt: registered algorithm 'NULL'
ata2.00: configured for UDMA/66
ACPI: PCI Interrupt 0000:00:07.2[C] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:07.2: EHCI Host Controller
ehci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
NET: Registered protocol family 23
ehci_hcd 0000:00:07.2: irq 10, io mem 0xdfffee00
ehci_hcd 0000:00:07.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
hostap_pci: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
8139too Fast Ethernet driver 0.9.28
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xf0814f00, 00:50:fc:33:ce:ba, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
hostap_pci: Registered netdevice wifi0
8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
wifi0: Original COR value: 0x0
USB Universal Host Controller Interface driver v3.0
ata2.00: configured for UDMA/66
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
prism2_hw_init: initialized in 580 ms
wifi0: NIC: id=0x8013 v1.0.0
wifi0: PRI: id=0x15 v1.0.7
wifi0: STA: id=0x1f v1.3.6
ata2.00: configured for UDMA/66
Linux agpgart interface v0.101 (c) Dave Jones
gameport: NS558 PnP Gameport is pnp00:0a/gameport0, io 0x200, speed 877kHz
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
wifi0: defaulting to host-based encryption as a workaround for firmware bug in Host AP mode WEP
wifi0: defaulting to bogus WDS frame as a workaround for firmware bug in Host AP mode WDS
wifi0: Intersil Prism2.5 PCI: mem=0xdfdff000, irq=12
wifi0: registered netdevice wlan0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 2
ata2.01: configured for UDMA/33
ata2: EH complete
uhci_hcd 0000:00:11.2: irq 12, io base 0x0000c800
usb usb2: configuration #1 chosen from 1 choice
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:11.3: irq 12, io base 0x0000cc00
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
es1968: not attempting power management.
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
usb 3-2: new full speed USB device using uhci_hcd and address 2
es1968: clocking to 48000
ata2.00: configured for UDMA/66
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:07.0: OHCI Host Controller
ohci_hcd 0000:00:07.0: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:07.0: irq 5, io mem 0xdfffc000
usb 3-2: configuration #1 chosen from 1 choice
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ACPI: PCI Interrupt 0000:00:07.1[B] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
ohci_hcd 0000:00:07.1: OHCI Host Controller
ohci_hcd 0000:00:07.1: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:07.1: irq 12, io mem 0xdfffd000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
usb0: register 'gl620a' at usb-0000:00:11.3-2, Genesys GeneLink, 5e:c0:c5:2a:8a:0a
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
usb 4-2: new low speed USB device using ohci_hcd and address 2
ata2.00: configured for UDMA/66
usb 4-2: configuration #1 chosen from 1 choice
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
usb 4-3: new full speed USB device using ohci_hcd and address 3
ata2.00: configured for UDMA/66
usb 4-3: configuration #1 chosen from 1 choice
usbcore: registered new interface driver gl620a
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
usb 5-1: new low speed USB device using ohci_hcd and address 2
ata2.00: configured for UDMA/66
usb 5-1: string descriptor 0 read error: -22
usb 5-1: string descriptor 0 read error: -22
usb 5-1: configuration #1 chosen from 1 choice
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: (BMDMA stat 0x65)
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 254 in
         res 51/54:03:00:00:00/00:00:00:00:00/a0 Emask 0x1 (device error)
input: ATI/X10 RF USB Remote Control(0bc7,0004) as /class/input/input2
usbcore: registered new interface driver ati_remote
drivers/usb/input/ati_remote.c: Weird data, len=1 ff 00 00 00 00 00 ...
drivers/usb/input/ati_remote.c: Registered USB driver ATI/X10 RF USB Remote Control v. 2.2.1
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: (BMDMA stat 0x65)
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 254 in
         res 51/54:03:00:00:00/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
Adding 2104472k swap on /dev/sda5.  Priority:-1 extents:1 across:2104472k
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
loop: loaded (max 8 devices)
ReiserFS: sda6: found reiserfs format "3.6" with standard journal
ReiserFS: sda6: using ordered data mode
ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda6: checking transaction log (sda6)
ReiserFS: sda6: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input5
ACPI: Sleep Button (CM) [SLPB]
powernow-k8: Processor cpuid 644 not supported
powernow: No powernow capabilities detected
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NET: Registered protocol family 17
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
audit(1172434229.307:2): audit_pid=3602 old=0 by auid=4294967295
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
ata2.00: configured for UDMA/66
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
eth0: no IPv6 routers present
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized r128 2.5.0 20030725 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
         res 51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr1: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ACPI: PCI interrupt for device 0000:00:06.0 disabled
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xf12f6f00, 00:50:fc:33:ce:ba, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
eth0: no IPv6 routers present
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x1 (device error)
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
ata2: EH complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information

--------------020802020907040902030900--
