From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Mon, 20 Mar 2006 20:18:02 -0500
Message-ID: <441F544A.6080301@pobox.com>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:27877 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964771AbWCUBSF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Mar 2006 20:18:05 -0500
In-Reply-To: <441DD300.9050702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Mark Lord wrote:
> 
>> Jeff Garzik wrote:
>>
>>> The idiot IOMMU layer may merge too aggressively, which is the reason 
>>> for this code and similar code in ata_fill_sg().  The IOMMU stuff 
>>> always happens at pci_map_sg() time, after the block layer gets out 
>>> of the way.
>>
>>
>> Ahh.. then how does the low-level driver know what to use for 
>> ".sg_tablesize"?
>>
>> It cannot use the real hardware/driver value, because it may need to do
>> request splitting.  I wonder what the worst case number of splits 
>> required
>> is, for each sg[] entry?
> 
> 
> Mmmm.  I suppose the answer is that the block layer guarantees
> no more than .sg_tablesize entries, and the IOMMU layer may reduce
> the segment count, but never increase it.
> 
> So the low-level driver should be able to safely use it's own internal
> hardware/driver limit when registering .sg_tablesize.

The IOMMU layer can merge across 64k boundaries, yet still produce a 
worst case s/g entry count.  Thus, you wind up with sg_tablesize 
entries, and splits still to be done.

That's why drivers that worry about 64k boundary have to give a false 
sg_tablesize to the SCSI layer: to reserve sufficient "true" s/g entries 
for the worst case IOMMU split.

	Jeff


