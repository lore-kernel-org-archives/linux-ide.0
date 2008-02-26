From: Mark Lord <liml@rtr.ca>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Mon, 25 Feb 2008 20:37:40 -0500
Message-ID: <47C36D64.6010001@rtr.ca>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com> <1203987277.15052.68.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1040 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986AbYBZBe4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 20:34:56 -0500
In-Reply-To: <1203987277.15052.68.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Benjamin Herrenschmidt wrote:
> On Mon, 2008-02-25 at 19:15 -0500, Jeff Garzik wrote:
>> Mark Lord wrote:
>>> Jeff,
>>>
>>> We had a discussion here today about IOMMUs,
>>> and they *never* split sg list entries -- they only ever *merge*.
>>>
>>> And this happens only after the block layer has
>>> already done merging while respecting q->seg_boundary_mask.
>>>
>>> So worst case, the IOMMU may merge everything, and then in
>>> libata we unmerge them again.  But the end result can never
>>> exceed the max_sg_entries limit enforced by the block layer.
>> <shrug>  Early experience said otherwise.  The split in foo_fill_sg() 
>> and resulting sg_tablesize reduction were both needed to successfully 
>> transfer data, when Ben H originally did the work.
>>
>> If Ben H and everyone on the arch side agrees with the above analysis, I 
>> would be quite happy to remove all those "/ 2".
> 
> The split wasn't done by the iommu. The split was done by the IDE code
> itself to handle the stupid 64k crossing thingy. If it's done
> differently now, it might be possible to remove it, I haven't looked.
..

The block layer uses seg_boundary_mask to ensure that we never have
to split them again in the LLD.

A very long time ago, when I wrote the IDE DMA code, this was not the case.

Cheers
