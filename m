From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/15] libata: ata_dev_revalidate() printk update
Date: Sun, 2 Apr 2006 18:51:52 +0900
Message-ID: <11439715123513-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:48058 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932269AbWDBJv6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:51:58 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447005nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:51:57 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
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

e6d04fab401570aa78c946ab3ddf2e923a2f64ac
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 843c08f..120f9cd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1961,12 +1961,8 @@ static int ata_dev_set_mode(struct ata_p
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
@@ -2781,15 +2777,14 @@ static int ata_dev_same_device(struct at
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
@@ -2806,7 +2801,9 @@ int ata_dev_revalidate(struct ata_port *
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


