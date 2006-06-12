From: Aalderd Bouwman <aalderd.boac@wanadoo.nl>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 using ahci
	module
Date: Mon, 12 Jun 2006 12:42:53 +0200
Message-ID: <1150108974.4020.3.camel@anja>
References: <1149787827.4180.8.camel@anja>  <44890ACA.5070504@gmail.com>
Reply-To: aalderd.boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp04.wanadoo.nl ([194.134.35.144]:26923 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S1751821AbWFLKk6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 06:40:58 -0400
In-Reply-To: <44890ACA.5070504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello Tejun,

#modprobe achi:
Jun 12 12:26:47 server ahci 0000:00:0f.0: version 1.3
Jun 12 12:26:47 server ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Jun 12 12:26:53 server ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
Jun 12 12:26:53 server ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jun 12 12:26:53 server ata13: SATA max UDMA/133 cmd 0xE048AD00 ctl 0x0 bmdma 0x0 irq 10
Jun 12 12:26:53 server ata14: SATA max UDMA/133 cmd 0xE048AD80 ctl 0x0 bmdma 0x0 irq 10
Jun 12 12:26:53 server ata15: SATA max UDMA/133 cmd 0xE048AE00 ctl 0x0 bmdma 0x0 irq 10
Jun 12 12:26:53 server ata16: SATA max UDMA/133 cmd 0xE048AE80 ctl 0x0 bmdma 0x0 irq 10
Jun 12 12:26:53 server ata13: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 12 12:26:53 server ata13.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:007f
Jun 12 12:26:53 server ata13.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 31/32)
Jun 12 12:26:53 server ata13.00: configured for UDMA/133
Jun 12 12:26:53 server scsi12 : ahci
Jun 12 12:26:53 server ata14: SATA link down (SStatus 0 SControl 300)
Jun 12 12:26:53 server scsi13 : ahci
Jun 12 12:26:54 server ata15: SATA link down (SStatus 0 SControl 300)
Jun 12 12:26:54 server scsi14 : ahci
Jun 12 12:26:54 server ata16: SATA link down (SStatus 0 SControl 300)
Jun 12 12:26:54 server scsi15 : ahci
Jun 12 12:26:54 server Vendor: ATA       Model: ST3808110AS       Rev: 3.AA
Jun 12 12:26:54 server Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 12 12:26:54 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Jun 12 12:26:54 server sda: Write Protect is off
Jun 12 12:26:54 server sda: Mode Sense: 00 3a 00 00
Jun 12 12:26:54 server SCSI device sda: drive cache: write back
Jun 12 12:26:54 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Jun 12 12:26:54 server sda: Write Protect is off
Jun 12 12:26:54 server sda: Mode Sense: 00 3a 00 00
Jun 12 12:26:54 server SCSI device sda: drive cache: write back
Jun 12 12:26:54 server sda: sda1 sda2 sda3 sda4 < sda5 >
Jun 12 12:26:54 server sd 12:0:0:0: Attached scsi disk sda
Jun 12 12:26:54 server sd 12:0:0:0: Attached scsi generic sg0 type 0
Jun 12 12:27:24 server ata13.00: qc timeout (cmd 0x2f)
Jun 12 12:27:24 server ata13: failed to read log page 10h (errno=-5)
Jun 12 12:27:24 server ata13.00: exception Emask 0x1 SAct 0xb SErr 0x0 action 0x2 frozen
Jun 12 12:27:24 server ata13.00: (irq_stat 0x40000000)
Jun 12 12:27:24 server ata13.00: tag 0 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun 12 12:27:24 server ata13.00: tag 1 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun 12 12:27:24 server ata13.00: tag 3 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun 12 12:27:24 server ata13: soft resetting port
Jun 12 12:27:24 server ata13: softreset failed (1st FIS failed)
Jun 12 12:27:24 server ata13: softreset failed, retrying in 5 secs
Jun 12 12:27:29 server ata13: hard resetting port

Remove sata-connector and then the power-connector of the Seagate drive.
(Note that I also have problems with hotplug the Maxtor-drive.
 I will post that problem later this day.)

Jun 12 12:27:37 server ata13: port is slow to respond, please be patient
Jun 12 12:28:00 server ata13: port failed to respond (30 secs)
Jun 12 12:28:00 server ata13: COMRESET failed (device not ready)
Jun 12 12:28:00 server ata13: hardreset failed, retrying in 5 secs
Jun 12 12:28:05 server ata13: hard resetting port
Jun 12 12:28:12 server ata13: port is slow to respond, please be patient
Jun 12 12:28:35 server ata13: port failed to respond (30 secs)
Jun 12 12:28:35 server ata13: COMRESET failed (device not ready)
Jun 12 12:28:35 server ata13: reset failed, giving up
Jun 12 12:28:35 server ata13.00: disabled
Jun 12 12:28:35 server ata13: EH complete
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 20836305
Jun 12 12:28:35 server printk: 971 messages suppressed.
Jun 12 12:28:35 server Buffer I/O error on device sda4, logical block 0
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 156296208
Jun 12 12:28:35 server Buffer I/O error on device sda5, logical block 135459840
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 20836296
Jun 12 12:28:35 server Buffer I/O error on device sda3, logical block 19551096
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 156296209
Jun 12 12:28:35 server Buffer I/O error on device sda5, logical block 135459841
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 20836297
Jun 12 12:28:35 server Buffer I/O error on device sda3, logical block 19551097
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 156296210
Jun 12 12:28:35 server Buffer I/O error on device sda5, logical block 135459842
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 20836298
Jun 12 12:28:35 server Buffer I/O error on device sda3, logical block 19551098
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 156296211
Jun 12 12:28:35 server Buffer I/O error on device sda5, logical block 135459843
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 20836299
Jun 12 12:28:35 server Buffer I/O error on device sda3, logical block 19551099
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 156296212
Jun 12 12:28:35 server Buffer I/O error on device sda5, logical block 135459844
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000
Jun 12 12:28:35 server end_request: I/O error, dev sda, sector 20836300
Jun 12 12:28:35 server sd 12:0:0:0: SCSI error: return code = 0x40000

...
A lot of SCSI errors...

#rmmod ahci:
Jun 12 12:29:13 server ACPI: PCI interrupt for device 0000:00:0f.0 disabled

No other commands I perform during this test.

Aalderd Bouwman.

On Fri, 2006-06-09 at 14:44 +0900, Tejun Heo wrote:
> Hello, Aalderd.
> 
> Aalderd Bouwman wrote:
> > Hello,
> > 
> > I am running Gentoo Linux on a Asus A8V-MX mainboard with the Via VT8251
> > southbridge chipset. The sata-controller is configured as AHCI.
> > Bios version is 0210.
> > 
> > The drive is working properly with the drivers of VIA.
> > 
> > A Maxtor drive works correct on this controller but this seagate drive
> > (ST3808110AS) fails on both modes (1.5Gb/s or 3.0Gb/s).
> > 
> > Here you can find the log-results after doing some actions on this
> > drive. After the sector errors the drive could not be accessed by fdisk.
> > 
> > # uname -a
> > Linux server 2.6.17-rc5-mm2 #2 Wed Jun 7 22:18:57 CEST 2006 i686 AMD
> > Opteron(tm) Processor 144 AuthenticAMD GNU/Linux
> > 
> > Kernel log:
> [--snip--]
> > Jun  8 18:52:19 server ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x2)
> 
> One spurious interrupt here and then device reports error after ~20 secs 
> which triggers libata to read log page 10h.
> 
> > Jun  8 18:53:09 server ata1.00: qc timeout (cmd 0x2f)
> > Jun  8 18:53:09 server ata1: failed to read log page 10h (errno=-5)
> 
> Which timed out here.
> 
> > Jun  8 18:53:09 server ata1.00: exception Emask 0x1 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
> > Jun  8 18:53:09 server ata1.00: (irq_stat 0x40000000)
> > Jun  8 18:53:09 server ata1.00: tag 0 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
> [--snip--]
> > Jun  8 18:53:09 server ata1.00: tag 30 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
> > Jun  8 18:53:09 server ata1: soft resetting port
> > Jun  8 18:53:09 server ata1: softreset failed (1st FIS failed)
> > Jun  8 18:53:09 server ata1: softreset failed, retrying in 5 secs
> > 
> > Jun  8 18:53:14 server ata1: hard resetting port
> > Jun  8 18:53:22 server ata1: port is slow to respond, please be patient
> > Jun  8 18:53:45 server ata1: port failed to respond (30 secs)
> > Jun  8 18:53:45 server ata1: COMRESET failed (device not ready)
> > Jun  8 18:53:45 server ata1: hardreset failed, retrying in 5 secs
> > Jun  8 18:53:50 server ata1: hard resetting port
> > Jun  8 18:53:57 server ata1: port is slow to respond, please be patient
> > 
> > Jun  8 18:54:20 server ata1: port failed to respond (30 secs)
> > Jun  8 18:54:20 server ata1: COMRESET failed (device not ready)
> > Jun  8 18:54:20 server ata1: reset failed, giving up
> > Jun  8 18:54:20 server ata1.00: disabled
> > Jun  8 18:54:20 server ata1: EH complete
> 
> And the drive and/or port is completely deaf.
> 
> Can you please unplug power to the drive and replug it while EH is in 
> progress, umm.. say during the first hardreset?
> 

