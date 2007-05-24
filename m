From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] IDE fixes
Date: Wed, 23 May 2007 18:56:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705231850520.3890@woody.linux-foundation.org>
References: <200705240246.19039.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:50691 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756579AbXEXB4v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 21:56:51 -0400
In-Reply-To: <200705240246.19039.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



On Thu, 24 May 2007, Bartlomiej Zolnierkiewicz wrote:
> diff --git a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
> index 6234f80..47bcd91 100644
> --- a/drivers/ide/pci/serverworks.c
> +++ b/drivers/ide/pci/serverworks.c
> @@ -173,7 +179,7 @@ dma_pio:
>  				   ((dma_stat&(1<<(5+unit)))==(1<<(5+unit)))) {
>  				u8 dmaspeed = dma_timing;
>  
> -				dma_timing &= ~0xFF;
> +				dma_timing &= ~0xFFU;

This is just crap.

The old code was _also_ crap, but the new code just is worse. 

What's the point of this, really?

dma_timing is a 8-bit value, so the above is just a *really* stupid and 
bad way of saying

	dma_timing = 0;

and whoever wrote that code is just terminally confused.

I pulled, but that driver is CRAP. Please don't add new crap blindly like 
that. 

Andrew, that was your change, it appears. Tssk.

Please, we do NOT fix compiler warnings without understanding the code! 
That's a sure way to just introduce _new_ bugs, rather than fix old ones. 
So please, please, please, realize that the compiler is _stupid_, and 
fixing warnings without understanding the code is bad.

In this case, anybody who actually spends 5 seconds looking at the code 
should have realized that the warning is just another way of saying that 
the author of the code was on some bad drugs, and the warnings WERE BETTER 
OFF REMAINING! Because that code _should_ have warnings. Big fat warnings 
about incompetence!

		Linus
