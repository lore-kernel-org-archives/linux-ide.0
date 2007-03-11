From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: libata Intel PIIX/ICH fails to detect both PATA drives, spews
 ACPI errors
Date: Sun, 11 Mar 2007 06:40:10 -0600
Message-ID: <45F3F8AA.4060501@gmail.com>
References: <45705618.2020608@gmail.com> <45E447DD.9050308@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090901070301040405040809"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:15012 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933291AbXCKMkQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Mar 2007 08:40:16 -0400
Received: by py-out-1112.google.com with SMTP id a29so440993pyi
        for <linux-ide@vger.kernel.org>; Sun, 11 Mar 2007 05:40:15 -0700 (PDT)
In-Reply-To: <45E447DD.9050308@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090901070301040405040809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Berck E. Nash wrote:
>> Testing the new libata ICH PATA drivers.  There's one PATA port on this
>> chip, and I've got two optical drives connected to it.  The master drive
>> fails to detect.  The slave detects and works properly.
> 
> Can you test 2.6.20.1 and post full dmesg?

Here's 2.6.20.2...  No ACPI errors, but still doesn't detect both drives.


--------------090901070301040405040809
Content-Type: text/plain;
 name="piierror"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="piierror"

[    0.000000] Linux version 2.6.20.2 (root@luna) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Sun Mar 11 05:50:34 MDT 2007
[    0.000000] Command line: root=/dev/sdc1 ro console=tty0 console=ttyS0,115200n8 BOOT_IMAGE=vmlinuz
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ff80000 (usable)
[    0.000000]  BIOS-e820: 000000003ff80000 - 000000003ff8e000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ff8e000 - 000000003ffe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003ffe0000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.4 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   262016
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bfb00000)
[    0.000000] PERCPU: Allocating 31872 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 257492
[    0.000000] Kernel command line: root=/dev/sdc1 ro console=tty0 console=ttyS0,115200n8 BOOT_IMAGE=vmlinuz
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   55.520818] Console: colour VGA+ 80x25
[   55.783193] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   55.790592] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   55.797553] Checking aperture...
[   55.808626] Memory: 1028168k/1048064k available (1968k kernel code, 19392k reserved, 887k data, 192k init)
[   55.899175] Calibrating delay using timer specific routine.. 5611.38 BogoMIPS (lpj=9349414)
[   55.907642] Mount-cache hash table entries: 256
[   55.912287] CPU: L1 I cache: 32K, L1 D cache: 32K
[   55.917075] CPU: L2 cache: 2048K
[   55.920342] using mwait in idle threads.
[   55.924299] CPU: Physical Processor ID: 0
[   55.928343] CPU: Processor Core ID: 0
[   55.932044] CPU0: Thermal monitoring enabled (TM2)
[   55.936881] Freeing SMP alternatives: 24k freed
[   55.941454] ACPI: Core revision 20060707
[   55.983013] Using local APIC timer interrupts.
[   56.023138] result 25026964
[   56.025969] Detected 25.026 MHz APIC timer.
[   56.032439] Booting processor 1/2 APIC 0x1
[   56.047243] Initializing CPU#1
[   56.128968] Calibrating delay using timer specific routine.. 5608.35 BogoMIPS (lpj=9342966)
[   56.128972] CPU: L1 I cache: 32K, L1 D cache: 32K
[   56.128974] CPU: L2 cache: 2048K
[   56.128975] CPU: Physical Processor ID: 0
[   56.128976] CPU: Processor Core ID: 1
[   56.128980] CPU1: Thermal monitoring enabled (TM2)
[   56.129178] Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz stepping 06
[   56.132304] Brought up 2 CPUs
[   56.174023] testing NMI watchdog ... OK.
[   56.211020] time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
[   56.217583] time.c: Detected 2803.022 MHz processor.
[   56.247913] migration_cost=19
[   56.251168] NET: Registered protocol family 16
[   56.255689] ACPI: bus type pci registered
[   56.259737] PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
[   56.266213] PCI: Not using MMCONFIG.
[   56.269829] PCI: Using configuration type 1
[   56.282502] ACPI: Interpreter enabled
[   56.286203] ACPI: Using IOAPIC for interrupt routing
[   56.292399] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   56.297698] PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
[   56.304186] PCI quirk: region 0480-04bf claimed by ICH6 GPIO
[   56.310279] PCI: Transparent bridge - 0000:00:1e.0
[   56.322219] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   56.330023] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[   56.337806] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
[   56.345607] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   56.353393] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   56.361176] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   56.368955] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   56.376736] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   56.384408] Linux Plug and Play Support v0.97 (c) Adam Belay
[   56.390103] pnp: PnP ACPI init
[   56.395707] pnp: PnP ACPI: found 15 devices
[   56.400015] SCSI subsystem initialized
[   56.403844] PCI: Using ACPI for IRQ routing
[   56.408063] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   56.416414] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   56.421502] hpet0: 3 64-bit timers, 14318180 Hz
[   56.427071] PCI-GART: No AMD northbridge found.
[   56.432135] pnp: 00:07: ioport range 0x290-0x297 has been reserved
[   56.438513] PCI: Bridge: 0000:00:01.0
[   56.442214]   IO window: disabled.
[   56.445653]   MEM window: faa00000-feafffff
[   56.449869]   PREFETCH window: cff00000-efefffff
[   56.454520] PCI: Bridge: 0000:00:1c.0
[   56.458214]   IO window: disabled.
[   56.461654]   MEM window: disabled.
[   56.465178]   PREFETCH window: cfe00000-cfefffff
[   56.470030] PCI: Bridge: 0000:00:1e.0
[   56.473725]   IO window: b000-cfff
[   56.477163]   MEM window: fa800000-fa9fffff
[   56.481380]   PREFETCH window: 50000000-500fffff
[   56.486037] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   56.493531] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   56.501042] NET: Registered protocol family 2
[   56.545457] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[   56.553045] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[   56.561104] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   56.568353] TCP: Hash tables configured (established 131072 bind 65536)
[   56.574996] TCP reno registered
[   56.589386] audit: initializing netlink socket (disabled)
[   56.594832] audit(1173592499.663:1): initialized
[   56.599613] io scheduler noop registered
[   56.603621] io scheduler anticipatory registered (default)
[   56.622262] assign_interrupt_mode Found MSI capability
[   56.627540] assign_interrupt_mode Found MSI capability
[   56.632874] input: Power Button (FF) as /class/input/input0
[   56.638481] ACPI: Power Button (FF) [PWRF]
[   56.642666] input: Power Button (CM) as /class/input/input1
[   56.648265] ACPI: Power Button (CM) [PWRB]
[   56.652649] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU1PM] [20060707]
[   56.662228] ACPI: Processor [CPU1] (supports 8 throttling states)
[   56.668639] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU2PM] [20060707]
[   56.683466] ACPI: Processor [CPU2] (supports 8 throttling states)
[   56.690939] Real Time Clock Driver v1.12ac
[   56.695164] intel_rng: FWH not detected
[   56.699037] Linux agpgart interface v0.101 (c) Dave Jones
[   56.704472] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   56.712426] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   56.718761] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   56.724519] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 22
[   56.941694] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   56.941695]         <Adaptec 2940 Ultra2 SCSI adapter>
[   56.941696]         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   56.941697] 
[   56.962521] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
[   57.222160] scsi 0:0:1:0: Direct-Access     IBM-PCCO ST39102LC     !# B219 PQ: 0 ANSI: 2
[   57.230294] scsi0:A:1:0: Tagged Queuing enabled.  Depth 8
[   57.235776]  target0:0:1: Beginning Domain Validation
[   57.247266]  target0:0:1: wide asynchronous
[   57.256161]  target0:0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
[   57.267388]  target0:0:1: Domain Validation skipping write tests
[   57.273427]  target0:0:1: Ending Domain Validation
[   57.281244] scsi 0:0:2:0: Direct-Access     SGI      SEAGATE ST39102L 2702 PQ: 0 ANSI: 2
[   57.289372] scsi0:A:2:0: Tagged Queuing enabled.  Depth 8
[   57.294856]  target0:0:2: Beginning Domain Validation
[   57.305241]  target0:0:2: wide asynchronous
[   57.313314]  target0:0:2: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
[   57.323711]  target0:0:2: Domain Validation skipping write tests
[   57.329755]  target0:0:2: Ending Domain Validation
[   57.970858] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[   57.978986] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part 
[   57.985578] ata1: SATA max UDMA/133 cmd 0xFFFFC20000020900 ctl 0x0 bmdma 0x0 irq 317
[   57.993399] ata2: SATA max UDMA/133 cmd 0xFFFFC20000020980 ctl 0x0 bmdma 0x0 irq 317
[   58.001218] ata3: SATA max UDMA/133 cmd 0xFFFFC20000020A00 ctl 0x0 bmdma 0x0 irq 317
[   58.009039] ata4: SATA max UDMA/133 cmd 0xFFFFC20000020A80 ctl 0x0 bmdma 0x0 irq 317
[   58.016821] scsi1 : ahci
[   58.496993] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   58.505547] ata1.00: ATA-6, max UDMA/133, 72303840 sectors: LBA48 
[   58.511761] ata1.00: ata1: dev 0 multi count 16
[   58.519669] ata1.00: configured for UDMA/133
[   58.523979] scsi2 : ahci
[   59.003225] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   60.409124] SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
[   60.417569] sda: Write Protect is off
[   60.422846] SCSI device sda: write cache: enabled, read cache: enabled, supports DPO and FUA
[   60.432095] SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
[   60.440541] sda: Write Protect is off
[   60.445819] SCSI device sda: write cache: enabled, read cache: enabled, supports DPO and FUA
[   60.454299]  sda: sda1 sda2
[   60.465967] sd 0:0:1:0: Attached scsi disk sda
[   60.470481] sd 0:0:1:0: Attached scsi generic sg0 type 0
[   60.476649] SCSI device sdb: 17781520 512-byte hdwr sectors (9104 MB)
[   60.486504] sdb: Write Protect is off
[   60.493972] SCSI device sdb: write cache: enabled, read cache: enabled, supports DPO and FUA
[   60.503270] SCSI device sdb: 17781520 512-byte hdwr sectors (9104 MB)
[   60.513114] sdb: Write Protect is off
[   60.520581] SCSI device sdb: write cache: enabled, read cache: enabled, supports DPO and FUA
[   60.529061]  sdb: sdb1
[   60.538527] sd 0:0:2:0: Attached scsi disk sdb
[   60.543046] sd 0:0:2:0: Attached scsi generic sg1 type 0
[   88.981254] ata2.00: qc timeout (cmd 0xec)
[   88.985383] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   96.857139] ata2: port is slow to respond, please be patient (Status 0x80)
[  119.787627] ata2: port failed to respond (30 secs, Status 0x80)
[  119.793575] ata2: COMRESET failed (device not ready)
[  119.798573] ata2: hardreset failed, retrying in 5 secs
[  125.651632] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  125.657895] ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA 
[  125.663505] ata2.00: ata2: dev 0 multi count 1
[  125.668045] ata2.00: configured for UDMA/133
[  125.672355] scsi3 : ahci
[  126.154411] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  126.161364] ata3.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
[  126.169145] ata3.00: ata3: dev 0 multi count 16
[  126.174517] ata3.00: configured for UDMA/133
[  126.178823] scsi4 : ahci
[  126.496622] ata4: SATA link down (SStatus 0 SControl 300)
[  126.502100] scsi 1:0:0:0: Direct-Access     ATA      WDC WD360GD-00FL 31.0 PQ: 0 ANSI: 5
[  126.510276] SCSI device sdc: 72303840 512-byte hdwr sectors (37020 MB)
[  126.516843] sdc: Write Protect is off
[  126.520551] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  126.529564] SCSI device sdc: 72303840 512-byte hdwr sectors (37020 MB)
[  126.536126] sdc: Write Protect is off
[  126.539833] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  126.548829]  sdc: sdc1 sdc2
[  126.559954] sd 1:0:0:0: Attached scsi disk sdc
[  126.564472] sd 1:0:0:0: Attached scsi generic sg2 type 0
[  126.569857] scsi 2:0:0:0: Direct-Access     ATA      Config  Disk     RGL1 PQ: 0 ANSI: 5
[  126.578029] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[  126.583815] sdd: Write Protect is off
[  126.587522] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  126.596621] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[  126.602403] sdd: Write Protect is off
[  126.606111] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  126.615192]  sdd: unknown partition table
[  126.619456] sd 2:0:0:0: Attached scsi disk sdd
[  126.623968] sd 2:0:0:0: Attached scsi generic sg3 type 0
[  126.629352] scsi 3:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
[  126.637526] SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
[  126.644264] sde: Write Protect is off
[  126.647971] SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  126.656981] SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
[  126.663721] sde: Write Protect is off
[  126.667428] SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  126.676420]  sde: sde1 sde2
[  126.691305] sd 3:0:0:0: Attached scsi disk sde
[  126.695823] sd 3:0:0:0: Attached scsi generic sg4 type 0
[  126.701211] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
[  126.708717] ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
[  126.715731] ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
[  126.722740] scsi5 : ata_piix
[  127.038530] ata5.00: ATAPI, max UDMA/33
[  127.202953] ata5.01: ATAPI, max UDMA/33
[  157.180645] ata5.00: qc timeout (cmd 0xef)
[  157.184782] ata5.00: failed to set xfermode (err_mask=0x4)
[  157.190303] ata5.00: limiting speed to UDMA/25
[  157.194780] ata5: failed to recover some devices, retrying in 5 secs
[  192.654443] ata5.00: qc timeout (cmd 0xef)
[  192.658580] ata5.00: failed to set xfermode (err_mask=0x4)
[  192.664102] ata5.00: limiting speed to PIO0
[  192.668316] ata5: failed to recover some devices, retrying in 5 secs
[  228.117537] ata5.00: qc timeout (cmd 0xef)
[  228.121677] ata5.00: failed to set xfermode (err_mask=0x4)
[  228.127196] ata5.00: disabled
[  228.130198] ata5: failed to recover some devices, retrying in 5 secs
[  233.133399] ata5.01: failed to set xfermode (err_mask=0x40)
[  233.139002] ata5.01: limiting speed to UDMA/25
[  233.143478] ata5: failed to recover some devices, retrying in 5 secs
[  238.625636] ata5.01: configured for UDMA/25
[  238.629853] scsi6 : ata_piix
[  238.797146] ATA: abnormal status 0x7F on port 0x177
[  238.803032] scsi 5:0:1:0: CD-ROM            _NEC     DVD_RW ND-3520AW 3.04 PQ: 0 ANSI: 5
[  238.815043] sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
[  238.821861] Uniform CD-ROM driver Revision: 3.20
[  238.826583] sr 5:0:1:0: Attached scsi generic sg5 type 5
[  238.831966] sil680: BA5_EN = 1 clock = 00
[  238.836017] sil680: BA5_EN = 1 clock = 10
[  238.840071] sil680: 133MHz clock.
[  238.843427] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 21 (level, low) -> IRQ 21
[  238.850924] ata7: PATA max UDMA/133 cmd 0xCC00 ctl 0xC882 bmdma 0xC400 irq 21
[  238.858108] ata8: PATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC408 irq 21
[  238.865286] scsi7 : pata_sil680
[  239.078089] ata7.00: ATA-0, max MWDMA2, 3145968 sectors: LBA 
[  239.083866] ata7.00: ata7: dev 0 multi count 16
[  239.111424] ata7.00: configured for MWDMA2
[  239.115557] scsi8 : pata_sil680
[  239.279207] ata8.00: ATA-5, max UDMA/133, 78198750 sectors: LBA 
[  239.285239] ata8.00: ata8: dev 0 multi count 16
[  239.295841] ata8.00: configured for UDMA/133
[  239.300176] scsi 7:0:0:0: Direct-Access     ATA      SAMSUNG WN316025 GF10 PQ: 0 ANSI: 5
[  239.308353] SCSI device sdf: 3145968 512-byte hdwr sectors (1611 MB)
[  239.314739] sdf: Write Protect is off
[  239.318449] SCSI device sdf: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  239.332799] SCSI device sdf: 3145968 512-byte hdwr sectors (1611 MB)
[  239.339193] sdf: Write Protect is off
[  239.342902] SCSI device sdf: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  239.351984]  sdf: sdf1
[  239.376352] sd 7:0:0:0: Attached scsi disk sdf
[  239.380865] sd 7:0:0:0: Attached scsi generic sg6 type 0
[  239.386253] scsi 8:0:0:0: Direct-Access     ATA      MAXTOR 6L040J2   A93. PQ: 0 ANSI: 5
[  239.394431] SCSI device sdg: 78198750 512-byte hdwr sectors (40038 MB)
[  239.400993] sdg: Write Protect is off
[  239.404703] SCSI device sdg: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  239.413720] SCSI device sdg: 78198750 512-byte hdwr sectors (40038 MB)
[  239.420287] sdg: Write Protect is off
[  239.423993] SCSI device sdg: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  239.432986]  sdg: sdg1
[  239.438582] sd 8:0:0:0: Attached scsi disk sdg
[  239.443098] sd 8:0:0:0: Attached scsi generic sg7 type 0
[  239.448504] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[  239.454720] PNP: PS/2 controller doesn't have AUX irq; using default 12
[  239.463973] serio: i8042 KBD port at 0x60,0x64 irq 1
[  239.468972] serio: i8042 AUX port at 0x60,0x64 irq 12
[  239.474111] mice: PS/2 mouse device common for all mice
[  239.479392] EDAC MC: Ver: 2.0.1 Mar 11 2007
[  239.483701] TCP cubic registered
[  239.486974] Initializing XFRM netlink socket
[  239.491293] NET: Registered protocol family 1
[  239.495689] NET: Registered protocol family 17
[  239.500173] NET: Registered protocol family 15
[  239.511429] input: AT Translated Set 2 keyboard as /class/input/input2
[  239.609857] ReiserFS: sdc1: found reiserfs format "3.6" with standard journal
[  239.617028] ReiserFS: sdc1: using ordered data mode
[  239.630466] ReiserFS: sdc1: journal params: device sdc1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[  239.645334] ReiserFS: sdc1: checking transaction log (sdc1)
[  239.674462] ReiserFS: sdc1: Using r5 hash to sort names
[  239.679751] VFS: Mounted root (reiserfs filesystem) readonly.
[  239.685560] Freeing unused kernel memory: 192k freed
INIT: version 2.86 booting
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...[  240.888839] Floppy drive(s): fd0 is 1.44M
[  240.911119] FDC 0 is a post-1991 82077
[  240.952117] usbcore: registered new interface driver usbfs
[  240.957738] usbcore: registered new interface driver hub
[  240.963177] usbcore: registered new device driver usb
[  241.055761] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 23
[  241.064226] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[  241.070633] 8139cp 0000:01:02.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
[  241.079212] 8139cp 0000:01:02.0: Try the "8139too" driver instead.
[  241.086286] USB Universal Host Controller Interface driver v3.0
[  241.092443] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
[  241.100025] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[  241.105413] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[  241.112965] uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
[  241.118891] usb usb1: configuration #1 chosen from 1 choice
[  241.124612] hub 1-0:1.0: USB hub found
[  241.128453] hub 1-0:1.0: 2 ports detected
[  241.132548] 8139too Fast Ethernet driver 0.9.28
[  241.235899] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
[  241.243452] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[  241.248773] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[  241.256293] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000e800
[  241.262182] usb usb2: configuration #1 chosen from 1 choice
[  241.267855] hub 2-0:1.0: USB hub found
[  241.271675] hub 2-0:1.0: 2 ports detected
[  241.379868] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[  241.387425] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[  241.392752] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[  241.400276] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e880
[  241.406161] usb usb3: configuration #1 chosen from 1 choice
[  241.411847] hub 3-0:1.0: USB hub found
[  241.415668] hub 3-0:1.0: 2 ports detected
[  241.463301] usb 1-1: new low speed USB device using uhci_hcd and address 2
[  241.523746] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
[  241.531313] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[  241.536640] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[  241.544171] uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ec00
[  241.550059] usb usb4: configuration #1 chosen from 1 choice
[  241.555763] hub 4-0:1.0: USB hub found
[  241.559581] hub 4-0:1.0: 2 ports detected
[  241.647412] usb 1-1: configuration #1 chosen from 1 choice
[  241.667931] ACPI: PCI Interrupt 0000:01:02.0[A] -> <6>ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
[  241.679170] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[  241.679172] GSI 23 (level, low) -> IRQ 23
[  241.688559] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[  241.688991] eth0: RealTek RTL8139 at 0xffffc20000174800, 00:e0:4e:03:18:39, IRQ 23
[  241.703808] ehci_hcd 0000:00:1d.7: debug port 1
[  241.708761] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xfebfbc00
[  241.718433] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[  241.726269] usb usb5: configuration #1 chosen from 1 choice
[  241.732033] hub 5-0:1.0: USB hub found
[  241.735955] hub 5-0:1.0: 8 ports detected
[  241.841643] usb 1-1: USB disconnect, address 2
[  241.848392] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
[  242.025765] hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
[  243.253245] usb 5-7: new high speed USB device using ehci_hcd and address 6
[  243.395176] usb 5-7: configuration #1 chosen from 1 choice
[  243.401137] hub 5-7:1.0: USB hub found
[  243.405234] hub 5-7:1.0: 4 ports detected
[  243.514593] usbcore: registered new interface driver hiddev
[  243.742744] usb 1-1: new low speed USB device using uhci_hcd and address 3
[  243.927433] usb 1-1: configuration #1 chosen from 1 choice
[  244.162102] usb 1-2: new low speed USB device using uhci_hcd and address 4
[  244.335058] usb 1-2: configuration #1 chosen from 1 choice
[  244.591575] usb 2-2: new full speed USB device using uhci_hcd and address 2
[  244.766129] usb 2-2: configuration #1 chosen from 1 choice
[  244.795509] Initializing USB Mass Storage driver...
[  245.007644] usb 3-2: new full speed USB device using uhci_hcd and address 2
[  250.203480] usb 3-2: configuration #1 chosen from 1 choice
[  250.399981] usb 5-7.3: new high speed USB device using ehci_hcd and address 7
[  250.500204] usb 5-7.3: configuration #1 chosen from 1 choice
[  250.522674] input: Microsoft Microsoft IntelliMouse® Explorer as /class/input/input3
[  250.530566] input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1d.0-1
[  250.553641] input: USBPS2 as /class/input/input4
[  250.558359] input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:1d.0-2
[  250.586635] input: USBPS2 as /class/input/input5
[  250.591433] input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:1d.0-2
[  250.598120] usbcore: registered new interface driver usbhid
[  250.603781] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[  250.610128] scsi9 : SCSI emulation for USB Mass Storage devices
[  250.616276] usbcore: registered new interface driver usb-storage
[  250.622497] USB Mass Storage support registered.
done.
Setting parameters of disc: (none).
Activating swap:swapon on /dev/sdc2
[  251.098267] Adding 1959920k swap on /dev/sdc2.  Priority:-1 extents:1 across:1959920k
.
Will now check root file system:fsck 1.40-WIP (14-Nov-2006)
[/sbin/fsck.reiserfs (1) -- /] fsck.reiserfs -a /dev/sdc1 
Filesystem seems mounted read-only. Skipping journal replay.
Checking internal tree..finished
Reiserfs super block in block 16 on 0x821 of format 3.6 with standard journal
Blocks (total/free): 8546560/6072885 by 4096 bytes
Filesystem is clean
[  255.717494] scsi 9:0:0:0: Direct-Access     eUSB     Compact Flash         PQ: 0 ANSI: 2
[  255.736464] SCSI device sdh: 1001952 512-byte hdwr sectors (513 MB)
[  255.753449] sdh: test WP failed, assume Write Enabled
[  255.758630] sdh: assuming drive cache: write through
[  255.784422] SCSI device sdh: 1001952 512-byte hdwr sectors (513 MB)
[  255.801406] sdh: test WP failed, assume Write Enabled
[  255.806531] sdh: assuming drive cache: write through
[  255.811640]  sdh: sdh1
[  255.826403] sd 9:0:0:0: Attached scsi removable disk sdh
[  255.831851] sd 9:0:0:0: Attached scsi generic sg8 type 0
Reiserfs super block in block 16 on 0x821 of format 3.6 with standard journal
Blocks (total/free): 8546560/6072885 by 4096 bytes
Filesystem is clean
.
Setting the system clock..
System Clock set. Local time: Sun Mar 11 05:58:22 MDT 2007.
Cleaning up ifupdown....
Loading kernel module nvidia.
FATAL: Module nvidia not found.
Loading kernel module 8139too.
Loading kernel module sky2.
Loading kernel module i2c-i801.
Loading kernel module i2c-isa.
Loading kernel module eeprom.
Loading kernel module w83627ehf.
FATAL: Error inserting w83627ehf (/lib/modules/2.6.20.2/kernel/drivers/hwmon/w83627ehf.ko): No such device
Loading kernel module snd-rtctimer.
Loading kernel module cdc-acm.
FATAL: Module cdc_acm not found.
Loading kernel module uhci-hcd.
Loading kernel module coretemp.
FATAL: Module coretemp not found.
Loading device-mapper support.
Will now check all file systems.
fsck 1.40-WIP (14-Nov-2006)
Checking all file systems.
Done checking file systems. 
A log is being saved in /var/log/fsck/checkfs if that location is writable.
Setting kernel variables...done.
Will now mount local filesystems:[  258.024070] ReiserFS: sde1: found reiserfs format "3.6" with standard journal
[  258.031302] ReiserFS: sde1: using ordered data mode
[  258.043142] ReiserFS: sde1: journal params: device sde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[  258.058099] ReiserFS: sde1: checking transaction log (sde1)
[  258.127206] ReiserFS: sde1: Using r5 hash to sort names
mount: unknown filesystem type 'reiser4'
 failed!
Will now activate swapfile swap:done.
Cleaning /tmp...done.
Cleaning /var/run...done.
Cleaning /var/lock...done.
Setting up networking....
Configuring network interfaces...[  258.463675] eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
Starting portmap daemon....
done.
Starting portmap daemon...Already running..
Setting sensors limits: done.
Setting console screen modes and fonts.
Setting up ALSA...warning: 'alsactl restore' failed with error message 'alsactl: set_control:991: warning: name mismatch (CD Playback Volume/Mic Playback Volume) for control #12
alsactl: set_control:993: warning: index mismatch (0/0) for control #12
alsactl: set_control:995: failed to obtain info for control #12 (Operation not permitted)'...done.
Initializing random number generator...done.
Recovering nvi editor sessions...none found.
Setting up X server socket directory /tmp/.X11-unix....
Setting up ICE socket directory /tmp/.ICE-unix....
Recovering schroot sessions:E: /var/lib/schroot/session: Failed to open file: No such file or directory
.
INIT: Entering runlevel: 2
Starting system log daemon....
Starting kernel log daemon....
Loading ACPI modules....
Starting Advanced Configuration and Power Interface daemon....
Starting Common Unix Printing System: cupsd.
Starting system message bus: dbus.
Starting Hardware abstraction layer: hald.
Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon.
Starting DirMngr: dirmngr.
Starting mouse interface server: gpm.
Starting disk temperature monitoring daemon: hddtemp:[  264.800533] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  264.807082] ata2.00: (irq_stat 0x40000001)
[  264.811262] ata2.00: cmd b0/d8:00:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0 
[  264.811263]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[  264.827003] ata2.00: configured for UDMA/133
[  264.831350] ata2: EH complete
[  264.834397] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[  264.840258] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  264.846799] ata2.00: (irq_stat 0x40000001)
[  264.850986] ata2.00: cmd b0/d0:01:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 512 in
[  264.850987]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[  264.867068] ata2.00: configured for UDMA/133
[  264.871415] ata2: EH complete
[  264.879756] sdd: Write Protect is off
[  264.883508] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  264.892733] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[  264.898589] sdd: Write Protect is off
[  264.902334] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
  /dev/sdc /dev/sde /dev/sdg..
Starting internet superserver: inetd.
Starting Postfix Mail Transport Agent: postfix.
Starting Samba daemons: nmbd smbd.
Starting sensor daemon: sensord.
Starting OpenBSD Secure Shell server: sshd.
Setting up X font server socket directory /tmp/.font-unix...done.
Starting X font server: xfs.
Starting NFS common utilities: statd.
Starting NTP server: ntpd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: crond.
Starting K Display Manager: kdm.
Running local boot scripts (/etc/rc.local).

Debian GNU/Linux 4.0 luna ttyS0

luna login: 
--------------090901070301040405040809--
