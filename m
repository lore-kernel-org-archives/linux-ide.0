From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v2)
Date: Fri, 23 Nov 2007 10:17:25 +0900
Message-ID: <47462A25.1060207@gmail.com>
References: <47438248.7030704@shaw.ca> <4745234E.9050409@gmail.com> <47462673.3080701@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:61395 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbXKWBRc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 20:17:32 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2506189rvb
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 17:17:32 -0800 (PST)
In-Reply-To: <47462673.3080701@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Robert Hancock wrote:
>>> +    /* Ensure DMA mask is set to 32-bit before allocating legacy PRD
>>> and
>>> +       pad buffers */
>>> +    pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
>>> +    pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
>> [--snip--]
>>> +    pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
>>> +    pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
>>
>> I'm probably being paranoid here but please add error checks.  Just
>> checking return value and returning error suffices.
> 
> In the 32-bit case, I'm pretty sure those are guaranteed not to fail
> because 32-bit is the default. For the 64-bit ones, we don't care if
> they fail, because then we'll just use whatever mask ends up being set
> (we store the actual set DMA mask in adma_dma_mask for use when we need
> to reconfigure the bounce limit). We definitely don't want to fail
> initialization if the 64-bit set doesn't succeed..

Then please add BUG or WARN_ON after 32bit switching (but then again if
you're gonna do that why not just add if (rc) return rc?) and add
comment stating setting 64 bit dma masks is allowed to fail.

Thanks.

-- 
tejun
