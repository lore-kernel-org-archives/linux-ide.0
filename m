From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [git pull] IDE fixes
Date: Sun, 07 Jun 2009 20:39:45 +0000
Message-ID: <1244407185.8262.178.camel@mulgrave.site>
References: <200906071444.33047.bzolnier@gmail.com>
	 <200906071744.23629.bzolnier@gmail.com>
	 <1244390889.8262.47.camel@mulgrave.site>
	 <200906071947.19723.bzolnier@gmail.com>
	 <1244401729.8262.102.camel@mulgrave.site>
	 <20090607210701.78103188@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51246 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754554AbZFGUjq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 16:39:46 -0400
In-Reply-To: <20090607210701.78103188@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2009-06-07 at 21:07 +0100, Alan Cox wrote:
> > > [ I also tried to encourage libata developers to look into making the needed
> > >   libata changes (see my initial posting of HPA patches) and I will still be
> > >   glad to help with libata patches if somebody would like to work on them
> > >   (Robert? Tejun?). ]
> > 
> > OK, so back off on the 2.6.30-rc7 release of this and I'll undertake to
> > get libata engaged for integrating this into both subsystems for
> > 2.6.31 ... does that sound fair?
> 
> libata already is, and I've been following and reviewing the patches. The
> problem remaining is basically that this is not the time to merge
> it.

Actually, I was talking about the fallback to disabling heuristic which
this patch set introduces, and which would fix bug 13365 if it were
applied to libata, but which is the bit I think needs some testing.

> It will probably also be worth looking at the way the CD driver plays
> fast and loose with capacity when handling CD-R devices as a follow on
> from this stuff.

James


