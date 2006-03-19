From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Sun, 19 Mar 2006 16:38:59 -0500
Message-ID: <441DCF73.2080600@pobox.com>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10407 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751087AbWCSVjC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Mar 2006 16:39:02 -0500
In-Reply-To: <441DCAC9.5090603@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>> Mark Lord wrote:
>>
>>> Jens / Jeff,
>>>
>>> Each libata driver registers a .dma_boundary field with SCSI.
>>> This field is used to prevent merging of bio segments across
>>> a hardware limitation boundary, usually 0xffff.
>>>
>>> This looks like it works for regular block I/O,
>>> but I'm not so sure about SGIO originated requests.
>>>
>>> Any thoughts, or code you can point me to?
>>
>>
>> Everything goes through the block layer, including SG_IO, so everyone 
>> agrees on the boundaries that must be respected.
>>
>> scsi sets blk_queue_segment_boundary() then gets out of the way, for 
>> the most part.  BIOVEC_SEG_BOUNDARY() is the macro that accesses this. 
>> Trace back and forth from there.  You will probably run into a call to 
>> blk_recount_segments() in __bio_add_page(), or maybe you'll check the 
>> seg boundary from another path.
> 
> 
> Yeah, I'm familiar with that part, and thanks for the note about SGIO.
> 
> So therefore, code to manage the dma_boundary is NOT necessary in sata 
> drivers. Right?  Currently we have in sata_mv.c:
> 
>     MV_DMA_BOUNDARY = 0xffff;
>                 while (sg_len) {
>                         offset = addr & MV_DMA_BOUNDARY;
>                         len = sg_len;
>                         if ((offset + sg_len) > 0x10000)
>                                 len = 0x10000 - offset;
>                 ...
> 
> 
> That whole block should be able to go, then.

Incorrect.  :)

The idiot IOMMU layer may merge too aggressively, which is the reason 
for this code and similar code in ata_fill_sg().  The IOMMU stuff always 
happens at pci_map_sg() time, after the block layer gets out of the way.

	Jeff



