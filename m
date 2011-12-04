From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: convert drivers/ide/* to use
 module_platform_driver()
Date: Sun, 04 Dec 2011 14:03:44 -0500 (EST)
Message-ID: <20111204.140344.632699547937708075.davem@davemloft.net>
References: <1322376711.2226.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:38418 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965Ab1LDTDw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Dec 2011 14:03:52 -0500
In-Reply-To: <1322376711.2226.5.camel@phoenix>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: axel.lin@gmail.com
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org, galak@kernel.crashing.org, linux-ide@vger.kernel.org

From: Axel Lin <axel.lin@gmail.com>
Date: Sun, 27 Nov 2011 14:51:51 +0800

> This patch converts the drivers in drivers/ide/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied.
