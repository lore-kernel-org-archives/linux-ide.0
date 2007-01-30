From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 23:14:29 -0500
Message-ID: <45BEC625.9010400@pobox.com>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>  <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net> <1170051963.6454.7.camel@Homer.simpson.net> <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org> <45BE5AF0.3030005@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42717 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965125AbXA3EPA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 23:15:00 -0500
In-Reply-To: <45BE5AF0.3030005@cs.wisc.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, Tejun Heo <htejun@gmail.com>

Mike Christie wrote:
> Strangely, if I use the sata driver, then nero uses the sg driver
> (drivers/scsi/sg.c) instead of the block layer sg io code. But the sata
> code spits out:
> 
> Jan 29 12:03:21 madmax kernel: ata1.00: ATAPI check failed
> Jan 29 12:03:21 madmax kernel: ata1.00: exception Emask 0x0 SAct 0x0
> SErr 0x0 action 0x2 frozen
> Jan 29 12:03:21 madmax kernel: ata1.00: cmd
> a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0xac data 808 in
> Jan 29 12:03:21 madmax kernel:          res
> 51/51:03:00:00:20/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
> Jan 29 12:03:21 madmax kernel: ata1: soft resetting port
> Jan 29 12:03:21 madmax kernel: ATA: abnormal status 0xD0 on port 0x1F7
> Jan 29 12:03:21 madmax kernel: ata1.00: failed to IDENTIFY (I/O error,
> err_mask=0x2)
> Jan 29 12:03:21 madmax kernel: ata1.00: revalidation failed (errno=-5)

-5 == EIO


> Jan 29 12:03:21 madmax kernel: ata1: failed to recover some devices,
> retrying in 5 secs
> Jan 29 12:03:33 madmax kernel: ata1: port is slow to respond, please be
> patient (Status 0xd0)
> Jan 29 12:03:56 madmax kernel: ata1: port failed to respond (30 secs,
> Status 0xd0)
> Jan 29 12:03:56 madmax kernel: ata1: soft resetting port
> Jan 29 12:03:57 madmax kernel: ata1.00: configured for PIO4
> Jan 29 12:03:57 madmax kernel: ata1: EH complete


It's not critical for 2.6.20, since the default recommendation for PATA 
is still "use drivers/ide", but Alan Cox (and Tejun and me) should be 
aware of cases where drivers/ide works but libata does not.

So, if you could post some machine and .config info regarding this to 
linux-ide (CC'ing Alan), that would be appreciated.

	Jeff


