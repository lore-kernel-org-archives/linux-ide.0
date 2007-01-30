From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Tue, 30 Jan 2007 05:00:06 +0100
Message-ID: <1170129606.6679.5.camel@Homer.simpson.net>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	 <20070127174230.GN6017@stusta.de> <20070128133344.214070@gmx.net>
	 <1170051963.6454.7.camel@Homer.simpson.net>
	 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
	 <45BE5AF0.3030005@cs.wisc.edu>
	 <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0701291453230.3611@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0701291532050.3611@woody.linux-foundation.org>
	 <45BE864A.2050907@cs.wisc.edu>
	 <Pine.LNX.4.64.0701291614020.3611@woody.linux-foundation.org>
	 <45BE9774.20105@cs.wisc.edu> <45BE99A4.9080503@cs.wisc.edu>
	 <Pine.LNX.4.64.0701291736550.3611@woody.linux-foundation.org>
	 <45BEB292.7060008@cs.wisc.edu>  <20070129190847.6ef1191f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37989 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965021AbXA3EAR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 23:00:17 -0500
In-Reply-To: <20070129190847.6ef1191f.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Christie <michaelc@cs.wisc.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>

On Mon, 2007-01-29 at 19:08 -0800, Andrew Morton wrote:
> On Mon, 29 Jan 2007 20:50:58 -0600
> Mike Christie <michaelc@cs.wisc.edu> wrote:
> 
> > With the attached patch, nero finds the cd drives and I can burn disks.
> > There is no errors from the ide layer like before.
> > 
> > 
> > [use-old-timeout-calc.patch  text/x-patch (399B)]
> > diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> > index 2528a0c..aded9a0 100644
> > --- a/block/scsi_ioctl.c
> > +++ b/block/scsi_ioctl.c
> > @@ -271,7 +271,7 @@ static int sg_io(struct file *file, requ
> >  
> >  	rq->cmd_type = REQ_TYPE_BLOCK_PC;
> >  
> > -	rq->timeout = jiffies_to_msecs(hdr->timeout);
> > +	rq->timeout = (hdr->timeout * HZ) / 1000;
> 
> Yes, that was a buggy conversion - it should have been msecs_to_jiffies().

Confirmed.  With that line changed to msecs_to_jiffies()in 2.6.20-rc6,
nero is a happy camper.  Burner selected, disk burned, no whimpering.

	-Mike

