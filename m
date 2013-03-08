From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] ide: tx4938ide: use module_platform_driver_probe()
Date: Fri, 08 Mar 2013 12:39:43 -0500 (EST)
Message-ID: <20130308.123943.1610699628760670897.davem@davemloft.net>
References: <004e01ce1948$be5f4f20$3b1ded60$%han@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:57102 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933174Ab3CHRjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Mar 2013 12:39:44 -0500
In-Reply-To: <004e01ce1948$be5f4f20$3b1ded60$%han@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jg1.han@samsung.com
Cc: linux-ide@vger.kernel.org

From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 05 Mar 2013 11:25:46 +0900

> This patch uses module_platform_driver_probe() macro which makes
> the code smaller and simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.
