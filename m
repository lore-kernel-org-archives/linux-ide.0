From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) sl82c105: DMA support code cleanup (take 3)
Date: Sat, 24 Feb 2007 00:42:59 +0100
Message-ID: <200702240042.59737.bzolnier@gmail.com>
References: <200702140043.25244.sshtylyov@ru.mvista.com> <200702231913.55522.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:14425 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932777AbXBWXgt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 18:36:49 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1006410nfa
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 15:36:48 -0800 (PST)
In-Reply-To: <200702231913.55522.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org


On Friday 23 February 2007, Sergei Shtylyov wrote:
> Fold the now equivalent code in the ide_dma_check() method into a mere call to
> ide_use_dma().  Make config_for_dma() return non-zero if DMA mode has been set
> and call it from the ide_dma_check() method instead of ide_dma_on().
> Also, defer writing the DMA timings to the chip registers until DMA is actually
> turned on (and do not enable IORDY for DMA).  Remove unnecessary code from the
> init_hwif() method, improve its looks overall, and also rename the driver's
> ide_dma_check() and dma_start() methods.
> 
> ---
> This version takes into account that the ide-use-fast-pio.patch had been merged
> to mainline...

applied
