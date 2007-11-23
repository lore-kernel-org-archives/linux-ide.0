From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v2)
Date: Thu, 22 Nov 2007 19:01:39 -0600
Message-ID: <47462673.3080701@shaw.ca>
References: <47438248.7030704@shaw.ca> <4745234E.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:26702 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbXKWBBn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 20:01:43 -0500
In-reply-to: <4745234E.9050409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> Hello, Robert.
> 
> Robert Hancock wrote:
>> This fixes some problems with ATAPI devices on nForce4 controllers in ADMA
>> mode on systems with memory located above 4GB. We need to delay setting the
>> 64-bit DMA mask until the PRD table and padding buffer are allocated so that
>> they don't get allocated above 4GB and break legacy mode (which is needed for
>> ATAPI devices). Also, explicitly set a 32-bit DMA mask before allocating the
>> legacy buffers since setting the DMA mask affects both ports and we need to
>> ensure the second port's buffers are allocated properly (fixes a problem
>> with the previous version of this patch).
>>
>> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
>>
>> +	/* Ensure DMA mask is set to 32-bit before allocating legacy PRD and
>> +	   pad buffers */
>> +	pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
>> +	pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> [--snip--]
>> +	pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
>> +	pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> 
> I'm probably being paranoid here but please add error checks.  Just
> checking return value and returning error suffices.

In the 32-bit case, I'm pretty sure those are guaranteed not to fail 
because 32-bit is the default. For the 64-bit ones, we don't care if 
they fail, because then we'll just use whatever mask ends up being set 
(we store the actual set DMA mask in adma_dma_mask for use when we need 
to reconfigure the bounce limit). We definitely don't want to fail 
initialization if the 64-bit set doesn't succeed..
