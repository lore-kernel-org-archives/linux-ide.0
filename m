From: Colin King <colin.king@canonical.com>
Subject: [PATCH] pata_serverworks: clean up misaligned indentation
Date: Thu, 14 Mar 2019 23:14:57 +0000
Message-ID: <20190314231457.20966-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several lines that are indented by one space too
many; clean these up.  Also re-work comment block to clean
up cppcheck warnings

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/pata_serverworks.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 57de02123c4c..6083c7acfbca 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -432,10 +432,12 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
 		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
 		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
 
-		 /* If the returned btr is the newer revision then
-		    select the right info block */
-		 if (rc == 3)
-		 	ppi[0] = &info[3];
+		/*
+		 * If the returned btr is the newer revision then
+		 * select the right info block
+		 */
+		if (rc == 3)
+			ppi[0] = &info[3];
 
 		/* Is this the 3rd channel CSB6 IDE ? */
 		if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)
-- 
2.20.1
