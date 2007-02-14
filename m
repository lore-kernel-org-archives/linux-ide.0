From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) sl82c105: DMA support code cleanup
Date: Wed, 14 Feb 2007 20:48:32 +0100
Message-ID: <200702142048.32535.bzolnier@gmail.com>
References: <200702140043.25244.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:45127 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbXBNTmu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Feb 2007 14:42:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so317142uga
        for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2007 11:42:49 -0800 (PST)
In-Reply-To: <200702140043.25244.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org


On Tuesday 13 February 2007 22:43, Sergei Shtylyov wrote:
> Fold the now equivalent code in the ide_dma_check() method into a mere call to
> ide_use_dma().  Make config_for_dma() return non-zero if DMA mode has been set
> and call it from the ide_dma_check() method instead of ide_dma_on().
> Also, defer writing the DMA timings to the chip registers until DMA is actually
> turned on (and do not enable IORDY for DMA).  Remove unnecessary code from the
> init_hwif() method, improve its looks overall, and also rename the driver's
> ide_dma_check() and dma_start() methods.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch has been actually tested at last. :-)
> Note that now this driver can be joined to the ide-use-fast-pio patch.

applied
