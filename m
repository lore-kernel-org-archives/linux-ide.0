From: Mark Lord <liml@rtr.ca>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Sun, 19 Mar 2006 16:45:37 -0500
Message-ID: <441DD101.5050202@rtr.ca>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:41357 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751107AbWCSVpm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Mar 2006 16:45:42 -0500
In-Reply-To: <441DCF73.2080600@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>
>> So therefore, code to manage the dma_boundary is NOT necessary in sata 
>> drivers. Right?  Currently we have in sata_mv.c:
>>
>>     MV_DMA_BOUNDARY = 0xffff;
>>                 while (sg_len) {
>>                         offset = addr & MV_DMA_BOUNDARY;
>>                         len = sg_len;
>>                         if ((offset + sg_len) > 0x10000)
>>                                 len = 0x10000 - offset;
>>                 ...
>>
>>
>> That whole block should be able to go, then.
> 
> Incorrect.  :)
> 
> The idiot IOMMU layer may merge too aggressively, which is the reason 
> for this code and similar code in ata_fill_sg().  The IOMMU stuff always 
> happens at pci_map_sg() time, after the block layer gets out of the way.

Ahh.. then how does the low-level driver know what to use for ".sg_tablesize"?

It cannot use the real hardware/driver value, because it may need to do
request splitting.  I wonder what the worst case number of splits required
is, for each sg[] entry?

?
