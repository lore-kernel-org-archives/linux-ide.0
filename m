From: "gardiol\@libero\.it" <gardiol@libero.it>
Subject: Re:hda: dma_intr: bad DMA status (dma_stat=f6) hda: dma_intr:
	status=0x50 { DriveReady SeekComplete }
Date: Sat, 23 Aug 2003 10:19:19 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <HK2CG7$496AC10A14121DB886F7BFC9877ADB5F@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.libero.it ([193.70.192.51]:24215 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S264179AbTHWITU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Aug 2003 04:19:20 -0400
List-Id: linux-ide@vger.kernel.org
To: chimicus75 <chimicus75@libero.it>
Cc: linux-ide <linux-ide@vger.kernel.org>


Caro Emiliano, non so di preciso (non ho ancora provcato il 2.6.0test) =
ma f=E0
piacere vedere un altro italiano in lista!

ciao!


> Hi,=0D
> My problem is that my vt8235 stopped working a week ago: I worked a l=
ot with=20
> the nvidia driver, after a reboot my kernel (2.6.0-test2) showed the =
error=20
> reported at the end of the mail and now it continues, before everythi=
ng=20
> worked. With the 2.4.21 was perfect but now... I tried recompiling wi=
thout=20
> the ACPI, without the apic and i searched the internet for some patch=
es or=20
> similar problems. I tryed with a different cable, tryed the hd on ano=
ther pc=20
> (it works) and tryed booting without the cdrom. Allways the same erro=
r with=20
> the same value. I encluse the output of dmesg and my .config of 2.6.0=
-test2,=20
> if you need something else I'm here....
>=20
> output dmesg:"
> Linux version 2.6.0-test2 (root@amanda) (gcc version 3.2.2) #1 Wed Ja=
n 2=20
> 22:51:3
> 7 CET 2002=0D
> Video mode to be used for restore is 305
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
>  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
>  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)=0D
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 255MB LOWMEM available.
> found SMP MP-table at 000f5470
> hm, page 000f5000 reserved twice.
> hm, page 000f6000 reserved twice.
> hm, page 000f1000 reserved twice.
> hm, page 000f2000 reserved twice.
> On node 0 totalpages: 65520=0D
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 61424 pages, LIFO batch:14
>   HighMem zone: 0 pages, LIFO batch:1
> ACPI: RSDP (v000 VKT400                     ) @ 0x000f6f30
> ACPI: RSDT (v001 VKT400 AWRDACPI 16944.11825) @ 0x0fff3000
> ACPI: FADT (v001 VKT400 AWRDACPI 16944.11825) @ 0x0fff3040
> ACPI: MADT (v001 VKT400 AWRDACPI 16944.11825) @ 0x0fff6f80
> ACPI: DSDT (v001 VKT400 AWRDACPI 00000.04096) @ 0x00000000
> ACPI: BIOS passes blacklist
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 6:8 APIC version 16
> ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
> IOAPIC[0]: Assigned apic_id 2
> IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
> ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trig=
ger[0x0])
> ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trig=
ger[0x0])
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Building zonelist for node : 0
> Kernel command line: BOOT_IMAGE=3DLinux ro root=3D302
> Initializing CPU#0
> PID hash table entries: 1024 (order 10: 8192 bytes)
> Detected 1249.202 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 2457.60 BogoMIPS
> Memory: 254696k/262080k available (2692k kernel code, 6656k reserved,=
 988k=20
> data,
>  156k init, 0k highmem)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> -> /dev
> -> /dev/console
> -> /root
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000020
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: AMD Athlon(tm)  stepping 00=0D
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> ENABLING IO-APIC IRQs
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, =
2-23 not=20
> co
> nnected.
> ..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
> number of MP IRQ sources: 15.
> number of IO-APIC #2 registers: 24.
> testing the IO APIC.......................
> IO APIC #2......
> .... register #00: 02000000=0D
> .......    : physical APIC id: 02
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 00178003
> .......     : max redirection entries: 0017
> .......     : PRQ implemented: 1
> .......     : IO APIC version: 0003
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 000 00  1    0    0   0   0    0    0    00
>  01 001 01  0    0    0   0   0    1    1    39
>  02 001 01  0    0    0   0   0    1    1    31
>  03 001 01  0    0    0   0   0    1    1    41
>  04 001 01  0    0    0   0   0    1    1    49
>  05 001 01  0    0    0   0   0    1    1    51
>  06 001 01  0    0    0   0   0    1    1    59
>  07 001 01  0    0    0   0   0    1    1    61
>  08 001 01  0    0    0   0   0    1    1    69
>  09 001 01  0    0    0   0   0    1    1    71
>  0a 001 01  0    0    0   0   0    1    1    79
>  0b 001 01  0    0    0   0   0    1    1    81
>  0c 001 01  0    0    0   0   0    1    1    89
>  0d 001 01  0    0    0   0   0    1    1    91
>  0e 001 01  0    0    0   0   0    1    1    99
>  0f 001 01  0    0    0   0   0    1    1    A1
>  10 000 00  1    0    0   0   0    0    0    00
>  11 000 00  1    0    0   0   0    0    0    00
>  12 000 00  1    0    0   0   0    0    0    00
>  13 000 00  1    0    0   0   0    0    0    00
>  14 000 00  1    0    0   0   0    0    0    00
>  15 000 00  1    0    0   0   0    0    0    00
>  16 000 00  1    0    0   0   0    0    0    00
>  17 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ5 -> 0:5
> IRQ6 -> 0:6=0D
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:9
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15=0D
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1248.0587 MHz.
> ..... host bus clock speed is 199.0774 MHz.
> Initializing RT netlink socket
> PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=3D1
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> BIO: pool of 256 setup, 14Kb (56 bytes/bio)
> biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
> biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
> biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
> biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
> biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
> biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)=0D
> ACPI: Subsystem revision 20030714
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
> ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
> ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
> ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)
> Linux Plug and Play Support v0.96 (c) Adam Belay
> SCSI subsystem initialized
> drivers/usb/core/usb.c: registered new driver usbfs
> drivers/usb/core/usb.c: registered new driver hub
> ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
> ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
> ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
> ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0
> IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
> 00:00:08[A] -> 2-16 -> IRQ 16
> IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
> 00:00:08[B] -> 2-17 -> IRQ 17
> IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
> 00:00:08[C] -> 2-18 -> IRQ 18
> IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
> 00:00:08[D] -> 2-19 -> IRQ 19
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> Pin 2-18 already programmed=0D
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
> ACPI: No IRQ known for interrupt pin B of device 0000:00:10.1
> ACPI: No IRQ known for interrupt pin C of device 0000:00:10.2
> ACPI: No IRQ known for interrupt pin D of device 0000:00:10.3
> ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using=
 IRQ 255
> PCI: Using ACPI for IRQ routing
> PCI: if you experience problems, try using option 'pci=3Dnoacpi' or e=
ven=20
> 'acpi=3Doff
> '
> Machine check exception polling timer started.
> Enabling SEP on CPU 0
> Journalled Block Device driver loaded
> Initializing Cryptographic API
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI: Fan [FAN] (on)
> ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
> ACPI: Thermal Zone [THRM] (52 C)
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
> Using anticipatory scheduling elevator
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> PPP generic driver version 2.4.2
> PPP Deflate Compression module registered
> PPP BSD Compression module registered
> 8139too Fast Ethernet driver 0.9.26
> eth0: RealTek RTL8139 Fast Ethernet at 0xd0807000, 00:48:54:8f:15:4d,=
 IRQ 16
> eth0:  Identified 8139 chip type 'RTL-8139C'
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with ide=
bus=3Dxx
> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using=
 IRQ 255
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with ide=
bus=3Dxx
> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
>     ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:pio, hdd:pio
> hda: ST320413A, ATA DISK drive
> hdb: LG DVD-ROM DRD-8120B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: max request size: 128KiB
> hda: host protected area =3D> 1
> hda: 39102336 sectors (20020 MB) w/512KiB Cache, CHS=3D38792/16/63, U=
DMA(100)
>  hda:<3>hda: dma_intr: bad DMA status (dma_stat=3Df6)
> hda: dma_intr: status=3D0x50 { DriveReady SeekComplete }
> =20
> hda: dma_intr: bad DMA status (dma_stat=3Df6)
> hda: dma_intr: status=3D0x50 { DriveReady SeekComplete }=0D
> =20
> hda: dma_intr: bad DMA status (dma_stat=3Df6)
> hda: dma_intr: status=3D0x50 { DriveReady SeekComplete }
> =20
> hda: dma_intr: bad DMA status (dma_stat=3Df6)
> hda: dma_intr: status=3D0x50 { DriveReady SeekComplete }
> =20
> hda: DMA disabled
> hdb: DMA disabled
> ide0: reset: success
>  hda1 hda2 hda3 hda4
> hdb: ATAPI 40X DVD-ROM drive, 512kB Cache
> Uniform CD-ROM driver Revision: 3.12
> ahc_pci:0:11:0: Host Adapter Bios disabled.  Using default SCSI devic=
e=20
> parameter
> s
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
>         <Adaptec 2902/04/10/15/20/30C SCSI adapter>
>         aic7850: Single Channel A, SCSI Id=3D7, 3/253 SCBs
> =20
> (scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
>   Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0b
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
> Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 5
> ACPI: No IRQ known for interrupt pin D of device 0000:00:10.3
> ehci_hcd 0000:00:10.3: VIA Technologies, In USB 2.0
> ehci_hcd 0000:00:10.3: irq 11, pci mem d081e000
> ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
> hub 1-0:0: USB hub found
> hub 1-0:0: 6 ports detected
> drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface =
driver =0D
> v2.1
> ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0=0D
> uhci-hcd 0000:00:10.0: VIA Technologies, In USB
> uhci-hcd 0000:00:10.0: irq 10, io base 0000dc00
> uhci-hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
> hub 2-0:0: USB hub found
> hub 2-0:0: 2 ports detected
> ACPI: No IRQ known for interrupt pin B of device 0000:00:10.1
> uhci-hcd 0000:00:10.1: VIA Technologies, In USB (#2)
> uhci-hcd 0000:00:10.1: irq 11, io base 0000e000
> uhci-hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
> hub 3-0:0: USB hub found
> hub 3-0:0: 2 ports detected
> ACPI: No IRQ known for interrupt pin C of device 0000:00:10.2
> uhci-hcd 0000:00:10.2: VIA Technologies, In USB (#3)=0D
> uhci-hcd 0000:00:10.2: irq 5, io base 0000e400
> uhci-hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
> hub 4-0:0: USB hub found
> hub 4-0:0: 2 ports detected
> drivers/usb/core/usb.c: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> drivers/usb/core/usb.c: registered new driver hid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> drivers/usb/core/usb.c: registered new driver usbscanner
> drivers/usb/image/scanner.c: 0.4.14:USB Scanner Driver
> mice: PS/2 mouse device common for all mice
> input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> es1371: version v0.32 time 22:48:56 Jan  2 2002
> es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
> es1371: found es1371 rev 2 at io 0xd000 irq 18 joystick 0x0
> ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
> Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12=
:01:18=20
> 2003
>  UTC).
> request_module: failed /sbin/modprobe -- snd-card-0. error =3D -16
> ALSA device list:
>   No soundcards found.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 32768)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> found reiserfs format "3.6" with standard journal
> hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
> hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
> hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
> hub 3-0:0: new USB device on port 1, assigned address 2
> Reiserfs journal params: device hda2, size 8192, journal first block =
18, max=20
> tra
> ns len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (hda2) for (hda2)
> Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.=0D
> Freeing unused kernel memory: 156k freed
> Adding 393584k swap on /dev/hda4.  Priority:-1 extents:1
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device hda3, size 8192, journal first block =
18, max=20
> tra
> ns len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (hda3) for (hda3)
> Using r5 hash to sort names
> eth0: Setting half-duplex based on auto-negotiated partner ability 00=
00.
> drivers/usb/core/message.c: usb_control/bulk_msg: timeout
> nfs warning: mount version older than kernel=0D
> nvidia: module license 'NVIDIA' taints kernel.
> 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496 =
 Wed Jul=20
> 16
>  19:03:09 PDT 2003
> 0: NVRM: AGPGART: unable to retrieve symbol table
> "=0D
> I know it's not perfect but i'm still tuning it...
>=20
> contents of .config:"
>  #
> # Automatically generated make config: don't edit
> #=0D
> CONFIG_X86=3Dy
> CONFIG_MMU=3Dy
> CONFIG_UID16=3Dy
> CONFIG_GENERIC_ISA_DMA=3Dy
>=20
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=3Dy
>=20
> #
> # General setup
> #
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_LOG_BUF_SHIFT=3D14
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_IOSCHED_AS=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
>=20
> #
> # Loadable module support
> #
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=3Dy
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=3Dy
>=20
> #
> # Processor type and features
> #
> CONFIG_X86_PC=3Dy
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set=0D
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set=0D
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> CONFIG_MK7=3Dy=0D
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=3Dy
> CONFIG_X86_XADD=3Dy
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_X86_WP_WORKS_OK=3Dy
> CONFIG_X86_INVLPG=3Dy
> CONFIG_X86_BSWAP=3Dy
> CONFIG_X86_POPAD_OK=3Dy=0D
> CONFIG_X86_GOOD_APIC=3Dy
> CONFIG_X86_INTEL_USERCOPY=3Dy
> CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
> CONFIG_X86_USE_3DNOW=3Dy
> # CONFIG_HUGETLB_PAGE is not set
> # CONFIG_SMP is not set
> CONFIG_PREEMPT=3Dy
> CONFIG_X86_UP_APIC=3Dy
> CONFIG_X86_UP_IOAPIC=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy=0D
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCE_NONFATAL=3Dy
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> # CONFIG_EDD is not set
> CONFIG_NOHIGHMEM=3Dy
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> CONFIG_MATH_EMULATION=3Dy
> CONFIG_MTRR=3Dy
> CONFIG_HAVE_DEC_LOCK=3Dy
>=20
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=3Dy
> # CONFIG_SOFTWARE_SUSPEND is not set
>=20
> #
> # ACPI Support
> #
>  CONFIG_ACPI=3Dy=0D
> # CONFIG_ACPI_HT_ONLY is not set
> CONFIG_ACPI_BOOT=3Dy
> # CONFIG_ACPI_SLEEP is not set
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=3Dy
> CONFIG_ACPI_FAN=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_THERMAL=3Dy
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=3Dy
> CONFIG_ACPI_INTERPRETER=3Dy
> CONFIG_ACPI_EC=3Dy
> CONFIG_ACPI_POWER=3Dy
> CONFIG_ACPI_PCI=3Dy
> CONFIG_ACPI_SYSTEM=3Dy
> # CONFIG_APM is not set
>=20
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
>=20
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=3Dy
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=3Dy
> CONFIG_PCI_BIOS=3Dy
> CONFIG_PCI_DIRECT=3Dy
> # CONFIG_PCI_LEGACY_PROC is not set
> CONFIG_PCI_NAMES=3Dy
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> CONFIG_HOTPLUG=3Dy
>=20
> #
> # PCMCIA/CardBus support
> #
> # CONFIG_PCMCIA is not set
>=20
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
>=20
> #
> # Executable file formats
> #
> CONFIG_KCORE_ELF=3Dy
> # CONFIG_KCORE_AOUT is not set
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_BINFMT_AOUT=3Dy
> CONFIG_BINFMT_MISC=3Dy
>=20
> #
> # Generic Driver Options
> #
> # CONFIG_FW_LOADER is not set
>=20
> #
> # Memory Technology Devices (MTD)
> #=0D
> # CONFIG_MTD is not set
>=20
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
>=20
> #
> # Plug and Play support
> #
> CONFIG_PNP=3Dy
> # CONFIG_PNP_DEBUG is not set
>=20
> #
> # Protocols
> #=0D
> # CONFIG_ISAPNP is not set
> CONFIG_PNPBIOS=3Dy
>=20
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=3Dy
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_LOOP is not set=0D
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_BLK_DEV_INITRD is not set
> # CONFIG_LBD is not set
>=20
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=3Dy
> CONFIG_BLK_DEV_IDE=3Dy
>=20
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=3Dy
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECD=3Dy
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> # CONFIG_IDE_TASKFILE_IO is not set
>=20
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=3Dy
> CONFIG_IDEPCI_SHARE_IRQ=3Dy
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=3Dy
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> # CONFIG_BLK_DEV_IDE_TCQ is not set
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=3Dy
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_IDEDMA_PCI_WIP is not set
> CONFIG_BLK_DEV_ADMA=3Dy
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> CONFIG_BLK_DEV_VIA82CXXX=3Dy
> CONFIG_BLK_DEV_IDEDMA=3Dy
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=3Dy=0D
> # CONFIG_DMA_NONPCI is not set
> # CONFIG_BLK_DEV_HD is not set
> =0D
> #
> # SCSI device support
> #
> CONFIG_SCSI=3Dy
>=20
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> # CONFIG_BLK_DEV_SD is not set=0D
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=3Dy
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_CHR_DEV_SG=3Dy
>=20
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_REPORT_LUNS is not set
> CONFIG_SCSI_CONSTANTS=3Dy
> # CONFIG_SCSI_LOGGING is not set
>=20
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> CONFIG_SCSI_AIC7XXX=3Dy
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D64
> CONFIG_AIC7XXX_RESET_DELAY_MS=3D2000
> # CONFIG_AIC7XXX_PROBE_EISA_VL is not set
> # CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
> # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
> CONFIG_AIC7XXX_DEBUG_MASK=3D0
> # CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
>=20
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
>=20
> #
> # Fusion MPT device support
> #=0D
>=20
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> # CONFIG_IEEE1394 is not set
>=20
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
>=20
> #
> # Networking support
> #
> CONFIG_NET=3Dy
> =0D
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> # CONFIG_PACKET_MMAP is not set
> # CONFIG_NETLINK_DEV is not set
> CONFIG_UNIX=3Dy
> CONFIG_NET_KEY=3Dy
> CONFIG_INET=3Dy
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set=0D
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_ARPD is not set
> # CONFIG_INET_ECN is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_IPV6=3Dy
> # CONFIG_IPV6_PRIVACY is not set
> CONFIG_INET6_AH=3Dy
> CONFIG_INET6_ESP=3Dy
> CONFIG_INET6_IPCOMP=3Dy
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_NETFILTER is not set
> CONFIG_XFRM_USER=3Dy
>=20
>=20
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=3Dy
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_LLC is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
>=20
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
>=20
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_NETDEVICES=3Dy
>=20
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=3Dy
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_ETHERTAP is not set
> # CONFIG_NET_SB1000 is not set
>=20
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=3Dy
> # CONFIG_MII is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_NET_VENDOR_3COM is not set
>=20
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> CONFIG_NET_PCI=3Dy
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_B44 is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_E100 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> CONFIG_8139TOO=3Dy
>=20
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> CONFIG_VIA_RHINE=3Dy
> # CONFIG_VIA_RHINE_MMIO is not set
>=20
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
>=20
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PPP=3Dy
> # CONFIG_PPP_MULTILINK is not set
> # CONFIG_PPP_FILTER is not set
> CONFIG_PPP_ASYNC=3Dy
> # CONFIG_PPP_SYNC_TTY is not set
> CONFIG_PPP_DEFLATE=3Dy
> CONFIG_PPP_BSDCOMP=3Dy
> # CONFIG_PPPOE is not set
> # CONFIG_SLIP is not set
>=20
> #=0D
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>=20
> #
> # Token Ring devices (depends on LLC=3Dy)
> #
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set=0D
>=20
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
>=20
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
>=20
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
>=20
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN_BOOL is not set
>=20
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
>=20
> #
> # Userland interfaces
> #=0D
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0D
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=3Dy
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=3Dy
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> =0D
> #
> # Character devices
> #
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> # CONFIG_SERIAL_NONSTANDARD is not set
> =0D
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=3Dy
> # CONFIG_SERIAL_8250_CONSOLE is not set
> # CONFIG_SERIAL_8250_ACPI is not set
> # CONFIG_SERIAL_8250_EXTENDED is not set
>=20
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=3Dy
> # CONFIG_UNIX98_PTYS is not set=0D
>=20
> #
> # I2C support
> #
> # CONFIG_I2C is not set
>=20
> #
> # I2C Hardware Sensors Mainboard support
> #
>=20
> #
> # I2C Hardware Sensors Chip support
> #
> # CONFIG_I2C_SENSOR is not set
>=20
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> # CONFIG_QIC02_TAPE is not set=0D
>=20
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
>=20
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> # CONFIG_NVRAM is not set
> # CONFIG_RTC is not set
> # CONFIG_GEN_RTC is not set
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set=0D
>=20
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_HANGCHECK_TIMER is not set
>=20
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
>=20
> #
> # Digital Video Broadcasting Devices
> #=0D
>

