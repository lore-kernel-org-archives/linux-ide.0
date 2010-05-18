From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 17/23] libata-sff: prd is BMDMA specific
Date: Tue, 18 May 2010 10:38:42 +0200
Message-ID: <4BF25212.4060400@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-18-git-send-email-tj@kernel.org> <4BF20446.9030606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46212 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756954Ab0ERIiu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 May 2010 04:38:50 -0400
In-Reply-To: <4BF20446.9030606@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/18/2010 05:06 AM, Jeff Garzik wrote:
> "bmdma_prd_dma" is a bit too redundant for my tastes.
> 
> I would prefer "bmdma_prd_addr" or similar.

That will be a tad bit confusing w/ the kernel address.  That is
specifically the DMA address of BMDMA PRD table instead of the kernel
visible address.  Given the weird nature of that address, I vote for
weird redundant name.

Thanks.

-- 
tejun
