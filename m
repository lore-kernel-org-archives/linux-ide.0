From: Mark Paulus <mark.paulus@verizonbusiness.com>
Subject: Re: sata_sil issue on 2.6.22
Date: Wed, 05 Dec 2007 07:29:06 -0700
Message-ID: <4756B5B2.1010302@verizonbusiness.com>
References: <47434526.7010304@verizonbusiness.com> <474CC29E.8020102@gmail.com>
 <475032AF.6090001@verizonbusiness.com> <4754C15C.1020107@gmail.com>
Reply-To: mark.paulus@verizonbusiness.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------020806060106060300070202
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pmesmtp03.mci.com ([199.249.20.32]:50372 "EHLO
	pmesmtp03.mci.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbXLEO3D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 09:29:03 -0500
Received: from pmismtp06.wcomnet.com ([166.37.158.166])
 by firewall.verizonbusiness.com (Iplanet MTA 5.2)
 with ESMTP id <0JSK001JAYWA0D@firewall.verizonbusiness.com> for
 linux-ide@vger.kernel.org; Wed, 05 Dec 2007 14:28:58 +0000 (GMT)
Received: from pmismtp06.wcomnet.com ([127.0.0.1])
 by pmismtp06.mcilink.com (iPlanet Messaging Server 5.2 HotFix 2.08 (built Sep
 22 2005)) with SMTP id <0JSK00CE9YWA1V@pmismtp06.mcilink.com> for
 linux-ide@vger.kernel.org; Wed, 05 Dec 2007 14:28:58 +0000 (GMT)
Received: from [127.0.0.1] ([166.34.133.85])
 by pmismtp06.mcilink.com (iPlanet Messaging Server 5.2 HotFix 2.08 (built Sep
 22 2005)) with ESMTP id <0JSK00B92YW83P@pmismtp06.mcilink.com> for
 linux-ide@vger.kernel.org; Wed, 05 Dec 2007 14:28:58 +0000 (GMT)
In-reply-to: <4754C15C.1020107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020806060106060300070202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Well, I feel foolish.  

One problem is that the prebuilt kernel is using an initrd
image, so I made your patch changes, and put them into 
/lib/modules/`uname -r`/kernel/drivers/ata/sata_sil.ko,
and guess what, they never got loaded.  Foolishness on my
part.

Anyway, this time I got to the single boot prompt, where I did
a 'rmmod sata_sil', and a 'modprobe sata_sil', and I know
it loaded the new version, because you can see the 
'sata_sil 0000:02:0b.0: version 2.2b', which I put in
to verify what the heck is going on. 

This machine is pretty slow to compile the kernel, which is
why I was trying to short cut the build/install some, but 
I might try to build the kernel on a faster machine and see if
I can get the initrd image rebuilt also.



Tejun Heo wrote:
> Mark Paulus wrote:
>> I applied the patch, and not much difference.  Still the same issue, and
>> here
>> is the new dmesg output.
> 
> Weird, okay, here's updated patch.  Please try this one and report the
> dmesg.  FYI, it won't fix the problem.  It's just to find out what's
> going on.
> 
> 

-- 
Mark Paulus
2424 Garden of the Gods Rd  | Phone:  v622-5578 / 719-535-5578
0419/117 - LEC Access ; D5-1010   | FAX:    719-535-1665
Colo Springs, CO  80919    | 1800PageMCI / 1406052
AIM : mgpaulus1    /  sametime : mark.paulus


--------------020806060106060300070202
Content-Type: text/plain;
 name="dmesg.bad4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.bad4"

Linux version 2.6.22-3-686 (Debian 2.6.22-5~bpo.1) (norbert@tretkowski.de) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Wed Oct 31 16:15:58 UTC 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
 BIOS-e820: 000000001ffd0000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (usable)
 BIOS-e820: 00000000feea0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
512MB LOWMEM available.
found SMP MP-table at 000f9bf0
Entering add_active_range(0, 0, 131072) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131072
  HighMem    131072 ->   131072
early_node_map[1] active PFN ranges
    0:        0 ->   131072
On node 0 totalpages: 131072
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 992 pages used for memmap
  Normal zone: 125984 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP 000E0010, 0014 (r0 COMPAQ)
ACPI: RSDT 000E0080, 005C (r1 COMPAQ CPQ0005  20020913             0)
ACPI: FACP 000E0130, 0074 (r1 COMPAQ SOLANO          1             0)
ACPI: DSDT 000E0204, 12F5 (r1 COMPAQ     DSDT        1 MSFT  100000D)
ACPI: FACS 000E0040, 0040
ACPI: SSDT 000E14F9, 0174 (r1 COMPAQ CORE_UTL        1 MSFT  100000D)
ACPI: SSDT 000E166D, 0D1C (r1 COMPAQ VILLTBL1        1 MSFT  100000D)
ACPI: SSDT 000E33B3, 005D (r1 COMPAQ     FHUB        1 MSFT  100000D)
ACPI: APIC 000E01A4, 0060 (r1 COMPAQ SOLANO          1             0)
ACPI: SSDT 000E333D, 0076 (r1 COMPAQ     APIC        1 MSFT  100000D)
ACPI: SSDT 000E2389, 06AD (r1 COMPAQ PNP_PRSS        1 MSFT  100000D)
ACPI: SSDT 000E2A94, 01A4 (r1 COMPAQ       S3        1 MSFT  100000D)
ACPI: SSDT 000E2C38, 0158 (r1 COMPAQ   PIDETM        1 MSFT  100000D)
ACPI: SSDT 000E2EED, 010B (r1 COMPAQ     GTF0        1 MSFT  100000D)
ACPI: SSDT 000E2FF8, 0117 (r1 COMPAQ     GTF1        1 MSFT  100000D)
ACPI: SSDT 000E2D90, 015D (r1 COMPAQ   SIDETM        1 MSFT  100000D)
ACPI: SSDT 000E310F, 0117 (r1 COMPAQ     GTF2        1 MSFT  100000D)
ACPI: SSDT 000E349B, 004E (r1 COMPAQ    FINIS        1 MSFT  100000D)
ACPI: PM-Timer IO Port: 0xf808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:deea0000)
Built 1 zonelists.  Total pages: 130048
Kernel command line: root=/dev/hda1 ro 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 996.822 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 510088k/524288k available (1689k kernel code, 13380k reserved, 648k data, 244k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4e000 - 0xfffff000   ( 708 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
      .init : 0xc034f000 - 0xc038c000   ( 244 kB)
      .data : 0xc02a65d7 - 0xc03487e4   ( 648 kB)
      .text : 0xc0100000 - 0xc02a65d7   (1689 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1995.21 BogoMIPS (lpj=3990423)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 11k freed
ACPI: Core revision 20070126
CPU0: Intel Pentium III (Coppermine) stepping 0a
Total of 1 processors activated (1995.21 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xe838d, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region f800-f87f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region fa00-fa3f claimed by ICH4 GPIO
PCI: Firmware left 0000:02:08.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 16 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: RTC can wake from S4
pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0e: ioport range 0x400-0x41f has been reserved
pnp: 00:0e: ioport range 0x420-0x43f has been reserved
pnp: 00:0e: ioport range 0x440-0x45f has been reserved
pnp: 00:0e: ioport range 0x460-0x47f has been reserved
pnp: 00:0e: ioport range 0xf800-0xf81f has been reserved
pnp: 00:0e: ioport range 0xf820-0xf83f has been reserved
pnp: 00:0e: ioport range 0xf840-0xf85f has been reserved
pnp: 00:0e: ioport range 0xf860-0xf87f has been reserved
pnp: 00:0f: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0f: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:0f: iomem range 0x100000-0x1fffffff could not be reserved
pnp: 00:0f: iomem range 0xfff80000-0xffffffff could not be reserved
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: 40000000-413fffff
  PREFETCH window: 41500000-4fffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 786432 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
checking if image is initramfs...<6>Switched to high resolution mode on CPU 0
 it is
Freeing initrd memory: 5901k freed
audit: initializing netlink socket (disabled)
audit(1196838639.324:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:02:04.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
Freeing unused kernel memory: 244k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: Processor [CPU0] (supports 8 throttling states)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 1
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2460-0x2467, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x2468-0x246f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
SCSI subsystem initialized
libata version 2.21 loaded.
hda: Maxtor 34098H4, ATA DISK drive
hdb: WDC WD200BB-00DEA0, ATA DISK drive
hda: selected mode 0x45
hdb: selected mode 0x45
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: COMPAQ SC-148F, ATAPI CD/DVD-ROM drive
hdc: selected mode 0x22
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: PCI Interrupt 0000:00:1f.4[C] -> GSI 23 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: UHCI Host Controller
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.4: irq 16, io base 0x00002440
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 17
e100: eth0: e100_probe: addr 0x41000000, irq 17, MAC addr 00:02:A5:10:5A:37
sata_sil 0000:02:0b.0: version 2.2
ACPI: PCI Interrupt 0000:02:0b.0[A] -> GSI 22 (level, low) -> IRQ 18
scsi0 : sata_sil
scsi1 : sata_sil
ata1: SATA max UDMA/100 cmd 0xe0812080 ctl 0xe081208a bmdma 0xe0812000 irq 18
ata2: SATA max UDMA/100 cmd 0xe08120c0 ctl 0xe08120ca bmdma 0xe0812008 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1.00: revalidation failed (errno=-5)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=4)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=3)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1.00: revalidation failed (errno=-5)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=2)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=1)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after 5 tries, giving up
ata1: EH complete
ata2: SATA link down (SStatus 0 SControl 310)
hda: max request size: 128KiB
hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 >
hdb: max request size: 128KiB
hdb: 39102336 sectors (20020 MB) w/8192KiB Cache, CHS=38792/16/63, UDMA(100)
hdb: cache flushes not supported
 hdb: hdb1
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Linux agpgart interface v0.102 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: AGP aperture is 64M @ 0x0
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
input: PC Speaker as /class/input/input1
Floppy drive(s): fd0 is 1.44M
Real Time Clock Driver v1.12ac
FDC 0 is a post-1991 82077
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
iTCO_wdt: Found a ICH2 TCO device (Version=1, TCOBASE=0xf860)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
Intel 82802 RNG detected
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.5 to 64
input: PS2++ Logitech MX Mouse as /class/input/input2
intel8x0_measure_ac97_clock: measured 52055 usecs
intel8x0: clocking to 41158
Adding 1642496k swap on /dev/hda5.  Priority:-1 extents:1 across:1642496k
EXT3 FS on hda1, internal journal
ACPI: PCI interrupt for device 0000:02:0b.0 disabled
sata_sil 0000:02:0b.0: version 2.2b
ACPI: PCI Interrupt 0000:02:0b.0[A] -> GSI 22 (level, low) -> IRQ 18
scsi2 : sata_sil
scsi3 : sata_sil
ata3: SATA max UDMA/100 cmd 0xe0886080 ctl 0xe088608a bmdma 0xe0886000 irq 18
ata4: SATA max UDMA/100 cmd 0xe08860c0 ctl 0xe08860ca bmdma 0xe0886008 irq 18
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata3.00: 19541088 sectors, multi 16: LBA 
ata3.00: applying bridge limits
ata3.00: failed to set xfermode (err_mask=0x40)
ata3: failed to recover some devices, retrying in 5 secs
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3.00: revalidation failed (errno=-5)
ata3.00: limiting speed to UDMA/100:PIO3
ata3: failed to recover some devices, retrying in 5 secs
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3.00: revalidation failed (errno=-5)
ata3.00: disabled
ata3: EH pending after completion, repeating EH (cnt=4)
ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata3.00: 19541088 sectors, multi 16: LBA 
ata3.00: applying bridge limits
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3.00: revalidation failed (errno=-5)
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to set xfermode (err_mask=0x40)
ata3.00: limiting speed to UDMA/100:PIO3
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3.00: revalidation failed (errno=-5)
ata3.00: disabled
ata3: EH pending after completion, repeating EH (cnt=3)
ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata3.00: 19541088 sectors, multi 16: LBA 
ata3.00: applying bridge limits
ata3.00: failed to set xfermode (err_mask=0x40)
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to set xfermode (err_mask=0x40)
ata3.00: limiting speed to UDMA/100:PIO3
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to set xfermode (err_mask=0x40)
ata3.00: disabled
ata3: EH pending after completion, repeating EH (cnt=2)
ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata3.00: 19541088 sectors, multi 16: LBA 
ata3.00: applying bridge limits
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3.00: revalidation failed (errno=-5)
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3.00: revalidation failed (errno=-5)
ata3.00: limiting speed to UDMA/100:PIO3
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to set xfermode (err_mask=0x40)
ata3.00: disabled
ata3: EH pending after completion, repeating EH (cnt=1)
ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata3.00: 19541088 sectors, multi 16: LBA 
ata3.00: applying bridge limits
ata3.00: failed to set xfermode (err_mask=0x40)
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3.00: revalidation failed (errno=-5)
ata3.00: limiting speed to UDMA/100:PIO3
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3: XXX SATA_IRQ, serror=0x0
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3.00: revalidation failed (errno=-5)
ata3.00: disabled
ata3: EH pending after 5 tries, giving up
ata3: EH complete
ata4: SATA link down (SStatus 0 SControl 310)

--------------020806060106060300070202
Content-Type: text/x-vcard; charset=utf-8;
 name="mark_paulus.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mark_paulus.vcf"

begin:vcard
fn:Mark Paulus
n:Paulus;Mark
org:MCI;Lec Interfaces / 40419
adr;dom:;;2424 Garden of the Gods Rd;Colorado Springs;CO;80919
email;internet:mark.paulus@verizonbusiness.com
title:Mark Paulus
tel;work:719-535-5578
tel;pager:800-pagemci / 1406052
tel;home:v622-5578
version:2.1
end:vcard


--------------020806060106060300070202--

