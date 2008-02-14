From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 09/11] ata: fix sparse warning in pata_marvell.c
Date: Wed, 13 Feb 2008 21:14:29 -0800
Message-ID: <1202966069.2748.25.camel@brick>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:8020 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763566AbYBNFOe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 00:14:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so160082rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 21:14:31 -0800 (PST)
In-Reply-To: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

drivers/ata/pata_marvell.c:88:2: warning: returning void-valued expression

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/pata_marvell.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 9afc8a3..a81f25d 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -85,8 +85,8 @@ static int marvell_cable_detect(struct ata_port *ap)
 
 static void marvell_error_handler(struct ata_port *ap)
 {
-	return ata_bmdma_drive_eh(ap, marvell_pre_reset, ata_std_softreset,
-				  NULL, ata_std_postreset);
+	ata_bmdma_drive_eh(ap, marvell_pre_reset, ata_std_softreset, NULL,
+			   ata_std_postreset);
 }
 
 /* No PIO or DMA methods needed for this device */
-- 
1.5.4.1.1278.gc75be


