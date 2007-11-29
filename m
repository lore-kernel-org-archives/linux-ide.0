From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/14] libata: make ->data_xfer return the number of
 consumed bytes
Date: Thu, 29 Nov 2007 18:24:09 +0000
Message-ID: <20071129182409.2fcd66d6@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468181417-git-send-email-htejun@gmail.com>
	<20071129155546.694c6c45@the-village.bc.nu>
	<474EE394.6020604@gmail.com>
	<20071129174259.6a1edc88@the-village.bc.nu>
	<474EFE58.701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35435 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756750AbXK2S2v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 13:28:51 -0500
In-Reply-To: <474EFE58.701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

> DMA alignment is host restriction so I think it belongs to ata_host if
> we ever need it.  Do you know of any controller which require such
> thing?  No need to add complexity when it's not necessary.

If we ever get the blasted inic162x working then that appears to have
some alignment limits. At least the docs say the DMA buffers must be quad
word aligned and sized (although it doesn't describe what occurs if the
total length of xfer disagrees with the buffers)
