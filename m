From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: 2.6.27-rc1 (2fca5c): libata: kernel cant boot
Date: Fri, 24 Oct 2008 16:16:08 +0900
Message-ID: <20081024071608.GA3879@linux-sh.org>
References: <a4423d670810240004t2d7c3bdah2bea77a6a49bb7c4@mail.gmail.com> <20081024070955.GN22217@kernel.dk> <20081024071329.GO22217@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:34848 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751483AbYJXHQt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 03:16:49 -0400
Content-Disposition: inline
In-Reply-To: <20081024071329.GO22217@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alexander Beregalov <a.beregalov@gmail.com>, tj@kernel.org, torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Fri, Oct 24, 2008 at 09:13:29AM +0200, Jens Axboe wrote:
> On Fri, Oct 24 2008, Jens Axboe wrote:
> > On Fri, Oct 24 2008, Alexander Beregalov wrote:
> > > Hi
> > > 
> > > commit 2fca5ccf97d2c28bcfce44f5b07d85e74e3cd18e
> > > Author: Jens Axboe <jens.axboe@oracle.com>
> > > Date:   Wed Oct 22 09:34:49 2008 +0200
> > > 
> > >     libata: switch to using block layer tagging support
> > > 
> > > 
> > > This kernel can not read even 0 sector on disk with rootfs. It
> > > initialized disk, but cant read it at all.
> > >  CMD646 on Sparc
> > > 
> > > Rverting helped.
> > 
> > Doh, how annoying! What driver does that controller use? PATA doesn't
> > even use NCQ, so it's a bit of an oddity that it makes a difference at
> > all.
> > 
> > Can you provide the boot messages?
> 
> Darn, this smells like a train wreck. I'm assuming this fixes it?
> 
Yes, that fixes it.
