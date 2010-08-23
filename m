From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-sff: remove harmful BUG_ON from ata_bmdma_qc_issue
Date: Mon, 23 Aug 2010 10:17:17 +0200
Message-ID: <4C722E8D.6030709@kernel.org>
References: <1282267195.8909.6.camel@corey> <1282268444.9628.4.camel@corey>	 <4C6E89A8.2000600@teksavvy.com> <1282313596.1634.0.camel@corey>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56384 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525Ab0HWIWp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2010 04:22:45 -0400
In-Reply-To: <1282313596.1634.0.camel@corey>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On 08/20/2010 04:13 PM, Mark Lord wrote:
> Remove harmful BUG_ON() from ata_bmdma_qc_issue(),
> as it casts too wide of a net and breaks sata_mv.
> It also crashes the kernel while doing the BUG_ON().
> 
> There's already a WARN_ON_ONCE() further down to catch
> the case of POLLING for a BMDMA operation.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
