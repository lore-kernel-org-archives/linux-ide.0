From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] hpt366: UltraDMA filtering for SATA cards
Date: Sat, 18 Aug 2007 21:18:45 +0200
Message-ID: <200708182118.45356.bzolnier@gmail.com>
References: <200708060008.38077.sshtylyov@ru.mvista.com> <46BDD989.6060202@ru.mvista.com> <46BE0726.1080609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:64200 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757105AbXHRTTR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:19:17 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1246464mue
        for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 12:19:17 -0700 (PDT)
In-Reply-To: <46BE0726.1080609@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: rah@bash.sh, linux-ide@vger.kernel.org


On Saturday 11 August 2007, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >>  101 files changed, 1880 insertions(+), 2828 deletions(-)
> 
> >> please look at -mm or IDE quilt tree instead. :)
> 
> >    Looking...
> 
>     When are you planning to push out to Linus the 
> ide-mode-limiting-fixes-for-user-requested-speed-changes.patch? I'd like my 
> HPT37x SATA mode filtering stuff to be atop of this one, after looking at it.

Preferably 2.6.24 material and ide_rate_filter() FIXME (respecting device PIO
limits) still needs to be addressed before pushing all mode limiting patches
upstream.

> >> ide_rate_filter() happily uses ide_find_dma_mode() nowadays (however this
> >> hpt366 patch is for vanilla kernel which doesn't have the needed 
> >> changes).
> 
>     Yeah, it keeps being in the same vein (same bug rather :-) as the old 
> code, i.e. not looking at hwif->mwdma_mask when falling back in 
> ide_rate_filter()...

Worth fixing but deserves a separate patch.

Bart
