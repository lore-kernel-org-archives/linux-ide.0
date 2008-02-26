From: Mark Lord <liml@rtr.ca>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Tue, 26 Feb 2008 11:51:42 -0500
Message-ID: <47C4439E.2000606@rtr.ca>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>	 <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>	 <47C36EC3.4080708@rtr.ca> <1203994454.15052.83.camel@pasglop>	 <47C397C4.2090309@rtr.ca> <1204003805.15052.112.camel@pasglop>	 <47C3A71B.2070705@rtr.ca> <1204004844.15052.123.camel@pasglop> <47C43D7F.3010005@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4882 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbYBZQsr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2008 11:48:47 -0500
In-Reply-To: <47C43D7F.3010005@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Mark Lord wrote:
> Benjamin Herrenschmidt wrote:
>> On Tue, 2008-02-26 at 00:43 -0500, Mark Lord wrote:
>>>> I suppose so. I don't remember all of the details, but iirc, it has to
>>>> do with crossing 64K boundaries. Some controllers can't handle it.
>>>>
>>>> It's not only the _size_ of the segments, it's their alignment.
>>>>
>>>> The iommu will not keep alignement beyond the page size (and even
>>>> then... on powerpc with a 64k base page size, you may still end up with
>>>> a 4k aligned result, but let's not go there now).
>>> ..
>>>
>>> That's just not possible, unless the IOMMU *splits* segments.
>>> And the IOMMU experts here say that it never does that.
>>
>> It is totally possible, and I know as wrote part of the powerpc iommu
>> code :-)
>>
>> The iommu code makes no guarantee vs. preserving the alignment of a
>> segment, at least not below PAGE_SIZE.
>>
>> Thus if you pass to dma_map_sg() a 64K aligned 64K segment, you may well
>> get back a 4K aligned 64K segment.
>>
>> Enforcing natural alignment in the iommu code only happens for
>> dma_alloc_coherent (it uses order-N allocations anyway), it doesn't
>> happen for map_sg. If we were to do that, we would make it very likely
>> for iommu allocations to fail on machine with small DMA windows.
>>
>> Ben.
> ..
> 
> That's interesting.  Can you point us to the exact file::lines where
> this happens?  It would be good to ensure that this gets fixed.
> 
> I'm copying Fujita Tomonori on this thread now -- he's the dude who's
> trying to sort out the IOMMU mess.
..

Mmm.. looks like ppc is already fixed in mainline,
commit 740c3ce66700640a6e6136ff679b067e92125794

Ben?
