From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/5] libata/sff: Use ops->bmdma_stop instead of ata_bmdma_stop()
Date: Tue, 01 Dec 2009 16:25:16 +0900
Message-ID: <4B14C4DC.6060107@kernel.org>
References: <20091201070833.CC084B7BD9@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56392 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbZLAHZI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 02:25:08 -0500
In-Reply-To: <20091201070833.CC084B7BD9@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org

On 12/01/2009 04:08 PM, Benjamin Herrenschmidt wrote:
> In libata-sff, ata_sff_post_internal_cmd() directly calls ata_bmdma_stop()
> instead of ap->ops->bmdma_stop(). This can be a problem for controllers
> that use their own bmdma_stop for which the generic sff one isn't suitable
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Oh... that's a scary bug lurking around.  Thanks for catching it.

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
