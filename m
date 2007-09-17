From: "Glen Larkins" <ghlave@gmail.com>
Subject: Problems with Promise controller or Seagate 500g ST3500630AS ?
Date: Sun, 16 Sep 2007 23:50:24 -0500
Message-ID: <ef5d62f60709162150j44a8bc63r230e89f6c46cc729@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:22304 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbXIQEu0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 00:50:26 -0400
Received: by py-out-1112.google.com with SMTP id u77so2939676pyb
        for <linux-ide@vger.kernel.org>; Sun, 16 Sep 2007 21:50:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've been fighting with a problem since June that has now caused me
two complete data losses involving a raid5 array. In June, I was using
Ubuntu Feisty, and my setup was 2 80g Maxtor drives in raid1 off the
nvidia controller on the motherboard, and 4 300g seagates off of a
Promise PDC20518/PDC40518 (SATAII 150 TX4), using raid5 and lvm. This
setup worked flawlessly for me for a long time.

In June, I added 4 Seagate 500g ST3500630AS to a second Promise
controller, and that's when everything begin going a little crazy.
While copying data to this new array, I started getting timeouts, and
messages stating that COMRESET FAILED (errno=-5). At the time, I
thought I had a failed drive. I shutdown, used seagate's disktool iso
and checked the drives out. I rma'd one and when I got it back, I
added it to the array, and during the rebuild, another drive dropped
out.

To summarize, I have tried all of the following: RMA'd 4 different
drives, replaced the Promise controller with a new one (PDC20718 (SATA
300 TX4)), replaced all sata cables, downgraded to Ubuntu Edgy and an
earlier kernel, re-setup the arrays, checked out the drives under
WinXP.

I'm currently running under Edgy and kernel 2.6.17-10, and I'm still
getting timeouts just during the boot process. I've included my
current dmesg, though its a bit lengthy. This particular boot has 3 of
the 4 500g drives disconnected.


    [42949372.960000] Linux version 2.6.17-10-server (root@terranova)
(gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #2
SMP Tue Dec 5 22:29:32 UTC 2006 (Ubuntu $
    [42949372.960000] BIOS-provided physical RAM map:
    [42949372.960000]  BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
    [42949372.960000]  BIOS-e820: 000000000009a800 - 00000000000a0000 (reserved)
    [42949372.960000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
    [42949372.960000]  BIOS-e820: 0000000000100000 - 000000005fff0000 (usable)
    [42949372.960000]  BIOS-e820: 000000005fff0000 - 000000005fff3000 (ACPI NVS)
    [42949372.960000]  BIOS-e820: 000000005fff3000 - 0000000060000000
(ACPI data)
    [42949372.960000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
    [42949372.960000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
    [42949372.960000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
    [42949372.960000] 639MB HIGHMEM available.
    [42949372.960000 ] 896MB LOWMEM available.
    [42949372.960000] found SMP MP-table at 000f5b50
    [42949372.960000] On node 0 totalpages: 393200
    [42949372.960000]   DMA zone: 4096 pages, LIFO batch:0
    [42949372.960000]   Normal zone: 225280 pages, LIFO batch:31
    [42949372.960000]   HighMem zone: 163824 pages, LIFO batch:31
    [42949372.960000] DMI 2.2 present.
    [42949372.960000] ACPI: RSDP (v000 Nvidia
      ) @ 0x000f7580
    [42949372.960000] ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD
0x00000000) @ 0x5fff3000
    [42949372.960000] ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD
0x00000000) @ 0x5fff3040
    [42949372.960000] ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD
0x00000000) @ 0x5fff7f40
    [42949372.960000] ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT
0x0100000e) @ 0x00000000
    [42949372.960000] ACPI: PM-Timer IO Port: 0x4008
    [42949372.960000] ACPI: Local APIC address 0xfee00000
    [42949372.960000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
    [42949372.960000] Processor #0 6:10 APIC version 16
    [42949372.960000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
    [42949372.960000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
    [42949372.960000] IOAPIC[0]: apic_id 2, version 17, address
0xfec00000, GSI 0-23
    [42949372.960000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
    [42949372.960000] ACPI: BIOS IRQ0 pin2 override ignored.
    [42949372.960000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9
high level)
    [42949372.960000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq
14 high edge)
    [42949372.960000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq
15 high edge)
    [42949372.960000] ACPI: IRQ9 used by override.
    [42949372.960000 ] ACPI: IRQ14 used by override.
    [42949372.960000] ACPI: IRQ15 used by override.
    [42949372.960000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
    [42949372.960000] Using ACPI (MADT) for SMP configuration information
    [42949372.960000] Allocating PCI resources starting at 70000000
(gap: 60000000:9ec00000)
    [42949372.960000] Built 1 zonelists
    [42949372.960000] Kernel command line: root=/dev/md0 ro quiet splash
    [42949372.960000 ] mapped APIC to ffffd000 (fee00000)
    [42949372.960000] mapped IOAPIC to ffffc000 (fec00000)
    [42949372.960000] Enabling fast FPU save and restore... done.
    [42949372.960000] Enabling unmasked SIMD FPU exception support... done.
    [42949372.960000] Initializing CPU#0
    [42949372.960000] PID hash table entries: 4096 (order: 12, 16384 bytes)
    [42949372.960000] Detected 1908.914 MHz processor.
    [42949372.960000] Using pmtmr for high-res timesource
    [42949372.960000] Console: colour VGA+ 80x25
    [42949374.410000] Dentry cache hash table entries: 131072 (order:
7, 524288 bytes)
    [42949374.410000] Inode-cache hash table entries: 65536 (order: 6,
262144 bytes)
    [42949374.460000] Memory: 1549272k/1572800k available (1903k
kernel code, 22308k reserved, 1073k data, 312k init, 655296k highmem)
    [42949374.460000] Checking if this processor honours the WP bit
even in supervisor mode... Ok.
    [42949374.610000] Calibrating delay using timer specific routine..
3821.22 BogoMIPS (lpj=19106138)
    [42949374.610000] Security Framework v1.0.0 initialized
    [42949374.610000] SELinux:  Disabled at boot.
    [42949374.610000 ] Mount-cache hash table entries: 512
    [42949374.610000] CPU: After generic identify, caps: 0383fbff
c1c3fbff 00000000 00000000 00000000 00000000 00000000
    [42949374.610000] CPU: After vendor identify, caps: 0383fbff
c1c3fbff 00000000 00000000 00000000 00000000 00000000
    [42949374.610000] CPU: L1 I Cache: 64K (64 bytes/line), D cache
64K (64 bytes/line)
    [42949374.610000] CPU: L2 Cache: 512K (64 bytes/line)
    [42949374.610000] CPU: After all inits, caps: 0383fbff c1c3fbff
00000000 00000420 00000000 00000000 00000000
    [42949374.610000] Checking 'hlt' instruction... OK.
    [42949374.650000] SMP alternatives: switching to UP code
    [42949374.650000] Freeing SMP alternatives: 16k freed
    [42949374.650000] checking if image is initramfs... it is
    [42949375.090000] Freeing initrd memory: 5428k freed
    [42949375.090000] ACPI: Core revision 20060707
    [42949375.100000] ACPI: Looking for DSDT ... not found!
    [42949375.100000] CPU0: AMD Athlon(tm) XP 2600+ stepping 00
    [42949375.100000] Total of 1 processors activated (3821.22 BogoMIPS).
    [42949375.100000] ENABLING IO-APIC IRQs
    [42949375.100000] ..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
    [42949375.310000] Brought up 1 CPUs
    [42949375.310000] migration_cost=0
    [42949375.310000] NET: Registered protocol family 16
    [42949375.310000] EISA bus registered
    [42949375.310000] ACPI: bus type pci registered
    [42949375.320000] PCI: PCI BIOS revision 2.10 entry at 0xfbe50, last bus=2
    [42949375.320000] PCI: Using configuration type 1
    [42949375.320000] Setting up standard PCI resources
    [42949375.340000] ACPI: Interpreter enabled
    [42949375.340000] ACPI: Using IOAPIC for interrupt routing
    [42949375.340000] ACPI: PCI Root Bridge [PCI0] (0000:00)
    [42949375.340000] PCI: Probing PCI hardware (bus 00)
    [42949375.340000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:09.0
    [42949375.340000] Boot video device is 0000:01: 00.0
    [42949375.340000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
    [42949375.400000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
    [42949375.400000] ACPI: Power Resource [ISAV] (on)
    [42949375.400000 ] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
    [42949375.410000] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7
9 10 11 12 14 15)
    [42949375.410000] ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7
9 10 11 12 14 15) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7
9 10 11 12 14 15) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7
9 *10 11 12 14 15)
    [42949375.410000] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7
9 10 11 12 14 15) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [LUBA] (IRQs 3 *4 5 6 7
9 10 11 12 14 15)
    [42949375.410000] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7
9 10 *11 12 14 15)
    [42949375.410000] ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 *7
9 10 11 12 14 15)
    [42949375.410000] ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7
9 10 11 12 14 15) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [LACI] (IRQs *3 4 5 6 7
9 10 11 12 14 15)
    [42949375.410000] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7
9 10 11 12 14 15) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7
9 *10 11 12 14 15)
    [42949375.410000] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7
*9 10 11 12 14 15)
    [42949375.410000] ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7
9 10 11 12 14 15) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7
9 10 11 12 14 15) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7
9 10 11 12 14 15) *0, disabled.
    [42949375.410000 ] ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7
9 10 *11 12 14 15)
    [42949375.410000] ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [APCI] (IRQs 20 21) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21) *0, disabled.
    [42949375.410000] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21) *0, disabled.
    [42949375.420000] ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
    [42949375.420000] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21) *0, disabled.
    [42949375.420000] ACPI: PCI Interrupt Link [APCM] (IRQs 20 21) *0, disabled.
    [42949375.420000] ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21) *0, disabled.
    [42949375.420000] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21) *0, disabled.
    [42949375.420000] ACPI: PCI Interrupt Link [APSI] (IRQs 22) *0, disabled.
    [42949375.420000] Linux Plug and Play Support v0.97 (c) Adam Belay
    [42949375.420000] pnp: PnP ACPI init
    [42949375.420000] pnp: PnP ACPI: found 11 devices
    [42949375.420000] PnPBIOS: Disabled by ACPI PNP
    [42949375.420000 ] PCI: Using ACPI for IRQ routing
    [42949375.420000] PCI: If a device doesn't work, try
"pci=routeirq".  If it helps, post a report
    [42949375.480000] pnp: 00:00: ioport range 0x4000-0x407f could not
be reserved
    [42949375.480000] pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
    [42949375.480000] pnp: 00:00: ioport range 0x4400-0x447f has been reserved
    [42949375.480000] pnp: 00:00: ioport range 0x4480-0x44ff could not
be reserved
    [42949375.480000] pnp: 00:00: ioport range 0x4200-0x427f has been reserved
    [42949375.480000] pnp: 00:00: ioport range 0x4280-0x42ff has been reserved
    [42949375.480000] pnp: 00:01: ioport range 0x5000-0x503f has been reserved
    [42949375.480000] pnp: 00:01: ioport range 0x5100-0x513f has been reserved
    [42949375.480000] PCI: Bridge: 0000:00:08.0
    [42949375.480000]   IO window: a000-bfff
    [42949375.480000]   MEM window: dc000000-ddffffff
    [42949375.480000]   PREFETCH window: 70000000-700fffff
    [42949375.480000] PCI: Bridge: 0000:00:1e.0
    [42949375.480000]   IO window: disabled.
    [42949375.480000]   MEM window: de000000-dfffffff
    [42949375.480000 ]   PREFETCH window: d0000000-d7ffffff
    [42949375.480000] PCI: Setting latency timer of device 0000:00:08.0 to 64
    [42949375.480000] NET: Registered protocol family 2
    [42949375.560000] IP route cache hash table entries: 32768 (order:
5, 131072 bytes)
    [42949375.560000] TCP established hash table entries: 262144
(order: 9, 2097152 bytes)
    [42949375.560000] TCP bind hash table entries: 65536 (order: 7,
524288 bytes)
    [42949375.560000] TCP: Hash tables configured (established 262144
bind 65536)
    [42949375.560000] TCP reno registered
    [42949375.560000] audit: initializing netlink socket (disabled)
    [42949375.560000] audit(1189987192.560:1): initialized
    [42949375.560000] highmem bounce pool size: 64 pages
    [42949375.560000] VFS: Disk quotas dquot_6.5.1
    [42949375.560000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
    [42949375.560000] Initializing Cryptographic API
    [42949375.560000] io scheduler noop registered
    [42949375.560000] io scheduler anticipatory registered
    [42949375.560000] io scheduler deadline registered (default)
    [42949375.560000] io scheduler cfq registered
    [42949375.560000] isapnp: Scanning for PnP cards...
    [42949375.920000] isapnp: No Plug & Play device found
    [42949375.940000] Real Time Clock Driver v1.12ac
    [42949375.940000] Serial: 8250/16550 driver $Revision: 1.90 $ 4
ports, IRQ sharing enabled
    [42949375.940000 ] mice: PS/2 mouse device common for all mice
    [42949375.940000] RAMDISK driver initialized: 16 RAM disks of
65536K size 1024 blocksize
    [42949375.940000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
    [42949375.940000 ] ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
    [42949375.940000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
    [42949375.940000] serio: i8042 AUX port at 0x60,0x64 irq 12
    [42949375.940000] serio: i8042 KBD port at 0x60,0x64 irq 1
    [42949375.940000] EISA: Probing bus 0 at eisa.0
    [42949375.940000] Cannot allocate resource for EISA slot 4
    [42949375.940000] Cannot allocate resource for EISA slot 5
    [42949375.940000] EISA: Detected 0 cards.
    [42949375.940000] TCP bic registered
    [42949375.940000] NET: Registered protocol family 1
    [42949375.940000] NET: Registered protocol family 8
    [42949375.940000] NET: Registered protocol family 20
    [42949375.940000] Using IPI No-Shortcut mode
    [42949375.940000] ACPI: (supports S0 S1 S4 S5)
    [42949375.940000] Freeing unused kernel memory: 312k freed
    [42949375.970000] input: AT Translated Set 2 keyboard as /class/input/input0
    [42949375.990000] Capability LSM initialized
    [42949376.340000] SCSI subsystem initialized
    [42949376.340000] libata version 1.20 loaded.
    [42949376.350000] sata_nv 0000:00:0b.0: version 0.8
    [42949376.350000] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
    [42949376.350000] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link
[APSI] -> GSI 22 (level, high) -> IRQ 177
    [42949376.350000] PCI: Setting latency timer of device 0000:00:0b.0 to 64
    [42949376.350000] ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2
bmdma 0xCC00 irq 177
    [42949376.350000] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72
bmdma 0xCC08 irq 177
    [42949376.560000] ata1: SATA link up 1.5 Gbps (SStatus 113)
    [42949376.740000] ata1: dev 0 cfg 49:2f00 82:7c6b 83:5b09 84:4673
85:7c69 86:1a21 87:4663 88:407f
    [42949376.740000] ata1: dev 0 ATA-7, max UDMA/133, 160086528 sectors: LBA
    [42949376.740000] nv_sata: Primary device added
    [42949376.740000] nv_sata: Primary device removed
    [42949376.740000] nv_sata: Secondary device added
    [42949376.740000] nv_sata: Secondary device removed
    [42949376.760000] ata1: dev 0 configured for UDMA/133
    [42949376.760000] scsi0 : sata_nv
    [42949376.970000] ata2: SATA link up 1.5 Gbps (SStatus 113)
    [42949377.150000 ] ata2: dev 0 cfg 49:2f00 82:7c6b 83:5b09 84:4673
85:7c69 86:1a21 87:4663 88:407f
    [42949377.150000] ata2: dev 0 ATA-7, max UDMA/133, 160086528 sectors: LBA
    [42949377.170000] ata2: dev 0 configured for UDMA/133
    [42949377.170000 ] scsi1 : sata_nv
    [42949377.170000]   Vendor: ATA       Model: Maxtor 6L080M0    Rev: BACE
    [42949377.170000]   Type:   Direct-Access
ANSI SCSI revision: 05
    [42949377.170000]   Vendor: ATA       Model: Maxtor 6L080M0    Rev: BACE
    [42949377.170000]   Type:   Direct-Access
ANSI SCSI revision: 05
    [42949377.170000] NFORCE2-U400R: IDE controller at PCI slot 0000:00:09.0
    [42949377.170000] NFORCE2-U400R: chipset revision 163
    [42949377.170000] NFORCE2-U400R: not 100% native mode: will probe irqs later
    [42949377.170000] NFORCE2-U400R: 0000:00:09.0 (rev a3) UDMA133 controller
    [42949377.170000]     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:DMA
    [42949377.170000]     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:DMA, hdd:DMA
    [42949377.170000] Probing IDE interface ide0...
    [42949377.190000] SCSI device sda: 160086528 512-byte hdwr sectors
(81964 MB)
    [42949377.190000] sda: Write Protect is off
    [42949377.190000] sda: Mode Sense: 00 3a 00 00
    [42949377.190000] SCSI device sda: drive cache: write back
    [42949377.190000] SCSI device sda: 160086528 512-byte hdwr sectors
(81964 MB)
    [42949377.190000] sda: Write Protect is off
    [42949377.190000] sda: Mode Sense: 00 3a 00 00
    [42949377.190000] SCSI device sda: drive cache: write back
    [42949377.190000]  sda: sda1 sda2 sda3
    [42949377.210000 ] sd 0:0:0:0: Attached scsi disk sda
    [42949377.210000] SCSI device sdb: 160086528 512-byte hdwr sectors
(81964 MB)
    [42949377.210000] sdb: Write Protect is off
    [42949377.210000] sdb: Mode Sense: 00 3a 00 00
    [42949377.210000 ] SCSI device sdb: drive cache: write back
    [42949377.210000] SCSI device sdb: 160086528 512-byte hdwr sectors
(81964 MB)
    [42949377.210000] sdb: Write Protect is off
    [42949377.210000] sdb: Mode Sense: 00 3a 00 00
    [42949377.210000] SCSI device sdb: drive cache: write back
    [42949377.210000]  sdb: sdb1 sdb2 sdb3
    [42949377.230000] sd 1:0:0:0: Attached scsi disk sdb
    [42949377.780000] Probing IDE interface ide1...
    [42949378.450000 ] sata_promise 0000:02:07.0: version 1.04
    [42949378.450000] ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
    [42949378.450000] ACPI: PCI Interrupt 0000:02:07.0[A] -> Link
[APC4] -> GSI 19 (level, low) -> IRQ 185
    [42949378.470000] ata3: SATA max UDMA/133 cmd 0xF8830200 ctl
0xF8830238 bmdma 0x0 irq 185
    [42949378.470000] ata4: SATA max UDMA/133 cmd 0xF8830280 ctl
0xF88302B8 bmdma 0x0 irq 185
    [42949378.470000] ata5: SATA max UDMA/133 cmd 0xF8830300 ctl
0xF8830338 bmdma 0x0 irq 185
    [42949378.470000] ata6: SATA max UDMA/133 cmd 0xF8830380 ctl
0xF88303B8 bmdma 0x0 irq 185
    [42949378.680000] ata3: SATA link up 1.5 Gbps (SStatus 113)
    [42949378.860000] ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673
85:7c69 86:3e01 87:4663 88:407f
    [42949378.860000] ata3: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
    [42949378.880000] ata3: dev 0 configured for UDMA/133
    [42949378.880000] scsi2 : sata_promise
    [42949379.090000] ata4: SATA link up 1.5 Gbps (SStatus 113)
    [42949379.270000] ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673
85:7c69 86:3e01 87:4663 88:407f
    [42949379.270000] ata4: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
    [42949379.290000] ata4: dev 0 configured for UDMA/133
    [42949379.290000] scsi3 : sata_promise
    [42949379.500000] ata5: SATA link up 1.5 Gbps (SStatus 113)
    [42949379.680000] ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673
85:7c69 86:3e01 87:4663 88:407f
    [42949379.680000 ] ata5: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
    [42949379.700000] ata5: dev 0 configured for UDMA/133
    [42949379.700000] scsi4 : sata_promise
    [42949379.910000] ata6: SATA link up 1.5 Gbps (SStatus 113)
    [42949380.090000] ata6: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673
85:7c69 86:3e21 87:4663 88:407f
    [42949380.090000] ata6: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
    [42949380.110000] ata6: dev 0 configured for UDMA/133
    [42949380.110000] scsi5 : sata_promise
    [42949380.110000]   Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
    [42949380.110000]   Type:   Direct-Access
ANSI SCSI revision: 05
    [42949380.110000 ] SCSI device sdc: 586114704 512-byte hdwr
sectors (300091 MB)
    [42949380.110000] sdc: Write Protect is off
    [42949380.110000] sdc: Mode Sense: 00 3a 00 00
    [42949380.110000] SCSI device sdc: drive cache: write back
    [42949380.110000] SCSI device sdc: 586114704 512-byte hdwr sectors
(300091 MB)
    [42949380.110000] sdc: Write Protect is off
    [42949380.110000] sdc: Mode Sense: 00 3a 00 00
    [42949380.110000] SCSI device sdc: drive cache: write back
    [42949380.110000]  sdc:
    [42949380.130000] sd 2:0:0:0: Attached scsi disk sdc
    [42949380.130000]   Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
    [42949380.130000]   Type:   Direct-Access
ANSI SCSI revision: 05
    [42949380.130000] SCSI device sdd: 586114704 512-byte hdwr sectors
(300091 MB)
    [42949380.130000] sdd: Write Protect is off
    [42949380.130000] sdd: Mode Sense: 00 3a 00 00
    [42949380.130000] SCSI device sdd: drive cache: write back
    [42949380.130000] SCSI device sdd: 586114704 512-byte hdwr sectors
(300091 MB)
    [42949380.130000] sdd: Write Protect is off
    [42949380.130000] sdd: Mode Sense: 00 3a 00 00
    [42949380.130000] SCSI device sdd: drive cache: write back
    [42949380.130000]  sdd: sdd1
    [42949380.150000] sd 3:0:0:0: Attached scsi disk sdd
    [42949380.150000]   Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
    [42949380.150000]   Type:   Direct-Access
ANSI SCSI revision: 05
    [42949380.150000] SCSI device sde: 586114704 512-byte hdwr sectors
(300091 MB)
    [42949380.150000] sde: Write Protect is off
    [42949380.150000] sde: Mode Sense: 00 3a 00 00
    [42949380.150000] SCSI device sde: drive cache: write back
    [42949380.150000] SCSI device sde: 586114704 512-byte hdwr sectors
(300091 MB)
    [42949380.150000] sde: Write Protect is off
    [42949380.150000] sde: Mode Sense: 00 3a 00 00
    [42949380.150000] SCSI device sde: drive cache: write back
    [42949380.150000]  sde:
    [42949380.170000] sd 4:0:0:0: Attached scsi disk sde
    [42949380.170000]   Vendor: ATA       Model: Maxtor 6L300S0    Rev: BACE
    [42949380.170000]   Type:   Direct-Access
ANSI SCSI revision: 05
    [42949380.170000] SCSI device sdf: 586114704 512-byte hdwr sectors
(300091 MB)
    [42949380.170000] sdf: Write Protect is off
    [42949380.170000] sdf: Mode Sense: 00 3a 00 00
    [42949380.170000] SCSI device sdf: drive cache: write back
    [42949380.170000] SCSI device sdf: 586114704 512-byte hdwr sectors
(300091 MB)
    [42949380.170000] sdf: Write Protect is off
    [42949380.170000] sdf: Mode Sense: 00 3a 00 00
    [42949380.170000] SCSI device sdf: drive cache: write back
    [42949380.170000]  sdf:
    [42949380.190000] sd 5:0:0:0: Attached scsi disk sdf
    [42949380.190000] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
    [42949380.190000] ACPI: PCI Interrupt 0000:02:08.0[A] -> Link
[APC1] -> GSI 16 (level, low) -> IRQ 193
    [42949380.210000] ata7: SATA max UDMA/133 cmd 0xF8832200 ctl
0xF8832238 bmdma 0x0 irq 193
    [42949380.210000] ata8: SATA max UDMA/133 cmd 0xF8832280 ctl
0xF88322B8 bmdma 0x0 irq 193
    [42949380.210000] ata9: SATA max UDMA/133 cmd 0xF8832300 ctl
0xF8832338 bmdma 0x0 irq 193
    [42949380.210000] ata10: SATA max UDMA/133 cmd 0xF8832380 ctl
0xF88323B8 bmdma 0x0 irq 193
    [42949380.420000] ata7: SATA link down (SStatus 0)
    [42949380.420000] scsi6 : sata_promise
    [42949380.630000] ata8: SATA link down (SStatus 0)
    [42949380.630000] scsi7 : sata_promise
    [42949380.840000] ata9: SATA link down (SStatus 0)
    [42949380.840000] scsi8 : sata_promise
    [42949381.050000] ata10: SATA link up 3.0 Gbps (SStatus 123)
    [42949381.230000 ] ata10: dev 0 cfg 49:2f00 82:346b 83:7d01
84:4023 85:3469 86:3c01 87:4023 88:407f
    [42949381.230000] ata10: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
    [42949381.250000] ata10: dev 0 configured for UDMA/133
    [42949381.250000] scsi9 : sata_promise
    [42949381.250000]   Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
    [42949381.250000]   Type:   Direct-Access
ANSI SCSI revision: 05
    [42949381.250000 ] SCSI device sdg: 976773168 512-byte hdwr
sectors (500108 MB)
    [42949381.250000] sdg: Write Protect is off
    [42949381.250000] sdg: Mode Sense: 00 3a 00 00
    [42949381.250000] SCSI device sdg: drive cache: write back
    [42949381.250000] SCSI device sdg: 976773168 512-byte hdwr sectors
(500108 MB)
    [42949381.250000] sdg: Write Protect is off
    [42949381.250000] sdg: Mode Sense: 00 3a 00 00
    [42949381.250000] SCSI device sdg: drive cache: write back
    [42949381.250000]  sdg:
    [42949381.260000] sd 9:0:0:0: Attached scsi disk sdg
    [42949381.540000] Probing IDE interface ide0...
    [42949381.550000] usbcore: registered new driver usbfs
    [42949381.550000] usbcore: registered new driver hub
    [42949381.550000] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host
Controller (OHCI) Driver (PCI)
    [42949381.550000] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
    [42949381.550000] ACPI: PCI Interrupt 0000:00: 02.0[A] -> Link
[APCF] -> GSI 21 (level, high) -> IRQ 201
    [42949381.550000] PCI: Setting latency timer of device 0000:00:02.0 to 64
    [42949381.550000] ohci_hcd 0000:00:02.0: OHCI Host Controller
    [42949381.550000 ] ohci_hcd 0000:00:02.0: new USB bus registered,
assigned bus number 1
    [42949381.580000] ohci_hcd 0000:00:02.0: irq 201, io mem 0xe0001000
    [42949381.580000] forcedeth.c: Reverse Engineered nForce ethernet
driver. Version 0.54.
    [42949381.590000] ieee1394: Initialized config rom entry `ip1394'
    [42949381.640000] usb usb1: configuration #1 chosen from 1 choice
    [42949381.640000] hub 1-0:1.0: USB hub found
    [42949381.640000] hub 1-0: 1.0: 4 ports detected
    [42949381.750000] ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
    [42949381.750000] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link
[APCG] -> GSI 20 (level, high) -> IRQ 209
    [42949381.750000 ] PCI: Setting latency timer of device 0000:00:02.1 to 64
    [42949381.750000] ohci_hcd 0000:00:02.1: OHCI Host Controller
    [42949381.750000] ohci_hcd 0000:00:02.1: new USB bus registered,
assigned bus number 2
    [42949381.770000 ] ohci_hcd 0000:00:02.1: irq 209, io mem 0xe0002000
    [42949381.830000] usb usb2: configuration #1 chosen from 1 choice
    [42949381.830000] hub 2-0:1.0: USB hub found
    [42949381.830000] hub 2-0:1.0: 4 ports detected
    [42949381.960000] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
    [42949381.960000] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link
[APCH] -> GSI 21 (level, high) -> IRQ 201
    [42949381.960000] PCI: Setting latency timer of device 0000:00: 04.0 to 64
    [42949382.150000] Probing IDE interface ide1...
    [42949382.490000] eth0: forcedeth.c: subsystem: 01462:570c bound
to 0000:00:04.0
    [42949382.490000] ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link
[APC4] -> GSI 19 (level, low) -> IRQ 185
    [42949382.490000] PCI: Via IRQ fixup for 0000:02:0b.0, from 10 to 9
    [42949382.540000] ohci1394: fw-host0: OHCI-1394 1.0 (PCI):
IRQ=[185]  MMIO=[dd042000-dd0427ff]  Max Packet=[2048]  IR/IT
contexts=[4/8]
    [42949382.550000 ] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
    [42949382.550000] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link
[APCL] -> GSI 20 (level, high) -> IRQ 209
    [42949382.550000] PCI: Setting latency timer of device 0000:00: 02.2 to 64
    [42949382.550000] ehci_hcd 0000:00:02.2: EHCI Host Controller
    [42949382.550000] ehci_hcd 0000:00:02.2: new USB bus registered,
assigned bus number 3
    [42949382.550000] ehci_hcd 0000:00:02.2: debug port 1
    [42949382.550000] PCI: cache line size of 64 is not supported by
device 0000:00:02.2
    [42949382.550000] ehci_hcd 0000:00:02.2: irq 209, io mem 0xe0003000
    [42949382.550000] ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI
1.00, driver 10 Dec 2004
    [42949382.550000] usb usb3: configuration #1 chosen from 1 choice
    [42949382.550000] hub 3-0:1.0: USB hub found
    [42949382.550000] hub 3-0:1.0: 8 ports detected
    [42949382.810000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
    [42949382.810000] md: bitmap version 4.39
    [42949382.810000] md: raid1 personality registered for level 1
    [42949383.870000] ieee1394: Host added: ID:BUS[0-00:1023]
GUID[0010dc00006b62f0]
    [42949865.910000] md: md0 stopped.
    [42949865.910000] md: bind<sdb1>
    [42949865.910000] md: bind<sda1>
    [42949865.920000] raid1: raid set md0 active with 2 out of 2 mirrors
    [42949865.930000] md: md1 stopped.
    [42949865.930000] md: bind<sdb2>
    [42949865.930000] md: bind<sda2>
    [42949865.940000] raid1: raid set md1 active with 2 out of 2 mirrors
    [42949865.960000] md: md2 stopped.
    [42949865.960000] md: bind<sdb3>
    [42949865.960000] md: bind<sda3>
    [42949865.970000] raid1: raid set md2 active with 2 out of 2 mirrors
    [42949866.310000] Attempting manual resume
    [42949866.340000] kjournald starting.  Commit interval 5 seconds
    [42949866.340000] EXT3-fs: mounted filesystem with ordered data mode.
    [42949869.470000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
    [42949869.480000] shpchp: Standard Hot Plug PCI Controller Driver
version: 0.4
    [42949870.000000] ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
    [42949870.000000] ACPI: PCI Interrupt 0000:00:06.0[A] -> Link
[APCJ] -> GSI 21 (level, high) -> IRQ 201
    [42949870.000000] PCI: Setting latency timer of device 0000:00: 06.0 to 64
    [42949870.030000] Linux agpgart interface v0.101 (c) Dave Jones
    [42949870.230000] input: PC Speaker as /class/input/input1
    [42949870.340000] intel8x0_measure_ac97_clock: measured 60679 usecs
    [42949870.340000 ] intel8x0: clocking to 47488
    [42949870.340000] agpgart: Detected NVIDIA nForce2 chipset
    [42949870.340000] agpgart: AGP aperture is 64M @ 0xd8000000
    [42949870.340000] i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
    [42949870.340000] i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
    [42949870.560000] sd 0:0:0:0: Attached scsi generic sg0 type 0
    [42949870.560000] sd 1:0:0:0: Attached scsi generic sg1 type 0
    [42949870.560000 ] sd 2:0:0:0: Attached scsi generic sg2 type 0
    [42949870.560000] sd 3:0:0:0: Attached scsi generic sg3 type 0
    [42949870.560000] sd 4:0:0:0: Attached scsi generic sg4 type 0
    [42949870.560000] sd 5:0:0:0: Attached scsi generic sg5 type 0
    [42949870.560000] sd 9:0:0:0: Attached scsi generic sg6 type 0
    [42949870.840000] input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
    [42949870.870000] ts: Compaq touchscreen protocol output
    [42949871.170000 ] lp: driver loaded but no devices found
    [42949871.180000] ieee1394: sbp2: Driver forced to serialize I/O
(serialize_io=1)
    [42949871.180000] ieee1394: sbp2: Try serialize_io=0 for better performance
    [42949871.210000 ] NET: Registered protocol family 10
    [42949871.210000] lo: Disabled Privacy Extensions
    [42949871.210000] IPv6 over IPv4 tunneling driver
    [42949871.330000] Adding 3317304k swap on
/dev/disk/by-uuid/06768679-b12b-4b06-843b-31a75ecb6b76.  Priority:-1
extents:1 across:3317304k
    [42949871.440000] EXT3 FS on md0, internal journal
    [42949871.950000] kjournald starting.  Commit interval 5 seconds
    [42949871.950000] EXT3 FS on sdd1, internal journal
    [42949871.950000] EXT3-fs: mounted filesystem with ordered data mode.
    [42949871.980000] kjournald starting.  Commit interval 5 seconds
    [42949872.020000] EXT3 FS on md2, internal journal
    [42949872.020000] EXT3-fs: mounted filesystem with ordered data mode.
    [42949881.750000] eth0: no IPv6 routers present
