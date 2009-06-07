From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 15:21:51 +0100
Message-ID: <20090607152151.3cb01901@lxorguk.ukuu.org.uk>
References: <200906071444.33047.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39753 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753524AbZFGOUy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 10:20:54 -0400
In-Reply-To: <200906071444.33047.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> diff --git a/fs/partitions/check.c b/fs/partitions/check.c
> index 99e33ef..4bc2c43 100644
> --- a/fs/partitions/check.c
> +++ b/fs/partitions/check.c


You seriously want to add code to the core partition handling logic
moments before release when we know we have all sorts of devices with
weird behaviours ?

This should be .31 stuff where we can take the time to see how it works
on all sorts of weird real world devices (eg those with 2K sector size)
and the like.

