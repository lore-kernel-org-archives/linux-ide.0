From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: limit sata_rcar host driver to ARCH_SHMOBILE
Date: Tue, 25 Mar 2014 20:10:27 +0100
Message-ID: <9835622.nRa3VdL61G@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:41860 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbaCYTKt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2014 15:10:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Limit sata_rcar host driver to ARCH_SHMOBILE as Renesas R-Car SATA
support is specific to Renesas SoCs and the driver to work requires
suitable device tree node (or platform device) to be defined.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2014-03-25 19:52:31.952327027 +0100
+++ b/drivers/ata/Kconfig	2014-03-25 19:57:21.104322097 +0100
@@ -298,6 +298,7 @@ config SATA_PROMISE
 
 config SATA_RCAR
 	tristate "Renesas R-Car SATA support"
+	depends on ARCH_SHMOBILE
 	help
 	  This option enables support for Renesas R-Car Serial ATA.
 

