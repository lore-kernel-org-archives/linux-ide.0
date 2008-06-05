From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] Support SB700 SATA controller PMP
Date: Thu, 5 Jun 2008 17:58:33 +0800
Message-ID: <1212659914.6639.12.camel@zm-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:7864 "EHLO
	VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758476AbYFEJ67 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jun 2008 05:58:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, htejun@gmail.com, shane.huang@amd.com

This patch supports SB700 SATA PMP, this patch depends on
the SB600 SATA PMP patch sent two days ago.

Signed-off-by: Shane Huang <shane.huang@amd.com>

diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c	2008-06-03 15:36:56.000000000 +0800
+++ b/drivers/ata/ahci.c	2008-06-03 15:37:11.000000000 +0800
@@ -385,12 +385,11 @@
 	},
 	/* board_ahci_sb700 */
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
-				 AHCI_HFLAG_NO_PMP),
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
+		.port_ops	= &ahci_sb600_ops,
 	},
 };
 


