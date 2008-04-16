From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/07] sata_mv disable hotplug for now
Date: Wed, 16 Apr 2008 14:57:25 -0400
Message-ID: <48064C15.9090109@rtr.ca>
References: <48064BCC.5070505@rtr.ca> <48064BF3.8010301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2654 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755423AbYDPS50 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2008 14:57:26 -0400
In-Reply-To: <48064BF3.8010301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Disable hot plug/unplug detection in sata_mv for now.
It is currently broken, and also interferes with PMP support.

This will get fixed in a subsequent patch series.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-15 18:16:29.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-15 18:20:02.000000000 -0400
@@ -42,6 +42,8 @@
 
   6) Add port multiplier support (intermediate)
 
+  7) Fix/reenable hot plug/unplug (should happen as a side-effect of (2) above).
+
   8) Develop a low-power-consumption strategy, and implement it.
 
   9) [Experiment, low priority] See if ATAPI can be supported using
@@ -296,7 +298,9 @@
 	EDMA_ERR_IRQ_TRANSIENT  = EDMA_ERR_LNK_CTRL_RX_0 |
 				  EDMA_ERR_LNK_CTRL_RX_1 |
 				  EDMA_ERR_LNK_CTRL_RX_3 |
-				  EDMA_ERR_LNK_CTRL_TX,
+				  EDMA_ERR_LNK_CTRL_TX |
+				 /* temporary, until we fix hotplug: */
+				 (EDMA_ERR_DEV_DCON | EDMA_ERR_DEV_CON),
 
 	EDMA_EH_FREEZE		= EDMA_ERR_D_PAR |
 				  EDMA_ERR_PRD_PAR |
