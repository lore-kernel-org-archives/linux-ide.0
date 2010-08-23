From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_mv: fix broken DSM/TRIM support (v2)
Date: Mon, 23 Aug 2010 15:47:39 +0200
Message-ID: <4C727BFB.5070203@kernel.org>
References: <1282267195.8909.6.camel@corey> <1282268444.9628.4.camel@corey>	 <4C722FD4.2010305@kernel.org> <1282570893.30799.1.camel@corey>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42260 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819Ab0HWNqs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2010 09:46:48 -0400
In-Reply-To: <1282570893.30799.1.camel@corey>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On 08/23/2010 03:41 PM, Mark Lord wrote:
>> Don't we need this for other BMDMA commands too?  If so, maybe it's
>> better to make it two patches?
> 
> 
> TRIM is the first/only command which actually breaks
> without this.  It is possible that other commands may
> benefit as well on some DVD-RW drives, but I have not
> encountered those yet.
> 
> So for now, I've left it as a single patch,
> with all of the (small) pieces together for TRIM.

I see.  Looks good to me then.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
