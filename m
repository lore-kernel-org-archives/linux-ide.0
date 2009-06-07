From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 23:08:13 +0200
Message-ID: <200906072308.13913.bzolnier@gmail.com>
References: <200906071444.33047.bzolnier@gmail.com> <20090607210701.78103188@lxorguk.ukuu.org.uk> <1244407185.8262.178.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:46303 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbZFGVD1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 17:03:27 -0400
In-Reply-To: <1244407185.8262.178.camel@mulgrave.site>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 07 June 2009 22:39:45 James Bottomley wrote:
> On Sun, 2009-06-07 at 21:07 +0100, Alan Cox wrote:
> > > > [ I also tried to encourage libata developers to look into making the needed
> > > >   libata changes (see my initial posting of HPA patches) and I will still be
> > > >   glad to help with libata patches if somebody would like to work on them
> > > >   (Robert? Tejun?). ]
> > > 
> > > OK, so back off on the 2.6.30-rc7 release of this and I'll undertake to
> > > get libata engaged for integrating this into both subsystems for
> > > 2.6.31 ... does that sound fair?
> > 
> > libata already is, and I've been following and reviewing the patches. The
> > problem remaining is basically that this is not the time to merge
> > it.
> 
> Actually, I was talking about the fallback to disabling heuristic which
> this patch set introduces, and which would fix bug 13365 if it were
> applied to libata, but which is the bit I think needs some testing.

My patches fix the root cause of the problem and alleviate the issue for
all new installations.  In libata's case more testing is needed because
the libata's default is to keep HPA enabled (which is proper for modern
systems).

Once you get all HPA details (it is a complicated mess -- that is why
kernel/distributions couldn't get it right for years) you will see the
overall picture of the problem -- the work on multiple fronts at once
(including user-space) is needed to fix it properly.
