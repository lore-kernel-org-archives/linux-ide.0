From: Colin King <colin.king@canonical.com>
Subject: [PATCH] pata_atiixp: fix trivial indentation misalignment on if statement
Date: Mon, 16 May 2016 12:35:03 +0100
Message-ID: <1463398503-19751-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54446 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbcEPLfL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 May 2016 07:35:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Jiri Kosina <trivial@kernel.org>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Remove extraneous space on if statement and on the following line,
trivial fix, no functional change

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/pata_atiixp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 970f776..49d705c 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -183,8 +183,8 @@ static void atiixp_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	 *	We must now look at the PIO mode situation. We may need to
 	 *	adjust the PIO mode to keep the timings acceptable
 	 */
-	 if (adev->dma_mode >= XFER_MW_DMA_2)
-	 	wanted_pio = 4;
+	if (adev->dma_mode >= XFER_MW_DMA_2)
+		wanted_pio = 4;
 	else if (adev->dma_mode == XFER_MW_DMA_1)
 		wanted_pio = 3;
 	else if (adev->dma_mode == XFER_MW_DMA_0)
-- 
2.8.1

