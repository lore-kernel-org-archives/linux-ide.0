From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/4] libata-dev: Use new AC_ERR_* flags
Date: Wed, 08 Feb 2006 16:50:29 +0800
Message-ID: <43E9B0D5.6070806@tw.ibm.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com> <43E9AD00.8070900@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:25993 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030584AbWBHIuj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Feb 2006 03:50:39 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k188oXQa029928
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 03:50:33 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k188qx5b191974
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:52:59 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k188oWxO028681
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:50:32 -0700
In-Reply-To: <43E9AD00.8070900@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Patch 3/4:

Changes:
  - Use new AC_ERR_* flags as done in Tejun's patches
  - In ata_qc_timeout(), replace ac_err_mask(drv_stat) with AC_ERR_TIMEOUT.
    This makes time out handler always report error to upper layer.
    Otherwise if the drv_stat looks good, libata might falsely report OK to the upper layer.

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

===

--- queuework/drivers/scsi/libata-core.c	2006-02-08 14:06:41.000000000 +0800
+++ errmask/drivers/scsi/libata-core.c	2006-02-08 14:42:34.000000000 +0800
@@ -3315,7 +3315,7 @@ static int ata_pio_first_block(struct at
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
 	if (ata_busy_sleep(ap, ATA_TMOUT_DATAOUT_QUICK, ATA_TMOUT_DATAOUT)) {
-		qc->err_mask |= AC_ERR_ATA_BUS;
+		qc->err_mask |= AC_ERR_TIMEOUT;
 		ap->hsm_task_state = HSM_ST_TMOUT;
 		goto err_out;
 	}
@@ -3324,7 +3324,7 @@ static int ata_pio_first_block(struct at
 	status = ata_chk_status(ap);
 	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
 		/* device status error */
-		qc->err_mask |= AC_ERR_ATA_BUS;
+		qc->err_mask |= AC_ERR_HSM;
 		ap->hsm_task_state = HSM_ST_ERR;
 		goto err_out;
 	}
@@ -3684,7 +3684,7 @@ static void ata_qc_timeout(struct ata_qu
 		ap->hsm_task_state = HSM_ST_IDLE;
 
 		/* complete taskfile transaction */
-		qc->err_mask |= ac_err_mask(drv_stat);
+		qc->err_mask |= AC_ERR_TIMEOUT;
 		break;
 	}
 
@@ -4365,7 +4365,7 @@ fsm_start:
 		/* check device status */
 		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
 			/* Wrong status. Let EH handle this */
-			qc->err_mask |= AC_ERR_ATA_BUS;
+			qc->err_mask |= AC_ERR_HSM;
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
@@ -4394,7 +4394,7 @@ fsm_start:
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
 				/* handle BSY=0, DRQ=0 as error */
-				qc->err_mask |= AC_ERR_ATA_BUS;
+				qc->err_mask |= AC_ERR_HSM;
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
 			}
@@ -4416,7 +4416,7 @@ fsm_start:
 	case HSM_ST_LAST:
 		if (unlikely(status & ATA_DRQ)) {
 			/* handle DRQ=1 as error */
-			qc->err_mask |= AC_ERR_ATA_BUS;
+			qc->err_mask |= AC_ERR_HSM;
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}



