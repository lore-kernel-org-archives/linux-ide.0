From: Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 1/3] libata: Fixup n_elem initialization
Date: Wed, 17 Jan 2007 12:32:12 -0600
Message-ID: <42966.6685093709$1169058768@news.gmane.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:35607 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932622AbXAQScZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Jan 2007 13:32:25 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0HIWNbS007831
	for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 13:32:23 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0HIWEDs273642
	for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 13:32:14 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0HIWDRN026164
	for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 13:32:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, htejun@gmail.com, brking@linux.vnet.ibm.com


Fixup the inialization of qc->n_elem. It currently gets
initialized to 1 for commands that do not transfer any data.
Fix this by initializing n_elem to 0 and only setting to 1
in ata_scsi_qc_new when there is data to transfer. This fixes
some problems seen with SATA devices attached to ipr adapters.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 linux-2.6-bjking1/drivers/ata/libata-scsi.c |    2 +-
 linux-2.6-bjking1/include/linux/libata.h    |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/ata/libata-scsi.c~libata_fixup_nelem drivers/ata/libata-scsi.c
--- linux-2.6/drivers/ata/libata-scsi.c~libata_fixup_nelem	2007-01-17 08:35:27.000000000 -0600
+++ linux-2.6-bjking1/drivers/ata/libata-scsi.c	2007-01-17 08:35:27.000000000 -0600
@@ -372,7 +372,7 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 		if (cmd->use_sg) {
 			qc->__sg = (struct scatterlist *) cmd->request_buffer;
 			qc->n_elem = cmd->use_sg;
-		} else {
+		} else if (cmd->request_bufflen) {
 			qc->__sg = &qc->sgent;
 			qc->n_elem = 1;
 		}
diff -puN include/linux/libata.h~libata_fixup_nelem include/linux/libata.h
--- linux-2.6/include/linux/libata.h~libata_fixup_nelem	2007-01-17 08:35:27.000000000 -0600
+++ linux-2.6-bjking1/include/linux/libata.h	2007-01-17 11:12:49.000000000 -0600
@@ -1149,6 +1149,7 @@ static inline void ata_qc_reinit(struct 
 	qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 	qc->nsect = 0;
 	qc->nbytes = qc->curbytes = 0;
+	qc->n_elem = 0;
 	qc->err_mask = 0;
 
 	ata_tf_init(qc->dev, &qc->tf);
_
