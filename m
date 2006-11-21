From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: don't request sense if the port is frozen
Date: Tue, 21 Nov 2006 10:40:51 +0900
Message-ID: <20061121014051.GQ2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:24414 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030651AbWKUBk7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Nov 2006 20:40:59 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1381373ugc
        for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2006 17:40:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

If EH command is issued to a frozen port, it fails with AC_ERR_SYSTEM.
libata used to request sense even when the port is frozen needlessly
adding AC_ERR_SYSTEM to err_mask.  Don't do it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1136,19 +1136,21 @@ static unsigned int ata_eh_analyze_tf(st
 		break;
 
 	case ATA_DEV_ATAPI:
-		tmp = atapi_eh_request_sense(qc->dev,
-					     qc->scsicmd->sense_buffer);
-		if (!tmp) {
-			/* ATA_QCFLAG_SENSE_VALID is used to tell
-			 * atapi_qc_complete() that sense data is
-			 * already valid.
-			 *
-			 * TODO: interpret sense data and set
-			 * appropriate err_mask.
-			 */
-			qc->flags |= ATA_QCFLAG_SENSE_VALID;
-		} else
-			qc->err_mask |= tmp;
+		if (!(qc->ap->pflags & ATA_PFLAG_FROZEN)) {
+			tmp = atapi_eh_request_sense(qc->dev,
+						     qc->scsicmd->sense_buffer);
+			if (!tmp) {
+				/* ATA_QCFLAG_SENSE_VALID is used to
+				 * tell atapi_qc_complete() that sense
+				 * data is already valid.
+				 *
+				 * TODO: interpret sense data and set
+				 * appropriate err_mask.
+				 */
+				qc->flags |= ATA_QCFLAG_SENSE_VALID;
+			} else
+				qc->err_mask |= tmp;
+		}
 	}
 
 	if (qc->err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT | AC_ERR_ATA_BUS))
