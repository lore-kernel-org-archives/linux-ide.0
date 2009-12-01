From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/5] powerpc/macio: Add devres support to macio_device
Date: Tue, 01 Dec 2009 16:20:49 +0900
Message-ID: <4B14C3D1.4010401@kernel.org>
References: <20091201070832.37EB8B7B65@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42567 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbZLAHUt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 02:20:49 -0500
In-Reply-To: <20091201070832.37EB8B7B65@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org

On 12/01/2009 04:08 PM, Benjamin Herrenschmidt wrote:
> This adds some basic devres support. When enabled via macio_enable_devres()
> resources requested by drivers will be automatically released.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
