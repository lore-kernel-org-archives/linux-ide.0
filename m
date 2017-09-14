From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ata: pata_artop: remove redundant initialization of pio
Date: Thu, 14 Sep 2017 19:54:18 +0100
Message-ID: <20170914185418.13790-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36027 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdINSyW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Sep 2017 14:54:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

pio is initialized and the data is never read, instead it is almost
immediately being updated to a new value. Fix this by removing the
initialization.

Detected by scan-build:
"warning: Value stored to 'pio' during its initialization is never read"

Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/pata_artop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 96c05c9494fa..6b3355343542 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -242,7 +242,7 @@ static void artop6210_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 
 static void artop6260_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
-	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
+	unsigned int pio;
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	u8 ultra;
 
-- 
2.14.1

