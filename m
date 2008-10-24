From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [Regression] 2.6.28-rc1 (2fca5c): libata: kernel cant boot (was: Re: 2.6.27-rc1 (2fca5c): libata: kernel cant boot)
Date: Fri, 24 Oct 2008 10:16:27 +0200
Message-ID: <20081024081626.GZ22217@kernel.dk>
References: <a4423d670810240004t2d7c3bdah2bea77a6a49bb7c4@mail.gmail.com> <200810240938.54167.rjw@sisk.pl> <20081024073458.GQ22217@kernel.dk> <200810241018.53645.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:54851 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbYJXIR1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 04:17:27 -0400
Content-Disposition: inline
In-Reply-To: <200810241018.53645.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexander Beregalov <a.beregalov@gmail.com>, tj@kernel.org, torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Fri, Oct 24 2008, Rafael J. Wysocki wrote:
> On Friday, 24 of October 2008, Jens Axboe wrote:
> > On Fri, Oct 24 2008, Rafael J. Wysocki wrote:
> > > On Friday, 24 of October 2008, Jens Axboe wrote:
> > > > On Fri, Oct 24 2008, Alexander Beregalov wrote:
> > > > > Hi
> > > > > 
> > > > > commit 2fca5ccf97d2c28bcfce44f5b07d85e74e3cd18e
> > > > > Author: Jens Axboe <jens.axboe@oracle.com>
> > > > > Date:   Wed Oct 22 09:34:49 2008 +0200
> > > > > 
> > > > >     libata: switch to using block layer tagging support
> > > > > 
> > > > > 
> > > > > This kernel can not read even 0 sector on disk with rootfs. It
> > > > > initialized disk, but cant read it at all.
> > > > >  CMD646 on Sparc
> > > > > 
> > > > > Rverting helped.
> > > 
> > > Confirmed on hp nx6325 w/ pata_atiixp (apparently, SCSI commands time out).
> > 
> > Basically it'll dererence ->qcmd[] with -1 index so it'll break in
> > various interesting ways, I'm sure.
> > 
> > > Reverting the commit also helps here.
> > > 
> > > [I guess it's going to break things left and right.]
> > 
> > Indeed.
> > 
> > > > Doh, how annoying! What driver does that controller use? PATA doesn't
> > > > even use NCQ, so it's a bit of an oddity that it makes a difference at
> > > > all.
> > > > 
> > > > Can you provide the boot messages?
> > > 
> > > If I'm able to reproduce the breakage of Asus L5D, I will.
> > 
> > I don't need that anymore, I realized the mistake right after sending
> > that.
> 
> The fix you posted helps here too. :-)

Good, please boot your regression time machine and get it committed
before -rc1 was released :-)

-- 
Jens Axboe

