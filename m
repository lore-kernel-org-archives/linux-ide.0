From: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Mon, 12 Jul 2004 13:52:30 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40F2CFDE.66D28904@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out004pub.verizon.net ([206.46.170.142]:6629 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S266903AbUGLRwI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jul 2004 13:52:08 -0400
Received: from M2Dual.localdomain ([4.15.37.40]) by out004.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20040712175207.OEYK1551.out004.verizon.net@M2Dual.localdomain>
          for <linux-ide@vger.kernel.org>; Mon, 12 Jul 2004 12:52:07 -0500
Received: from verizon.net ([10.0.0.10])
	by M2Dual.localdomain (8.12.8/8.12.8) with ESMTP id i6CHq6lo016951
	for <linux-ide@vger.kernel.org>; Mon, 12 Jul 2004 13:52:07 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 
> On Monday 12 of July 2004 17:15, Max T. Woodbury wrote:
> > PIIXa: IDE controller at PCI slot 00:01.0
> > PIIXa: chipset revision 2
> > PIIXa: not 100% native mode: will probe irqs later
> > PIIXa: neither IDE port enabled (BIOS)
> 
> Do you have IDE ports disabled in BIOS?
> 
> This prevents piix IDE driver from working and instead you are using
> generic IDE driver which is much slower (no DMA!) and may be unsafe.
> 
> Bartlomiej

The Thinkpad 760 BIOS setup does not make this easy.  It's this pretty
GUI thingy with a humming bird for a cursor and practically no text
anywhere.  Very international.  There's a more comprehensive control
program under 'doz.  I'll try to find something on the thinkpad lists...
I don't remember seeing anything in the user docs on this.

Still, why would PIO mode be unsafe?  (I can see slower, but I don't
expect speed from this beast.  Oh well.  Thanks for the pointer.)

Hmm.  Going to DMA would almost certainly make the symptoms disappear
because the I/O timing would change and whatever was screwing up the
I/O would happen at a non-critical point.  Much like the fact that I
could get the symptoms to disappear by by putting a computational load
on the machine.  It would NOT actually solve the underlying problem,
whatever that problem really is.

Max
