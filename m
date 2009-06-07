From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 16:32:30 +0200
Message-ID: <200906071632.30914.bzolnier@gmail.com>
References: <200906071444.33047.bzolnier@gmail.com> <20090607152151.3cb01901@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:34504 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZFGO1f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 10:27:35 -0400
In-Reply-To: <20090607152151.3cb01901@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 07 June 2009 16:21:51 Alan Cox wrote:
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

If you want to discuss any code that I push upstream then *please* quote
it in your mails so we all can see what parts you question and discuss it
based on technical merits.
