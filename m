From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: Fix SC1200 dependencies
Date: Mon, 17 Mar 2014 15:58:39 -0400 (EDT)
Message-ID: <20140317.155839.1304942520876013229.davem@davemloft.net>
References: <20140314175431.60e30b07@endymion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42261 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbaCQT6l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2014 15:58:41 -0400
In-Reply-To: <20140314175431.60e30b07@endymion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jdelvare@suse.de
Cc: linux-ide@vger.kernel.org

From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 14 Mar 2014 17:54:31 +0100

> The SC1200 is a SoC based on the Geode GX1 32-bit x86 processor, so
> its drivers are only needed on this architecture, except for build
> testing purpose.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Applied.
