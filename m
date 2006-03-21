From: Mark Lord <liml@rtr.ca>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Mon, 20 Mar 2006 23:43:36 -0500
Message-ID: <441F8478.50806@rtr.ca>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:6024 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030287AbWCUEni (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Mar 2006 23:43:38 -0500
In-Reply-To: <441F544A.6080301@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
..
>>> Ahh.. then how does the low-level driver know what to use for 
>>> ".sg_tablesize"?
>>>
>>> It cannot use the real hardware/driver value, because it may need to do
>>> request splitting.  I wonder what the worst case number of splits 
>>> required
>>> is, for each sg[] entry?
>>
>>
>> Mmmm.  I suppose the answer is that the block layer guarantees
>> no more than .sg_tablesize entries, and the IOMMU layer may reduce
>> the segment count, but never increase it.
>>
>> So the low-level driver should be able to safely use it's own internal
>> hardware/driver limit when registering .sg_tablesize.
> 
> The IOMMU layer can merge across 64k boundaries, yet still produce a 
> worst case s/g entry count.  Thus, you wind up with sg_tablesize 
> entries, and splits still to be done.
> 
> That's why drivers that worry about 64k boundary have to give a false 
> sg_tablesize to the SCSI layer: to reserve sufficient "true" s/g entries 
> for the worst case IOMMU split.

But what is the worst case?  What's to stop the IOMMU layer from merging,
say, thirty 64KB segments into a single SG entry.  And then doing that
several times..  nothing.

But (as I replied to myself earlier), I think it is a non issue,
because the IOMMU merging cannot produce more SG entries than
there were originally.  It may produce less, and the driver may then
end up splitting them apart again, but it will never exceed what
the block layer permitted in the first place.

So, I think that means the driver can report the real SG tablesize,
and not worry about divide-by-??? margins.

Cheers

