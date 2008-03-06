From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 02/16] ata: replace remaining __FUNCTION__ occurrences
Date: Wed, 05 Mar 2008 18:24:52 -0800
Message-ID: <1204770292.14154.38.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:61432 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbYCFCYz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 21:24:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2014416wah.23
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 18:24:54 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

__FUNCTION__ is gcc-specific, use __func__

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/libata-acpi.c   |    8 ++++----
 drivers/ata/libata-core.c   |   14 +++++++-------
 drivers/ata/pata_pdc2027x.c |    2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 9e8ec19..0770cb7 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -382,7 +382,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
-			       __FUNCTION__, ap->port_no);
+			       __func__, ap->port_no);
 
 	/* _GTF has no input parameters */
 	status = acpi_evaluate_object(dev->acpi_handle, "_GTF", NULL, &output);
@@ -402,7 +402,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 		if (ata_msg_probe(ap))
 			ata_dev_printk(dev, KERN_DEBUG, "%s: Run _GTF: "
 				"length or ptr is NULL (0x%llx, 0x%p)\n",
-				__FUNCTION__,
+				__func__,
 				(unsigned long long)output.length,
 				output.pointer);
 		rc = -EINVAL;
@@ -432,7 +432,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 		if (ata_msg_probe(ap))
 			ata_dev_printk(dev, KERN_DEBUG,
 				       "%s: returning gtf=%p, gtf_count=%d\n",
-				       __FUNCTION__, *gtf, rc);
+				       __func__, *gtf, rc);
 	}
 	return rc;
 
@@ -725,7 +725,7 @@ static int ata_acpi_push_id(struct ata_device *dev)
 
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ix = %d, port#: %d\n",
-			       __FUNCTION__, dev->devno, ap->port_no);
+			       __func__, dev->devno, ap->port_no);
 
 	/* Give the drive Identify data to the drive via the _SDD method */
 	/* _SDD: set up input parameters */
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4fbcce7..5310513 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1719,7 +1719,7 @@ void ata_port_flush_task(struct ata_port *ap)
 	cancel_rearming_delayed_work(&ap->port_task);
 
 	if (ata_msg_ctl(ap))
-		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __FUNCTION__);
+		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __func__);
 }
 
 static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
@@ -2056,7 +2056,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	int rc;
 
 	if (ata_msg_ctl(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER\n", __func__);
 
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
  retry:
@@ -2253,12 +2253,12 @@ int ata_dev_configure(struct ata_device *dev)
 
 	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
 		ata_dev_printk(dev, KERN_INFO, "%s: ENTER/EXIT -- nodev\n",
-			       __FUNCTION__);
+			       __func__);
 		return 0;
 	}
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER\n", __func__);
 
 	/* set horkage */
 	dev->horkage |= ata_dev_blacklisted(dev);
@@ -2279,7 +2279,7 @@ int ata_dev_configure(struct ata_device *dev)
 		ata_dev_printk(dev, KERN_DEBUG,
 			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
 			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
-			       __FUNCTION__,
+			       __func__,
 			       id[49], id[82], id[83], id[84],
 			       id[85], id[86], id[87], id[88]);
 
@@ -2511,13 +2511,13 @@ int ata_dev_configure(struct ata_device *dev)
 
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: EXIT, drv_stat = 0x%x\n",
-			__FUNCTION__, ata_chk_status(ap));
+			__func__, ata_chk_status(ap));
 	return 0;
 
 err_out_nosup:
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG,
-			       "%s: EXIT, err\n", __FUNCTION__);
+			       "%s: EXIT, err\n", __func__);
 	return rc;
 }
 
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 028af5d..511c89b 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -39,7 +39,7 @@
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
-#define PDPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#define PDPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
 #else
 #define PDPRINTK(fmt, args...)
 #endif
-- 
1.5.4.GIT


