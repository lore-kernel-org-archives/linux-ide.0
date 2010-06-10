From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_sil24: Use memory barriers before issuing commands
Date: Thu, 10 Jun 2010 17:24:33 +0200
Message-ID: <4C1103B1.7050307@kernel.org>
References: <20100610145706.15588.4562.stgit@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32949 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968Ab0FJPYw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jun 2010 11:24:52 -0400
In-Reply-To: <20100610145706.15588.4562.stgit@e102109-lin.cambridge.arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Colin Tuckley <colin.tuckley@arm.com>

On 06/10/2010 04:57 PM, Catalin Marinas wrote:
> The data in the cmd_block buffers may reach the main memory after the
> writel() to the device ports. This patch introduces two calls to wmb()
> to ensure the relative ordering.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Colin Tuckley <colin.tuckley@arm.com>
> Cc: Tejun Heo <tj@kernel.org>

Can you please add comments explaining why they're needed?

Thanks.

-- 
tejun
