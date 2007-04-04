From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] sl82c105: DMA support code cleanup (take 4)
Date: Wed, 4 Apr 2007 21:38:02 +0200
Message-ID: <200704042138.02233.bzolnier@gmail.com>
References: <200702140043.25244.sshtylyov@ru.mvista.com> <200702231913.55522.sshtylyov@ru.mvista.com> <200703282250.02679.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:15951 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993039AbXDDTgk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Apr 2007 15:36:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so782475uga
        for <linux-ide@vger.kernel.org>; Wed, 04 Apr 2007 12:36:39 -0700 (PDT)
In-Reply-To: <200703282250.02679.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Wednesday 28 March 2007, Sergei Shtylyov wrote:
> Fold the now equivalent code in the ide_dma_check() method into a mere call to
> ide_use_dma().  Make config_for_dma() return non-zero if DMA mode has been set
> and call it from the ide_dma_check() method instead of ide_dma_on().
> Defer writing the DMA timings to the chip registers until DMA is really turned
> on (and do not enable IORDY for DMA).
> Remove unneeded code from the init_hwif() method, improve its overall looks.
> Rename the dma_start(), ide_dma_check(), and ide_dma_lostirq() methods, and
> also use more proper hwif->dma_command, fix printk() and comment in the latter
> one as well.  While at it, cleanup style in several places.
> 
> ---
> This patch has also been actually tested at last. :-)
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

I moved Signed-off-by-s before "---" to prevent them from being eaten by git.

applied
