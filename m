From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] ide: palm_bk3710: add missing __iomem annotation
Date: Thu, 05 Sep 2013 15:38:42 -0400 (EDT)
Message-ID: <20130905.153842.1587700814364739951.davem@davemloft.net>
References: <002801ce932d$5ea499a0$1bedcce0$@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:40638 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363Ab3IETin (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Sep 2013 15:38:43 -0400
In-Reply-To: <002801ce932d$5ea499a0$1bedcce0$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jg1.han@samsung.com
Cc: linux-ide@vger.kernel.org

From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 07 Aug 2013 14:17:11 +0900

> Added missing __iomem annotation in order to fix the following
> sparse warnings:
> 
> drivers/ide/palm_bk3710.c:194:31: warning: incorrect type in initializer (different address spaces)
> drivers/ide/palm_bk3710.c:194:31:    expected void [noderef] <asn:2>*base
> drivers/ide/palm_bk3710.c:194:31:    got void *<noident>
> drivers/ide/palm_bk3710.c:212:31: warning: incorrect type in initializer (different address spaces)
> drivers/ide/palm_bk3710.c:212:31:    expected void [noderef] <asn:2>*base
> drivers/ide/palm_bk3710.c:212:31:    got void *<noident>
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.
