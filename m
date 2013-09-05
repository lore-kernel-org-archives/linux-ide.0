From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: replace strict_strtol() with kstrtol()
Date: Thu, 05 Sep 2013 15:38:10 -0400 (EDT)
Message-ID: <20130905.153810.1690419991795636927.davem@davemloft.net>
References: <000b01ce844d$c9735490$5c59fdb0$@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:40624 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab3IETiV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Sep 2013 15:38:21 -0400
In-Reply-To: <000b01ce844d$c9735490$5c59fdb0$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jg1.han@samsung.com
Cc: linux-ide@vger.kernel.org

From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 19 Jul 2013 16:01:26 +0900

> The usage of strict_strtol() is not preferred, because
> strict_strtol() is obsolete. Thus, kstrtol() should be
> used.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.
