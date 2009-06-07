From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 22:42:37 +0200
Message-ID: <200906072242.38021.bzolnier@gmail.com>
References: <200906071444.33047.bzolnier@gmail.com> <1244401729.8262.102.camel@mulgrave.site> <20090607210701.78103188@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755284AbZFGUiA@vger.kernel.org>
In-Reply-To: <20090607210701.78103188@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sunday 07 June 2009 22:07:01 Alan Cox wrote:
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

In ide's case the situation is a bit different:

This is a bug fix.  Not an obvious one but it will help anyone installing
a new distribution/kernel using ide on machine with HPA, as it will allow
this user for streamline transition to a distribution/kernel using libata
later if needed (even though I don't recommend it :).

I just want a fair treatment.  I'm not posting crap -rc pull request so
I see no reason why I have to pay for other maintainers mistakes.

This was better tested and reviewed that some other changes that got in
after 2.6.30-rc8 (and is smaller than at least one other pull request
that got in).

I even admitted in the pull request that this may be too late but based on
my technical judgment (strongly backed by on reviews from you and Sergei)
I considered those changes to be on the edge...

It is not a *must*have* for 2.6.30 but still 2.6.30 *shall*have* it.

> It will probably also be worth looking at the way the CD driver plays
> fast and loose with capacity when handling CD-R devices as a follow on
> from this stuff.

Sure and it would be easier to look into this (and libata changes) with
partitions/ide changes in.
