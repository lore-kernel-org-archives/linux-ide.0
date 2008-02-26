From: Mark Lord <liml@rtr.ca>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Mon, 25 Feb 2008 20:43:31 -0500
Message-ID: <47C36EC3.4080708@rtr.ca>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com> <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2058 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbYBZBkq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 20:40:46 -0500
In-Reply-To: <47C36D64.6010001@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Benjamin Herrenschmidt wrote:
..
>> The split wasn't done by the iommu. The split was done by the IDE code
>> itself to handle the stupid 64k crossing thingy. If it's done
>> differently now, it might be possible to remove it, I haven't looked.
> ..
> 
> The block layer uses seg_boundary_mask to ensure that we never have
> to split them again in the LLD.
..

James B.  suggests that we stick a WARN_ON() into libata to let us
know if that precondition is violated.  Sounds like an easy thing to do
for a couple of -rc cycles someday.

Cheers
