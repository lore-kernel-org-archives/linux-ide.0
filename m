From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 27/35] ide: use dev_get_platdata()
Date: Thu, 05 Sep 2013 15:38:35 -0400 (EDT)
Message-ID: <20130905.153835.1261694727181836564.davem@davemloft.net>
References: <005601ce8cfd$22cedd40$686c97c0$@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:40634 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363Ab3IETih (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Sep 2013 15:38:37 -0400
In-Reply-To: <005601ce8cfd$22cedd40$686c97c0$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jg1.han@samsung.com
Cc: linux-ide@vger.kernel.org

From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 30 Jul 2013 17:16:47 +0900

> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.
