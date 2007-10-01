From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/15] ide: remove ->dma_master field from ide_hwif_t
Date: Mon, 01 Oct 2007 17:48:35 -0400
Message-ID: <47016B33.9010001@garzik.org>
References: <200710012339.39304.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60956 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbXJAVsh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Oct 2007 17:48:37 -0400
In-Reply-To: <200710012339.39304.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> * Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
>   pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.

Before using pci_resource_start(), the code should check 
pci_resource_len() to ensure it is the appropriate size.

It would be very wise to ensure that pci_resource_flags()&IORESOURCE_IO 
is true, too.

	Jeff



