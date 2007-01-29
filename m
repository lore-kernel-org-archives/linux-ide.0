From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Sun, 28 Jan 2007 23:04:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
 <1170051963.6454.7.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:52122 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933181AbXA2HOu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 02:14:50 -0500
In-Reply-To: <1170051963.6454.7.camel@Homer.simpson.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Cc: Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, Mike Christie <michaelc@cs.wisc.edu>, James Bottomley <James.Bottomley@SteelEye.com>



[ Added Jeff, Jens and Mike Christie to Cc. I would _guess_ this is 
  associated with the "larger block pc request" stuff: Mike, Jens? James B 
  added for good luck.

  It apparently started happening somewhere between 2.6.19 and 2.6.20-rc2, 
  and doing a

	gitk v2.6.19..v2.6.20-rc2 block/scsi_ioctl.c drivers/ide/

  I don't see anything else that really looks all that suspicious.. Unless 
  maybe it's that "Fix SG_IO leak". Jeff added because of the hddtemp 
  issue, but I think that was effectively SATA-only, so probably isn't 
  relevant.

  Damn, I just realized that Jens is in the middle of his vacation for a 
  week..

  Mike, can you please look at this and check? ]

On Mon, 29 Jan 2007, Mike Galbraith wrote:
> 
> FWIW, I just tried it with 2.6.20-rc6, and can confirm.  Once nero is
> run, the kernel never gives up retrying whatever command failed, so I
> get...
> 
> [ 4362.972995] hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [ 4362.981475] ide: failed opcode was: unknown
> [ 4362.986183] hdd: drive not ready for command

Ok, I tried the demo version you can download at

	http://www.nero.com/eng/nerolinux-prog.html

and yes, nerolinux seems broken. I've never used it before, but it 
triggers:

	hda: irq timeout: status=0xc0 { Busy }
	ide: failed opcode was: unknown

and after that there is indeed an endless stream of:

	hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
	ide: failed opcode was: unknown
	hda: drive not ready for command

Which eventially switches to

	hda: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
	hda: status error: error=0x40 { LastFailedSense=0x04 }
	ide: failed opcode was: unknown
	hda: drive not ready for command

However, it appears to be rather hard to debug, with nerolinux being some 
closed black box. Does anybody who knows nero know if there is some way to 
get debug information out of it to see what it tried to do?

Can somebody try to bisect this?

		Linus
