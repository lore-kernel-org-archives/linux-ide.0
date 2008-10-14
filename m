From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Porting old hardware from ide to libata (was [PATCH 0/7] ide: locking improvements)
Date: Tue, 14 Oct 2008 04:11:34 +0200
Message-ID: <200810140411.34912.bzolnier@gmail.com>
References: <678468.92529.qm@web57414.mail.re1.yahoo.com> <200810132345.51836.bzolnier@gmail.com> <20081013234648.41cfca48@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:5018 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbYJNCPI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 22:15:08 -0400
Received: by nf-out-0910.google.com with SMTP id d3so859469nfc.21
        for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 19:15:06 -0700 (PDT)
In-Reply-To: <20081013234648.41cfca48@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stan.cunningham@yahoo.com, linux-ide@vger.kernel.org

On Tuesday 14 October 2008, Alan Cox wrote:
> O> You may want to dig into archives and learn about history of libata.
> > Especially under what conditions it has been ACK-ed and merged _five_
> > years ago.  Just to quickly recall, there were two such conditions:
> > 
> > * PATA support would be moved from IDE to libata in an evolutionary way.
> 
> IDE stood stale for a year while you vanished (to CERN ?) so the rest of

The real issue is that some corporate people are taking things for granted
so when the pace slowed down (after I "vanished", which was a known fact,
and had a less of my time than before to work on IDE) they started pushing
more pressure on me instead of considering constructive solutions, i.e.
it is not like I ever got an offer from somebody else to take over the code
or to help with the code etc.

[ It is also worth to notice that I never promised to be the one doing
  all the IDE -> libata work so if somebody thought otherwise it was only
  his unrealistic expectation (especially given timescale and the fact
  that because of 2.5.x IDE revert, early 2.4.x -> 2.6.x IDE stabilization
  required a lot work). ]

Yes, the code "stood stale" but only after flamewar + libata PATA + kick
from some fellow maintainers (well, I learned that the outcome of the game
has already been decided months ago and thought that me vs Red Hat was a
lost cause + also that I was a real idiot from the start :-).

[ "stood stale" is not completely correct since the patches were
  being (slowly) reviewed and Andrew has been pushing them upstream ]

> the world decided to get on with it. As it happens an evolutionary change
> would have made no sense as the mentality of the code is [thankfully]

It is not like there wasn't a sane roadmap, TODOs, repeated descriptions
of needed tasks, just nobody from corporate Linux world was interested in
doing any real work (except Tejun).  This wasn't so bad in itself because
I would still be able to handle most of it.  The real problem was that
I was forwarded unprocessed bugreports or half-baked patches and actually
expected/pressed to also handle all that at the same time.  While there
were absolutely no people around to help with it.

> quite different and we could eject an enormous amount of crud in the
> process.

I think that there is no point in discussing it any further since we are
unlikely to ever come to similar conclusions.

Lets just peacefully disagree on this case and move on other things.
