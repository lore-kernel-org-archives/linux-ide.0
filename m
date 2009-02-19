From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] fix dma_unmap_sg misuse
Date: Thu, 19 Feb 2009 18:03:43 +0900
Message-ID: <499D206F.5030906@kernel.org>
References: <20090217133432M.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47185 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571AbZBSJDl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 04:03:41 -0500
In-Reply-To: <20090217133432M.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org

FUJITA Tomonori wrote:
> Looks like that libata misuses dma_unmap_sg though I'm not familiar
> with libata so I might completely misunderstand something.
> 
> =
> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Subject: [PATCH] fix dma_unmap_sg misuse
> 
> DMA-mapping.txt says:
> 
> To unmap a scatterlist, just call:
> 
> 	pci_unmap_sg(pdev, sglist, nents, direction);
> 
> Again, make sure DMA activity has already finished.
> 
> PLEASE NOTE:  The 'nents' argument to the pci_unmap_sg call must be
>               the _same_ one you passed into the pci_map_sg call,
> 	      it should _NOT_ be the 'count' value _returned_ from the
>               pci_map_sg call.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Right, nice spotting.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
