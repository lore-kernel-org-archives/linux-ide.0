From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/15] ide: remove ->dma_master field from ide_hwif_t
Date: Tue, 2 Oct 2007 00:06:35 +0200
Message-ID: <200710020006.35156.bzolnier@gmail.com>
References: <200710012339.39304.bzolnier@gmail.com> <47016B33.9010001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:29519 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbXJAWCU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 18:02:20 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1981001ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 15:02:17 -0700 (PDT)
In-Reply-To: <47016B33.9010001@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Monday 01 October 2007, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > * Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
> >   pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.
> 
> Before using pci_resource_start(), the code should check 
> pci_resource_len() to ensure it is the appropriate size.
> 
> It would be very wise to ensure that pci_resource_flags()&IORESOURCE_IO 
> is true, too.

Sure but since the old code hasn't been doing these checks (old code
just did pci_resource_start() -> hwif->dma_base -> hwif->dma_master)
this is a separate issue from what the patch tries to achieve.

Bart
