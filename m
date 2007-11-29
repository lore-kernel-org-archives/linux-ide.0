From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 05/14] libata: make ->data_xfer return the number of consumed
 bytes
Date: Thu, 29 Nov 2007 13:57:03 -0500
Message-ID: <474F0B7F.8090209@rtr.ca>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468181417-git-send-email-htejun@gmail.com>	<20071129155546.694c6c45@the-village.bc.nu>	<474EE394.6020604@gmail.com>	<20071129174259.6a1edc88@the-village.bc.nu>	<474EFE58.701@gmail.com> <20071129182409.2fcd66d6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4611 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758105AbXK2S5E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 13:57:04 -0500
In-Reply-To: <20071129182409.2fcd66d6@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

Alan Cox wrote:
>> DMA alignment is host restriction so I think it belongs to ata_host if
>> we ever need it.  Do you know of any controller which require such
>> thing?  No need to add complexity when it's not necessary.
> 
> If we ever get the blasted inic162x working then that appears to have
> some alignment limits. At least the docs say the DMA buffers must be quad
> word aligned and sized (although it doesn't describe what occurs if the
> total length of xfer disagrees with the buffers)
...

If it's an ADMA device, then they may support bits in the CPB
to direct what should happen for various overrun/underrun conditions.
