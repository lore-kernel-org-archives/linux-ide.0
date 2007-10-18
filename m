From: h292@ied.com
Subject: Re: Please help. ICH6 chipset: dvd drive dies after a short time
Date: Thu, 18 Oct 2007 13:12:02 -0400
Message-ID: <471793E2.1070004@ied.com>
References: <4713DE22.4010109@ied.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xtreme-157-79.static.aci.on.ca ([69.17.157.79]:48939 "EHLO
	mail.ied.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754393AbXJRRMH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 13:12:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.ied.com (sendmail) with ESMTP id 6B99D941B7
	for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 13:12:03 -0400 (EDT)
In-Reply-To: <4713DE22.4010109@ied.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


 hi,

getting no response to my original msg, i assume that it is better to
include the logs right inside the posted message. I hope that this way
it will be easier.

Could some knowledgeable soul please suggest something I could try to
avoid losing the DVD drive after a short while of uptime?

 thanks a bunch, the logs are 30 lines below.

    John

 
on 10/15/07 17:39 John said the following:
> hi, on a friend's laptop, the DVD drive dies after a short while and
> takes down the main HD's DMA down with it, hda has to be reinstantiated
> with hdparm -d1 /dev/hda,   but hdb (DVD drive) cannot be revived.
>
> tried with both kernel 2.6.17 and 2.6.22/23
>
> here is a link to 50kB+ debug info: http://ied.com/linux_dying_dvd_1.txt
> contents:
> ( uname -a; lspci; lspci -n; tail -600 /var/log/syslog; cd /proc ; head
> -100 $( cd /proc ; find ide -type f  ) ; hdparm -iI /dev/hda /dev/hdb )
> This contents was generated *after* the bug manifested, and manual
> hdparm -d1 /dev/hda was issued.
>
> What else should be in the contents to help you guys pinpoint the problem?
>
> Should I include the 50kB+ contents inside this message, or is posting a
> link better?
>  
> Can someone please suggest what to try to pass to kernel at boot to work
> around, so the drive doesn't die? (If I absolutely had to, I would try
> to recompile the kernel -- I haven't done that in a few years.)
>   

 # uname -a
  Linux lewlin 2.6.17-3 #1 SMP Wed May 19 23:31:20 MDT 2007 i686
Intel(R) Pentium(R) M processor 1.70GHz GNU/Linux


 # lspci
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 04)
00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 04)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 04)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 04)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 04)
02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8036 PCI-E
Fast Ethernet Controller (rev 10)
06:04.0 Network controller: Intel Corporation PRO/Wireless 2200BG
Network Connection (rev 05)
06:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
06:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394
Host Controller
06:09.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller
06:09.4 Class 0805: Texas Instruments PCI6411, PCI6421, PCI6611,
PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller

 # lspci -n
00:00.0 0600: 8086:2590 (rev 04)
00:02.0 0300: 8086:2592 (rev 04)
00:02.1 0380: 8086:2792 (rev 04)
00:1c.0 0604: 8086:2660 (rev 04)
00:1d.0 0c03: 8086:2658 (rev 04)
00:1d.1 0c03: 8086:2659 (rev 04)
00:1d.2 0c03: 8086:265a (rev 04)
00:1d.3 0c03: 8086:265b (rev 04)
00:1d.7 0c03: 8086:265c (rev 04)
00:1e.0 0604: 8086:2448 (rev d4)
00:1e.2 0401: 8086:266e (rev 04)
00:1f.0 0601: 8086:2641 (rev 04)
00:1f.1 0101: 8086:266f (rev 04)
00:1f.3 0c05: 8086:266a (rev 04)
02:00.0 0200: 11ab:4351 (rev 10)
06:04.0 0280: 8086:4220 (rev 05)
06:09.0 0607: 104c:8031
06:09.2 0c00: 104c:8032
06:09.3 0180: 104c:8033
06:09.4 0805: 104c:8034



Oct 13 00:19:05 lewlin syslogd 1.4.1: restart.
Oct 13 00:19:05 lewlin INIT: Loading ACPI module fan: successfull
Oct 13 00:19:05 lewlin INIT: Loading ACPI module hotkey: failed
Oct 13 00:19:05 lewlin INIT: Loading ACPI module processor: successfull
Oct 13 00:19:05 lewlin INIT: Loading ACPI module thermal: successfull
Oct 13 00:19:05 lewlin INIT: Loading ACPI module video: successfull
Oct 13 00:19:05 lewlin kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct 13 00:19:05 lewlin kernel: Inspecting /boot/System.map-2.6.17-3
Oct 13 00:19:06 lewlin kernel: Loaded 21496 symbols from
/boot/System.map-2.6.17-3.
Oct 13 00:19:06 lewlin kernel: Symbols match kernel version 2.6.17.
Oct 13 00:19:06 lewlin kernel: No module symbols loaded - kernel modules
not enabled.
Oct 13 00:19:06 lewlin kernel: Linux version 2.6.17-3 (root@localhost)
(gcc version 4.1.1 20060724 (prerelease) (4.1.1-2)) #1 SMP Wed May 19
23:31:20 MDT 2007
Oct 13 00:19:06 lewlin kernel: BIOS-provided physical RAM map:
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 0000000000000000 -
000000000009f800 (usable)
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 000000000009f800 -
00000000000a0000 (reserved)
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 00000000000dc000 -
0000000000100000 (reserved)
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 0000000000100000 -
000000007f6e0000 (usable)
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 000000007f6e0000 -
000000007f6ea000 (ACPI data)
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 000000007f6ea000 -
000000007f700000 (ACPI NVS)
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 000000007f700000 -
0000000080000000 (reserved)
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 00000000e0000000 -
00000000f0006000 (reserved)
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 00000000f0008000 -
00000000f000c000 (reserved)
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 00000000fed20000 -
00000000fed90000 (reserved)
Oct 13 00:19:06 lewlin kernel:  BIOS-e820: 00000000ff000000 -
0000000100000000 (reserved)
Oct 13 00:19:06 lewlin kernel: 1142MB HIGHMEM available.
Oct 13 00:19:06 lewlin kernel: 895MB LOWMEM available.
Oct 13 00:19:06 lewlin kernel: DMI present.
Oct 13 00:19:06 lewlin kernel: ACPI: PM-Timer IO Port: 0x1008
Oct 13 00:19:06 lewlin kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00]
enabled)
Oct 13 00:19:06 lewlin kernel: Processor #0 6:13 APIC version 20
Oct 13 00:19:06 lewlin kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01]
disabled)
Oct 13 00:19:06 lewlin kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge
lint[0x1])
Oct 13 00:19:06 lewlin kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge
lint[0x1])
Oct 13 00:19:06 lewlin kernel: ACPI: IOAPIC (id[0x01]
address[0xfec00000] gsi_base[0])
Oct 13 00:19:06 lewlin kernel: IOAPIC[0]: apic_id 1, version 32, address
0xfec00000, GSI 0-23
Oct 13 00:19:06 lewlin kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
Oct 13 00:19:06 lewlin kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 high level)
Oct 13 00:19:06 lewlin kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Oct 13 00:19:06 lewlin kernel: Using ACPI (MADT) for SMP configuration
information
Oct 13 00:19:06 lewlin kernel: Allocating PCI resources starting at
88000000 (gap: 80000000:60000000)
Oct 13 00:19:06 lewlin kernel: Built 1 zonelists
Oct 13 00:19:06 lewlin kernel: Enabling fast FPU save and restore... done.
Oct 13 00:19:06 lewlin kernel: Enabling unmasked SIMD FPU exception
support... done.
Oct 13 00:19:06 lewlin kernel: Initializing CPU#0
Oct 13 00:19:06 lewlin kernel: PID hash table entries: 4096 (order: 12,
16384 bytes)
Oct 13 00:19:06 lewlin kernel: Detected 1696.531 MHz processor.
Oct 13 00:19:06 lewlin kernel: Using pmtmr for high-res timesource
Oct 13 00:19:06 lewlin kernel: Console: colour VGA+ 80x25
Oct 13 00:19:06 lewlin kernel: Dentry cache hash table entries: 131072
(order: 7, 524288 bytes)
Oct 13 00:19:06 lewlin kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Oct 13 00:19:06 lewlin kernel: Memory: 2064556k/2087808k available
(2430k kernel code, 21468k reserved, 760k data, 244k init, 1170308k
highmem, 0k BadRAM)
Oct 13 00:19:06 lewlin kernel: Checking if this processor honours the WP
bit even in supervisor mode... Ok.
Oct 13 00:19:06 lewlin kernel: Calibrating delay using timer specific
routine.. 3397.78 BogoMIPS (lpj=6795567)
Oct 13 00:19:06 lewlin kernel: Mount-cache hash table entries: 512
Oct 13 00:19:06 lewlin kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Oct 13 00:19:06 lewlin kernel: CPU: L2 cache: 2048K
Oct 13 00:19:06 lewlin kernel: Intel machine check architecture supported.
Oct 13 00:19:06 lewlin kernel: Intel machine check reporting enabled on
CPU#0.
Oct 13 00:19:06 lewlin kernel: Checking 'hlt' instruction... OK.
Oct 13 00:19:06 lewlin kernel: SMP alternatives: switching to UP code
Oct 13 00:19:06 lewlin kernel: Freeing SMP alternatives: 16k freed
Oct 13 00:19:06 lewlin kernel: checking if image is initramfs... it is
Oct 13 00:19:06 lewlin kernel: Freeing initrd memory: 391k freed
Oct 13 00:19:06 lewlin kernel: ACPI: Looking for DSDT in initramfs...
error, file /DSDT.aml not found.
Oct 13 00:19:06 lewlin kernel: CPU0: Intel(R) Pentium(R) M processor
1.70GHz stepping 08
Oct 13 00:19:06 lewlin kernel: Total of 1 processors activated (3397.78
BogoMIPS).
Oct 13 00:19:06 lewlin kernel: ENABLING IO-APIC IRQs
Oct 13 00:19:06 lewlin kernel: ..TIMER: vector=0x31 apic1=0 pin1=2
apic2=-1 pin2=-1
Oct 13 00:19:06 lewlin kernel: Brought up 1 CPUs
Oct 13 00:19:06 lewlin kernel: migration_cost=0
Oct 13 00:19:06 lewlin kernel: NET: Registered protocol family 16
Oct 13 00:19:06 lewlin kernel: ACPI: bus type pci registered
Oct 13 00:19:06 lewlin kernel: PCI: Using MMCONFIG
Oct 13 00:19:06 lewlin kernel: Setting up standard PCI resources
Oct 13 00:19:06 lewlin kernel: ACPI: Subsystem revision 20060127
Oct 13 00:19:06 lewlin kernel: ACPI: Interpreter enabled
Oct 13 00:19:06 lewlin kernel: ACPI: Using IOAPIC for interrupt routing
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Oct 13 00:19:06 lewlin kernel: PCI quirk: region 1000-107f claimed by
ICH6 ACPI/GPIO/TCO
Oct 13 00:19:06 lewlin kernel: PCI quirk: region 1180-11bf claimed by
ICH6 GPIO
Oct 13 00:19:06 lewlin kernel: PCI: Ignoring BAR0-3 of IDE controller
0000:00:1f.1
Oct 13 00:19:06 lewlin kernel: PCI: Transparent bridge - 0000:00:1e.0
Oct 13 00:19:06 lewlin kernel: PCI: Bus #07 (-#0a) is hidden behind
transparent bridge #06 (-#07) (try 'pci=assign-busses')
Oct 13 00:19:06 lewlin kernel: Please report the result to linux-kernel
to fix this permanently
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 11) *10
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 11)
*0, disabled.
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *11
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 11) *10
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
Oct 13 00:19:06 lewlin kernel: ACPI: Embedded Controller [EC0] (gpe 28)
interrupt mode.
Oct 13 00:19:06 lewlin kernel: Linux Plug and Play Support v0.97 (c)
Adam Belay
Oct 13 00:19:06 lewlin kernel: pnp: PnP ACPI init
Oct 13 00:19:06 lewlin kernel: pnp: PnP ACPI: found 9 devices
Oct 13 00:19:06 lewlin kernel: PnPBIOS: Disabled
Oct 13 00:19:06 lewlin kernel: PCI: Using ACPI for IRQ routing
Oct 13 00:19:06 lewlin kernel: PCI: If a device doesn't work, try
"pci=routeirq".  If it helps, post a report
Oct 13 00:19:06 lewlin kernel: PCI: Ignore bogus resource 6 [0:0] of
0000:00:02.0
Oct 13 00:19:06 lewlin kernel: PCI: Bridge: 0000:00:1c.0
Oct 13 00:19:06 lewlin kernel:   IO window: 3000-3fff
Oct 13 00:19:06 lewlin kernel:   MEM window: b4000000-b7ffffff
Oct 13 00:19:06 lewlin kernel:   PREFETCH window: d0000000-d3ffffff
Oct 13 00:19:06 lewlin kernel: PCI: Bus 7, cardbus bridge: 0000:06:09.0
Oct 13 00:19:06 lewlin kernel:   IO window: 00004000-000040ff
Oct 13 00:19:06 lewlin kernel:   IO window: 00004400-000044ff
Oct 13 00:19:06 lewlin kernel:   PREFETCH window: 88000000-89ffffff
Oct 13 00:19:06 lewlin kernel:   MEM window: 8c000000-8dffffff
Oct 13 00:19:06 lewlin kernel: PCI: Bridge: 0000:00:1e.0
Oct 13 00:19:06 lewlin kernel:   IO window: 4000-4fff
Oct 13 00:19:06 lewlin kernel:   MEM window: b8000000-b80fffff
Oct 13 00:19:06 lewlin kernel:   PREFETCH window: 88000000-89ffffff
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] ->
GSI 17 (level, low) -> IRQ 16
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:06:09.0[A] ->
GSI 16 (level, low) -> IRQ 17
Oct 13 00:19:06 lewlin kernel: NET: Registered protocol family 2
Oct 13 00:19:06 lewlin kernel: IP route cache hash table entries: 32768
(order: 5, 131072 bytes)
Oct 13 00:19:06 lewlin kernel: TCP established hash table entries:
262144 (order: 9, 2097152 bytes)
Oct 13 00:19:06 lewlin kernel: TCP bind hash table entries: 65536
(order: 7, 524288 bytes)
Oct 13 00:19:06 lewlin kernel: TCP: Hash tables configured (established
262144 bind 65536)
Oct 13 00:19:06 lewlin kernel: TCP reno registered
Oct 13 00:19:06 lewlin kernel: Simple Boot Flag at 0x36 set to 0x1
Oct 13 00:19:06 lewlin kernel: apm: BIOS not found.
Oct 13 00:19:06 lewlin kernel: audit: initializing netlink socket (disabled)
Oct 13 00:19:06 lewlin kernel: audit(1192321128.652:1): initialized
Oct 13 00:19:06 lewlin kernel: highmem bounce pool size: 64 pages
Oct 13 00:19:06 lewlin kernel: Total HugeTLB memory allocated, 0
Oct 13 00:19:06 lewlin kernel: VFS: Disk quotas dquot_6.5.1
Oct 13 00:19:06 lewlin kernel: Dquot-cache hash table entries: 1024
(order 0, 4096 bytes)
Oct 13 00:19:06 lewlin kernel: Initializing Cryptographic API
Oct 13 00:19:06 lewlin kernel: io scheduler noop registered
Oct 13 00:19:06 lewlin kernel: io scheduler anticipatory registered
(default)
Oct 13 00:19:06 lewlin kernel: io scheduler deadline registered
Oct 13 00:19:06 lewlin kernel: io scheduler cfq registered
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] ->
GSI 17 (level, low) -> IRQ 16
Oct 13 00:19:06 lewlin kernel: assign_interrupt_mode Found MSI capability
Oct 13 00:19:06 lewlin kernel: isapnp: Scanning for PnP cards...
Oct 13 00:19:06 lewlin kernel: isapnp: No Plug & Play device found
Oct 13 00:19:06 lewlin kernel: Real Time Clock Driver v1.12ac
Oct 13 00:19:06 lewlin kernel: Serial: 8250/16550 driver $Revision: 1.90
$ 4 ports, IRQ sharing enabled
Oct 13 00:19:06 lewlin kernel: RAMDISK driver initialized: 16 RAM disks
of 32000K size 1024 blocksize
Oct 13 00:19:06 lewlin kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Oct 13 00:19:06 lewlin kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Oct 13 00:19:06 lewlin kernel: ICH6: IDE controller at PCI slot 0000:00:1f.1
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] ->
GSI 18 (level, low) -> IRQ 18
Oct 13 00:19:06 lewlin kernel: ICH6: chipset revision 4
Oct 13 00:19:06 lewlin kernel: ICH6: not 100% native mode: will probe
irqs later
Oct 13 00:19:06 lewlin kernel:     ide0: BM-DMA at 0x1810-0x1817, BIOS
settings: hda:DMA, hdb:DMA
Oct 13 00:19:06 lewlin kernel: hda: FUJITSU MHV2100AT PL, ATA DISK drive
Oct 13 00:19:06 lewlin kernel: hdb: PHILIPS DVD+/-RW SDVD8441, ATAPI
CD/DVD-ROM drive
Oct 13 00:19:06 lewlin kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 13 00:19:06 lewlin kernel: hda: max request size: 128KiB
Oct 13 00:19:06 lewlin kernel: hda: 195371568 sectors (100030 MB)
w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
Oct 13 00:19:06 lewlin kernel: hda: cache flushes supported
Oct 13 00:19:06 lewlin kernel:  hda: hda1 hda2 hda3 < hda5 hda6 >
Oct 13 00:19:06 lewlin kernel: PNP: PS/2 Controller
[PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Oct 13 00:19:06 lewlin kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 13 00:19:06 lewlin kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 13 00:19:06 lewlin kernel: mice: PS/2 mouse device common for all mice
Oct 13 00:19:06 lewlin kernel: md: md driver 0.90.3 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Oct 13 00:19:06 lewlin kernel: md: bitmap version 4.39
Oct 13 00:19:06 lewlin kernel: TCP bic registered
Oct 13 00:19:06 lewlin kernel: NET: Registered protocol family 1
Oct 13 00:19:06 lewlin kernel: Using IPI No-Shortcut mode
Oct 13 00:19:06 lewlin kernel: ACPI wakeup devices:
Oct 13 00:19:06 lewlin kernel:  LID AZAL RP01 USB1 USB2 USB3 USB4 USB7
LANC CRDB MODM
Oct 13 00:19:06 lewlin kernel: ACPI: (supports S0 S3 S4 S5)
Oct 13 00:19:06 lewlin kernel: BIOS EDD facility v0.16 2004-Jun-25, 1
devices found
Oct 13 00:19:06 lewlin kernel: Freeing unused kernel memory: 244k freed
Oct 13 00:19:06 lewlin kernel: input: AT Translated Set 2 keyboard as
/class/input/input0
Oct 13 00:19:06 lewlin kernel: Synaptics Touchpad, model: 1, fw: 5.9,
id: 0x23aeb3, caps: 0xa04713/0x10008
Oct 13 00:19:06 lewlin kernel: input: SynPS/2 Synaptics TouchPad as
/class/input/input1
Oct 13 00:19:06 lewlin kernel: ts: Compaq touchscreen protocol output
Oct 13 00:19:06 lewlin kernel: usbcore: registered new driver usbfs
Oct 13 00:19:06 lewlin kernel: usbcore: registered new driver hub
Oct 13 00:19:06 lewlin kernel: USB Universal Host Controller Interface
driver v3.0
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] ->
GSI 19 (level, low) -> IRQ 19
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.0: new USB bus
registered, assigned bus number 1
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.0: irq 19, io base
0x00001820
Oct 13 00:19:06 lewlin kernel: usb usb1: configuration #1 chosen from 1
choice
Oct 13 00:19:06 lewlin kernel: hub 1-0:1.0: USB hub found
Oct 13 00:19:06 lewlin kernel: hub 1-0:1.0: 2 ports detected
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] ->
GSI 23 (level, low) -> IRQ 20
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.1: new USB bus
registered, assigned bus number 2
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.1: irq 20, io base
0x00001840
Oct 13 00:19:06 lewlin kernel: usb usb2: configuration #1 chosen from 1
choice
Oct 13 00:19:06 lewlin kernel: hub 2-0:1.0: USB hub found
Oct 13 00:19:06 lewlin kernel: hub 2-0:1.0: 2 ports detected
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] ->
GSI 22 (level, low) -> IRQ 21
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.2: new USB bus
registered, assigned bus number 3
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.2: irq 21, io base
0x00001860
Oct 13 00:19:06 lewlin kernel: usb usb3: configuration #1 chosen from 1
choice
Oct 13 00:19:06 lewlin kernel: hub 3-0:1.0: USB hub found
Oct 13 00:19:06 lewlin kernel: hub 3-0:1.0: 2 ports detected
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] ->
GSI 22 (level, low) -> IRQ 21
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.3: new USB bus
registered, assigned bus number 4
Oct 13 00:19:06 lewlin kernel: uhci_hcd 0000:00:1d.3: irq 21, io base
0x00001880
Oct 13 00:19:06 lewlin kernel: usb usb4: configuration #1 chosen from 1
choice
Oct 13 00:19:06 lewlin kernel: hub 4-0:1.0: USB hub found
Oct 13 00:19:06 lewlin kernel: hub 4-0:1.0: 2 ports detected
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] ->
GSI 19 (level, low) -> IRQ 19
Oct 13 00:19:06 lewlin kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Oct 13 00:19:06 lewlin kernel: ehci_hcd 0000:00:1d.7: new USB bus
registered, assigned bus number 5
Oct 13 00:19:06 lewlin kernel: ehci_hcd 0000:00:1d.7: debug port 1
Oct 13 00:19:06 lewlin kernel: ehci_hcd 0000:00:1d.7: irq 19, io mem
0xb0040000
Oct 13 00:19:06 lewlin kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started,
EHCI 1.00, driver 10 Dec 2004
Oct 13 00:19:06 lewlin kernel: usb usb5: configuration #1 chosen from 1
choice
Oct 13 00:19:06 lewlin kernel: hub 5-0:1.0: USB hub found
Oct 13 00:19:06 lewlin kernel: hub 5-0:1.0: 8 ports detected
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:06:09.2[C] ->
GSI 18 (level, low) -> IRQ 18
Oct 13 00:19:06 lewlin kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI):
IRQ=[18]  MMIO=[b8007000-b80077ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Oct 13 00:19:06 lewlin kernel: fuse init (API version 7.6)
Oct 13 00:19:06 lewlin kernel: Non-volatile memory driver v1.2
Oct 13 00:19:06 lewlin kernel: hw_random: RNG not detected
Oct 13 00:19:06 lewlin kernel: Linux agpgart interface v0.101 (c) Dave Jones
Oct 13 00:19:06 lewlin kernel: agpgart: Detected an Intel 915GM Chipset.
Oct 13 00:19:06 lewlin kernel: agpgart: Detected 7932K stolen memory.
Oct 13 00:19:06 lewlin kernel: agpgart: AGP aperture is 256M @ 0xc0000000
Oct 13 00:19:06 lewlin kernel: ACPI: CPU0 (power states: C1[C1] C2[C2]
C3[C3] C4[C3])
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:06:09.0[A] ->
GSI 16 (level, low) -> IRQ 17
Oct 13 00:19:06 lewlin kernel: Yenta: CardBus bridge found at
0000:06:09.0 [107b:0365]
Oct 13 00:19:06 lewlin kernel: Yenta: Using CSCINT to route CSC
interrupts to PCI
Oct 13 00:19:06 lewlin kernel: Yenta: Routing CardBus interrupts to PCI
Oct 13 00:19:06 lewlin kernel: Yenta TI: socket 0000:06:09.0, mfunc
0x01ac1b22, devctl 0x64
Oct 13 00:19:06 lewlin kernel: Yenta: ISA IRQ mask 0x0cf8, PCI irq 17
Oct 13 00:19:06 lewlin kernel: Socket status: 30000810
Oct 13 00:19:06 lewlin kernel: pcmcia: parent PCI bridge I/O window:
0x4000 - 0x4fff
Oct 13 00:19:06 lewlin kernel: cs: IO port probe 0x4000-0x4fff: clean.
Oct 13 00:19:06 lewlin kernel: pcmcia: parent PCI bridge Memory window:
0xb8000000 - 0xb80fffff
Oct 13 00:19:06 lewlin kernel: pcmcia: parent PCI bridge Memory window:
0x88000000 - 0x89ffffff
Oct 13 00:19:06 lewlin kernel: device-mapper: 4.6.0-ioctl (2006-02-17)
initialised: dm-devel@redhat.com
Oct 13 00:19:06 lewlin kernel: pccard: PCMCIA card inserted into slot 0
Oct 13 00:19:06 lewlin kernel: cs: memory probe 0xb8000000-0xb80fffff:
excluding 0xb8000000-0xb800ffff
Oct 13 00:19:06 lewlin kernel: pcmcia: registering new device pcmcia0.0
Oct 13 00:19:06 lewlin kernel: cs: IO port probe 0x100-0x3af: clean.
Oct 13 00:19:06 lewlin kernel: cs: IO port probe 0x3e0-0x4ff: excluding
0x4d0-0x4d7
Oct 13 00:19:06 lewlin kernel: cs: IO port probe 0x820-0x8ff: clean.
Oct 13 00:19:06 lewlin kernel: cs: IO port probe 0xc00-0xcf7: clean.
Oct 13 00:19:06 lewlin kernel: cs: IO port probe 0xa00-0xaff: clean.
Oct 13 00:19:06 lewlin kernel: hdc: LEXAR ATA_FLASH CARD, CFA DISK drive
Oct 13 00:19:06 lewlin kernel: hdd: probing with STATUS(0xc0) instead of
ALTSTATUS(0x0a)
Oct 13 00:19:06 lewlin kernel: EXT3-fs: Unrecognized mount option
"notail" or missing value
Oct 13 00:19:06 lewlin kernel: FAT: utf8 is not a recommended IO charset
for FAT filesystems, filesystem will be case sensitive!
Oct 13 00:19:06 lewlin kernel: loop: loaded (max 8 devices, max 1
partitions per device)
Oct 13 00:19:06 lewlin kernel: hdd: probing with STATUS(0x00) instead of
ALTSTATUS(0x0a)
Oct 13 00:19:06 lewlin kernel: Adding 2088408k swap on
/dev/mapper/swap.  Priority:-1 extents:1 across:2088408k
Oct 13 00:19:06 lewlin kernel: hdb: ATAPI 24X DVD-ROM DVD-R CD-R/RW
drive, 2048kB Cache, UDMA(33)
Oct 13 00:19:06 lewlin kernel: Uniform CD-ROM driver Revision: 3.20
Oct 13 00:19:06 lewlin kernel: ide1 at 0x4100-0x4107,0x410e on irq 3
Oct 13 00:19:06 lewlin kernel: hdc: max request size: 128KiB
Oct 13 00:19:06 lewlin kernel: hdc: 129024 sectors (66 MB) w/1KiB Cache,
CHS=1008/4/32
Oct 13 00:19:06 lewlin kernel: hdc: cache flushes not supported
Oct 13 00:19:06 lewlin kernel:  hdc: hdc1
Oct 13 00:19:06 lewlin kernel: ide-cs: hdc: Vpp = 0.0
Oct 13 00:19:06 lewlin kernel: ACPI: AC Adapter [ACAD] (on-line)
Oct 13 00:19:06 lewlin kernel: ACPI: Battery Slot [BAT1] (battery present)
Oct 13 00:19:06 lewlin kernel: ACPI: Power Button (FF) [PWRF]
Oct 13 00:19:06 lewlin kernel: ACPI: Power Button (CM) [PWRB]
Oct 13 00:19:06 lewlin kernel: ACPI: Sleep Button (CM) [SLPB]
Oct 13 00:19:06 lewlin kernel: ACPI: Lid Switch [LID]
Oct 13 00:19:06 lewlin kernel: Using specific hotkey driver
Oct 13 00:19:06 lewlin kernel: ACPI: Thermal Zone [THRM] (40 C)
Oct 13 00:19:06 lewlin kernel: ACPI: Video Device [VGA_PEGP]
(multi-head: yes  rom: no  post: no)
Oct 13 00:19:06 lewlin kernel: ACPI: Video Device [GFX0_PCI0]
(multi-head: yes  rom: yes  post: no)
Oct 13 00:19:06 lewlin kernel: ACPI: PCI Interrupt 0000:00:1e.2[A] ->
GSI 21 (level, low) -> IRQ 22
Oct 13 00:19:06 lewlin kernel: NET: Registered protocol family 17
Oct 13 00:19:06 lewlin kernel: intel8x0_measure_ac97_clock: measured
53769 usecs
Oct 13 00:19:06 lewlin kernel: intel8x0: clocking to 48000
Oct 13 00:19:06 lewlin smartd[1941]: smartd version 5.36
[i586-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Oct 13 00:19:06 lewlin smartd[1941]: Home page is
http://smartmontools.sourceforge.net/  
Oct 13 00:19:06 lewlin smartd[1941]: Opened configuration file
/etc/smartd.conf
Oct 13 00:19:06 lewlin smartd[1941]: Configuration file /etc/smartd.conf
was parsed, found DEVICESCAN, scanning devices
Oct 13 00:19:06 lewlin smartd[1941]: Problem creating device name scan list
Oct 13 00:19:06 lewlin smartd[1941]: Device: /dev/hda, opened
Oct 13 00:19:06 lewlin smartd[1941]: Device: /dev/hda, not found in
smartd database.
Oct 13 00:19:06 lewlin smartd[1941]: Device: /dev/hda, enabled SMART
Attribute Autosave.
Oct 13 00:19:08 lewlin smartd[1941]: Device: /dev/hda, enabled SMART
Automatic Offline Testing.
Oct 13 00:19:08 lewlin smartd[1941]: Device: /dev/hda, is SMART capable.
Adding to "monitor" list.
Oct 13 00:19:08 lewlin smartd[1941]: Device: /dev/hdb, opened
Oct 13 00:19:08 lewlin smartd[1941]: Device: /dev/hdb, packet devices
[this device CD/DVD] not SMART capable
Oct 13 00:19:08 lewlin smartd[1941]: Device: /dev/hdc, opened
Oct 13 00:19:08 lewlin kernel: hdc: drive_cmd: status=0x51 { DriveReady
SeekComplete Error }
Oct 13 00:19:08 lewlin kernel: hdc: drive_cmd: error=0x04 {
DriveStatusError }
Oct 13 00:19:08 lewlin kernel: ide: failed opcode was: 0xa1
Oct 13 00:19:08 lewlin smartd[1941]: Device: /dev/hdc, packet devices
[this device Write-once (optical disk)] not SMART capable
Oct 13 00:19:08 lewlin smartd[1941]: Monitoring 1 ATA and 0 SCSI devices
Oct 13 00:19:09 lewlin smartd[2121]: smartd has fork()ed into background
mode. New PID=2121.
Oct 13 00:19:11 lewlin kernel: hdc: drive_cmd: status=0x51 { DriveReady
SeekComplete Error }
Oct 13 00:19:11 lewlin kernel: hdc: drive_cmd: error=0x04 {
DriveStatusError }
Oct 13 00:19:11 lewlin kernel: ide: failed opcode was: 0xef
Oct 13 00:19:11 lewlin kernel: ieee80211: 802.11 data/management/control
stack, git-1.1.13
Oct 13 00:19:11 lewlin kernel: ieee80211: Copyright (C) 2004-2005 Intel
Corporation <jketreno@linux.intel.com>
Oct 13 00:19:11 lewlin kernel: ipw2200: Intel(R) PRO/Wireless 2200/2915
Network Driver, 1.1.2kmpr
Oct 13 00:19:11 lewlin kernel: ipw2200: Copyright(c) 2003-2006 Intel
Corporation
Oct 13 00:19:11 lewlin kernel: ACPI: PCI Interrupt 0000:06:04.0[A] ->
GSI 17 (level, low) -> IRQ 16
Oct 13 00:19:11 lewlin kernel: ipw2200: Detected Intel PRO/Wireless
2200BG Network Connection
Oct 13 00:19:11 lewlin kernel: ipw2200: Detected geography ZZM (11
802.11bg channels, 0 802.11a channels)
Oct 13 00:19:11 lewlin ifplugd(eth1)[2451]: ifplugd 0.28 initializing.
Oct 13 00:19:11 lewlin ifplugd(eth1)[2451]: Using interface
eth1/00:13:CE:FB:01:37 with driver <ipw2200> (version: 1.1.2kmpr)
Oct 13 00:19:11 lewlin ifplugd(eth1)[2451]: Using detection mode:
SIOCETHTOOL
Oct 13 00:19:11 lewlin ifplugd(eth1)[2451]: Initialization complete,
link beat not detected.
Oct 13 00:19:12 lewlin kernel: usbcore: registered new driver rt2570
Oct 13 00:19:12 lewlin kernel: tun: Universal TUN/TAP device driver, 1.6
Oct 13 00:19:12 lewlin kernel: tun: (C) 1999-2004 Max Krasnyansky
<maxk@qualcomm.com>
Oct 13 00:19:12 lewlin udevd-event[2649]: udev_node_symlink:
symlink(../tun, /dev/net/tun) failed: File exists
Oct 13 00:19:12 lewlin kernel: EXT3-fs: Unrecognized mount option
"notail" or missing value
Oct 13 00:19:13 lewlin kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Oct 13 00:19:14 lewlin kernel: NET: Registered protocol family 10
Oct 13 00:19:14 lewlin kernel: lo: Disabled Privacy Extensions
Oct 13 00:19:14 lewlin kernel: ADDRCONF(NETDEV_UP): eth1: link is not ready
Oct 13 00:19:14 lewlin kernel: IPv6 over IPv4 tunneling driver
Oct 13 00:19:14 lewlin udevd-event[2783]: rename_netif: error changing
netif name sit0 to : Invalid argument
Oct 13 00:19:15 lewlin kdm_config[2790]: Invalid option value 'None' at
/usr/share/config/kdm/kdmrc:359
Oct 13 00:19:15 lewlin kernel: ADDRCONF(NETDEV_CHANGE): eth1: link
becomes ready
Oct 13 00:19:15 lewlin kernel: Netfilter messages via NETLINK v0.30.
Oct 13 00:19:15 lewlin kernel: ip_conntrack version 2.4 (8192 buckets,
65536 max) - 224 bytes per conntrack
Oct 13 00:19:15 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:19:16 lewlin ifplugd(eth1)[2451]: Executing
'/etc/ifplugd/ifplugd.action eth1 up'.
Oct 13 00:19:17 lewlin kernel: [drm] Initialized drm 1.0.1 20051102
Oct 13 00:19:17 lewlin kernel: ACPI: PCI Interrupt 0000:00:02.0[A] ->
GSI 16 (level, low) -> IRQ 17
Oct 13 00:19:17 lewlin kernel: [drm] Initialized i915 1.4.0 20060119 on
minor 0
Oct 13 00:19:17 lewlin kernel: ClusterIP Version 0.8 loaded successfully
Oct 13 00:19:18 lewlin kernel: ipt_recent v0.3.1: Stephen Frost
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Oct 13 00:19:20 lewlin ifplugd(eth1)[2451]: Program executed successfully.
Oct 13 00:19:23 lewlin kernel: netfilter PSD loaded - (c) astaro AG
Oct 13 00:19:23 lewlin kernel: IFWLOG: register target
Oct 13 00:19:23 lewlin logger: Shorewall started
Oct 13 00:19:24 lewlin kernel: device eth1 entered promiscuous mode
Oct 13 00:19:24 lewlin kernel: audit(1192335564.188:2): dev=eth1
prom=256 old_prom=0 auid=4294967295
Oct 13 00:19:25 lewlin cpufreqd: apm_init                 : /proc/apm:
No such file or directory
Oct 13 00:19:25 lewlin xinetd[4767]: xinetd Version 2.3.14 started with
libwrap options compiled in.
Oct 13 00:19:25 lewlin xinetd[4767]: Started working: 0 available services
Oct 13 00:19:25 lewlin cpufreqd: pmu_init                 :
/proc/pmu/info: No such file or directory
Oct 13 00:19:25 lewlin cpufreqd: sensors_post_conf        :
sensors_init() failed, sensosrs disabled!
Oct 13 00:19:25 lewlin cpufreqd: plugins_post_conf        : Unable to
configure plugin sensors_plugin, removing
Oct 13 00:19:25 lewlin cpufreqd: nforce2_post_conf        :
Unconfigured, exiting.
Oct 13 00:19:25 lewlin cpufreqd: plugins_post_conf        : Unable to
configure plugin nforce2_atxp1, removing
Oct 13 00:47:53 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:47:54 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:48:06 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:48:07 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:48:20 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:48:21 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:48:30 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:48:31 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:48:40 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:48:41 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:48:44 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:48:45 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:48:53 lewlin kernel: ipw2200: Firmware error detected. 
Restarting.
Oct 13 00:48:53 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:48:54 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:49:13 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:49:14 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:49:30 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:49:31 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:49:34 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:49:35 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:49:48 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:49:49 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:50:08 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:50:09 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:50:20 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:50:21 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:50:25 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:50:26 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:50:33 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:50:34 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:51:00 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:51:01 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:51:04 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:51:05 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:51:28 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:51:29 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:51:52 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:51:53 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:52:11 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:52:12 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:52:27 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:52:28 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:52:31 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:52:32 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:52:35 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:52:36 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:52:42 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:52:43 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:53:00 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:53:01 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:53:07 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:53:08 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:53:21 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:53:22 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:53:41 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:53:42 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:53:58 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:53:59 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:54:46 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:54:47 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:56:06 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:56:07 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:57:07 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:57:08 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:58:02 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:58:03 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 00:58:09 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 00:58:10 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 17:08:46 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 17:08:47 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 17:09:32 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 17:09:33 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 17:09:37 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 13 17:09:38 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 13 17:38:50 lewlin kernel: hdc: drive_cmd: status=0x51 { DriveReady
SeekComplete Error }
Oct 13 17:38:50 lewlin kernel: hdc: drive_cmd: error=0x04 {
DriveStatusError }
Oct 13 17:38:50 lewlin kernel: ide: failed opcode was: 0xef
Oct 13 17:38:51 lewlin kernel: hdc: drive_cmd: status=0x51 { DriveReady
SeekComplete Error }
Oct 13 17:38:51 lewlin kernel: hdc: drive_cmd: error=0x04 {
DriveStatusError }
Oct 13 17:38:51 lewlin kernel: ide: failed opcode was: 0xef
Oct 14 13:21:26 lewlin kernel: hdb: status timeout: status=0x90 { Busy }
Oct 14 13:21:26 lewlin kernel: ide: failed opcode was: unknown
Oct 14 13:21:26 lewlin kernel: hdb: DMA disabled
Oct 14 13:21:56 lewlin kernel: hdb: ATAPI reset timed-out, status=0x90
Oct 14 13:21:56 lewlin kernel: hda: DMA disabled
Oct 14 13:22:28 lewlin kernel: ide0: reset timed-out, status=0xd0
Oct 14 13:22:34 lewlin kernel: hdb: status timeout: status=0x90 { Busy }
Oct 14 13:22:34 lewlin kernel: ide: failed opcode was: unknown
Oct 14 13:22:34 lewlin kernel: hdb: drive not ready for command
Oct 14 13:22:34 lewlin kernel: ipw2200: Firmware error detected. 
Restarting.
Oct 14 13:22:34 lewlin ifplugd(eth1)[2451]: Link beat lost.
Oct 14 13:22:35 lewlin ifplugd(eth1)[2451]: Link beat detected.
Oct 14 13:23:04 lewlin kernel: hdb: ATAPI reset timed-out, status=0x90
Oct 14 13:23:35 lewlin kernel: ide0: reset timed-out, status=0xd0


 # head -100 $( cd /proc ; find ide -type f  )

==> ide/ide1/hdc/settings <==
name            value        min        max        mode
----            -----        ---        ---        ----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                1008            0               65535           rw
bios_head               4               0               255             rw
bios_sect               32              0               63              rw
bswap                   0               0               1               r
current_speed           0               0               70              rw
failures                0               0               65535           rw
init_speed              0               0               70              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               0               0               1               rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw
wcache                  1               0               1               rw

==> ide/ide1/hdc/model <==
LEXAR ATA_FLASH CARD

==> ide/ide1/hdc/media <==
disk

==> ide/ide1/hdc/identify <==
848a 03f0 0000 0004 4000 0200 0020 0001
f800 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0002 0002 0004 5636
2e30 332e 2020 4c45 5841 5220 4154 415f
464c 4153 4820 4341 5244 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0001
0000 0200 0000 0200 0000 0001 03f0 0004
0020 f800 0001 0100 f800 0001 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 4245 5248 414e 5520 494d 414e 2020
2020 2020 424f 4220 5245 4944 2020 2020
2020 2020 4b45 4e20 5345 544f 2020 2020
2020 4849 524f 2054 4148 4152 4120 e4f8
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

==> ide/ide1/hdc/driver <==
ide-disk version 1.18

==> ide/ide1/model <==
pci

==> ide/ide1/mate <==
(none)

==> ide/ide1/channel <==
0

==> ide/drivers <==
ide-disk version 1.18
ide-cdrom version 4.61

==> ide/ide0/hdb/capacity <==
205480079


==> ide/ide0/hdb/settings <==
name            value        min        max        mode
----            -----        ---        ---        ----
current_speed           66              0               70              rw
dsc_overlap             1               0               1               rw
init_speed              66              0               70              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
nice1                   1               0               1               rw
number                  1               0               3               rw
pio_mode                write-only      0               255             w
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw

==> ide/ide0/hdb/model <==
PHILIPS DVD+/-RW SDVD8441

==> ide/ide0/hdb/media <==
cdrom

==> ide/ide0/hdb/identify <==
000a 6f72 0a6d 2000 5644 2b44 2d2f 5752
5320 5644 3844 3434 0a31 6500 2d0a 2d2d
092d 0909 2d2d 2d2d 092d 2d09 2d2d 0909
2d2d 092d 2d09 2d2d 0a2d 7563 7272 6e65
5f74 7073 6565 2064 2020 2020 2020 2020
2020 3636 2020 2020 2020 2020 2020 2020
2020 2030 2020 2020 2020 2020 2020 2020
2020 3037 2020 2020 2020 2020 2020 2020
2020 7772 640a 6373 6f5f 6576 6c72 7061
2020 2020 2020 2020 2020 2020 3120 2020
2020 2020 2020 2020 2020 2020 3020 2020
2020 2020 2020 2020 2020 2020 3120 2020
2020 2020 2020 2020 2020 2020 7220 0a77
6e69 7469 735f 6570 6465 2020 2020 2020
2020 2020 2020 2020 3636 2020 2020 2020
2020 2020 2020 2020 2030 2020 2020 2020
2020 2020 2020 2020 3037 2020 2020 2020
2020 2020 2020 2020 7772 690a 5f6f 3233
6962 2074 2020 2020 2020 2020 2020 2020
2020 3020 2020 2020 2020 2020 2020 2020
2020 3020 2020 2020 2020 2020 2020 2020
2020 3320 2020 2020 2020 2020 2020 2020
2020 7220 0a77 656b 7065 6573 7474 6e69
7367 2020 2020 2020 2020 2020 2020 2030
2020 2020 2020 2020 2020 2020 2020 2030
2020 2020 2020 2020 2020 2020 2020 2031
2020 2020 2020 2020 2020 2020 2020 7772
6e0a 6369 3165 2020 2020 2020 2020 2020
2020 2020 2020 2020 3120 2020 2020 2020
2020 2020 2020 2020 3020 2020 2020 2020
2020 2020 2020 2020 3120 2020 2020 2020
2020 2020 2020 2020 7220 0a77 756e 626d

==> ide/ide0/hdb/driver <==
ide-cdrom version 4.61

==> ide/ide0/hda/smart_thresholds <==
0010 2e01 0000 0000 0000 0000 0000 1e02
0000 0000 0000 0000 0000 1903 0000 0000
0000 0000 0000 0004 0000 0000 0000 0000
0000 1805 0000 0000 0000 0000 0000 2f07
0000 0000 0000 0000 0000 1308 0000 0000
0000 0000 0000 0009 0000 0000 0000 0000
0000 140a 0000 0000 0000 0000 0000 000c
0000 0000 0000 0000 0000 00c0 0000 0000
0000 0000 0000 00c1 0000 0000 0000 0000
0000 00c2 0000 0000 0000 0000 0000 00c3
0000 0000 0000 0000 0000 00c4 0000 0000
0000 0000 0000 00c5 0000 0000 0000 0000
0000 00c6 0000 0000 0000 0000 0000 00c7
0000 0000 0000 0000 0000 3cc8 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 00cb
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 f500

==> ide/ide0/hda/smart_values <==
0010 0f01 6400 3764 00e7 0000 0000 0502
6400 eb64 cf01 0001 0000 0303 6400 0164
0000 0000 0000 3204 6000 fc60 004d 0000
0000 3305 6400 0064 0000 d000 0007 0f07
6400 6564 0001 0000 0000 0508 6400 0064
0000 0000 0000 3209 5300 d853 df63 0001
0000 130a 6400 0064 0000 0000 0000 320c
6400 f364 0000 0000 0000 32c0 6400 2964
0000 0000 0000 32c1 6300 3363 006b 0000
0000 22c2 6400 2b41 0e00 4300 0000 1ac3
6400 7b64 000f 0000 0000 32c4 6400 0064
0000 001b 0000 12c5 6400 0064 0000 0000
0000 10c6 6400 0064 0000 0000 0000 3ec7
c800 00c8 0000 0000 0000 0fc8 6400 9764
000b 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 02cb
6400 fb64 5901 6405 0002 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 2082 02b6 7b00
0003 0001 5802 0002 0000 0000 0000 0000
0000 2c40 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 4a61
01df 055b 0000 0014 0017 106e 130f 0000
0000 0000 0000 0000 0000 0000 1000 0000
0000 0000 0000 ffff c5b5 1f2f 0167 5300

==> ide/ide0/hda/geometry <==
physical     16383/16/63
logical      65535/16/63

==> ide/ide0/hda/capacity <==
195371568

==> ide/ide0/hda/cache <==
8192

==> ide/ide0/hda/settings <==
name            value        min        max        mode
----            -----        ---        ---        ----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                65535           0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
bswap                   0               0               1               r
current_speed           69              0               70              rw
failures                0               0               65535           rw
init_speed              69              0               70              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               0               0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
wcache                  1               0               1               rw

==> ide/ide0/hda/model <==
FUJITSU MHV2100AT PL

==> ide/ide0/hda/media <==
disk

==> ide/ide0/hda/identify <==
045a 3fff c837 0010 0000 0000 003f 0000
0000 0000 2020 2020 2020 2020 4e53 4133
5436 3132 3753 5453 0003 4000 0000 3030
3030 3030 4130 4655 4a49 5453 5520 4d48
5632 3130 3041 5420 504c 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2b00 4000 0200 0200 0007 3fff 0010
003f fc10 00fb 0110 2230 0ba5 0000 0007
0003 0078 0078 00f0 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
00fc 0021 346b 5b29 6003 346b 9a01 6003
203f 0032 0000 40fe fffe 603b fefe 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0001
0000 0000 0000 0000 0000 0000 0000 0000
000b 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
8442 0000 0000 0000 4004 4000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 003d 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 5ca5

==> ide/ide0/hda/driver <==
ide-disk version 1.18

==> ide/ide0/model <==
pci

==> ide/ide0/mate <==
(none)

==> ide/ide0/channel <==
0





 # hdparm -iI /dev/hda /dev/hdb

/dev/hda:

 Model=FUJITSU MHV2100AT PL, FwRev=000000A0, SerialNo=NSA3T6237STS
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=195371568
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4
ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7

 * signifies the current active mode


ATA device, with non-removable media
    Model Number:       FUJITSU MHV2100AT PL                    
    Serial Number:      NSA3T6237STS
    Firmware Revision:  000000A0
Standards:
    Used: Reserved
    Supported: 7 6 5 4
Configuration:
    Logical        max    current
    cylinders    16383    16383
    heads        16    16
    sectors/track    63    63
    --
    CHS current addressable sectors:   16514064
    LBA    user addressable sectors:  195371568
    device size with M = 1024*1024:       95396 MBytes
    device size with M = 1000*1000:      100030 MBytes (100 GB)
Capabilities:
    LBA, IORDY(cannot be disabled)
    Standby timer values: spec'd by Standard, no device specific minimum
    R/W multiple sector transfer: Max = 16    Current = 16
    Advanced power management level: 254 (0xfe)
    Recommended acoustic management value: 254, current value: 254
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
         Cycle time: min=120ns recommended=120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
    Enabled    Supported:
       *    SMART feature set
       *    Security Mode feature set
       *    Power Management feature set
       *    Write cache
       *    Look-ahead
       *    Host Protected Area feature set
       *    WRITE_BUFFER command
       *    READ_BUFFER command
       *    DOWNLOAD_MICROCODE
            Advanced Power Management feature set
            Power-Up In Standby feature set
            SET_MAX security extension
       *    Automatic Acoustic Management feature set
       *    Device Configuration Overlay feature set
       *    Mandatory FLUSH_CACHE
       *    SMART error logging
       *    SMART self-test
       *    IDLE_IMMEDIATE with UNLOAD
Security:
    Master password revision code = 65534
        supported
        enabled
    not    locked
        frozen
    not    expired: security count
    not    supported: enhanced erase
    Security level high
    100min for SECURITY ERASE UNIT.
HW reset results:
    CBLID- above Vih
    Device num = 0 determined by the jumper
Checksum: correct

/dev/hdb:

 Model=PHILIPS DVD+/-RW SDVD8441, FwRev=PA48, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

 * signifies the current active mode


ATA device, with non-removable media
Standards:
    Likely used: 1
Configuration:
    Logical        max    current
    cylinders    0    0
    heads        0    0
    sectors/track    0    0
    --
    device size with M = 1024*1024:           0 MBytes
    device size with M = 1000*1000:           0 MBytes
Capabilities:
    IORDY not likely
    Cannot perform double-word IO
    R/W multiple sector transfer: not supported
    DMA: not supported
    PIO: pio0

