From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/13] siimage: fix wrong ->swdma_mask
Date: Sat, 10 Mar 2007 23:37:47 +0100
Message-ID: <200703102337.47122.bzolnier@gmail.com>
References: <200703102212.49447.bzolnier@gmail.com> <45F3219C.5040500@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:9670 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbXCJWar (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 17:30:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1762887uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 14:30:45 -0800 (PST)
In-Reply-To: <45F3219C.5040500@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Saturday 10 March 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > [PATCH] siimage: fix wrong ->swdma_mask
> 
> > This driver doesn't support SWDMA so use the correct ->swdma_mask.
> 
> > While at it:
> 
> > * no need to call config_chipset_for_pio() in config_chipset_for_dma(),
> >   if DMA is not available config_chipset_for_pio() will be called
> >   by siimage_config_drive_for_dma() and if DMA is available
> >   config_siimage_chipset_for_pio() will be called by siimage_tune_chipset()
> 
>     Ugh, this driver has such a messy code PIO-wise!  There seems to be 
> completely no point in calling config_siimage_chipset_for_pio() from 
> siimage_tune_chipset().  Not mentioning that tuneproc() method fails to 
> actually control IORDY (it only twiddles IORDY bits for taskfile access). Ah, 
> and tuneproc() fails to set the drive's own mode (as usual)... :-)
>     I was going to post patches but then figured out that we don't actually 
> support this driver, so the priority has significatly dropped. :-)

Does it mean that I should expect more patches for other drivers? ;-)

If so I could take care of this one... :-)

Bart
