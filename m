From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/14] libata: make ->data_xfer return the number of consumed
 bytes
Date: Thu, 29 Nov 2007 14:37:03 -0500
Message-ID: <474F14DF.8050201@garzik.org>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468181417-git-send-email-htejun@gmail.com>	<20071129155546.694c6c45@the-village.bc.nu>	<474EE394.6020604@gmail.com>	<20071129174259.6a1edc88@the-village.bc.nu>	<474EFE58.701@gmail.com> <20071129182409.2fcd66d6@the-village.bc.nu> <474F0B7F.8090209@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55640 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759717AbXK2ThG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 14:37:06 -0500
In-Reply-To: <474F0B7F.8090209@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

Mark Lord wrote:
> Alan Cox wrote:
>>> DMA alignment is host restriction so I think it belongs to ata_host if
>>> we ever need it.  Do you know of any controller which require such
>>> thing?  No need to add complexity when it's not necessary.
>>
>> If we ever get the blasted inic162x working then that appears to have
>> some alignment limits. At least the docs say the DMA buffers must be quad
>> word aligned and sized (although it doesn't describe what occurs if the
>> total length of xfer disagrees with the buffers)
> ...
> 
> If it's an ADMA device, then they may support bits in the CPB
> to direct what should happen for various overrun/underrun conditions.

Yeah most devices that are not strictly SFF (i.e. have a real register 
space) are like that.

	Jeff



