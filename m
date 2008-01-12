From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: PROBLEM REMAINS: [sata_nv ADMA breaks ATAPI] Crash
	on	accessing DVD-RAM
Date: Sat, 12 Jan 2008 17:27:20 -0600
Message-ID: <1200180440.3656.76.camel@localhost.localdomain>
References: <fa.krOVfyFmB2aqGjJIoHCLmQxecWc@ifi.uio.no>
	 <478702C7.80401@shaw.ca> <47887982.6050805@mail.ru>
	 <47891426.1020604@shaw.ca> <1200170117.3656.66.camel@localhost.localdomain>
	 <47894785.2050508@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:58148 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751058AbYALX12 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 18:27:28 -0500
In-Reply-To: <47894785.2050508@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Alexander <aledin@mail.ru>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

On Sat, 2008-01-12 at 17:04 -0600, Robert Hancock wrote:
> I don't think the problem is that there's some buffer which is getting 
> allocated above 4GB and never bounced, since the problem goes away if 
> ADMA is disabled entirely and the DMA mask remains 32-bit always. My 
> guess is something is basing its decision on whether to bounce or not on 
> the device DMA mask. That can't possibly work properly for sata_nv since 
> the same PCI device has 2 ports, one of which can be in ADMA mode and 
> 64-bit capable and the other can be in legacy mode and only 32-bit capable.

Erm, well, you can't decouple them.  Having a differing blk queue bounce
mask and device mask is going to cause huge trouble.  The reason is this
insidious nasty called swiotlb.  Basically, with it enabled (and again,
it can be on ia64 or x86_64), the kernel can bypass the bounce limit
safe in the knowledge that swiotlb will fix up behind in the dma_map_
Unfortunately, if the device mask doesn't match the queue mask then
swiotlb will never kick in and you'll end up with mapped pages beyond
the 4GB limit.

> Tejun, I believe you had a patch that was printing warnings when libata 
> tried to program a legacy PRD with an address over 4GB. Could we change 
> that to WARN_ON and get someone experiencing this to try it and
> see what the stack trace points to?

Unfortunately, the stack trace probably won't help, since the command
likely gets issued from the block request function, so the trace won't
go back to the culpable initiator; that's why the command would be
helpful.

James


