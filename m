From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v2)
Date: Thu, 22 Nov 2007 15:35:58 +0900
Message-ID: <4745234E.9050409@gmail.com>
References: <47438248.7030704@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:48873 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbXKVGgF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 01:36:05 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2294039rvb
        for <linux-ide@vger.kernel.org>; Wed, 21 Nov 2007 22:36:04 -0800 (PST)
In-Reply-To: <47438248.7030704@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Hello, Robert.

Robert Hancock wrote:
> This fixes some problems with ATAPI devices on nForce4 controllers in ADMA
> mode on systems with memory located above 4GB. We need to delay setting the
> 64-bit DMA mask until the PRD table and padding buffer are allocated so that
> they don't get allocated above 4GB and break legacy mode (which is needed for
> ATAPI devices). Also, explicitly set a 32-bit DMA mask before allocating the
> legacy buffers since setting the DMA mask affects both ports and we need to
> ensure the second port's buffers are allocated properly (fixes a problem
> with the previous version of this patch).
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> 
> +	/* Ensure DMA mask is set to 32-bit before allocating legacy PRD and
> +	   pad buffers */
> +	pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +	pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
[--snip--]
> +	pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));

I'm probably being paranoid here but please add error checks.  Just
checking return value and returning error suffices.

Thanks.

-- 
tejun
