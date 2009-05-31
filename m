From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pdc202xx_old: fix resetproc() method
Date: Sun, 31 May 2009 16:58:45 +0200
Message-ID: <200905311658.45703.bzolnier@gmail.com>
References: <200905300007.13113.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:50729 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbZEaOxz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 May 2009 10:53:55 -0400
Received: by ewy24 with SMTP id 24so7298881ewy.37
        for <linux-ide@vger.kernel.org>; Sun, 31 May 2009 07:53:56 -0700 (PDT)
In-Reply-To: <200905300007.13113.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Friday 29 May 2009 22:07:12 Sergei Shtylyov wrote:
> pdc202xx_reset() calls pdc202xx_reset_host() twice, for both channels, while
> that function actually twiddles the single, shared software reset bit -- the
> net effect is a duplicated reset and horrendous 4 second delay happening not
> only on a channel reset but also when dma_lost_irq() and dma_clear() methods
> are called.  Fold pdc202xx_reset_host() into pdc202xx_reset(), fix printk(),
> and move it before the actual reset...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is against the ide-2.6.git master branch...
> 
> Bart, I know you have the docs... from the now removed source code I was able
> to figure out that the bit in question most probably drives RST- signal on both
> channels (it seems to require re-tuning drives on both channels which we are
> currently not doing). If I'm right, why the hell we're twiddling it on a normal
> SRST reset, and what's worse on an interrupt timeout conditions? Anyway, it's

Unfortunately the documentation doesn't say anything more than that the changing
of the bit value results in SRST on both channels...

IIRC from some old discussions this is required by the chipset sometimes..

> hardly a good idea to reset both channels when you only have problem with only
> one of them, and I don't see any justification to doing that... So maybe this
> patch should've actually wiped out that whole reset insanity for good?..

I'm pretty sure that there are valid reasons behind some of this insanity,
OTOH (per mail from Alan) it completely ignores the fact that the other port
may be active.. 

We may try removing it in incremental patch so it is easier to track/revert
it if things go wrong..
