From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Mon, 20 Mar 2006 20:15:25 -0500
Message-ID: <441F53AD.1060608@pobox.com>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:15077 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932258AbWCUBP2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Mar 2006 20:15:28 -0500
In-Reply-To: <441DD101.5050202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>> Mark Lord wrote:
>>
>>> So therefore, code to manage the dma_boundary is NOT necessary in 
>>> sata drivers. Right?  Currently we have in sata_mv.c:
>>>
>>>     MV_DMA_BOUNDARY = 0xffff;
>>>                 while (sg_len) {
>>>                         offset = addr & MV_DMA_BOUNDARY;
>>>                         len = sg_len;
>>>                         if ((offset + sg_len) > 0x10000)
>>>                                 len = 0x10000 - offset;
>>>                 ...
>>>
>>>
>>> That whole block should be able to go, then.
>>
>>
>> Incorrect.  :)
>>
>> The idiot IOMMU layer may merge too aggressively, which is the reason 
>> for this code and similar code in ata_fill_sg().  The IOMMU stuff 
>> always happens at pci_map_sg() time, after the block layer gets out of 
>> the way.
> 
> 
> Ahh.. then how does the low-level driver know what to use for 
> ".sg_tablesize"?
> 
> It cannot use the real hardware/driver value, because it may need to do
> request splitting.  I wonder what the worst case number of splits required
> is, for each sg[] entry?

To answer that question, you have to take into account the 64k DMA 
boundary requirement, the worst case split (==sg_tablesize), and how 
many splits required in each s/g entry -- in the case of sata_mv.c and 
ata_fill_sg(), worst case is one split per s/g entry.

	Jeff


