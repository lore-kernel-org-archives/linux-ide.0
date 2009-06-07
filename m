From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [git pull] IDE fixes
Date: Sun, 07 Jun 2009 09:38:56 -0500
Message-ID: <1244385536.8262.5.camel@mulgrave.site>
References: <200906071444.33047.bzolnier@gmail.com>
	 <20090607152151.3cb01901@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56566 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751993AbZFGOi7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 10:38:59 -0400
In-Reply-To: <20090607152151.3cb01901@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2009-06-07 at 15:21 +0100, Alan Cox wrote:
> > diff --git a/fs/partitions/check.c b/fs/partitions/check.c
> > index 99e33ef..4bc2c43 100644
> > --- a/fs/partitions/check.c
> > +++ b/fs/partitions/check.c
> 
> 
> You seriously want to add code to the core partition handling logic
> moments before release when we know we have all sorts of devices with
> weird behaviours ?
> 
> This should be .31 stuff where we can take the time to see how it works
> on all sorts of weird real world devices (eg those with 2K sector size)
> and the like.

Absolutely seconded.

Plus this is only one of the proposals for dealing with IDE native sizes
moving through the process.  The other one is in libata with the gendisk
proposal for alt size instead of your set_capacity callback.   The last
thing we want is two separate mechanisms for this, so trying to push
anything upstream before we have agreement on direction is premature ...
trying to send a feature as a bug fix is doubly so.

James


