From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] pata_macio: Delete an error message for a failed memory
 allocation in two functions
Date: Fri, 16 Feb 2018 13:38:20 +0100
Message-ID: <0e764e7d-98cf-7f4e-91ff-bf82aa381442@users.sourceforge.net>
References: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:46065 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966628AbeBPMia (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 16 Feb 2018 07:38:30 -0500
In-Reply-To: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 13:01:45 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_macio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 0adcb40d2794..9588e685d994 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1131,11 +1131,9 @@ static int pata_macio_attach(struct macio_dev *mdev,
 	/* Allocate and init private data structure */
 	priv = devm_kzalloc(&mdev->ofdev.dev,
 			    sizeof(struct pata_macio_priv), GFP_KERNEL);
-	if (priv == NULL) {
-		dev_err(&mdev->ofdev.dev,
-			"Failed to allocate private memory\n");
+	if (!priv)
 		return -ENOMEM;
-	}
+
 	priv->node = of_node_get(mdev->ofdev.dev.of_node);
 	priv->mdev = mdev;
 	priv->dev = &mdev->ofdev.dev;
@@ -1277,11 +1275,9 @@ static int pata_macio_pci_attach(struct pci_dev *pdev,
 	/* Allocate and init private data structure */
 	priv = devm_kzalloc(&pdev->dev,
 			    sizeof(struct pata_macio_priv), GFP_KERNEL);
-	if (priv == NULL) {
-		dev_err(&pdev->dev,
-			"Failed to allocate private memory\n");
+	if (!priv)
 		return -ENOMEM;
-	}
+
 	priv->node = of_node_get(np);
 	priv->pdev = pdev;
 	priv->dev = &pdev->dev;
-- 
2.16.1

