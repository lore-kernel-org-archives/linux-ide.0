From: Brian King <brking@us.ibm.com>
Subject: [PATCH 1/1] libata: Fixup ata_sas_queuecmd to handle __ata_scsi_queuecmd failure
Date: Mon, 20 Nov 2006 13:51:56 -0600
Message-ID: <200611201951.kAKJpwix023253@d03av03.boulder.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:57837 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S966590AbWKTTwB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Nov 2006 14:52:01 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAKJpxvn031276
	for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2006 14:51:59 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAKJpxSE330624
	for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2006 12:51:59 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAKJpwD3023260
	for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2006 12:51:58 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brking@us.ibm.com


Fixes ata_sas_queuecmd to properly handle a failure from
__ata_scsi_queuecmd. 

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/ata/libata-scsi.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN drivers/ata/libata-scsi.c~libata_sas_qcmd_response drivers/ata/libata-scsi.c
--- libata-dev/drivers/ata/libata-scsi.c~libata_sas_qcmd_response	2006-11-20 13:49:29.000000000 -0600
+++ libata-dev-bjking1/drivers/ata/libata-scsi.c	2006-11-20 13:49:29.000000000 -0600
@@ -3330,20 +3330,23 @@ EXPORT_SYMBOL_GPL(ata_sas_slave_configur
  *	@ap:	ATA port to which the command is being sent
  *
  *	RETURNS:
- *	Zero.
+ *	Return value from __ata_scsi_queuecmd() if @cmd can be queued,
+ *	0 otherwise.
  */
 
 int ata_sas_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
 		     struct ata_port *ap)
 {
+	int rc = 0;
+
 	ata_scsi_dump_cdb(ap, cmd);
 
 	if (likely(ata_scsi_dev_enabled(ap->device)))
-		__ata_scsi_queuecmd(cmd, done, ap->device);
+		rc = __ata_scsi_queuecmd(cmd, done, ap->device);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
 	}
-	return 0;
+	return rc;
 }
 EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
_
