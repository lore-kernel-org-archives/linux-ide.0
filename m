From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 2/8] sata_mv mask all interrupt coalescing bits
Date: Sat, 19 Apr 2008 14:44:42 -0400
Message-ID: <480A3D9A.8050202@rtr.ca>
References: <480A3D2E.4040503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3970 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758335AbYDSSoj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 14:44:39 -0400
In-Reply-To: <480A3D2E.4040503@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Ignore *all* interrupt coalescing bits on all controllers,
not just some of each.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-19 13:01:22.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-19 13:02:17.000000000 -0400
@@ -204,6 +204,7 @@
 	HC_MAIN_RSVD_5		= (0x1fff << 19), /* bits 31-19 */
 	HC_MAIN_RSVD_SOC	= (0x3fffffb << 6),     /* bits 31-9, 7-6 */
 	HC_MAIN_MASKED_IRQS	= (TRAN_LO_DONE | TRAN_HI_DONE |
+				   PORTS_0_3_COAL_DONE | PORTS_4_7_COAL_DONE |
 				   PORTS_0_7_COAL_DONE | GPIO_INT | TWSI_INT |
 				   HC_MAIN_RSVD),
 	HC_MAIN_MASKED_IRQS_5	= (PORTS_0_3_COAL_DONE | PORTS_4_7_COAL_DONE |
