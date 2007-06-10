From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_it821x: (partially) fix DMA in RAID mode
Date: Sun, 10 Jun 2007 18:42:08 +0100
Message-ID: <20070610184208.2224e023@the-village.bc.nu>
References: <200706101843.20947.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47283 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753924AbXFJRgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jun 2007 13:36:53 -0400
In-Reply-To: <200706101843.20947.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>

> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


Acked-by: Alan Cox <alan@redhat.com>


> -	/* Bits 5 and 6 indicate if DMA is active on master/slave */
> -	/* It is possible that BMDMA isn't allocated */
> -	if (ap->ioaddr.bmdma_addr)
> -		dma_enabled = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
> -
>  	for (i = 0; i < ATA_MAX_DEVICES; i++) {
