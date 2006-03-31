From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] libata: fix ata_qc_issue failure path
Date: Fri, 31 Mar 2006 20:36:47 +0900
Message-ID: <20060331113647.GD13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.232]:12280 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751326AbWCaLgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 06:36:53 -0500
Received: by wproxy.gmail.com with SMTP id i22so901137wra
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 03:36:52 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On sg_err failure path, ata_qc_issue() doesn't mark the qc active
before returning.  This triggers WARN_ON() in __ata_qc_complete() when
the qc gets completed.  This patch moves ap->active_tag and
QCFLAG_ACTIVE setting to the top of the function.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2006-03-31 20:28:47.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2006-03-31 20:34:02.000000000 +0900
@@ -4006,6 +4006,9 @@ unsigned int ata_qc_issue(struct ata_que
 {
 	struct ata_port *ap = qc->ap;
 
+	qc->ap->active_tag = qc->tag;
+	qc->flags |= ATA_QCFLAG_ACTIVE;
+
 	if (ata_should_dma_map(qc)) {
 		if (qc->flags & ATA_QCFLAG_SG) {
 			if (ata_sg_setup(qc))
@@ -4020,9 +4023,6 @@ unsigned int ata_qc_issue(struct ata_que
 
 	ap->ops->qc_prep(qc);
 
-	qc->ap->active_tag = qc->tag;
-	qc->flags |= ATA_QCFLAG_ACTIVE;
-
 	return ap->ops->qc_issue(qc);
 
 sg_err:
