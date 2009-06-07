From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 19:55:42 +0200
Message-ID: <200906071955.42378.bzolnier@gmail.com>
References: <200906071444.33047.bzolnier@gmail.com> <200906071744.23629.bzolnier@gmail.com> <84144f020906070954p54cdfee4y62a51795be10b0d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:41029 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZFGRvz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 13:51:55 -0400
In-Reply-To: <84144f020906070954p54cdfee4y62a51795be10b0d0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 07 June 2009 18:54:08 Pekka Enberg wrote:
> Hi Bartlomiej,
> 
> On Sun, Jun 7, 2009 at 6:44 PM, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> > Honestly, this should be solved on technical basis by somebody posting
> > needed libata patches instead of attempts to slow down IDE fixes.
> 
> Nobody is "slowing down" IDE fixes here. Linus explicitly said that
> -rc8 is the last release candidate and the next one is going to be
> -final. There's absolutely _no way_ this series is appropriate at the
> very end of a release cycle.

My honest opinion is that it is as appropriate now as it will be 2.6.31.

[ I'm still amazed by the amount of *completely* bogus reasons given for
  not merging it. ]

However it sure can wait, no big deal (though I still think that it was
worth to try to get it in and not make users wait another few months).

I'll let Linus decide and revise pull request if necessary.
