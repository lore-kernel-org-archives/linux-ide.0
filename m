From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 12:58:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
 <1170051963.6454.7.camel@Homer.simpson.net>
 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
 <45BE5AF0.3030005@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:56723 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbXA2VJI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 16:09:08 -0500
In-Reply-To: <45BE5AF0.3030005@cs.wisc.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>



On Mon, 29 Jan 2007, Mike Christie wrote:
> 
> What chipsets are you guys using?

I can see it with a 

	00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 02)
	00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controller IDE (rev 02)

where the disk is on the SATA side, and the DVD writer is PATA using 
ide_piix.

> I tried 2.6.20-rc6, and forced my cdrom to be used by the ide piix
> driver instead of the sata one, so the device shows up as hda instead of
> a scsi one. And, if I use the ide piix driver for the cdrom then it
> works fine. I see IO going through the block layer sg io code which was
> modified in 2.6.20 to support larger IOs.

That doesn't sound very different from my setup.. I wonder why it works 
for you.

That said, I'm making progress with my bisection. "16 revisions left to 
test after this", and three of those sixteen are

	Remove unnecessary blk_queue_bounce in SG_IO
	fix SG_IO bio leak
	remove blk_queue_activity_fn

but I'll do the bisection 'til the bitter end, in case I get into a 
similar nonsense value that the other Mike got into.

		Linus
