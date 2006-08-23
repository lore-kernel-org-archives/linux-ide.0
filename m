From: "Fajun Chen" <fajunchen@gmail.com>
Subject: PATA Sil680 Warm Plug Caused 2.6.18-rc2 Kernel Internel Error
Date: Wed, 23 Aug 2006 10:06:38 -0600
Message-ID: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:24105 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965006AbWHWQGk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Aug 2006 12:06:40 -0400
Received: by py-out-1112.google.com with SMTP id n25so278120pyg
        for <linux-ide@vger.kernel.org>; Wed, 23 Aug 2006 09:06:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com

Hi Folks,

I used Linux 2.6.18-rc2 with Jeff Garzik's git libata patch for new EH, hotplug,
and pata support. Hardware is ARM IOP80321 with PCI-X. Host adapters
is pata Sil680.  The sequence of actions are "power off drive ->
remove drive -> power on drive -> add drive" and there's kernel errors
while adding the drive.  Complete dmesg traces attached. Has anyone
seen this problem before?

Thanks,
Fajun

~ $ dmesg
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
Calling initcall 0xc000f39c: timer_init_sysfs+0x0/0x3c()
Calling initcall 0xc002c4ec: iop3xx_aau_init+0x0/0x504()
Intel IOP3xx AAU RAID Copyright(c) 2003 Intel Corporation
Calling initcall 0xc0011444: fpe_init+0x0/0x84()
NetWinder Floating Point Emulator V0.97 (double precision)
Calling initcall 0xc0011d80: create_proc_profile+0x0/0x70()
Calling initcall 0xc0011f48: ioresources_init+0x0/0x5c()
Calling initcall 0xc00121d4: timekeeping_init_device+0x0/0x38()
Calling initcall 0xc0012388: uid_cache_init+0x0/0xa8()
Calling initcall 0xc0012754: param_sysfs_init+0x0/0x180()
Calling initcall 0xc00128d4: init_posix_timers+0x0/0xc0()
Calling initcall 0xc00129dc: init_posix_cpu_timers+0x0/0x84()
Calling initcall 0xc0012aac: init_clocksource_sysfs+0x0/0x68()
Calling initcall 0xc0012ba8: init_jiffies_clocksource+0x0/0x1c()
Calling initcall 0xc0012bc4: init+0x0/0x60()
Calling initcall 0xc0012c24: kallsyms_init+0x0/0x38()
Calling initcall 0xc00140c8: init_per_zone_pages_min+0x0/0x50()
Calling initcall 0xc0014400: pdflush_init+0x0/0x1c()
Calling initcall 0xc0014454: kswapd_init+0x0/0x38()
Calling initcall 0xc0014500: procswaps_init+0x0/0x38()
Calling initcall 0xc0014538: init_tmpfs+0x0/0x100()
Calling initcall 0xc00146a8: cpucache_init+0x0/0x1c()
Calling initcall 0xc0014f90: fasync_init+0x0/0x4c()
Calling initcall 0xc0015724: aio_setup+0x0/0x94()
Calling initcall 0xc00157b8: inotify_setup+0x0/0x24()
Calling initcall 0xc00157dc: inotify_user_setup+0x0/0xf8()
Calling initcall 0xc00158d4: eventpoll_init+0x0/0xec()
Calling initcall 0xc0015ec0: init_devpts_fs+0x0/0x48()
Calling initcall 0xc0015f08: init_ext2_fs+0x0/0x88()
Calling initcall 0xc0015f90: init_ramfs_fs+0x0/0x1c()
Calling initcall 0xc001618c: noop_init+0x0/0x1c()
io scheduler noop registered
Calling initcall 0xc00161a8: as_init+0x0/0x80()
io scheduler anticipatory registered
Calling initcall 0xc0016228: deadline_init+0x0/0x78()
io scheduler deadline registered
Calling initcall 0xc00162a0: cfq_init+0x0/0x10c()
io scheduler cfq registered (default)
Calling initcall 0xc00175b8: pci_init+0x0/0x3c()
PCI: Calling quirk c0018048 for 0000:00:01.0
PCI: Calling quirk c001c878 for 0000:00:01.0
Calling initcall 0xc0019044: pci_sysfs_init+0x0/0x44()
Calling initcall 0xc0019298: pci_proc_init+0x0/0x90()
Calling initcall 0xc0019e9c: rand_initialize+0x0/0x38()
Calling initcall 0xc0019f70: tty_init+0x0/0x1f8()
Calling initcall 0xc001a168: pty_init+0x0/0x3fc()
Calling initcall 0xc00db7cc: aauc_init+0x0/0x14c()
Calling initcall 0xc00e8ab4: usbfifoInit+0x0/0x1c()
Calling initcall 0xc001b184: serial8250_init+0x0/0x130()
Serial: 8250/16550 driver $Revision: 1.4 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0xfe800000 (irq = 29) is a SC16C752
serial8250: ttyS1 at MMIO 0xfe800008 (irq = 30) is a SC16C752
Calling initcall 0xc001b578: serial8250_pci_init+0x0/0x20()
Calling initcall 0xc001bc80: rd_init+0x0/0x194()
RAMDISK driver initialized: 16 RAM disks of 10485760K size 1024 blocksize
Calling initcall 0xc001bef4: net_olddevs_init+0x0/0xdc()
Calling initcall 0xc001c024: tun_init+0x0/0x64()
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Calling initcall 0xc001c3ac: spi_transport_init+0x0/0x44()
Calling initcall 0xc001c3f0: fc_transport_init+0x0/0x4c()
Calling initcall 0xc001c43c: iscsi_transport_init+0x0/0x108()
Calling initcall 0xc001c544: ata_init+0x0/0xa0()
libata version 2.00 loaded.
Calling initcall 0xc001c5e4: sil_init+0x0/0x20()
Calling initcall 0xc001c604: sil24_init+0x0/0x20()
Calling initcall 0xc001c624: sil680_init+0x0/0x20()
pata_sil680 0000:00:01.0: version 0.3.2
sil680: BA5_EN = 1 clock = 00
sil680: BA5_EN = 1 clock = 10
sil680: 133MHz clock.
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: Enabling bus mastering for device 0000:00:01.0
ata1: PATA max UDMA/133 cmd 0xFE000010 ctl 0xFE000022 bmdma 0xFE000000 irq 27
ata2: PATA max UDMA/133 cmd 0xFE000018 ctl 0xFE000026 bmdma 0xFE000008 irq 27
scsi0 : pata_sil680
ata1.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata1.00: configured for UDMA/100
scsi1 : pata_sil680
ata2.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata2.00: configured for UDMA/100
  Vendor: ATA       Model: ST3320820A        Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3320820A        Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
Calling initcall 0xc001c644: init_sd+0x0/0x8c()
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
Calling initcall 0xc001c6d0: init_sg+0x0/0x14c()
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
Calling initcall 0xc001cd50: i2c_dev_init+0x0/0xa8()
i2c /dev entries driver
Calling initcall 0xc001cdf8: i2c_iop3xx_init+0x0/0x1c()
Calling initcall 0xc001ce14: hwmon_init+0x0/0x5c()
Calling initcall 0xc001d460: flow_cache_init+0x0/0x174()
Calling initcall 0xc001e888: xfrm4_transport_init+0x0/0x20()
Calling initcall 0xc001e8a8: xfrm4_tunnel_init+0x0/0x20()
Calling initcall 0xc001e8c8: inet_diag_init+0x0/0x80()
Calling initcall 0xc001e948: tcp_diag_init+0x0/0x1c()
Calling initcall 0xc001e964: bictcp_register+0x0/0x1c()
TCP bic registered
Calling initcall 0xc001eb40: af_unix_init+0x0/0x80()
NET: Registered protocol family 1
Calling initcall 0xc001ebc0: packet_init+0x0/0x70()
NET: Registered protocol family 17
Calling initcall 0xc0012a88: clocksource_done_booting+0x0/0x24()
Calling initcall 0xc0019ed4: seqgen_init+0x0/0x1c()
Calling initcall 0xc001ba44: early_uart_console_switch+0x0/0x90()
Calling initcall 0xc0139c74: net_random_reseed+0x0/0x38()
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 104K
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x1)
ata2.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
ata2: EH complete

~ $ sg_scan
/dev/sg0: scsi0 channel=0 id=0 lun=0 [em]
/dev/sg1: scsi1 channel=0 id=0 lun=0 [em]

~ $ echo "scsi remove-single-device 1 0 0 0" > /proc/scsi/scsi
~ $ dmesg
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
Calling initcall 0xc000f39c: timer_init_sysfs+0x0/0x3c()
Calling initcall 0xc002c4ec: iop3xx_aau_init+0x0/0x504()
Intel IOP3xx AAU RAID Copyright(c) 2003 Intel Corporation
Calling initcall 0xc0011444: fpe_init+0x0/0x84()
NetWinder Floating Point Emulator V0.97 (double precision)
Calling initcall 0xc0011d80: create_proc_profile+0x0/0x70()
Calling initcall 0xc0011f48: ioresources_init+0x0/0x5c()
Calling initcall 0xc00121d4: timekeeping_init_device+0x0/0x38()
Calling initcall 0xc0012388: uid_cache_init+0x0/0xa8()
Calling initcall 0xc0012754: param_sysfs_init+0x0/0x180()
Calling initcall 0xc00128d4: init_posix_timers+0x0/0xc0()
Calling initcall 0xc00129dc: init_posix_cpu_timers+0x0/0x84()
Calling initcall 0xc0012aac: init_clocksource_sysfs+0x0/0x68()
Calling initcall 0xc0012ba8: init_jiffies_clocksource+0x0/0x1c()
Calling initcall 0xc0012bc4: init+0x0/0x60()
Calling initcall 0xc0012c24: kallsyms_init+0x0/0x38()
Calling initcall 0xc00140c8: init_per_zone_pages_min+0x0/0x50()
Calling initcall 0xc0014400: pdflush_init+0x0/0x1c()
Calling initcall 0xc0014454: kswapd_init+0x0/0x38()
Calling initcall 0xc0014500: procswaps_init+0x0/0x38()
Calling initcall 0xc0014538: init_tmpfs+0x0/0x100()
Calling initcall 0xc00146a8: cpucache_init+0x0/0x1c()
Calling initcall 0xc0014f90: fasync_init+0x0/0x4c()
Calling initcall 0xc0015724: aio_setup+0x0/0x94()
Calling initcall 0xc00157b8: inotify_setup+0x0/0x24()
Calling initcall 0xc00157dc: inotify_user_setup+0x0/0xf8()
Calling initcall 0xc00158d4: eventpoll_init+0x0/0xec()
Calling initcall 0xc0015ec0: init_devpts_fs+0x0/0x48()
Calling initcall 0xc0015f08: init_ext2_fs+0x0/0x88()
Calling initcall 0xc0015f90: init_ramfs_fs+0x0/0x1c()
Calling initcall 0xc001618c: noop_init+0x0/0x1c()
io scheduler noop registered
Calling initcall 0xc00161a8: as_init+0x0/0x80()
io scheduler anticipatory registered
Calling initcall 0xc0016228: deadline_init+0x0/0x78()
io scheduler deadline registered
Calling initcall 0xc00162a0: cfq_init+0x0/0x10c()
io scheduler cfq registered (default)
Calling initcall 0xc00175b8: pci_init+0x0/0x3c()
PCI: Calling quirk c0018048 for 0000:00:01.0
PCI: Calling quirk c001c878 for 0000:00:01.0
Calling initcall 0xc0019044: pci_sysfs_init+0x0/0x44()
Calling initcall 0xc0019298: pci_proc_init+0x0/0x90()
Calling initcall 0xc0019e9c: rand_initialize+0x0/0x38()
Calling initcall 0xc0019f70: tty_init+0x0/0x1f8()
Calling initcall 0xc001a168: pty_init+0x0/0x3fc()
Calling initcall 0xc00db7cc: aauc_init+0x0/0x14c()
Calling initcall 0xc00e8ab4: usbfifoInit+0x0/0x1c()
Calling initcall 0xc001b184: serial8250_init+0x0/0x130()
Serial: 8250/16550 driver $Revision: 1.4 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0xfe800000 (irq = 29) is a SC16C752
serial8250: ttyS1 at MMIO 0xfe800008 (irq = 30) is a SC16C752
Calling initcall 0xc001b578: serial8250_pci_init+0x0/0x20()
Calling initcall 0xc001bc80: rd_init+0x0/0x194()
RAMDISK driver initialized: 16 RAM disks of 10485760K size 1024 blocksize
Calling initcall 0xc001bef4: net_olddevs_init+0x0/0xdc()
Calling initcall 0xc001c024: tun_init+0x0/0x64()
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Calling initcall 0xc001c3ac: spi_transport_init+0x0/0x44()
Calling initcall 0xc001c3f0: fc_transport_init+0x0/0x4c()
Calling initcall 0xc001c43c: iscsi_transport_init+0x0/0x108()
Calling initcall 0xc001c544: ata_init+0x0/0xa0()
libata version 2.00 loaded.
Calling initcall 0xc001c5e4: sil_init+0x0/0x20()
Calling initcall 0xc001c604: sil24_init+0x0/0x20()
Calling initcall 0xc001c624: sil680_init+0x0/0x20()
pata_sil680 0000:00:01.0: version 0.3.2
sil680: BA5_EN = 1 clock = 00
sil680: BA5_EN = 1 clock = 10
sil680: 133MHz clock.
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: Enabling bus mastering for device 0000:00:01.0
ata1: PATA max UDMA/133 cmd 0xFE000010 ctl 0xFE000022 bmdma 0xFE000000 irq 27
ata2: PATA max UDMA/133 cmd 0xFE000018 ctl 0xFE000026 bmdma 0xFE000008 irq 27
scsi0 : pata_sil680
ata1.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata1.00: configured for UDMA/100
scsi1 : pata_sil680
ata2.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata2.00: configured for UDMA/100
  Vendor: ATA       Model: ST3320820A        Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3320820A        Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
Calling initcall 0xc001c644: init_sd+0x0/0x8c()
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
Calling initcall 0xc001c6d0: init_sg+0x0/0x14c()
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
Calling initcall 0xc001cd50: i2c_dev_init+0x0/0xa8()
i2c /dev entries driver
Calling initcall 0xc001cdf8: i2c_iop3xx_init+0x0/0x1c()
Calling initcall 0xc001ce14: hwmon_init+0x0/0x5c()
Calling initcall 0xc001d460: flow_cache_init+0x0/0x174()
Calling initcall 0xc001e888: xfrm4_transport_init+0x0/0x20()
Calling initcall 0xc001e8a8: xfrm4_tunnel_init+0x0/0x20()
Calling initcall 0xc001e8c8: inet_diag_init+0x0/0x80()
Calling initcall 0xc001e948: tcp_diag_init+0x0/0x1c()
Calling initcall 0xc001e964: bictcp_register+0x0/0x1c()
TCP bic registered
Calling initcall 0xc001eb40: af_unix_init+0x0/0x80()
NET: Registered protocol family 1
Calling initcall 0xc001ebc0: packet_init+0x0/0x70()
NET: Registered protocol family 17
Calling initcall 0xc0012a88: clocksource_done_booting+0x0/0x24()
Calling initcall 0xc0019ed4: seqgen_init+0x0/0x1c()
Calling initcall 0xc001ba44: early_uart_console_switch+0x0/0x90()
Calling initcall 0xc0139c74: net_random_reseed+0x0/0x38()
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 104K
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x1)
ata2.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
ata2: EH complete

~ $ sg_scan
/dev/sg0: scsi0 channel=0 id=0 lun=0 [em]

~ $ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3320820A       Rev: 3.AA
  Type:   Direct-Access                    ANSI SCSI revision: 05

~ $ dmesg
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
Calling initcall 0xc000f39c: timer_init_sysfs+0x0/0x3c()
Calling initcall 0xc002c4ec: iop3xx_aau_init+0x0/0x504()
Intel IOP3xx AAU RAID Copyright(c) 2003 Intel Corporation
Calling initcall 0xc0011444: fpe_init+0x0/0x84()
NetWinder Floating Point Emulator V0.97 (double precision)
Calling initcall 0xc0011d80: create_proc_profile+0x0/0x70()
Calling initcall 0xc0011f48: ioresources_init+0x0/0x5c()
Calling initcall 0xc00121d4: timekeeping_init_device+0x0/0x38()
Calling initcall 0xc0012388: uid_cache_init+0x0/0xa8()
Calling initcall 0xc0012754: param_sysfs_init+0x0/0x180()
Calling initcall 0xc00128d4: init_posix_timers+0x0/0xc0()
Calling initcall 0xc00129dc: init_posix_cpu_timers+0x0/0x84()
Calling initcall 0xc0012aac: init_clocksource_sysfs+0x0/0x68()
Calling initcall 0xc0012ba8: init_jiffies_clocksource+0x0/0x1c()
Calling initcall 0xc0012bc4: init+0x0/0x60()
Calling initcall 0xc0012c24: kallsyms_init+0x0/0x38()
Calling initcall 0xc00140c8: init_per_zone_pages_min+0x0/0x50()
Calling initcall 0xc0014400: pdflush_init+0x0/0x1c()
Calling initcall 0xc0014454: kswapd_init+0x0/0x38()
Calling initcall 0xc0014500: procswaps_init+0x0/0x38()
Calling initcall 0xc0014538: init_tmpfs+0x0/0x100()
Calling initcall 0xc00146a8: cpucache_init+0x0/0x1c()
Calling initcall 0xc0014f90: fasync_init+0x0/0x4c()
Calling initcall 0xc0015724: aio_setup+0x0/0x94()
Calling initcall 0xc00157b8: inotify_setup+0x0/0x24()
Calling initcall 0xc00157dc: inotify_user_setup+0x0/0xf8()
Calling initcall 0xc00158d4: eventpoll_init+0x0/0xec()
Calling initcall 0xc0015ec0: init_devpts_fs+0x0/0x48()
Calling initcall 0xc0015f08: init_ext2_fs+0x0/0x88()
Calling initcall 0xc0015f90: init_ramfs_fs+0x0/0x1c()
Calling initcall 0xc001618c: noop_init+0x0/0x1c()
io scheduler noop registered
Calling initcall 0xc00161a8: as_init+0x0/0x80()
io scheduler anticipatory registered
Calling initcall 0xc0016228: deadline_init+0x0/0x78()
io scheduler deadline registered
Calling initcall 0xc00162a0: cfq_init+0x0/0x10c()
io scheduler cfq registered (default)
Calling initcall 0xc00175b8: pci_init+0x0/0x3c()
PCI: Calling quirk c0018048 for 0000:00:01.0
PCI: Calling quirk c001c878 for 0000:00:01.0
Calling initcall 0xc0019044: pci_sysfs_init+0x0/0x44()
Calling initcall 0xc0019298: pci_proc_init+0x0/0x90()
Calling initcall 0xc0019e9c: rand_initialize+0x0/0x38()
Calling initcall 0xc0019f70: tty_init+0x0/0x1f8()
Calling initcall 0xc001a168: pty_init+0x0/0x3fc()
Calling initcall 0xc00db7cc: aauc_init+0x0/0x14c()
Calling initcall 0xc00e8ab4: usbfifoInit+0x0/0x1c()
Calling initcall 0xc001b184: serial8250_init+0x0/0x130()
Serial: 8250/16550 driver $Revision: 1.4 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0xfe800000 (irq = 29) is a SC16C752
serial8250: ttyS1 at MMIO 0xfe800008 (irq = 30) is a SC16C752
Calling initcall 0xc001b578: serial8250_pci_init+0x0/0x20()
Calling initcall 0xc001bc80: rd_init+0x0/0x194()
RAMDISK driver initialized: 16 RAM disks of 10485760K size 1024 blocksize
Calling initcall 0xc001bef4: net_olddevs_init+0x0/0xdc()
Calling initcall 0xc001c024: tun_init+0x0/0x64()
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Calling initcall 0xc001c3ac: spi_transport_init+0x0/0x44()
Calling initcall 0xc001c3f0: fc_transport_init+0x0/0x4c()
Calling initcall 0xc001c43c: iscsi_transport_init+0x0/0x108()
Calling initcall 0xc001c544: ata_init+0x0/0xa0()
libata version 2.00 loaded.
Calling initcall 0xc001c5e4: sil_init+0x0/0x20()
Calling initcall 0xc001c604: sil24_init+0x0/0x20()
Calling initcall 0xc001c624: sil680_init+0x0/0x20()
pata_sil680 0000:00:01.0: version 0.3.2
sil680: BA5_EN = 1 clock = 00
sil680: BA5_EN = 1 clock = 10
sil680: 133MHz clock.
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: Enabling bus mastering for device 0000:00:01.0
ata1: PATA max UDMA/133 cmd 0xFE000010 ctl 0xFE000022 bmdma 0xFE000000 irq 27
ata2: PATA max UDMA/133 cmd 0xFE000018 ctl 0xFE000026 bmdma 0xFE000008 irq 27
scsi0 : pata_sil680
ata1.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata1.00: configured for UDMA/100
scsi1 : pata_sil680
ata2.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata2.00: configured for UDMA/100
  Vendor: ATA       Model: ST3320820A        Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3320820A        Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
Calling initcall 0xc001c644: init_sd+0x0/0x8c()
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
Calling initcall 0xc001c6d0: init_sg+0x0/0x14c()
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
Calling initcall 0xc001cd50: i2c_dev_init+0x0/0xa8()
i2c /dev entries driver
Calling initcall 0xc001cdf8: i2c_iop3xx_init+0x0/0x1c()
Calling initcall 0xc001ce14: hwmon_init+0x0/0x5c()
Calling initcall 0xc001d460: flow_cache_init+0x0/0x174()
Calling initcall 0xc001e888: xfrm4_transport_init+0x0/0x20()
Calling initcall 0xc001e8a8: xfrm4_tunnel_init+0x0/0x20()
Calling initcall 0xc001e8c8: inet_diag_init+0x0/0x80()
Calling initcall 0xc001e948: tcp_diag_init+0x0/0x1c()
Calling initcall 0xc001e964: bictcp_register+0x0/0x1c()
TCP bic registered
Calling initcall 0xc001eb40: af_unix_init+0x0/0x80()
NET: Registered protocol family 1
Calling initcall 0xc001ebc0: packet_init+0x0/0x70()
NET: Registered protocol family 17
Calling initcall 0xc0012a88: clocksource_done_booting+0x0/0x24()
Calling initcall 0xc0019ed4: seqgen_init+0x0/0x1c()
Calling initcall 0xc001ba44: early_uart_console_switch+0x0/0x90()
Calling initcall 0xc0139c74: net_random_reseed+0x0/0x38()
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 104K
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x1)
ata2.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
ata2: EH complete
~ $
~ $ pwd
/
~ $ ./PowerOn 0
driveOn = 1
~ $ dmesg
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
Calling initcall 0xc000f39c: timer_init_sysfs+0x0/0x3c()
Calling initcall 0xc002c4ec: iop3xx_aau_init+0x0/0x504()
Intel IOP3xx AAU RAID Copyright(c) 2003 Intel Corporation
Calling initcall 0xc0011444: fpe_init+0x0/0x84()
NetWinder Floating Point Emulator V0.97 (double precision)
Calling initcall 0xc0011d80: create_proc_profile+0x0/0x70()
Calling initcall 0xc0011f48: ioresources_init+0x0/0x5c()
Calling initcall 0xc00121d4: timekeeping_init_device+0x0/0x38()
Calling initcall 0xc0012388: uid_cache_init+0x0/0xa8()
Calling initcall 0xc0012754: param_sysfs_init+0x0/0x180()
Calling initcall 0xc00128d4: init_posix_timers+0x0/0xc0()
Calling initcall 0xc00129dc: init_posix_cpu_timers+0x0/0x84()
Calling initcall 0xc0012aac: init_clocksource_sysfs+0x0/0x68()
Calling initcall 0xc0012ba8: init_jiffies_clocksource+0x0/0x1c()
Calling initcall 0xc0012bc4: init+0x0/0x60()
Calling initcall 0xc0012c24: kallsyms_init+0x0/0x38()
Calling initcall 0xc00140c8: init_per_zone_pages_min+0x0/0x50()
Calling initcall 0xc0014400: pdflush_init+0x0/0x1c()
Calling initcall 0xc0014454: kswapd_init+0x0/0x38()
Calling initcall 0xc0014500: procswaps_init+0x0/0x38()
Calling initcall 0xc0014538: init_tmpfs+0x0/0x100()
Calling initcall 0xc00146a8: cpucache_init+0x0/0x1c()
Calling initcall 0xc0014f90: fasync_init+0x0/0x4c()
Calling initcall 0xc0015724: aio_setup+0x0/0x94()
Calling initcall 0xc00157b8: inotify_setup+0x0/0x24()
Calling initcall 0xc00157dc: inotify_user_setup+0x0/0xf8()
Calling initcall 0xc00158d4: eventpoll_init+0x0/0xec()
Calling initcall 0xc0015ec0: init_devpts_fs+0x0/0x48()
Calling initcall 0xc0015f08: init_ext2_fs+0x0/0x88()
Calling initcall 0xc0015f90: init_ramfs_fs+0x0/0x1c()
Calling initcall 0xc001618c: noop_init+0x0/0x1c()
io scheduler noop registered
Calling initcall 0xc00161a8: as_init+0x0/0x80()
io scheduler anticipatory registered
Calling initcall 0xc0016228: deadline_init+0x0/0x78()
io scheduler deadline registered
Calling initcall 0xc00162a0: cfq_init+0x0/0x10c()
io scheduler cfq registered (default)
Calling initcall 0xc00175b8: pci_init+0x0/0x3c()
PCI: Calling quirk c0018048 for 0000:00:01.0
PCI: Calling quirk c001c878 for 0000:00:01.0
Calling initcall 0xc0019044: pci_sysfs_init+0x0/0x44()
Calling initcall 0xc0019298: pci_proc_init+0x0/0x90()
Calling initcall 0xc0019e9c: rand_initialize+0x0/0x38()
Calling initcall 0xc0019f70: tty_init+0x0/0x1f8()
Calling initcall 0xc001a168: pty_init+0x0/0x3fc()
Calling initcall 0xc00db7cc: aauc_init+0x0/0x14c()
Calling initcall 0xc00e8ab4: usbfifoInit+0x0/0x1c()
Calling initcall 0xc001b184: serial8250_init+0x0/0x130()
Serial: 8250/16550 driver $Revision: 1.4 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0xfe800000 (irq = 29) is a SC16C752
serial8250: ttyS1 at MMIO 0xfe800008 (irq = 30) is a SC16C752
Calling initcall 0xc001b578: serial8250_pci_init+0x0/0x20()
Calling initcall 0xc001bc80: rd_init+0x0/0x194()
RAMDISK driver initialized: 16 RAM disks of 10485760K size 1024 blocksize
Calling initcall 0xc001bef4: net_olddevs_init+0x0/0xdc()
Calling initcall 0xc001c024: tun_init+0x0/0x64()
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Calling initcall 0xc001c3ac: spi_transport_init+0x0/0x44()
Calling initcall 0xc001c3f0: fc_transport_init+0x0/0x4c()
Calling initcall 0xc001c43c: iscsi_transport_init+0x0/0x108()
Calling initcall 0xc001c544: ata_init+0x0/0xa0()
libata version 2.00 loaded.
Calling initcall 0xc001c5e4: sil_init+0x0/0x20()
Calling initcall 0xc001c604: sil24_init+0x0/0x20()
Calling initcall 0xc001c624: sil680_init+0x0/0x20()
pata_sil680 0000:00:01.0: version 0.3.2
sil680: BA5_EN = 1 clock = 00
sil680: BA5_EN = 1 clock = 10
sil680: 133MHz clock.
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: Enabling bus mastering for device 0000:00:01.0
ata1: PATA max UDMA/133 cmd 0xFE000010 ctl 0xFE000022 bmdma 0xFE000000 irq 27
ata2: PATA max UDMA/133 cmd 0xFE000018 ctl 0xFE000026 bmdma 0xFE000008 irq 27
scsi0 : pata_sil680
ata1.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata1.00: configured for UDMA/100
scsi1 : pata_sil680
ata2.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata2.00: configured for UDMA/100
  Vendor: ATA       Model: ST3320820A        Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3320820A        Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
Calling initcall 0xc001c644: init_sd+0x0/0x8c()
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
Calling initcall 0xc001c6d0: init_sg+0x0/0x14c()
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
Calling initcall 0xc001cd50: i2c_dev_init+0x0/0xa8()
i2c /dev entries driver
Calling initcall 0xc001cdf8: i2c_iop3xx_init+0x0/0x1c()
Calling initcall 0xc001ce14: hwmon_init+0x0/0x5c()
Calling initcall 0xc001d460: flow_cache_init+0x0/0x174()
Calling initcall 0xc001e888: xfrm4_transport_init+0x0/0x20()
Calling initcall 0xc001e8a8: xfrm4_tunnel_init+0x0/0x20()
Calling initcall 0xc001e8c8: inet_diag_init+0x0/0x80()
Calling initcall 0xc001e948: tcp_diag_init+0x0/0x1c()
Calling initcall 0xc001e964: bictcp_register+0x0/0x1c()
TCP bic registered
Calling initcall 0xc001eb40: af_unix_init+0x0/0x80()
NET: Registered protocol family 1
Calling initcall 0xc001ebc0: packet_init+0x0/0x70()
NET: Registered protocol family 17
Calling initcall 0xc0012a88: clocksource_done_booting+0x0/0x24()
Calling initcall 0xc0019ed4: seqgen_init+0x0/0x1c()
Calling initcall 0xc001ba44: early_uart_console_switch+0x0/0x90()
Calling initcall 0xc0139c74: net_random_reseed+0x0/0x38()
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 104K
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x1)
ata2.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
ata2: EH complete
~ $
~ $ echo "scsi add-single-device 1 0 0 0" > /proc/scsi/scsi
~ $ sg_scan
/dev/sg0: scsi0 channel=0 id=0 lun=0 [em]
~ $ dmesg
ng initcall 0xc00162a0: cfq_init+0x0/0x10c()
io scheduler cfq registered (default)
Calling initcall 0xc00175b8: pci_init+0x0/0x3c()
PCI: Calling quirk c0018048 for 0000:00:01.0
PCI: Calling quirk c001c878 for 0000:00:01.0
Calling initcall 0xc0019044: pci_sysfs_init+0x0/0x44()
Calling initcall 0xc0019298: pci_proc_init+0x0/0x90()
Calling initcall 0xc0019e9c: rand_initialize+0x0/0x38()
Calling initcall 0xc0019f70: tty_init+0x0/0x1f8()
Calling initcall 0xc001a168: pty_init+0x0/0x3fc()
Calling initcall 0xc00db7cc: aauc_init+0x0/0x14c()
Calling initcall 0xc00e8ab4: usbfifoInit+0x0/0x1c()
Calling initcall 0xc001b184: serial8250_init+0x0/0x130()
Serial: 8250/16550 driver $Revision: 1.4 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0xfe800000 (irq = 29) is a SC16C752
serial8250: ttyS1 at MMIO 0xfe800008 (irq = 30) is a SC16C752
Calling initcall 0xc001b578: serial8250_pci_init+0x0/0x20()
Calling initcall 0xc001bc80: rd_init+0x0/0x194()
RAMDISK driver initialized: 16 RAM disks of 10485760K size 1024 blocksize
Calling initcall 0xc001bef4: net_olddevs_init+0x0/0xdc()
Calling initcall 0xc001c024: tun_init+0x0/0x64()
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Calling initcall 0xc001c3ac: spi_transport_init+0x0/0x44()
Calling initcall 0xc001c3f0: fc_transport_init+0x0/0x4c()
Calling initcall 0xc001c43c: iscsi_transport_init+0x0/0x108()
Calling initcall 0xc001c544: ata_init+0x0/0xa0()
libata version 2.00 loaded.
Calling initcall 0xc001c5e4: sil_init+0x0/0x20()
Calling initcall 0xc001c604: sil24_init+0x0/0x20()
Calling initcall 0xc001c624: sil680_init+0x0/0x20()
pata_sil680 0000:00:01.0: version 0.3.2
sil680: BA5_EN = 1 clock = 00
sil680: BA5_EN = 1 clock = 10
sil680: 133MHz clock.
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: Enabling bus mastering for device 0000:00:01.0
ata1: PATA max UDMA/133 cmd 0xFE000010 ctl 0xFE000022 bmdma 0xFE000000 irq 27
ata2: PATA max UDMA/133 cmd 0xFE000018 ctl 0xFE000026 bmdma 0xFE000008 irq 27
scsi0 : pata_sil680
ata1.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata1.00: configured for UDMA/100
scsi1 : pata_sil680
ata2.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata2.00: configured for UDMA/100
  Vendor: ATA       Model: ST3320820A        Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3320820A        Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
Calling initcall 0xc001c644: init_sd+0x0/0x8c()
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
Calling initcall 0xc001c6d0: init_sg+0x0/0x14c()
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
Calling initcall 0xc001cd50: i2c_dev_init+0x0/0xa8()
i2c /dev entries driver
Calling initcall 0xc001cdf8: i2c_iop3xx_init+0x0/0x1c()
Calling initcall 0xc001ce14: hwmon_init+0x0/0x5c()
Calling initcall 0xc001d460: flow_cache_init+0x0/0x174()
Calling initcall 0xc001e888: xfrm4_transport_init+0x0/0x20()
Calling initcall 0xc001e8a8: xfrm4_tunnel_init+0x0/0x20()
Calling initcall 0xc001e8c8: inet_diag_init+0x0/0x80()
Calling initcall 0xc001e948: tcp_diag_init+0x0/0x1c()
Calling initcall 0xc001e964: bictcp_register+0x0/0x1c()
TCP bic registered
Calling initcall 0xc001eb40: af_unix_init+0x0/0x80()
NET: Registered protocol family 1
Calling initcall 0xc001ebc0: packet_init+0x0/0x70()
NET: Registered protocol family 17
Calling initcall 0xc0012a88: clocksource_done_booting+0x0/0x24()
Calling initcall 0xc0019ed4: seqgen_init+0x0/0x1c()
Calling initcall 0xc001ba44: early_uart_console_switch+0x0/0x90()
Calling initcall 0xc0139c74: net_random_reseed+0x0/0x38()
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 104K
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x1)
ata2.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
ata2: EH complete
ata2: soft resetting port
ata2.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
ata2.00: configured for UDMA/100
ata2: EH complete
Unable to handle kernel paging request at virtual address 6f020091
pgd = c0004000
[6f020091] *pgd=00000000
Internal error: Oops: f3 [#1]
Modules linked in:
CPU: 0
PC is at scsi_device_get+0x40/0x98
LR is at kobject_get+0x18/0x20
pc : [<c00f6728>]    lr : [<c00c8274>]    Not tainted
sp : c0b5ff10  ip : c0b5feec  fp : c0b5ff24
r10: c0b68298  r9 : 00000000  r8 : 60000013
r7 : c0b68298  r6 : 00000000  r5 : c0bba090  r4 : c0bba000
r3 : 6f020045  r2 : fffffffa  r1 : c0197340  r0 : c0bba090
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 397F  Table: 02EB8000  DAC: 00000017
Process ata_aux (pid: 13, stack limit = 0xc0b5e250)
Stack: (0xc0b5ff10 to 0xc0b60000)
ff00:                                     c0bba000 c0b68424 c0b5ff50 c0b5ff28
ff20: c0112d28 c00f66f4 c0b50b20 20000013 c0112c98 c0b50b28 00000001 00000000
ff40: fffffffc c0b5ff70 c0b5ff54 c0047e4c c0112ca4 c0b50b30 c0b50b28 c0b5ff90
ff60: c0b50b20 c0b5ffc0 c0b5ff74 c0047fb4 c0047da4 ffffffff ffffffff 00000001
ff80: 00000000 c003406c 00010000 00000000 00000000 c0b5b940 c003406c 00100100
ffa0: 00200200 c0b50b20 c0b5e000 c0befefc c0047ea0 c0b5fff4 c0b5ffc4 c004b670
ffc0: c0047eac 00000001 ffffffff ffffffff 00000000 00000000 00000000 00000000
ffe0: 00000000 00000000 00000000 c0b5fff8 c0039d24 c004b590 906f8a57 c8a970b5
Backtrace:
[<c00f66e8>] (scsi_device_get+0x0/0x98) from [<c0112d28>]
(ata_scsi_hotplug+0x90/0x188)
 r5 = C0B68424  r4 = C0BBA000
[<c0112c98>] (ata_scsi_hotplug+0x0/0x188) from [<c0047e4c>]
(run_workqueue+0xb4/0x108)
[<c0047d98>] (run_workqueue+0x0/0x108) from [<c0047fb4>]
(worker_thread+0x114/0x16c)
 r7 = C0B50B20  r6 = C0B5FF90  r5 = C0B50B28  r4 = C0B50B30
[<c0047ea0>] (worker_thread+0x0/0x16c) from [<c004b670>] (kthread+0xec/0x11c)
 r7 = C0047EA0  r6 = C0BEFEFC  r5 = C0B5E000  r4 = C0B50B20
[<c004b584>] (kthread+0x0/0x11c) from [<c0039d24>] (do_exit+0x0/0x7f4)
Code: e3500000 e3e02005 0a000014 e5943000 (e593304c)
