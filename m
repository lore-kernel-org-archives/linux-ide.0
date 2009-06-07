From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 21:25:40 +0200
Message-ID: <200906072125.40784.bzolnier@gmail.com>
References: <200906071444.33047.bzolnier@gmail.com> <200906072100.10649.bzolnier@gmail.com> <84144f020906071209m51e5fd15jaa67f9143ab1d126@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:58411 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbZFGTUt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 15:20:49 -0400
In-Reply-To: <84144f020906071209m51e5fd15jaa67f9143ab1d126@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 07 June 2009 21:09:47 Pekka Enberg wrote:
> Hi Bartlomiej,
> 
> On Sun, Jun 7, 2009 at 10:00 PM, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> >> > My honest opinion is that it is as appropriate now as it will be 2.6.31.
> >> >
> >> > [ I'm still amazed by the amount of *completely* bogus reasons given for
> >> >  not merging it. ]
> >>
> >> I don't consider this a bogus reason at all:
> >>
> >>  10 files changed, 134 insertions(+), 43 deletions(-)
> >
> > Since when do we validate code quality based solely on LOC changed? :)
> 
> Since when we entered -rc8 (or even earlier).

To be perfectly clear on this:

* all patches were posted a week ago to the list (they replaced patches
  from two weeks ago -- which were intended for -rc8 but thanks to feedback
  I found a better way to do it).

> On Sun, Jun 7, 2009 at 10:00 PM, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> > I'm yet to see anybody posting a single code chunk in this whole discussion.
> 
> That's because I am not objecting to the code. I am objecting to the
> fact that you're submitting something as big as this so late in the
> release cycle and the fact that it's not a clear-cut bug fix.

That is a valid objection in contrast to some other ones.

Still, changes are really *safe*:

* fs/partitions/check.c change is straight-forward
  (doesn't affect anything besides ide-gd)

* ide-gd changes are making it similar in HPA behavior to libata
  (which is what most distributions are shipping)
