From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression] 2.6.28-rc1 (2fca5c): libata: kernel cant boot (was: Re: 2.6.27-rc1 (2fca5c): libata: kernel cant boot)
Date: Fri, 24 Oct 2008 09:38:53 +0200
Message-ID: <200810240938.54167.rjw@sisk.pl>
References: <a4423d670810240004t2d7c3bdah2bea77a6a49bb7c4@mail.gmail.com> <20081024070955.GN22217@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42763 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbYJXHeZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 03:34:25 -0400
In-Reply-To: <20081024070955.GN22217@kernel.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alexander Beregalov <a.beregalov@gmail.com>, tj@kernel.org, torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Friday, 24 of October 2008, Jens Axboe wrote:
> On Fri, Oct 24 2008, Alexander Beregalov wrote:
> > Hi
> > 
> > commit 2fca5ccf97d2c28bcfce44f5b07d85e74e3cd18e
> > Author: Jens Axboe <jens.axboe@oracle.com>
> > Date:   Wed Oct 22 09:34:49 2008 +0200
> > 
> >     libata: switch to using block layer tagging support
> > 
> > 
> > This kernel can not read even 0 sector on disk with rootfs. It
> > initialized disk, but cant read it at all.
> >  CMD646 on Sparc
> > 
> > Rverting helped.

Confirmed on hp nx6325 w/ pata_atiixp (apparently, SCSI commands time out).

Reverting the commit also helps here.

[I guess it's going to break things left and right.]

> Doh, how annoying! What driver does that controller use? PATA doesn't
> even use NCQ, so it's a bit of an oddity that it makes a difference at
> all.
> 
> Can you provide the boot messages?

If I'm able to reproduce the breakage of Asus L5D, I will.

Thanks,
Rafael
