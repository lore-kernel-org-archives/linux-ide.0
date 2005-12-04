From: Jeff Garzik <jgarzik@pobox.com>
Subject: [git patch] 2.6.x libata fix
Date: Sat, 3 Dec 2005 20:57:50 -0500
Message-ID: <20051204015750.GA17802@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:26544 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751314AbVLDB57 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Dec 2005 20:57:59 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/libata-scsi.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

Tejun Heo:
      libata: fix ata_scsi_pass_thru error handling

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 3b4ca55..379e870 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2239,7 +2239,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
 	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN)
-		return 1;
+		goto invalid_fld;
 
 	/*
 	 * 12 and 16 byte CDBs use different offsets to
@@ -2301,7 +2301,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	 */
 	if ((tf->command == ATA_CMD_SET_FEATURES)
 	 && (tf->feature == SETFEATURES_XFER))
-		return 1;
+		goto invalid_fld;
 
 	/*
 	 * Set flags so that all registers will be written,
@@ -2322,6 +2322,11 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	qc->nsect = cmd->bufflen / ATA_SECT_SIZE;
 
 	return 0;
+
+ invalid_fld:
+	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x00);
+	/* "Invalid field in cdb" */
+	return 1;
 }
 
 /**
