From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: Fix CS5520 and CS5530 dependencies
Date: Mon, 17 Mar 2014 15:58:33 -0400 (EDT)
Message-ID: <20140317.155833.2250421879915712965.davem@davemloft.net>
References: <20140311124454.1238167f@endymion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42257 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbaCQT6f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2014 15:58:35 -0400
In-Reply-To: <20140311124454.1238167f@endymion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jdelvare@suse.de
Cc: linux-ide@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk

From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 11 Mar 2014 12:44:54 +0100

> As far as I know, the CS5520 and CS5530 chipsets were only used with
> 32-bit x86 Geode processors, so I think their drivers are only needed
> on this architecture, except for build testing purpose.
> 
> While we're here, simplify the dependencies for the CS5535 driver.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Applied.
