From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_sil24: fix kernel panic on ARM caused
 by unaligned access in sata_sil24
Date: Fri, 04 Jun 2010 16:19:51 +0200
Message-ID: <4C090B87.1070109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58514 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755896Ab0FDOUe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jun 2010 10:20:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Robin Randhawa <Robin.Randhawa@arm.com>, Colin Tuckley <colin.tuckley@arm.com>

From: Colin Tuckley <colin.tuckley@arm.com>

The sata_sil24 driver has six 16-bit registers that are initialised with
32-bit writes. This cause a kernel panic on ARM due to the unaligned
accesses which result.

This patch changes the accesses to the correct 16-bit ones.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/sata_sil24.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 433b6b8..62ee924 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -539,12 +539,12 @@ static void sil24_config_port(struct ata_port *ap)
 		writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);

 	/* zero error counters. */
-	writel(0x8000, port + PORT_DECODE_ERR_THRESH);
-	writel(0x8000, port + PORT_CRC_ERR_THRESH);
-	writel(0x8000, port + PORT_HSHK_ERR_THRESH);
-	writel(0x0000, port + PORT_DECODE_ERR_CNT);
-	writel(0x0000, port + PORT_CRC_ERR_CNT);
-	writel(0x0000, port + PORT_HSHK_ERR_CNT);
+	writew(0x8000, port + PORT_DECODE_ERR_THRESH);
+	writew(0x8000, port + PORT_CRC_ERR_THRESH);
+	writew(0x8000, port + PORT_HSHK_ERR_THRESH);
+	writew(0x0000, port + PORT_DECODE_ERR_CNT);
+	writew(0x0000, port + PORT_CRC_ERR_CNT);
+	writew(0x0000, port + PORT_HSHK_ERR_CNT);

 	/* always use 64bit activation */
 	writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
