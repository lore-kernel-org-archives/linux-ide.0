From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: kernel BUG at ide-cd.c:1726 in 2.6.24-03863-g0ba6c33 && -g8561b089
Date: Fri, 1 Feb 2008 22:59:20 +0100
Message-ID: <200802012259.21037.bzolnier@gmail.com>
References: <20080129.151353.48534987.k-ueda@ct.jp.nec.com> <20080131145341.GA32687@paradigm.rfc822.org> <20080131150418.GD15220@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:48010 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756886AbYBAWhK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 17:37:10 -0500
Received: by wa-out-1112.google.com with SMTP id v27so945366wah.23
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 14:37:10 -0800 (PST)
In-Reply-To: <20080131150418.GD15220@kernel.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Florian Lohoff <flo@rfc822.org>, Nai Xia <nai.xia@gmail.com>, Roland Dreier <rdreier@cisco.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, bbpetkov@yahoo.de, linux-kernel@vger.kernel.org, j-nomura@ce.jp.nec.com, linux-ide@vger.kernel.org

On Thursday 31 January 2008, Jens Axboe wrote:
> On Thu, Jan 31 2008, Florian Lohoff wrote:
> > On Thu, Jan 31, 2008 at 02:05:58PM +0100, Jens Axboe wrote:
> > > The below fix should be enough. It's perfectly legal to have leftover
> > > byte counts when the drive signals completion, happens all the time for
> > > eg user issued commands where you don't know an exact byte count.
> > > 
> > > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > > index 74c6087..bee05a3 100644
> > > --- a/drivers/ide/ide-cd.c
> > > +++ b/drivers/ide/ide-cd.c
> > > @@ -1722,7 +1722,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
> > >  	 */
> > >  	if ((stat & DRQ_STAT) == 0) {
> > >  		spin_lock_irqsave(&ide_lock, flags);
> > > -		if (__blk_end_request(rq, 0, 0))
> > > +		if (__blk_end_request(rq, 0, rq->data_len))
> > >  			BUG();
> > >  		HWGROUP(drive)->rq = NULL;
> > >  		spin_unlock_irqrestore(&ide_lock, flags);
> > > 
> > 
> > Fixes the crash on boot for me ...
> 
> Great, thanks for confirming that. I'll make sure the patch goes
> upstream today, if Linus is available.

Thanks Jens.
