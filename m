From: =?ISO-8859-15?Q?Martin_Ammerm=FCller?=
	<martin.ammermueller@bnro.de>
Subject: Re: [sata_sil]Random timeout error (data loss)
Date: Wed, 24 May 2006 18:03:55 +0200
Message-ID: <447483EB.5070102@bnro.de>
References: <443E6B81.5090004@bnro.de> <443E916F.1040203@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090506000701080201050706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout09.sul.t-online.com ([194.25.134.84]:19665 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932309AbWEXQE3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 May 2006 12:04:29 -0400
In-Reply-To: <443E916F.1040203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090506000701080201050706
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks to Fourat Zouari, who got the same notebook as i, i was able to
solve the timeout problem by appending "noapic acpi=off" to my kernel
boot command.

Additionaly, i tested 2.6.17-rc4-git2 with the great update patch and
apic and acpi turned on. It seems that sata_sil error handling works. At
least dmesg contained messages about libata error handling ("EH" lines).

Since a notebook without acpi isn't quite usable, i would be happy if
someone could point me to a site where i can get further help to
investigate the acpi issue.

Best Regards,
Martin Ammermüller
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEdIPrFjFZ/qjkvZARAmWqAJ9HpAX3KYXYXtY93Rv+ixoKQwgopACff6sR
BWnADQihiO8n4E5css+ymE0=
=ArDN
-----END PGP SIGNATURE-----

--------------090506000701080201050706
Content-Type: text/plain;
 name="dmesg_libata"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_libata"

[4294667.296000] Linux version 2.6.17-rc4-git2 (root@tenco) (gcc-Version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 PREEMPT Thu May 18 16:00:48 CEST 2006
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[4294667.296000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000001dea0000 (usable)
[4294667.296000]  BIOS-e820: 000000001dea0000 - 000000001deb0000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000001deb0000 - 000000001df00000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 000000001df00000 - 000000001e000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[4294667.296000] 0MB HIGHMEM available.
[4294667.296000] 478MB LOWMEM available.
[4294667.296000] found SMP MP-table at 000f7710
[4294667.296000] On node 0 totalpages: 122528
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:0
[4294667.296000]   Normal zone: 118432 pages, LIFO batch:31
[4294667.296000] DMI present.
[4294667.296000] ATI board detected. Disabling timer routing over 8254.
[4294667.296000] ACPI: RSDP (v000 TOSINV                                ) @ 0x000f76c0
[4294667.296000] ACPI: RSDT (v001 TOSINV   RSDT   0x06040000  LTP 0x00000000) @ 0x1deabf9b
[4294667.296000] ACPI: FADT (v001 TOSINV Goldfish 0x06040000 ATI  0x000f4240) @ 0x1deafef6
[4294667.296000] ACPI: MADT (v001 TOSINV 	 APIC   0x06040000  LTP 0x00000000) @ 0x1deaff6a
[4294667.296000] ACPI: MCFG (v001 TOSINV   MCFG   0x06040000  LTP 0x00000000) @ 0x1deaffc4
[4294667.296000] ACPI: SSDT (v001 TOSINV  Cpu0Cst 0x00003001 INTL 0x20030224) @ 0x1deac1ce
[4294667.296000] ACPI: SSDT (v001 TOSINV    CpuPm 0x00003000 INTL 0x20030224) @ 0x1deabfd3
[4294667.296000] ACPI: DSDT (v001 TOSINV    SB450 0x06040000 MSFT 0x0100000e) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0x8008
[4294667.296000] ACPI: Local APIC address 0xfee00000
[4294667.296000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 6:13 APIC version 20
[4294667.296000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[4294667.296000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[4294667.296000] IOAPIC[0]: apic_id 1, version 33, address 0xfec00000, GSI 0-23
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
[4294667.296000] ACPI: IRQ0 used by override.
[4294667.296000] ACPI: IRQ2 used by override.
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Using ACPI (MADT) for SMP configuration information
[4294667.296000] Allocating PCI resources starting at 20000000 (gap: 1e000000:c2000000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/sda3 ro quiet splash
[4294667.296000] mapped APIC to ffffd000 (fee00000)
[4294667.296000] mapped IOAPIC to ffffc000 (fec00000)
[4294667.296000] Enabling fast FPU save and restore... done.
[4294667.296000] Enabling unmasked SIMD FPU exception support... done.
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[4294667.296000] Detected 1394.231 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour VGA+ 80x25
[4294671.231000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[4294671.232000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[4294671.247000] Memory: 476196k/490112k available (1893k kernel code, 13272k reserved, 586k data, 288k init, 0k highmem)
[4294671.247000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[4294671.307000] Calibrating delay using timer specific routine.. 2790.10 BogoMIPS (lpj=1395053)
[4294671.307000] Security Framework v1.0.0 initialized
[4294671.307000] SELinux:  Disabled at boot.
[4294671.307000] Mount-cache hash table entries: 512
[4294671.307000] CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000000 00000000 00000000
[4294671.307000] CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000000 00000000 00000000
[4294671.307000] CPU: L1 I cache: 32K, L1 D cache: 32K
[4294671.307000] CPU: L2 cache: 1024K
[4294671.307000] CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000000 00000000 00000000
[4294671.307000] CPU: Intel(R) Celeron(R) M processor         1.40GHz stepping 08
[4294671.307000] Checking 'hlt' instruction... OK.
[4294671.311000] SMP alternatives: switching to UP code
[4294671.311000] Freeing SMP alternatives: 0k freed
[4294671.329000] ENABLING IO-APIC IRQs
[4294671.329000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[4294671.329000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[4294671.329000] ...trying to set up timer (IRQ0) through the 8259A ...  failed.
[4294671.329000] ...trying to set up timer as Virtual Wire IRQ... works.
[4294671.450000] checking if image is initramfs... it is
[4294672.143000] Freeing initrd memory: 5869k freed
[4294672.144000] NET: Registered protocol family 16
[4294672.144000] EISA bus registered
[4294672.144000] ACPI: bus type pci registered
[4294672.144000] PCI: Using MMCONFIG
[4294672.145000] Setting up standard PCI resources
[4294672.148000] ACPI: Subsystem revision 20060127
[4294672.157000] ACPI: Interpreter enabled
[4294672.157000] ACPI: Using IOAPIC for interrupt routing
[4294672.158000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294672.158000] PCI: Probing PCI hardware (bus 00)
[4294672.160000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
[4294672.160000] Boot video device is 0000:01:05.0
[4294672.161000] PCI: Transparent bridge - 0000:00:14.4
[4294672.161000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[4294672.164000] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
[4294672.164000] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
[4294672.165000] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
[4294672.165000] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
[4294672.165000] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
[4294672.165000] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
[4294672.166000] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
[4294672.166000] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
[4294672.167000] ACPI: Embedded Controller [EC0] (gpe 7) interrupt mode.
[4294672.167000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
[4294672.167000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[4294672.168000] ACPI: Power Resource [PFA1] (off)
[4294672.168000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294672.168000] pnp: PnP ACPI init
[4294672.181000] pnp: PnP ACPI: found 10 devices
[4294672.181000] PnPBIOS: Disabled by ACPI PNP
[4294672.181000] PCI: Using ACPI for IRQ routing
[4294672.181000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[4294672.181000] pnp: 00:08: ioport range 0x1080-0x1080 has been reserved
[4294672.181000] pnp: 00:08: ioport range 0x220-0x22f has been reserved
[4294672.181000] pnp: 00:08: ioport range 0x400-0x401 has been reserved
[4294672.181000] pnp: 00:08: ioport range 0x40b-0x40b has been reserved
[4294672.181000] PCI: Bridge: 0000:00:01.0
[4294672.181000]   IO window: 9000-9fff
[4294672.181000]   MEM window: c0100000-c01fffff
[4294672.181000]   PREFETCH window: d0000000-dfffffff
[4294672.181000] PCI: Bus 3, cardbus bridge: 0000:02:06.0
[4294672.181000]   IO window: 0000a400-0000a4ff
[4294672.181000]   IO window: 0000a800-0000a8ff
[4294672.181000]   PREFETCH window: 20000000-21ffffff
[4294672.181000]   MEM window: 24000000-25ffffff
[4294672.181000] PCI: Bridge: 0000:00:14.4
[4294672.181000]   IO window: a000-afff
[4294672.181000]   MEM window: c0200000-c02fffff
[4294672.181000]   PREFETCH window: 20000000-21ffffff
[4294672.181000] PCI: Enabling device 0000:02:06.0 (0004 -> 0007)
[4294672.181000] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 23 (level, low) -> IRQ 177
[4294672.181000] NET: Registered protocol family 2
[4294672.190000] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[4294672.190000] TCP established hash table entries: 16384 (order: 4, 65536 bytes)
[4294672.190000] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[4294672.190000] TCP: Hash tables configured (established 16384 bind 8192)
[4294672.190000] TCP reno registered
[4294672.190000] audit: initializing netlink socket (disabled)
[4294672.190000] audit(1147970692.189:1): initialized
[4294672.190000] VFS: Disk quotas dquot_6.5.1
[4294672.190000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[4294672.190000] Initializing Cryptographic API
[4294672.190000] io scheduler noop registered
[4294672.190000] io scheduler anticipatory registered (default)
[4294672.191000] io scheduler deadline registered
[4294672.191000] io scheduler cfq registered
[4294672.860000] isapnp: Scanning for PnP cards...
[4294673.218000] isapnp: No Plug & Play device found
[4294673.240000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[4294673.242000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[4294673.242000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294673.242000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294673.242000] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[4294673.244000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294673.244000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294673.244000] mice: PS/2 mouse device common for all mice
[4294673.245000] EISA: Probing bus 0 at eisa.0
[4294673.245000] Cannot allocate resource for EISA slot 1
[4294673.245000] Cannot allocate resource for EISA slot 8
[4294673.245000] EISA: Detected 0 cards.
[4294673.245000] TCP bic registered
[4294673.245000] NET: Registered protocol family 1
[4294673.245000] NET: Registered protocol family 8
[4294673.245000] NET: Registered protocol family 20
[4294673.245000] Using IPI Shortcut mode
[4294673.245000] ACPI wakeup devices: 
[4294673.245000]  LID OHC1 OHC2 EHCI  P2P LANC AUDO MODM 
[4294673.245000] ACPI: (supports S0 S3 S4 S5)
[4294673.246000] Freeing unused kernel memory: 288k freed
[4294673.282000] input: AT Translated Set 2 keyboard as /class/input/input0
[4294673.305000] ACPI: Fan [FAN1] (off)
[4294673.309000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[4294673.309000] ACPI: Processor [CPU0] (supports 8 throttling states)
[4294673.470000] ACPI: Thermal Zone [TZCR] (51 C)
[4294673.777000] SCSI subsystem initialized
[4294673.781000] libata version 1.30 loaded.
[4294673.782000] sata_sil 0000:00:12.0: version 1.0
[4294673.782000] PCI: Enabling device 0000:00:12.0 (0005 -> 0007)
[4294673.782000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 185
[4294673.782000] ata1: SATA max UDMA/100 cmd 0xDE82A080 ctl 0xDE82A08A bmdma 0xDE82A000 irq 185
[4294673.782000] ata2: SATA max UDMA/100 cmd 0xDE82A0C0 ctl 0xDE82A0CA bmdma 0xDE82A008 irq 185
[4294674.134000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4294674.136000] ata1.00: cfg 49:2f00 82:746b 83:7d09 84:6023 85:7469 86:3d09 87:6023 88:203f
[4294674.136000] ata1.00: ATA-6, max UDMA/100, 156301488 sectors: LBA48 NCQ (depth 0/32)
[4294674.138000] ata1.00: configured for UDMA/100
[4294674.138000] scsi0 : sata_sil
[4294674.340000] ata2: SATA link down (SStatus 0 SControl 300)
[4294674.340000] scsi1 : sata_sil
[4294674.341000]   Vendor: ATA       Model: TOSHIBA MK8032GS  Rev: AS11
[4294674.341000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294674.348000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[4294674.348000] sda: Write Protect is off
[4294674.348000] sda: Mode Sense: 00 3a 00 00
[4294674.348000] SCSI device sda: drive cache: write back
[4294674.348000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[4294674.348000] sda: Write Protect is off
[4294674.348000] sda: Mode Sense: 00 3a 00 00
[4294674.348000] SCSI device sda: drive cache: write back
[4294674.348000]  sda: sda1 sda2 sda3
[4294674.399000] sd 0:0:0:0: Attached scsi disk sda
[4294674.721000] ATIIXP: IDE controller at PCI slot 0000:00:14.1
[4294674.721000] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 193
[4294674.721000] ATIIXP: chipset revision 128
[4294674.721000] ATIIXP: not 100% native mode: will probe irqs later
[4294674.721000]     ide0: BM-DMA at 0x8460-0x8467, BIOS settings: hda:pio, hdb:pio
[4294674.721000]     ide1: BM-DMA at 0x8468-0x846f, BIOS settings: hdc:DMA, hdd:pio
[4294674.721000] Probing IDE interface ide0...
[4294675.240000] Probing IDE interface ide1...
[4294675.912000] hdc: HL-DT-ST DVDRAM GMA-4082N, ATAPI CD/DVD-ROM drive
[4294676.219000] ide1 at 0x170-0x177,0x376 on irq 15
[4294676.228000] hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
[4294676.228000] Uniform CD-ROM driver Revision: 3.20
[4294676.366000] usbcore: registered new driver usbfs
[4294676.366000] usbcore: registered new driver hub
[4294676.366000] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[4294676.366000] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 201
[4294676.366000] ohci_hcd 0000:00:13.0: OHCI Host Controller
[4294676.367000] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
[4294676.367000] ohci_hcd 0000:00:13.0: irq 201, io mem 0xc0005000
[4294676.418000] usb usb1: configuration #1 chosen from 1 choice
[4294676.418000] hub 1-0:1.0: USB hub found
[4294676.418000] hub 1-0:1.0: 4 ports detected
[4294676.519000] ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 201
[4294676.519000] ohci_hcd 0000:00:13.1: OHCI Host Controller
[4294676.519000] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
[4294676.519000] ohci_hcd 0000:00:13.1: irq 201, io mem 0xc0006000
[4294676.570000] usb usb2: configuration #1 chosen from 1 choice
[4294676.570000] hub 2-0:1.0: USB hub found
[4294676.570000] hub 2-0:1.0: 4 ports detected
[4294676.671000] ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 201
[4294676.671000] ehci_hcd 0000:00:13.2: EHCI Host Controller
[4294676.671000] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
[4294676.672000] ehci_hcd 0000:00:13.2: irq 201, io mem 0xc0007000
[4294676.672000] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[4294676.672000] usb usb3: configuration #1 chosen from 1 choice
[4294676.672000] hub 3-0:1.0: USB hub found
[4294676.672000] hub 3-0:1.0: 8 ports detected
[4294676.792000] Probing IDE interface ide0...
[4294677.245000] usb 1-1: new low speed USB device using ohci_hcd and address 3
[4294677.337000] Attempting manual resume
[4294677.343000] JFS: nTxBlock = 3770, nTxLock = 30163
[4294677.390000] usb 1-1: configuration #1 chosen from 1 choice
[4294677.406000] usbcore: registered new driver hiddev
[4294677.412000] input: Microsoft Microsoft 3-Button Mouse with IntelliEye? as /class/input/input1
[4294677.412000] input: USB HID v1.00 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye?] on usb-0000:00:13.0-1
[4294677.412000] usbcore: registered new driver usbhid
[4294677.412000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[4294681.666000] ts: Compaq touchscreen protocol output
[4294681.756000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[4294682.500000] input: PC Speaker as /class/input/input2
[4294682.673000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[4294682.724000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[4294682.749000] Linux agpgart interface v0.101 (c) Dave Jones
[4294682.937000] Real Time Clock Driver v1.12ac
[4294683.154000] ieee1394: Initialized config rom entry `ip1394'
[4294683.252000] ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 185
[4294683.303000] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[185]  MMIO=[c0215800-c0215fff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[4294683.336000] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 23 (level, low) -> IRQ 177
[4294683.336000] Yenta: CardBus bridge found at 0000:02:06.0 [1179:ff10]
[4294683.336000] Yenta: Enabling burst memory read transactions
[4294683.336000] Yenta: Using CSCINT to route CSC interrupts to PCI
[4294683.336000] Yenta: Routing CardBus interrupts to PCI
[4294683.336000] Yenta TI: socket 0000:02:06.0, mfunc 0x01111122, devctl 0x44
[4294683.343000] 8139too Fast Ethernet driver 0.9.27
[4294683.559000] Yenta: ISA IRQ mask 0x0ef8, PCI irq 177
[4294683.559000] Socket status: 30000006
[4294683.559000] pcmcia: parent PCI bridge I/O window: 0xa000 - 0xafff
[4294683.559000] cs: IO port probe 0xa000-0xafff: clean.
[4294683.560000] pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xc02fffff
[4294683.560000] pcmcia: parent PCI bridge Memory window: 0x20000000 - 0x21ffffff
[4294683.802000] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04713/0x0
[4294683.802000] synaptics: Toshiba Satellite A100 detected, limiting rate to 40pps.
[4294683.824000] ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 20 (level, low) -> IRQ 209
[4294683.824000] eth0: RealTek RTL8139 at 0xdebcc000, 00:a0:d1:34:39:23, IRQ 209
[4294683.824000] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[4294683.837000] input: SynPS/2 Synaptics TouchPad as /class/input/input3
[4294683.863000] 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
[4294683.967000] ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 193
[4294684.100000] ACPI Error (evxfevnt-0388): Could not disable RealTimeClock events [20060127]
[4294684.144000] hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
[4294684.559000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00080da0d1343923]
[4294684.592000] cs: IO port probe 0x100-0x3af: excluding 0x1f0-0x1f7
[4294684.595000] cs: IO port probe 0x3e0-0x4ff: excluding 0x3f0-0x3f7 0x4d0-0x4d7
[4294684.596000] cs: IO port probe 0x820-0x8ff: excluding 0x878-0x87f
[4294684.597000] cs: IO port probe 0xc00-0xcf7: excluding 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf
[4294684.598000] cs: IO port probe 0xa00-0xaff: clean.
[4294684.988000] lp: driver loaded but no devices found
[4294685.026000] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[4294685.026000] ieee1394: sbp2: Try serialize_io=0 for better performance
[4294685.136000] Adding 971924k swap on /dev/sda2.  Priority:-1 extents:1 across:971924k
[4294686.000000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[4294686.000000] md: bitmap version 4.39
[4294686.802000] device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
[4294688.303000] device-mapper: dm-linear: Device lookup failed
[4294688.303000] device-mapper: error adding target to table
[4294688.304000] device-mapper: dm-linear: Device lookup failed
[4294688.304000] device-mapper: error adding target to table
[4294688.305000] device-mapper: dm-linear: Device lookup failed
[4294688.305000] device-mapper: error adding target to table
[4294688.306000] device-mapper: dm-linear: Device lookup failed
[4294688.306000] device-mapper: error adding target to table
[4294688.307000] device-mapper: dm-linear: Device lookup failed
[4294688.308000] device-mapper: error adding target to table
[4294688.309000] device-mapper: dm-linear: Device lookup failed
[4294688.309000] device-mapper: error adding target to table
[4294688.310000] device-mapper: dm-linear: Device lookup failed
[4294688.310000] device-mapper: error adding target to table
[4294688.311000] device-mapper: dm-linear: Device lookup failed
[4294688.311000] device-mapper: error adding target to table
[4294688.312000] device-mapper: dm-linear: Device lookup failed
[4294688.312000] device-mapper: error adding target to table
[4294688.313000] device-mapper: dm-linear: Device lookup failed
[4294688.313000] device-mapper: error adding target to table
[4294688.315000] device-mapper: dm-linear: Device lookup failed
[4294688.315000] device-mapper: error adding target to table
[4294688.316000] device-mapper: dm-linear: Device lookup failed
[4294688.316000] device-mapper: error adding target to table
[4294688.461000] NTFS driver 2.1.27 [Flags: R/O MODULE].
[4294688.577000] NTFS volume version 3.1.
[4294691.140000] ACPI: AC Adapter [ADP0] (on-line)
[4294691.271000] ACPI: Battery Slot [BAT0] (battery present)
[4294691.290000] ACPI Exception (utmutex-0257): AE_TIME, Thread 0 could not acquire Mutex [8] [20060127]
[4294691.290000] ACPI Exception (utmutex-0257): AE_TIME, Thread 0 could not acquire Mutex [8] [20060127]
[4294691.291000] ACPI: Power Button (FF) [PWRF]
[4294691.292000] ACPI: Power Button (CM) [PWRB]
[4294691.292000] ACPI: Lid Switch [LID]
[4294691.344000] Using specific hotkey driver
[4294691.367000] ibm_acpi: ec object not found
[4294925.115000] ACPI Error (evevent-0312): No installed handler for fixed event [00000000] [20060127]
[4296109.762000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
[4296109.762000] ata1.00: (BMDMA stat 0x21)
[4296109.762000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
[4296109.763000] ata1: soft resetting port
[4296109.914000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4296109.919000] ata1.00: configured for UDMA/100
[4296109.919000] ata1: EH complete
[4296451.308000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
[4296451.308000] ata1.00: (BMDMA stat 0x21)
[4296451.308000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
[4296451.308000] ata1: soft resetting port
[4296451.459000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4296451.463000] ata1.00: configured for UDMA/100
[4296451.463000] ata1: EH complete
[4296764.739000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
[4296764.739000] ata1.00: (BMDMA stat 0x21)
[4296764.739000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
[4296764.739000] ata1: soft resetting port
[4296764.890000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4296764.894000] ata1.00: configured for UDMA/100
[4296764.894000] ata1: EH complete

--------------090506000701080201050706--
