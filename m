From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] atm: libahci: replace obselete simple_strtoul() with
 kstrtouint()
Date: Wed, 19 Feb 2014 01:05:09 -0500 (EST)
Message-ID: <20140219.010509.484470671732800480.davem@davemloft.net>
References: <1983660.RVkLooTtjT@daeseok-laptop.cloud.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:39027 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaBSGFL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 01:05:11 -0500
In-Reply-To: <1983660.RVkLooTtjT@daeseok-laptop.cloud.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: daeseok.youn@gmail.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Daeseok Youn <daeseok.youn@gmail.com>
Date: Wed, 19 Feb 2014 14:09:49 +0900

> From 18bd7236f36a248a0871f810cec3c1e98f098a91 Mon Sep 17 00:00:00 2001
> From: Daeseok Youn <daeseok.youn@gmail.com>
> Date: Wed, 19 Feb 2014 13:44:24 +0900
> Subject: [PATCH] atm: libahci: replace obselete simple_strtoul() with
>  kstrtouint()
> 
> Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>

Please fix your Subject line, you meant "ata: " not "atm: "
