From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] libata-scsi: Delete an unnecessary variable in
 ata_scsi_slave_config()
Date: Fri, 16 Feb 2018 18:26:30 +0100
Message-ID: <52d9a12e-e420-b880-ac02-c8156d977264@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 18:19:13 +0100

* Return a result code without storing it in an intermediate variable.

* Reduce the needed source code.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/libata-scsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 66be961c93a4..93456cff051b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1345,14 +1345,9 @@ int ata_scsi_slave_config(struct scsi_device *sdev)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
-	int rc = 0;
 
 	ata_scsi_sdev_config(sdev);
-
-	if (dev)
-		rc = ata_scsi_dev_config(sdev, dev);
-
-	return rc;
+	return dev ? ata_scsi_dev_config(sdev, dev) : 0;
 }
 
 /**
-- 
2.16.1

