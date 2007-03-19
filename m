From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Errors with AHCI and 10K Raptor drive
Date: Mon, 19 Mar 2007 11:01:37 -0400
Message-ID: <45FEA5D1.20101@pobox.com>
References: <20070319075321.444c241e@freebird>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53115 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932306AbXCSPBl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 11:01:41 -0400
In-Reply-To: <20070319075321.444c241e@freebird>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: linux-ide@vger.kernel.org

Stephen Hemminger wrote:
> This is a new drive, so I suspect some driver incompatibility between the
> driver (AHCI) and the hard drive (WD Raptor 10K 74G).

Driver incompatibilities between the driver (LLDD or libata-core) and a 
hard drive are extremely rare.

The most common problem on modern SATA drives is drive firmware bugs, at 
the moment.


> [  841.645699] ata1.00: exception Emask 0x10 SAct 0x2 SErr 0x400100 action 0x2 frozen
> [  841.645708] ata1.00: (irq_stat 0x08000000, interface fatal error)
> [  841.645719] ata1.00: cmd 61/00:08:17:31:f1/04:00:03:00:00/40 tag 1 cdb 0x0 data 524288 out
> [  841.645721]          res 40/00:18:5f:fa:b9/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
> [  841.947855] ata1: soft resetting port
> [  842.447515] ata1: softreset failed (1st FIS failed)
> [  842.447526] ata1: softreset failed, retrying in 5 secs
> [  847.445028] ata1: hard resetting port
> [  854.938851] ata1: port is slow to respond, please be patient (Status 0x80)
> [  877.923808] ata1: port failed to respond (30 secs, Status 0x80)
> [  877.923816] ata1: COMRESET failed (device not ready)
> [  877.923822] ata1: hardreset failed, retrying in 5 secs
> [  882.921328] ata1: hard resetting port
> [  883.377028] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  883.391971] ata1.00: configured for UDMA/133
> [  883.391992] ata1: EH complete
> [  883.392186] SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
> [  883.392381] sda: Write Protect is off
> [  883.392387] sda: Mode Sense: 00 3a 00 00
> [  883.392594] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [  970.422983] ata1.00: exception Emask 0x10 SAct 0x7 SErr 0x400100 action 0x2 frozen
> [  970.422993] ata1.00: (irq_stat 0x08000000, interface fatal error)
> [  970.423005] ata1.00: cmd 61/a8:00:0f:1d:cb/02:00:01:00:00/40 tag 0 cdb 0x0 data 348160 out
> [  970.423008]          res 40/00:08:bf:24:cb/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
> [  970.423018] ata1.00: cmd 61/a8:08:bf:24:cb/00:00:01:00:00/40 tag 1 cdb 0x0 data 86016 out
> [  970.423021]          res 40/00:08:bf:24:cb/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
> [  970.423031] ata1.00: cmd 61/08:10:97:41:c5/00:00:03:00:00/40 tag 2 cdb 0x0 data 4096 out
> [  970.423034]          res 40/00:08:bf:24:cb/00:00:01:00:00/40 Emask 0x10 (ATA bus error)

The PHY is crapping itself.  The port headers may be damaged on the 
drive or motherboard, or (most likely) you need a new cable.  SATA 
cables in particular are known to be lame.

Try different ports and cables.

You can also see what happens if you disable NCQ 
(http://linux-ata.org/faq.html#ncq).  Though given the interface errors, 
if disabling NCQ solves problems, it /may/ just be that you slowed 
things down enough to work, not that the drive firmware is bad.

	Jeff


