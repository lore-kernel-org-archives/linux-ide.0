From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix ata_scsi_pass_thru error handling
Date: Fri, 2 Dec 2005 11:49:11 +0900
Message-ID: <20051202024911.GA13292@htj.dyndns.org>
References: <438D5742.3000804@gmail.com> <438FAA8E.9010502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:20586 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964811AbVLBCt3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 21:49:29 -0500
Received: by zproxy.gmail.com with SMTP id 13so4809nzn
        for <linux-ide@vger.kernel.org>; Thu, 01 Dec 2005 18:49:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <438FAA8E.9010502@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: russb@emc.com, Linux-ide <linux-ide@vger.kernel.org>

This patch makes ata_scsi_pass_thru() properly set result code and
sense data on translation failures.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 957a9ca..7445d8b 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2233,7 +2233,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
 	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN)
-		return 1;
+		goto invalid_fld;
 
 	/*
 	 * 12 and 16 byte CDBs use different offsets to
@@ -2295,7 +2295,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	 */
 	if ((tf->command == ATA_CMD_SET_FEATURES)
 	 && (tf->feature == SETFEATURES_XFER))
-		return 1;
+		goto invalid_fld;
 
 	/*
 	 * Set flags so that all registers will be written,
@@ -2316,6 +2316,11 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	qc->nsect = cmd->bufflen / ATA_SECT_SIZE;
 
 	return 0;
+
+ invalid_fld:
+	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x00);
+	/* "Invalid field in cdb" */
+	return 1;
 }
 
 /**
