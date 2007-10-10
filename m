From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix revalidation issuing after configuration commands
Date: Wed, 10 Oct 2007 15:57:44 +0900
Message-ID: <20071010065744.GO12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:27675 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbXJJG5u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 02:57:50 -0400
Received: by rv-out-0910.google.com with SMTP id k20so107716rvb
        for <linux-ide@vger.kernel.org>; Tue, 09 Oct 2007 23:57:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, idurdanovic@comcast.net

After commands which can change device configuration, EH is scheduled
to revalidate and reconfigure the device.  Host link was incorrectly
used unconditionally when scheduling EH action.  This resulted in
bogus revalidation request and mismatched configuration between device
and driver.  Fix it.

This bug was reported by Igor Durdanovic.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Igor Durdanovic <idurdanovic@comcast.net>
---
 drivers/ata/libata-scsi.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ea53e6a..d63c81e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1363,6 +1363,7 @@ nothing_to_do:
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_eh_info *ehi = &qc->dev->link->eh_info;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
  	int need_sense = (qc->err_mask != 0);
@@ -1376,14 +1377,14 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 		case ATA_CMD_SET_FEATURES:
 			if ((qc->tf.feature == SETFEATURES_WC_ON) ||
 			    (qc->tf.feature == SETFEATURES_WC_OFF)) {
-				ap->link.eh_info.action |= ATA_EH_REVALIDATE;
+				ehi->action |= ATA_EH_REVALIDATE;
 				ata_port_schedule_eh(ap);
 			}
 			break;
 
 		case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
 		case ATA_CMD_SET_MULTI: /* multi_count changed */
-			ap->link.eh_info.action |= ATA_EH_REVALIDATE;
+			ehi->action |= ATA_EH_REVALIDATE;
 			ata_port_schedule_eh(ap);
 			break;
 		}
