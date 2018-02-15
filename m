From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] sata_dwc_460ex: Delete an error message for a failed memory
 allocation in sata_dwc_port_start()
Date: Thu, 15 Feb 2018 22:22:16 +0100
Message-ID: <3ba388af-286a-df63-e78f-c82c1d084439@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 22:15:25 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/sata_dwc_460ex.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 6af4ec3c88c3..ce3d6674ef80 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -901,7 +901,6 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	/* Allocate Port Struct */
 	hsdevp = kzalloc(sizeof(*hsdevp), GFP_KERNEL);
 	if (!hsdevp) {
-		dev_err(ap->dev, "%s: kmalloc failed for hsdevp\n", __func__);
 		err = -ENOMEM;
 		goto CLEANUP;
 	}
-- 
2.16.1

