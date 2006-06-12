From: Aalderd Bouwman <aalderd.boac@wanadoo.nl>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 using
	ahci	module
Date: Mon, 12 Jun 2006 13:24:16 +0200
Message-ID: <1150111457.4060.2.camel@anja>
References: <1149787827.4180.8.camel@anja>  <44890ACA.5070504@gmail.com>
	 <1150108974.4020.3.camel@anja>  <448D474E.6020706@gmail.com>
Reply-To: aalderd.boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp04.wanadoo.nl ([194.134.35.144]:12854 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S1751877AbWFLLWO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 07:22:14 -0400
In-Reply-To: <448D474E.6020706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun,

#modprobe ahci:
Jun 12 13:13:25 server ahci 0000:00:0f.0: version 1.3
Jun 12 13:13:25 server ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Jun 12 13:13:32 server ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
Jun 12 13:13:32 server ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jun 12 13:13:32 server ata17: SATA max UDMA/133 cmd 0xE048AD00 ctl 0x0 bmdma 0x0 irq 10
Jun 12 13:13:32 server ata18: SATA max UDMA/133 cmd 0xE048AD80 ctl 0x0 bmdma 0x0 irq 10
Jun 12 13:13:32 server ata19: SATA max UDMA/133 cmd 0xE048AE00 ctl 0x0 bmdma 0x0 irq 10
Jun 12 13:13:32 server ata20: SATA max UDMA/133 cmd 0xE048AE80 ctl 0x0 bmdma 0x0 irq 10
Jun 12 13:13:33 server ata17: SATA link down (SStatus 0 SControl 300)
Jun 12 13:13:33 server scsi16 : ahci
Jun 12 13:13:33 server ata18: SATA link down (SStatus 0 SControl 300)
Jun 12 13:13:33 server scsi17 : ahci
Jun 12 13:13:33 server ata19: SATA link down (SStatus 0 SControl 300)
Jun 12 13:13:33 server scsi18 : ahci
Jun 12 13:13:33 server ata20: SATA link down (SStatus 0 SControl 300)
Jun 12 13:13:33 server scsi19 : ahci

Turning on sata-drive:
Jun 12 13:13:38 server ata18: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
Jun 12 13:13:38 server ata18: (irq_stat 0x00000040, connection status changed)
Jun 12 13:13:38 server ata18: soft resetting port
Jun 12 13:13:38 server ata18: SATA link down (SStatus 1 SControl 300)
Jun 12 13:13:38 server ata18: EH complete
Jun 12 13:13:38 server ata18: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
Jun 12 13:13:38 server ata18: (irq_stat 0x00000040, connection status changed)
Jun 12 13:13:38 server ata18: soft resetting port
Jun 12 13:13:38 server ata18: SATA link down (SStatus 1 SControl 300)
Jun 12 13:13:38 server ata18: EH complete

Turing off sata-drive:
no messages

Turning on sata-drive:
Jun 12 13:13:58 server ata18: exception Emask 0x10 SAct 0x0 SErr 0x4070000 action 0x2 frozen
Jun 12 13:13:58 server ata18: (irq_stat 0x04400040, connection status changed)
Jun 12 13:13:58 server ata18: soft resetting port
Jun 12 13:13:58 server ata18: SATA link down (SStatus 1 SControl 300)
Jun 12 13:13:58 server ata18: EH complete

Turning off sata-drive:
no messages

Turning on sata-drive:
Jun 12 13:14:13 server ata18: exception Emask 0x10 SAct 0x0 SErr 0x40f0000 action 0x2 frozen
Jun 12 13:14:13 server ata18: (irq_stat 0x04400040, connection status changed)
Jun 12 13:14:13 server ata18: soft resetting port
Jun 12 13:14:13 server ata18: SATA link down (SStatus 1 SControl 300)
Jun 12 13:14:13 server ata18: EH complete

Turning off sata-drive:
no messages

#rmmod ahci:
Jun 12 13:14:23 server ACPI: PCI interrupt for device 0000:00:0f.0 disabled

Loading the ahci-driver while the drive is turned on, the drive is working properly.
I have copied a lot of data to/from this drive and compared this data to the orginal with diff.

Aalderd Bouwman.

On Mon, 2006-06-12 at 19:51 +0900, Tejun Heo wrote:
> Aalderd Bouwman wrote:
> > Jun 12 12:27:24 server ata13.00: (irq_stat 0x40000000)
> > Jun 12 12:27:24 server ata13.00: tag 0 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
> > Jun 12 12:27:24 server ata13.00: tag 1 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
> > Jun 12 12:27:24 server ata13.00: tag 3 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
> > Jun 12 12:27:24 server ata13: soft resetting port
> > Jun 12 12:27:24 server ata13: softreset failed (1st FIS failed)
> > Jun 12 12:27:24 server ata13: softreset failed, retrying in 5 secs
> > Jun 12 12:27:29 server ata13: hard resetting port
> > 
> > Remove sata-connector and then the power-connector of the Seagate drive.
> > (Note that I also have problems with hotplug the Maxtor-drive.
> >  I will post that problem later this day.)
> 
> Can you remove and then replug those?  I wanna see whether the 
> controller is locked up or the drive.
> 

