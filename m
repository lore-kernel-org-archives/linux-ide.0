From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] sata_sil24: Use memory barriers before issuing commands
Date: Thu, 10 Jun 2010 18:12:13 +0200
Message-ID: <4C110EDD.2010409@kernel.org>
References: <20100610160212.18091.29856.stgit@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41852 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759426Ab0FJQMd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jun 2010 12:12:33 -0400
In-Reply-To: <20100610160212.18091.29856.stgit@e102109-lin.cambridge.arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Colin Tuckley <colin.tuckley@arm.com>, Jeff Garzik <jeff@garzik.org>

On 06/10/2010 06:02 PM, Catalin Marinas wrote:
> The data in the cmd_block buffers may reach the main memory after the
> writel() to the device ports. This patch introduces two calls to wmb()
> to ensure the relative ordering.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Colin Tuckley <colin.tuckley@arm.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Jeff Garzik <jeff@garzik.org>

I suppose you have tested and verified that this is actually
necessary, right?  I've been looking through the docs but couldn't
find anything which described the ordering between writes to main
memory and write[bwl]()'s.  One thing that kind of bothers me is that
r/wmb()'s are for ordering memory accesses among CPUs which
participate in cache coherency protocol and although it may work right
in the above case I'm not really sure whether this is the right thing
to do.  Do you have more information on the subject?

Thanks.

-- 
tejun
