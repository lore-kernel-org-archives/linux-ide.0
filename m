From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 18:20:15 +0100
Message-ID: <1138296016.9413.72.camel@localhost>
References: <20060126055050.GA4737@htj.dyndns.org>
	 <43D8FBBD.6070205@dgreaves.com>  <43D8FF9A.4020805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:47082 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932360AbWAZRUq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jan 2006 12:20:46 -0500
Received: from fortknox (localhost [127.0.0.1])
	by prosun.first.fraunhofer.de (8.12.10/8.12.10) with ESMTP id k0QHKgTI019508
	for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 18:20:42 +0100 (MET)
In-Reply-To: <43D8FF9A.4020805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>, Nicolas.Mailhot@LaPoste.net, Jens Axboe <axboe@suse.de>, Linux-ide <linux-ide@vger.kernel.org>, Christopher Smith <csmith@nighthawkrad.net>, Erik Slagter <erik@slagter.name>, hahn@physics.mcmaster.ca, mlaks@verizon.net, mlaks@verizononline.net

On Thu, 2006-01-26 at 11:58 -0500, Jeff Garzik wrote:
> David Greaves wrote:
> > Have a look for subjects such as
> >   Problems with multiple Promise SATA150 TX4 cards
> 
> This is almost certainly either a power or PCI bus/slot issue.

So you mean the freeze I am observing when I copy files from the sata
disk to some
ieee1394 device (they are sharing interrupt 16)

 16:     430796   IO-APIC-level  ide2, ide3, libata, ohci1394

leading to lots of output as...

ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x0c { DriveStatusError }

could be a cause of just that ?

> >   Possible libata/sata/Asus problem (was Re: Need to upgrade to latest
> > stable mdadm version?)
> 
> Highly likely to be a motherboard/BIOS issue related to properly tuning 
> and timing the hardware.
> 
> HOWEVER, libata can help (via Tejun's recent patches) by properly 
> handling the error when throw to us by hardware.

So it could help in the first case but also with this: I can freeze the
system bei hdparm -y /dev/sda ... will this patch also help in that
case ?

Soeren.
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

