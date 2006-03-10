From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 5/5] libata-dev: Add back irq-pio patches, etc.
Date: Fri, 10 Mar 2006 23:55:59 +0800
Message-ID: <4411A18F.8010009@tw.ibm.com>
References: <44119BC9.8080502@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:51154 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751676AbWCJP4F
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Mar 2006 10:56:05 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2AFtrb1013998
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 10:55:53 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2AFwjQP165558
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 08:58:45 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2AFtqgq027287
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 08:55:53 -0700
In-Reply-To: <44119BC9.8080502@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Add back irq-pio patches, etc.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

---

Changes:
- add back irq-pio patches removed in patch 3/5.
- ata_dev_revalidate() by Tejun
- remove redundant ap->hsm_task_state = HSM_ST_IDLE in ata_qc_timeout().

--- catchup3/drivers/scsi/libata-core.c	2006-03-10 18:04:35.000000000 +0800
+++ catchup4/drivers/scsi/libata-core.c	2006-03-10 18:11:56.000000000 +0800
@@ -1159,6 +1159,12 @@ static int ata_dev_configure(struct ata_
 				       dev->cylinders, dev->heads, dev->sectors);
 		}
 
+		if (dev->id[59] & 0x100) {
+			dev->multi_count = dev->id[59] & 0xff;
+			DPRINTK("ata%u: dev %u multi count %u\n",
+				ap->id, device, dev->multi_count);
+		}
+
 		dev->cdb_len = 16;
 	}
 
@@ -1172,6 +1178,9 @@ static int ata_dev_configure(struct ata_
 		}
 		dev->cdb_len = (unsigned int) rc;
 
+		if (ata_id_cdb_intr(dev->id))
+			dev->flags |= ATA_DFLAG_CDB_INTR;
+
 		/* print device info to dmesg */
 		if (print_info)
 			printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
@@ -1618,6 +1627,12 @@ static void ata_dev_set_mode(struct ata_
 	idx = ofs + dev->xfer_shift;
 	WARN_ON(idx >= ARRAY_SIZE(xfer_mode_str));
 
+	if (ata_dev_revalidate(ap, dev, 0)) {
+		printk(KERN_ERR "ata%u: failed to revalidate after set "
+		       "xfermode, disabled\n", ap->id);
+		ata_port_disable(ap);
+	}
+
 	DPRINTK("idx=%d xfer_shift=%u, xfer_mode=0x%x, base=0x%x, offset=%d\n",
 		idx, dev->xfer_shift, (int)dev->xfer_mode, (int)base, ofs);
 
@@ -3853,8 +3868,6 @@ static void ata_qc_timeout(struct ata_qu
 		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
-		ap->hsm_task_state = HSM_ST_IDLE;
-
 		/* complete taskfile transaction */
 		qc->err_mask |= AC_ERR_TIMEOUT;
 		break;


