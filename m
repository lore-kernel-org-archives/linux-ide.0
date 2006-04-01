From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/14] libata: ata_dev_revalidate() printk update
Date: Sat, 1 Apr 2006 19:48:36 +0900
Message-ID: <11438885161916-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:39690 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751282AbWDAKsl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:41 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210249nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:41 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make sure ata_dev_revalidate() complains on failures and kill
revalidation failure message printed from ata_dev_set_mode().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

48633a90b26ada7104a8e320636f20f642ee2de4
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 93f8bce..402c0e4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1972,12 +1972,8 @@ static int ata_dev_set_mode(struct ata_p
 	}
 
 	rc = ata_dev_revalidate(ap, dev, 0);
-	if (rc) {
-		printk(KERN_ERR
-		       "ata%u: failed to revalidate after set xfermode\n",
-		       ap->id);
+	if (rc)
 		return rc;
-	}
 
 	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
 		dev->xfer_shift, (int)dev->xfer_mode);
@@ -2775,15 +2771,14 @@ static int ata_dev_same_device(struct at
 int ata_dev_revalidate(struct ata_port *ap, struct ata_device *dev,
 		       int post_reset)
 {
-	unsigned int class;
-	u16 *id;
+	unsigned int class = dev->class;
+	u16 *id = NULL;
 	int rc;
 
-	if (!ata_dev_enabled(dev))
-		return -ENODEV;
-
-	class = dev->class;
-	id = NULL;
+	if (!ata_dev_enabled(dev)) {
+		rc = -ENODEV;
+		goto fail;
+	}
 
 	/* allocate & read ID data */
 	rc = ata_dev_read_id(ap, dev, &class, post_reset, &id);
@@ -2800,7 +2795,9 @@ int ata_dev_revalidate(struct ata_port *
 	dev->id = id;
 
 	/* configure device according to the new ID */
-	return ata_dev_configure(ap, dev, 0);
+	rc = ata_dev_configure(ap, dev, 0);
+	if (rc == 0)
+		return 0;
 
  fail:
 	printk(KERN_ERR "ata%u: dev %u revalidation failed (errno=%d)\n",
-- 
1.2.4


