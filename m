From: Wolfgang Karall <lists+linux-ide@karall-edv.at>
Subject: [lists+linux-ide@karall-edv.at: Possible regression when going
	from 2.6.26 to 2.6.32]
Date: Fri, 29 Oct 2010 10:28:25 +0200
Message-ID: <20101029082825.GA6620@lenny.spiney.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lenny.fqdn.at ([188.40.128.251]:56590 "EHLO lenny.spiney.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab0J2IeZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Oct 2010 04:34:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: saeed.bishara@gmail.com, mlord@pobox.com, tbm@cyrius.com


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

And as per usual I forgot attaching the files, so here they are. :)

Cheers
Wolfgang

----- Forwarded message from Wolfgang Karall <lists+linux-ide@karall-edv.at> -----

Date: Fri, 29 Oct 2010 10:26:12 +0200
From: Wolfgang Karall <lists+linux-ide@karall-edv.at>
To: linux-ide@vger.kernel.org
Cc: saeed.bishara@gmail.com, mlord@pobox.com, tbm@cyrius.com
Subject: Possible regression when going from 2.6.26 to 2.6.32

Hello,

when upgrading my QNAP TS-409 device (Marvell Orion based) from kernel
version 2.6.26 (current Debian 5.0/lenny) to 2.6.32 (Martin Michlmayr's
repository at http://people.debian.org/~tbm/orion who's also pointed me
to this list and recipients) only 2 out of the 4 HDD drives connected get
recognized.

Attached are dmesg outputs from both a successful boot with 2.6.26
showing all 4 drives and a failed boot with 2.6.32 showing only 2
drives.

If you need any more information, please let me know.

Best regards
Wolfgang Karall

PS: no need to CC me, I'm subscribed to the list.

----- End forwarded message -----

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6.26-2-orion5x"

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-2-orion5x (Debian 2.6.26-25lenny1) (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Fri Sep 17 00:22:00 UTC 2010
[    0.000000] CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=00053177
[    0.000000] Machine: QNAP TS-409
[    0.000000] Clearing invalid memory bank 0KB@0x00000000
[    0.000000] Clearing invalid memory bank 0KB@0x00000000
[    0.000000] Clearing invalid memory bank 0KB@0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x41000403
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65536
[    0.000000]   DMA zone: 512 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 65024 pages, LIFO batch:15
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] CPU0: D VIVT write-back cache
[    0.000000] CPU0: I cache: 32768 bytes, associativity 1, 32 byte lines, 1024 sets
[    0.000000] CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/ram rw initrd=0x800000,0x3fffff
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[42949372.960000] Console: colour dummy device 80x30
[42949372.960000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[42949372.960000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[42949372.980000] Memory: 256MB = 256MB total
[42949372.980000] Memory: 252672KB available (2564K code, 358K data, 116K init)
[42949372.980000] Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)
[42949373.230000] Security Framework initialized
[42949373.230000] SELinux:  Disabled at boot.
[42949373.230000] Capability LSM initialized
[42949373.230000] Mount-cache hash table entries: 512
[42949373.230000] Initializing cgroup subsys ns
[42949373.230000] Initializing cgroup subsys cpuacct
[42949373.230000] Initializing cgroup subsys devices
[42949373.230000] CPU: Testing write buffer coherency: ok
[42949373.230000] net_namespace: 652 bytes
[42949373.230000] NET: Registered protocol family 16
[42949373.230000] Orion ID: MV88F5281-D0. TCLK=166666667.
[42949373.230000] Orion: Applying 5281 D0 WFI workaround.
[42949373.260000] PCI: bus0: Fast back to back transfers disabled
[42949373.260000] PCI: bus1: Fast back to back transfers enabled
[42949373.270000] qnap_ts409_pci_map_irq failed, unknown bus
[42949373.300000] NET: Registered protocol family 2
[42949373.310000] Switched to high resolution mode on CPU 0
[42949373.390000] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[42949373.390000] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[42949373.390000] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[42949373.390000] TCP: Hash tables configured (established 8192 bind 8192)
[42949373.390000] TCP reno registered
[42949373.420000] NET: Registered protocol family 1
[42949373.420000] checking if image is initramfs... it is
[42949375.190000] Freeing initrd memory: 4095K
[42949375.190000] NetWinder Floating Point Emulator V0.97 (double precision)
[42949375.190000] audit: initializing netlink socket (disabled)
[42949375.190000] type=2000 audit(2.230:1): initialized
[42949375.190000] VFS: Disk quotas dquot_6.5.1
[42949375.190000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[42949375.190000] msgmni has been set to 501
[42949375.190000] async_tx: api initialized (async)
[42949375.190000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[42949375.190000] io scheduler noop registered
[42949375.190000] io scheduler anticipatory registered
[42949375.190000] io scheduler deadline registered
[42949375.190000] io scheduler cfq registered (default)
[42949375.210000] Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
[42949375.210000] serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 3) is a 16550A
[42949375.210000] console [ttyS0] enabled
[42949375.560000] serial8250.0: ttyS1 at MMIO 0xf1012100 (irq = 4) is a 16550A
[42949375.580000] brd: module loaded
[42949375.580000] NFTL driver: nftlcore.c $Revision: 1.98 $, nftlmount.c $Revision: 1.41 $
[42949375.590000] physmap platform flash device: 00800000 at ff800000
[42949375.590000] physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank
[42949375.600000]  Intel/Sharp Extended Query Table at 0x0031
[42949375.610000] Using buffer write method
[42949375.610000] cfi_cmdset_0001: Erase suspend on write enabled
[42949375.620000] erase region 0: offset=0x0,size=0x20000,blocks=64
[42949375.660000] RedBoot partition parsing not available
[42949375.660000] Using physmap partition information
[42949375.670000] Creating 6 MTD partitions on "physmap-flash.0":
[42949375.670000] 0x00780000-0x00800000 : "U-Boot"
[42949375.680000] ftl_cs: FTL header not found.
[42949375.680000] 0x00000000-0x00200000 : "Kernel"
[42949375.690000] ftl_cs: FTL header not found.
[42949375.690000] 0x00200000-0x00600000 : "RootFS1"
[42949375.700000] ftl_cs: FTL header not found.
[42949375.700000] 0x00600000-0x00700000 : "RootFS2"
[42949375.710000] ftl_cs: FTL header not found.
[42949375.710000] 0x00760000-0x00780000 : "U-Boot Config"
[42949375.720000] ftl_cs: FTL header not found.
[42949375.720000] 0x00700000-0x00760000 : "NAS Config"
[42949375.730000] ftl_cs: FTL header not found.
[42949375.740000] mice: PS/2 mouse device common for all mice
[42949375.740000] i2c /dev entries driver
[42949375.750000] rtc-s35390a 0-0030: rtc core: registered rtc-s35390a as rtc0
[42949375.760000] Registered led device: ts409:red:sata1
[42949375.770000] Registered led device: ts409:red:sata2
[42949375.770000] Registered led device: ts409:red:sata3
[42949375.780000] Registered led device: ts409:red:sata4
[42949375.790000] TCP cubic registered
[42949375.790000] NET: Registered protocol family 17
[42949375.790000] VFP support v0.3: implementor 41 architecture 1 part 10 variant 9 rev 0
[42949375.800000] registered taskstats version 1
[42949375.810000] rtc-s35390a 0-0030: setting system clock to 2010-10-26 18:35:20 UTC (1288118120)
[42949375.820000] Freeing init memory: 116K
[42949376.210000] SCSI subsystem initialized
[42949376.310000] libata version 3.00 loaded.
[42949376.330000] sata_mv 0000:00:01.0: version 1.24
[42949376.330000] sata_mv 0000:00:01.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
[42949376.340000] scsi0 : sata_mv
[42949376.350000] scsi1 : sata_mv
[42949376.350000] scsi2 : sata_mv
[42949376.360000] scsi3 : sata_mv
[42949376.360000] ata1: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0022000 irq 11
[42949376.370000] ata2: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0024000 irq 11
[42949376.370000] ata3: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0026000 irq 11
[42949376.380000] ata4: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0028000 irq 11
[42949379.840000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[42949379.860000] ata1.00: HPA detected: current 2930277168, native 18446744072344861488
[42949379.860000] ata1.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[42949379.870000] ata1.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[42949379.900000] ata1.00: configured for UDMA/133
[42949380.590000] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[42949380.610000] ata2.00: HPA detected: current 2930277168, native 18446744072344861488
[42949380.610000] ata2.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[42949380.620000] ata2.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[42949380.670000] ata2.00: configured for UDMA/133
[42949383.040000] ata2: exception Emask 0x10 SAct 0x0 SErr 0x180000 action 0x6 frozen
[42949383.050000] ata2: edma_err_cause=00000020 pp_flags=00000000, SError=00180000
[42949383.060000] ata2: SError: { 10B8B Dispar }
[42949383.060000] ata2: hard resetting link
[42949383.070000] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002 action 0xe frozen
[42949383.070000] ata1: edma_err_cause=00000028 pp_flags=00000000, dev disconnect, SError=00190002
[42949383.080000] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[42949383.090000] ata1: hard resetting link
[42949383.100000] ata3: SATA link down (SStatus 0 SControl 300)
[42949383.100000] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
[42949383.110000] ata3: failed to recover some devices, retrying in 5 secs
[42949383.420000] ata2: SATA link down (SStatus 0 SControl 300)
[42949383.420000] ata2: failed to recover some devices, retrying in 5 secs
[42949388.440000] ata2: hard resetting link
[42949389.050000] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[42949389.070000] ata3.00: HPA detected: current 2930277168, native 18446744072344861488
[42949389.070000] ata3.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[42949389.080000] ata3.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[42949389.090000] ata3.00: Drive reports diagnostics failure. This may indicate a drive
[42949389.090000] ata3.00: fault or invalid emulation. Contact drive vendor for information.
[42949389.120000] ata3.00: configured for UDMA/133
[42949389.120000] ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x1 t4
[42949389.130000] ata3: edma_err_cause=00000020 pp_flags=00000000, SError=00190002
[42949389.190000] ata3.00: configured for UDMA/133
[42949389.190000] ata3: EH complete
[42949389.580000] ata1: link is slow to respond, please be patient (ready=0)
[42949389.700000] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[42949389.740000] ata2.00: configured for UDMA/133
[42949389.740000] ata2: limiting SATA link speed to 1.5 Gbps
[42949389.750000] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[42949389.750000] ata2: edma_err_cause=00000010 pp_flags=00000000, dev connect
[42949389.760000] ata2: hard resetting link
[42949390.180000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[42949390.220000] ata1.00: configured for UDMA/133
[42949390.220000] ata1: EH complete
[42949390.850000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[42949390.890000] ata2.00: configured for UDMA/133
[42949390.890000] ata2: EH complete
[42949394.740000] ata4: link is slow to respond, please be patient (ready=0)
[42949396.960000] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[42949396.980000] ata4.00: HPA detected: current 2930277168, native 18446744072344861488
[42949396.980000] ata4.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[42949396.990000] ata4.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[42949397.020000] ata4.00: configured for UDMA/133
[42949397.020000] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[42949397.030000] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[42949397.040000] scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[42949397.050000] scsi 3:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[42949398.170000] Driver 'sd' needs updating - please use bus_type methods
[42949398.210000] sd 0:0:0:0: [sda] 2930277168 512-byte hardware sectors (1500302 MB)
[42949398.210000] sd 0:0:0:0: [sda] Write Protect is off
[42949398.220000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[42949398.220000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[42949398.240000] sd 0:0:0:0: [sda] 2930277168 512-byte hardware sectors (1500302 MB)
[42949398.250000] sd 0:0:0:0: [sda] Write Protect is off
[42949398.250000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[42949398.250000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[42949398.260000]  sda: sda1 sda2 sda3 sda4
[42949398.400000] sd 0:0:0:0: [sda] Attached SCSI disk
[42949398.410000] sd 1:0:0:0: [sdb] 2930277168 512-byte hardware sectors (1500302 MB)
[42949398.410000] sd 1:0:0:0: [sdb] Write Protect is off
[42949398.420000] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[42949398.420000] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[42949398.430000] sd 1:0:0:0: [sdb] 2930277168 512-byte hardware sectors (1500302 MB)
[42949398.440000] sd 1:0:0:0: [sdb] Write Protect is off
[42949398.450000] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[42949398.460000] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[42949398.470000]  sdb: sdb1 sdb2 sdb3 sdb4
[42949398.670000] sd 1:0:0:0: [sdb] Attached SCSI disk
[42949398.680000] sd 2:0:0:0: [sdc] 2930277168 512-byte hardware sectors (1500302 MB)
[42949398.690000] sd 2:0:0:0: [sdc] Write Protect is off
[42949398.690000] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[42949398.690000] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[42949398.700000] sd 2:0:0:0: [sdc] 2930277168 512-byte hardware sectors (1500302 MB)
[42949398.710000] sd 2:0:0:0: [sdc] Write Protect is off
[42949398.720000] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[42949398.730000] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[42949398.740000]  sdc: sdc1 sdc2 sdc3 sdc4
[42949398.870000] sd 2:0:0:0: [sdc] Attached SCSI disk
[42949398.880000] sd 3:0:0:0: [sdd] 2930277168 512-byte hardware sectors (1500302 MB)
[42949398.890000] sd 3:0:0:0: [sdd] Write Protect is off
[42949398.890000] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[42949398.890000] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[42949398.900000] sd 3:0:0:0: [sdd] 2930277168 512-byte hardware sectors (1500302 MB)
[42949398.910000] sd 3:0:0:0: [sdd] Write Protect is off
[42949398.920000] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[42949398.940000] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[42949398.940000]  sdd: sdd1 sdd2 sdd3 sdd4
[42949399.030000] sd 3:0:0:0: [sdd] Attached SCSI disk
[42949401.730000] md: raid1 personality registered for level 1
[42949401.770000] xor: measuring software checksum speed
[42949401.820000]    arm4regs  :   428.800 MB/sec
[42949401.870000]    8regs     :   368.800 MB/sec
[42949401.920000]    32regs    :   297.200 MB/sec
[42949401.920000] xor: using function: arm4regs (428.800 MB/sec)
[42949402.130000] raid6: int32x1     23 MB/s
[42949402.300000] raid6: int32x2     39 MB/s
[42949402.470000] raid6: int32x4     47 MB/s
[42949402.640000] raid6: int32x8     47 MB/s
[42949402.640000] raid6: using algorithm int32x4 (47 MB/s)
[42949402.650000] md: raid6 personality registered for level 6
[42949402.650000] md: raid5 personality registered for level 5
[42949402.660000] md: raid4 personality registered for level 4
[42949402.760000] md: md0 stopped.
[42949402.830000] md: bind<sdb1>
[42949402.830000] md: bind<sda1>
[42949402.850000] raid1: raid set md0 active with 2 out of 2 mirrors
[42949402.930000] md: md1 stopped.
[42949402.990000] md: bind<sdd1>
[42949402.990000] md: bind<sdc1>
[42949403.020000] raid1: raid set md1 active with 2 out of 2 mirrors
[42949403.060000] md: md2 stopped.
[42949403.150000] md: bind<sdb2>
[42949403.150000] md: bind<sdc2>
[42949403.160000] md: bind<sdd2>
[42949403.160000] md: bind<sda2>
[42949403.190000] raid5: device sda2 operational as raid disk 0
[42949403.190000] raid5: device sdd2 operational as raid disk 3
[42949403.200000] raid5: device sdc2 operational as raid disk 2
[42949403.200000] raid5: device sdb2 operational as raid disk 1
[42949403.210000] raid5: allocated 4218kB for md2
[42949403.220000] raid5: raid level 5 set md2 active with 4 out of 4 devices, algorithm 2
[42949403.220000] RAID5 conf printout:
[42949403.230000]  --- rd:4 wd:4
[42949403.230000]  disk 0, o:1, dev:sda2
[42949403.240000]  disk 1, o:1, dev:sdb2
[42949403.240000]  disk 2, o:1, dev:sdc2
[42949403.240000]  disk 3, o:1, dev:sdd2
[42949403.320000] md: md3 stopped.
[42949403.370000] md: bind<sdb3>
[42949403.370000] md: bind<sdc3>
[42949403.370000] md: bind<sdd3>
[42949403.380000] md: bind<sda3>
[42949403.400000] raid5: device sda3 operational as raid disk 0
[42949403.410000] raid5: device sdd3 operational as raid disk 3
[42949403.420000] raid5: device sdc3 operational as raid disk 2
[42949403.420000] raid5: device sdb3 operational as raid disk 1
[42949403.430000] raid5: allocated 4218kB for md3
[42949403.430000] raid5: raid level 5 set md3 active with 4 out of 4 devices, algorithm 2
[42949403.440000] RAID5 conf printout:
[42949403.450000]  --- rd:4 wd:4
[42949403.450000]  disk 0, o:1, dev:sda3
[42949403.450000]  disk 1, o:1, dev:sdb3
[42949403.460000]  disk 2, o:1, dev:sdc3
[42949403.460000]  disk 3, o:1, dev:sdd3
[42949403.720000] device-mapper: uevent: version 1.0.3
[42949403.730000] device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
[42949404.040000] kjournald starting.  Commit interval 5 seconds
[42949404.090000] EXT3 FS on md0, internal journal
[42949404.090000] EXT3-fs: mounted filesystem with ordered data mode.
[42949407.420000] NET: Registered protocol family 10
[42949407.430000] lo: Disabled Privacy Extensions
[42949407.890000] udevd version 125 started
[42949416.300000] usbcore: registered new interface driver usbfs
[42949416.300000] usbcore: registered new interface driver hub
[42949416.420000] input: gpio-keys as /class/input/input0
[42949416.460000] MV-643xx 10/100/1000 Ethernet Driver
[42949416.470000] eth0: port 0 with MAC address 00:00:00:00:51:81
[42949416.480000] eth0: Scatter Gather Enabled
[42949416.480000] eth0: TX TCP/IP Checksumming Supported
[42949416.490000] eth0: RX TCP/UDP Checksum Offload ON 
[42949416.490000] eth0: RX NAPI Enabled 
[42949416.510000] usbcore: registered new device driver usb
[42949416.570000] orion-ehci orion-ehci.0: Marvell Orion EHCI
[42949416.570000] orion-ehci orion-ehci.0: new USB bus registered, assigned bus number 1
[42949416.630000] orion-ehci orion-ehci.0: irq 17, io mem 0xf1050000
[42949416.650000] orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[42949416.650000] usb usb1: configuration #1 chosen from 1 choice
[42949416.660000] hub 1-0:1.0: USB hub found
[42949416.660000] hub 1-0:1.0: 1 port detected
[42949416.780000] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[42949416.780000] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[42949416.790000] usb usb1: Product: Marvell Orion EHCI
[42949416.800000] usb usb1: Manufacturer: Linux 2.6.26-2-orion5x ehci_hcd
[42949416.800000] usb usb1: SerialNumber: orion-ehci.0
[42949417.100000] usb 1-1: new high speed USB device using orion-ehci and address 2
[42949417.250000] usb 1-1: configuration #1 chosen from 1 choice
[42949417.270000] hub 1-1:1.0: USB hub found
[42949417.270000] hub 1-1:1.0: 4 ports detected
[42949417.400000] usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
[42949417.400000] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[42949417.410000] usb 1-1: Product: USB2.0 Hub
[42949419.670000] Adding 1951736k swap on /dev/md1.  Priority:-1 extents:1 across:1951736k
[42949421.370000] loop: module loaded
[42949433.800000] kjournald starting.  Commit interval 5 seconds
[42949433.870000] EXT3 FS on dm-1, internal journal
[42949433.870000] EXT3-fs: mounted filesystem with ordered data mode.
[42949433.900000] kjournald starting.  Commit interval 5 seconds
[42949433.940000] EXT3 FS on dm-0, internal journal
[42949433.940000] EXT3-fs: mounted filesystem with ordered data mode.
[42949512.560000] RPC: Registered udp transport module.
[42949512.570000] RPC: Registered tcp transport module.
[42949513.180000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[42949541.800000] IPv6 over IPv4 tunneling driver
[42949541.810000] sit0: Disabled Privacy Extensions
[42949542.100000] tun: Universal TUN/TAP device driver, 1.6
[42949542.110000] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[42949550.050000] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[42949550.070000] NFSD: starting 90-second grace period
[42949559.060000] warning: `ntpd' uses 32-bit capabilities (legacy support in use)

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6.32-5-orion5x"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.32-5-orion5x (Debian 2.6.32-13) (maks@debian.org) (gcc version 4.3.4 (Debian 4.3.4-10) ) #1 Sat May 22 02:17:44 UTC 2010
[    0.000000] CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: QNAP TS-409
[    0.000000] Clearing invalid memory bank 0KB@0x00000000
[    0.000000] Clearing invalid memory bank 0KB@0x00000000
[    0.000000] Clearing invalid memory bank 0KB@0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x41000403
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c038d010, node_mem_map c03f7000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65024 pages, LIFO batch:15
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/ram rw initrd=0x800000,0x3fffff
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 256MB = 256MB total
[    0.000000] Memory: 251520KB available (3244K code, 568K data, 120K init, 0K highmem)
[    0.000000] SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:64
[    0.000000] Console: colour dummy device 80x30
[    0.000194] Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)
[    0.250134] Security Framework initialized
[    0.250169] SELinux:  Disabled at boot.
[    0.250214] Mount-cache hash table entries: 512
[    0.250850] Initializing cgroup subsys ns
[    0.250876] Initializing cgroup subsys cpuacct
[    0.250896] Initializing cgroup subsys devices
[    0.250916] Initializing cgroup subsys freezer
[    0.250935] Initializing cgroup subsys net_cls
[    0.251020] CPU: Testing write buffer coherency: ok
[    0.252891] devtmpfs: initialized
[    0.255332] regulator: core version 0.5
[    0.255716] NET: Registered protocol family 16
[    0.256560] Orion ID: MV88F5281-D0. TCLK=166666667.
[    0.256590] Orion: Applying 5281 D0 WFI workaround.
[    0.305041] pci 0000:00:00.0: reg 10 64bit mmio pref: [0xf1000000-0xf10fffff]
[    0.305076] pci 0000:00:00.0: reg 18 32bit mmio: [0x000000-0x1fffffff]
[    0.305210] pci 0000:00:01.0: reg 10 64bit mmio: [0x40000000-0x400fffff]
[    0.305244] pci 0000:00:01.0: reg 18 io port: [0xf0000000-0xf00000ff]
[    0.305381] PCI: bus0: Fast back to back transfers disabled
[    0.305966] pci 0000:01:00.0: reg 10 64bit mmio pref: [0x000000-0xfffffff]
[    0.306003] pci 0000:01:00.0: reg 18 64bit mmio pref: [0x10000000-0x1fffffff]
[    0.306039] pci 0000:01:00.0: reg 20 64bit mmio: [0xf1000000-0xf10fffff]
[    0.306071] pci 0000:01:00.0: reg 30 32bit mmio pref: [0xe0000000-0xe7ffffff]
[    0.306124] pci 0000:01:00.0: supports D1 D2
[    0.306145] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
[    0.306169] pci 0000:01:00.0: PME# disabled
[    0.306267] PCI: bus1: Fast back to back transfers enabled
[    0.309444] bio: create slab <bio-0> at 0
[    0.310150] vgaarb: loaded
[    0.311250] Switching to clocksource orion_clocksource
[    0.320212] NET: Registered protocol family 2
[    0.320643] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.322100] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.322512] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.322723] TCP: Hash tables configured (established 8192 bind 8192)
[    0.322745] TCP reno registered
[    0.323156] NET: Registered protocol family 1
[    0.323567] Unpacking initramfs...
[    0.929851] Freeing initrd memory: 4092K
[    0.929997] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.930557] audit: initializing netlink socket (disabled)
[    0.930624] type=2000 audit(0.920:1): initialized
[    0.944318] VFS: Disk quotas dquot_6.5.2
[    0.944850] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.945089] msgmni has been set to 499
[    0.946506] alg: No test for stdrng (krng)
[    0.946785] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.946813] io scheduler noop registered
[    0.946831] io scheduler anticipatory registered
[    0.946850] io scheduler deadline registered
[    0.947330] io scheduler cfq registered (default)
[    0.959774] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.960731] serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 3) is a 16550A
[    1.321081] console [ttyS0] enabled
[    1.325150] serial8250.1: ttyS1 at MMIO 0xf1012100 (irq = 4) is a 16550A
[    1.332722] physmap platform flash device: 00800000 at ff800000
[    1.338862] physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank
[    1.345383]  Intel/Sharp Extended Query Table at 0x0031
[    1.350608]  Intel/Sharp Extended Query Table at 0x0031
[    1.355866] Using buffer write method
[    1.359519] cfi_cmdset_0001: Erase suspend on write enabled
[    1.365109] erase region 0: offset=0x0,size=0x20000,blocks=64
[    1.411940] RedBoot partition parsing not available
[    1.416810] Using physmap partition information
[    1.421384] Creating 6 MTD partitions on "physmap-flash.0":
[    1.426957] 0x000000780000-0x000000800000 : "U-Boot"
[    1.433122] 0x000000000000-0x000000200000 : "Kernel"
[    1.439081] 0x000000200000-0x000000600000 : "RootFS1"
[    1.445193] 0x000000600000-0x000000700000 : "RootFS2"
[    1.451263] 0x000000760000-0x000000780000 : "U-Boot Config"
[    1.457896] 0x000000700000-0x000000760000 : "NAS Config"
[    1.465017] mice: PS/2 mouse device common for all mice
[    1.471028] i2c /dev entries driver
[    1.477591] rtc-s35390a 0-0030: rtc core: registered rtc-s35390a as rtc0
[    1.484850] Registered led device: ts409:red:sata1
[    1.489745] Registered led device: ts409:red:sata2
[    1.494690] Registered led device: ts409:red:sata3
[    1.499608] Registered led device: ts409:red:sata4
[    1.506515] TCP cubic registered
[    1.509746] NET: Registered protocol family 17
[    1.514247] VFP support v0.3: implementor 41 architecture 1 part 10 variant 9 rev 0
[    1.522560] registered taskstats version 1
[    1.527722] rtc-s35390a 0-0030: setting system clock to 2010-10-26 14:25:33 UTC (1288103133)
[    1.536187] Initalizing network drop monitor service
[    1.541325] Freeing init memory: 120K
[    2.039345] SCSI subsystem initialized
[    2.235184] libata version 3.00 loaded.
[    2.277488] sata_mv 0000:00:01.0: version 1.28
[    2.282736] sata_mv 0000:00:01.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
[    2.293658] scsi0 : sata_mv
[    2.297090] scsi1 : sata_mv
[    2.300335] scsi2 : sata_mv
[    2.303628] scsi3 : sata_mv
[    2.306710] ata1: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0022000 irq 11
[    2.314402] ata2: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0024000 irq 11
[    2.322077] ata3: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0026000 irq 11
[    2.329720] ata4: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0028000 irq 11
[    6.441362] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.461873] ata1.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[    6.467874] ata1.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    6.491959] ata1.00: configured for UDMA/133
[    6.496826] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[    7.191362] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.211871] ata2.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[    7.217869] ata2.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    7.241963] ata2.00: configured for UDMA/133
[    7.246800] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[    8.544082] ata2: exception Emask 0x10 SAct 0x0 SErr 0x180000 action 0x6 frozen
[    8.551456] ata2: edma_err_cause=00000020 pp_flags=00000000, SError=00180000
[    8.558499] ata2: SError: { 10B8B Dispar }
[    8.562639] ata2: hard resetting link
[    8.566773] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002 action 0xe frozen
[    8.574100] ata1: edma_err_cause=00000028 pp_flags=00000000, dev disconnect, SError=00190002
[    8.582554] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[    8.588399] ata1: hard resetting link
[    8.601384] ata3: SATA link down (SStatus 0 SControl 300)
[    8.606781] ata3.00: link offline, clearing class 1 to NONE
[    8.921344] ata2: SATA link down (SStatus 0 SControl 300)
[    8.951339] ata4: SATA link down (SStatus 0 SControl 300)
[    9.237146] ata2: hard resetting link
[    9.241453] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
[    9.248836] ata4: edma_err_cause=00000010 pp_flags=00000000, dev connect
[    9.255580] ata4: SError: { PHYRdyChg DevExch }
[    9.260138] ata4: hard resetting link
[   10.091435] ata4: SATA link down (SStatus 0 SControl 300)
[   10.096855] ata4: EH complete
[   14.811327] ata2: link is slow to respond, please be patient (ready=0)
[   14.981322] ata1: link is slow to respond, please be patient (ready=0)
[   16.371362] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   16.411974] ata2.00: configured for UDMA/133
[   16.416256] ata2: EH complete
[   16.419511] sd 1:0:0:0: [sdb] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   16.427983] sd 1:0:0:0: [sdb] Write Protect is off
[   16.432825] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   16.433142] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   16.443700]  sdb:
[   16.541363] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   16.581963] ata1.00: configured for UDMA/133
[   16.586239] ata1: EH complete
[   16.589495] sd 0:0:0:0: [sda] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   16.597913] sd 0:0:0:0: [sda] Write Protect is off
[   16.602757] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   16.603115] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   16.613676]  sda: sdb1 sdb2 sdb3 sdb4
[   16.793972] sd 1:0:0:0: [sdb] Attached SCSI disk
[   16.943771]  sda1 sda2 sda3 sda4
[   16.958107] sd 0:0:0:0: [sda] Attached SCSI disk
[   19.230940] md: raid1 personality registered for level 1
[   19.275556] async_tx: api initialized (async)
[   19.302614] xor: measuring software checksum speed
[   19.351309]    arm4regs  :   429.200 MB/sec
[   19.401309]    8regs     :   377.200 MB/sec
[   19.451303]    32regs    :   416.800 MB/sec
[   19.455484] xor: using function: arm4regs (429.200 MB/sec)
[   19.653645] raid6: int32x1     24 MB/s
[   19.821573] raid6: int32x2     35 MB/s
[   19.992371] raid6: int32x4     47 MB/s
[   20.161986] raid6: int32x8     42 MB/s
[   20.165734] raid6: using algorithm int32x4 (47 MB/s)
[   20.253668] md: raid6 personality registered for level 6
[   20.258977] md: raid5 personality registered for level 5
[   20.264354] md: raid4 personality registered for level 4
[   20.351513] md: md0 stopped.
[   20.407892] md: bind<sdb1>
[   20.411095] md: bind<sda1>
[   20.438813] raid1: raid set md0 active with 2 out of 2 mirrors
[   20.444915] md0: detected capacity change from 0 to 1998585856
[   20.461588] md: md1 stopped.
[   20.481194]  md0: unknown partition table
[   20.711706] md: md2 stopped.
[   20.773993] md: bind<sdb2>
[   20.777195] md: bind<sda2>
[   20.809526] raid5: device sda2 operational as raid disk 0
[   20.814982] raid5: device sdb2 operational as raid disk 1
[   20.825649] raid5: allocated 4228kB for md2
[   20.833774] 0: w=1 pa=0 pr=4 m=1 a=2 r=4 op1=0 op2=0
[   20.838736] 1: w=2 pa=0 pr=4 m=1 a=2 r=4 op1=0 op2=0
[   20.843756] raid5: not enough operational devices for md2 (2/4 failed)
[   20.850333] RAID5 conf printout:
[   20.853601]  --- rd:4 wd:2
[   20.856308]  disk 0, o:1, dev:sda2
[   20.859700]  disk 1, o:1, dev:sdb2
[   20.866978] raid5: failed to run raid set md2
[   20.871411] md: pers->run() failed ...
[   20.884033] md: md3 stopped.
[   20.930777] md: bind<sdb3>
[   20.934091] md: bind<sda3>
[   20.966351] raid5: device sda3 operational as raid disk 0
[   20.971814] raid5: device sdb3 operational as raid disk 1
[   20.986142] raid5: allocated 4228kB for md3
[   20.990515] 0: w=1 pa=0 pr=4 m=1 a=2 r=4 op1=0 op2=0
[   20.995539] 1: w=2 pa=0 pr=4 m=1 a=2 r=4 op1=0 op2=0
[   21.000499] raid5: not enough operational devices for md3 (2/4 failed)
[   21.007095] RAID5 conf printout:
[   21.010319]  --- rd:4 wd:2
[   21.013088]  disk 0, o:1, dev:sda3
[   21.016492]  disk 1, o:1, dev:sdb3
[   21.023794] raid5: failed to run raid set md3
[   21.028151] md: pers->run() failed ...
[   21.329872] device-mapper: uevent: version 1.0.3
[   21.342860] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[   22.119235] kjournald starting.  Commit interval 5 seconds
[   22.501849] EXT3 FS on md0, internal journal
[   22.506137] EXT3-fs: mounted filesystem with ordered data mode.
[   31.225234] NET: Registered protocol family 10
[   31.232599] lo: Disabled Privacy Extensions
[   31.702111] udevd version 125 started
[   40.805212] usbcore: registered new interface driver usbfs
[   40.828850] usbcore: registered new interface driver hub
[   40.919071] usbcore: registered new device driver usb
[   41.002567] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[   41.066687] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   41.112644] orion-ehci orion-ehci.0: Marvell Orion EHCI
[   41.117966] orion-ehci orion-ehci.0: new USB bus registered, assigned bus number 1
[   41.151827] orion-ehci orion-ehci.0: irq 17, io mem 0xf1050000
[   41.171438] orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00
[   41.177453] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   41.184295] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   41.191531] usb usb1: Product: Marvell Orion EHCI
[   41.196231] usb usb1: Manufacturer: Linux 2.6.32-5-orion5x ehci_hcd
[   41.202511] usb usb1: SerialNumber: orion-ehci.0
[   41.243034] usb usb1: configuration #1 chosen from 1 choice
[   41.261418] hub 1-0:1.0: USB hub found
[   41.265446] hub 1-0:1.0: 1 port detected
[   41.269774] MV-643xx 10/100/1000 ethernet driver version 1.4
[   41.292853] mv643xx_eth smi: probed
[   41.581397] usb 1-1: new high speed USB device using orion-ehci and address 2
[   41.763212] usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
[   41.769925] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   41.777087] usb 1-1: Product: USB2.0 Hub
[   41.854312] usb 1-1: configuration #1 chosen from 1 choice
[   41.892748] hub 1-1:1.0: USB hub found
[   41.921364] hub 1-1:1.0: 4 ports detected
[   43.712855] net eth0: port 0 with MAC address 00:00:00:00:51:81
[   47.100089] loop: module loaded
[   47.928059] md: md1 stopped.
[ 3077.314921] SysRq : HELP : loglevel(0-9) reBoot Crash terminate-all-tasks(E) memory-full-oom-kill(F) kill-all-tasks(I) thaw-filesystems(J) saK show-memory-usage(M) nice-all-RT-tasks(N) powerOff show-registers(P) show-all-timers(Q) unRaw Sync show-task-states(T) Unmount show-blocked-tasks(W) dump-ftrace-buffer(Z) 
[ 3081.814052] SysRq : HELP : loglevel(0-9) reBoot Crash terminate-all-tasks(E) memory-full-oom-kill(F) kill-all-tasks(I) thaw-filesystems(J) saK show-memory-usage(M) nice-all-RT-tasks(N) powerOff show-registers(P) show-all-timers(Q) unRaw Sync show-task-states(T) Unmount show-blocked-tasks(W) dump-ftrace-buffer(Z) 
[ 3085.815435] SysRq : HELP : loglevel(0-9) reBoot Crash terminate-all-tasks(E) memory-full-oom-kill(F) kill-all-tasks(I) thaw-filesystems(J) saK show-memory-usage(M) nice-all-RT-tasks(N) powerOff show-registers(P) show-all-timers(Q) unRaw Sync show-task-states(T) Unmount show-blocked-tasks(W) dump-ftrace-buffer(Z) 
[ 3427.531899] EXT3 FS on md0, internal journal

--oyUTqETQ0mS9luUI--
