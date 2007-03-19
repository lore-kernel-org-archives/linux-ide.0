From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Change Libata Error Handling for Drive Testing
Date: Mon, 19 Mar 2007 10:01:48 -0700
Message-ID: <8202f4270703191001l50250d2fndb7403e41c39fa1@mail.gmail.com>
References: <8202f4270703182216r33860cbdha404865d05a03b81@mail.gmail.com>
	 <45FE3F17.4010500@gmail.com>
	 <8202f4270703190927p4fd7098at5d0f4706d66009cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:55294 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964848AbXCSRBt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 13:01:49 -0400
Received: by wr-out-0506.google.com with SMTP id 41so1543635wry
        for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 10:01:48 -0700 (PDT)
In-Reply-To: <8202f4270703190927p4fd7098at5d0f4706d66009cf@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

> > > Another error we're analyzing is "disabled IRQ" due to screaming
> > > unhandled interrupts from ata_interrupt(). Since this happened on
> > > different drives, it doesn't seem to be a drive issue. Any known
> > > problem on this one? Could long ISR locking by some rogue application
> > > cause this problem? To detect the problem early, it probably makes
> > > sense to add error handling code to check for screeming unhandled ISR
> > > in ata_interrupt() function?
> >
> > Which driver are you using?  Please report with lspci -nn and full dmesg
> > with linux-ide cc'd.
> >
> We use PATA Sil680.  I don't have lspci ported yet on the target test
> hardware. I'll collect the kernel log and report it to you later.
>
Kernel revision is 2.6.18-rc2 and libata 2.00. The following changes
were made to pata_sil680.c:
1.    For PCI IO performance:
       /* FIXME: double check */
	//pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, (class_rev) ? 1 : 255);
	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0);
	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
2.  Applied one of the patches to change TF1 timing register to 0x2283

Below are the kernel logs at the time of the failure:
call 0xc0015f90: init_ramfs_fs+0x0/0x1c()
[42949375.530000] Calling initcall 0xc001618c: noop_init+0x0/0x1c()
[42949375.530000] io scheduler noop registered
[42949375.530000] Calling initcall 0xc00161a8: as_init+0x0/0x80()
[42949375.530000] io scheduler anticipatory registered
[42949375.530000] Calling initcall 0xc0016228: deadline_init+0x0/0x78()
[42949375.530000] io scheduler deadline registered
[42949375.530000] Calling initcall 0xc00162a0: cfq_init+0x0/0x10c()
[42949375.530000] io scheduler cfq registered (default)
[42949375.530000] Calling initcall 0xc00175b8: pci_init+0x0/0x3c()
[42949375.530000] PCI: Calling quirk c0018048 for 0000:00:01.0
[42949375.530000] PCI: Calling quirk c001cb64 for 0000:00:01.0
[42949375.530000] Calling initcall 0xc0019044: pci_sysfs_init+0x0/0x44()
[42949375.530000] Calling initcall 0xc0019298: pci_proc_init+0x0/0x90()
[42949375.530000] Calling initcall 0xc0019e9c: rand_initialize+0x0/0x38()
[42949375.530000] Calling initcall 0xc0019f70: tty_init+0x0/0x1f8()
[42949375.530000] Calling initcall 0xc001a168: pty_init+0x0/0x3fc()
[42949375.720000] Calling initcall 0xc00db7cc: aauc_init+0x0/0x14c()
[42949375.720000] Calling initcall 0xc00e8b00: usbfifoInit+0x0/0x1c()
[42949375.720000] Calling initcall 0xc001b184: serial8250_init+0x0/0x130()
[42949375.720000] Serial: 8250/16550 driver $Revision: 1.4 $ 2 ports,
IRQ sharing disabled
[42949375.720000] serial8250: ttyS0 at MMIO 0xfe800000 (irq = 29) is a SC16C752
[42949375.720000] serial8250: ttyS1 at MMIO 0xfe800008 (irq = 30) is a SC16C752
[42949375.720000] Calling initcall 0xc001b578: serial8250_pci_init+0x0/0x20()
[42949375.720000] Calling initcall 0xc001bc80: rd_init+0x0/0x194()
[42949375.730000] RAMDISK driver initialized: 16 RAM disks of
10485760K size 1024 blocksize
[42949375.730000] Calling initcall 0xc001bef4: net_olddevs_init+0x0/0xdc()
[42949375.730000] Calling initcall 0xc001c024: tun_init+0x0/0x64()
[42949375.730000] tun: Universal TUN/TAP device driver, 1.6
[42949375.730000] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[42949375.730000] Calling initcall 0xc001c3ac: spi_transport_init+0x0/0x44()
[42949375.730000] Calling initcall 0xc001c3f0: fc_transport_init+0x0/0x4c()
[42949375.730000] Calling initcall 0xc001c43c: iscsi_transport_init+0x0/0x108()
[42949375.730000] Calling initcall 0xc001c544: ata_init+0x0/0xa0()
[42949375.730000] libata version 2.00 loaded.
[42949375.730000] Calling initcall 0xc001c5e4: sil_init+0x0/0x20()
[42949375.730000] Calling initcall 0xc001c604: sil24_init+0x0/0x20()
[42949375.730000] Calling initcall 0xc001c624: sil680_init+0x0/0x20()
[42949375.730000] pata_sil680 0000:00:01.0: version 0.3.2
[42949375.730000] sil680: BA5_EN = 1 clock = 00
[42949375.730000] sil680: BA5_EN = 1 clock = 10
[42949375.730000] sil680: 133MHz clock.
[42949375.730000] PCI: enabling device 0000:00:01.0 (0140 -> 0143)
[42949375.730000] PCI: Enabling bus mastering for device 0000:00:01.0
[42949375.730000] ata1: PATA max UDMA/133 cmd 0xFE000010 ctl
0xFE000022 bmdma 0xFE000000 irq 27
[42949375.730000] ata2: PATA max UDMA/133 cmd 0xFE000018 ctl
0xFE000026 bmdma 0xFE000008 irq 27
[42949375.730000] scsi0 : pata_sil680
[42949375.750000] scsi1 : pata_sil680
[42949375.770000] Calling initcall 0xc001c910: vsc_sata_init+0x0/0x20()
[42949375.770000] Calling initcall 0xc001c930: init_sd+0x0/0x8c()
[42949375.770000] Calling initcall 0xc001c9bc: init_sg+0x0/0x14c()
[42949375.770000] Calling initcall 0xc001d03c: i2c_dev_init+0x0/0xa8()
[42949375.770000] i2c /dev entries driver
[42949375.770000] Calling initcall 0xc001d0e4: i2c_iop3xx_init+0x0/0x1c()
[42949375.770000] Calling initcall 0xc001d100: hwmon_init+0x0/0x5c()
[42949375.770000] Calling initcall 0xc001d74c: flow_cache_init+0x0/0x174()
[42949375.770000] Calling initcall 0xc001eb74: xfrm4_transport_init+0x0/0x20()
[42949375.770000] Calling initcall 0xc001eb94: xfrm4_tunnel_init+0x0/0x20()
[42949375.770000] Calling initcall 0xc001ebb4: inet_diag_init+0x0/0x80()
[42949375.770000] Calling initcall 0xc001ec34: tcp_diag_init+0x0/0x1c()
[42949375.770000] Calling initcall 0xc001ec50: bictcp_register+0x0/0x1c()
[42949375.770000] TCP bic registered
[42949375.770000] Calling initcall 0xc001ee2c: af_unix_init+0x0/0x80()
[42949375.770000] NET: Registered protocol family 1
[42949375.770000] Calling initcall 0xc001eeac: packet_init+0x0/0x70()
[42949375.770000] NET: Registered protocol family 17
[42949375.770000] Calling initcall 0xc0012a88:
clocksource_done_booting+0x0/0x24()
[42949375.770000] Calling initcall 0xc0019ed4: seqgen_init+0x0/0x1c()
[42949375.770000] Calling initcall 0xc001ba44:
early_uart_console_switch+0x0/0x90()
[42949375.770000] Calling initcall 0xc013a11c: net_random_reseed+0x0/0x38()
[42949375.770000] RAMDISK: Compressed image found at block 0
[42949378.950000] VFS: Mounted root (ext2 filesystem).
[42949378.950000] Freeing init memory: 104K
[42949550.800000] ata2: soft resetting port
[42949550.840000] ata2.00: ATA-6, max UDMA/100, 156301488 sectors: LBA48
[42949550.840000] ata2.00: configured for UDMA/100
[42949550.840000] ata2: EH complete
[42949550.840000]   Vendor: ATA       Model: ST980815A         Rev: ALD2
[42949550.840000]   Type:   Direct-Access                      ANSI
SCSI revision: 05
[42949550.850000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[42949550.850000] sda: Write Protect is off
[42949550.850000] sda: Mode Sense: 00 3a 00 00
[42949550.850000] SCSI device sda: drive cache: write back
[42949550.860000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[42949550.860000] sda: Write Protect is off
[42949550.860000] sda: Mode Sense: 00 3a 00 00
[42949550.860000] SCSI device sda: drive cache: write back
[42949550.860000]  sda: unknown partition table
[42949550.890000] sd 1:0:0:0: Attached scsi disk sda
[42949550.890000] sd 1:0:0:0: Attached scsi generic sg0 type 0
[42949550.920000] ata2: soft resetting port
[42949550.960000] ata2.00: configured for UDMA/100
[42949550.960000] ata2: EH complete
[42949550.960000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[42949550.960000] sda: Write Protect is off
[42949550.960000] sda: Mode Sense: 00 3a 00 00
[42949550.970000] SCSI device sda: drive cache: write back
[  344.980000] ata2: soft resetting port
[  345.020000] ata2.00: configured for UDMA/100
[  345.020000] ata2: EH complete
[  345.020000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[  345.020000] sda: Write Protect is off
[  345.020000] sda: Mode Sense: 00 3a 00 00
[  345.030000] SCSI device sda: drive cache: write back
[  502.520000] irq 27: nobody cared (try booting with the "irqpoll" option)
[  502.520000] handlers:
[  502.520000] [<c010ddac>] (ata_interrupt+0x0/0x208)
[  502.520000] Disabling IRQ #27
[  517.170000] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  517.170000] ata2.00: tag 0 cmd 0xec Emask 0x4 stat 0x40 err 0x0 (timeout)
[  517.170000] ata2: soft resetting port
[  547.350000] ata2.00: qc timeout (cmd 0xec)
[  547.350000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  547.350000] ata2.00: revalidation failed (errno=-5)
[  547.350000] ata2: failed to recover some devices, retrying in 5 secs
[  552.360000] ata2: soft resetting port
[  582.540000] ata2.00: qc timeout (cmd 0xec)
[  582.540000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  582.540000] ata2.00: revalidation failed (errno=-5)
[  582.540000] ata2: failed to recover some devices, retrying in 5 secs
[  587.550000] ata2: soft resetting port
[  617.730000] ata2.00: qc timeout (cmd 0xec)
[  617.730000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  617.730000] ata2.00: revalidation failed (errno=-5)
[  617.730000] ata2.00: disabled
[  618.240000] ata2: EH complete
[  632.910000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308

Thanks,
Fajun
