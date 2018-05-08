From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ata: ata_piix: Fix a possible data race in piix_pci_device_resume
Date: Tue,  8 May 2018 11:46:13 +0800
Message-ID: <20180508034613.12969-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-ide@vger.kernel.org

The write operation to "host->flags" is protected by
the lock on line 1048, but the read operation to
this data on line 1046 is not protected by the lock.
Thus, there may exist a data race for "host->flags".

To fix this data race, the read operation to "host->flags" 
should be also protected by the lock.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ata/ata_piix.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 7ecb1322a514..c99fdf473dee 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1043,8 +1043,8 @@ static int piix_pci_device_resume(struct pci_dev *pdev)
 	unsigned long flags;
 	int rc;
 
+	spin_lock_irqsave(&host->lock, flags);
 	if (host->flags & PIIX_HOST_BROKEN_SUSPEND) {
-		spin_lock_irqsave(&host->lock, flags);
 		host->flags &= ~PIIX_HOST_BROKEN_SUSPEND;
 		spin_unlock_irqrestore(&host->lock, flags);
 
@@ -1060,8 +1060,10 @@ static int piix_pci_device_resume(struct pci_dev *pdev)
 			dev_err(&pdev->dev,
 				"failed to enable device after resume (%d)\n",
 				rc);
-	} else
+	} else {
+		spin_unlock_irqrestore(&host->lock, flags);
 		rc = ata_pci_device_do_resume(pdev);
+	}
 
 	if (rc == 0)
 		ata_host_resume(host);
-- 
2.17.0
