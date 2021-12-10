Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303DBC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhLJHdo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35076 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbhLJHdZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 626312170E;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPhnFIxjmBXt98cn096HoTLctBFVnctxo8xCa8drYKY=;
        b=buvltI3NvIKI5Py7RzduB1yPT2JMF65KxmcelogwX/9lPWFneEMeOD7OnoPuoWdz6OPc1Y
        gPu0PjgmA7TYzrTvqZJIFnQG0k0L4yC7GR78JAF8gpxVBvUvXb6CbzustC4z4efGyqtp2/
        S9r2XWfjT3jbVUgc2Dr90pbsgD0YkvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPhnFIxjmBXt98cn096HoTLctBFVnctxo8xCa8drYKY=;
        b=sH2BOyAa9umlOVPQfPxm1UrxvXplhyOQSgfEbBXCqYEvkq5JNO3vfWE3hTyGr0ULTSTH3f
        t/w0D+H0G3fPYRBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 5DC96A3BD4;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 5BB7351920A3; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 65/68] libata-scsi: rework ata_dump_status to avoid using pr_cont()
Date:   Fri, 10 Dec 2021 08:29:02 +0100
Message-Id: <20211210072905.15666-66-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

pr_cont() has the problem that individual calls will be disrupted
under high load, causing each call to end up on a single line and
thereby mangling the output.
So rework ata_dump_status() to have just one call to ata_port_warn()
and avoid this problem.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-scsi.c | 49 ++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bbbd0a06ffd2..aab648d20493 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -678,37 +678,32 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	inherited from caller
  */
-static void ata_dump_status(unsigned id, struct ata_taskfile *tf)
+static void ata_dump_status(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	u8 stat = tf->command, err = tf->feature;
 
-	pr_warn("ata%u: status=0x%02x { ", id, stat);
 	if (stat & ATA_BUSY) {
-		pr_cont("Busy }\n");	/* Data is not valid in this case */
+		ata_port_warn(ap, "status=0x%02x {Busy} ", stat);
 	} else {
-		if (stat & ATA_DRDY)	pr_cont("DriveReady ");
-		if (stat & ATA_DF)	pr_cont("DeviceFault ");
-		if (stat & ATA_DSC)	pr_cont("SeekComplete ");
-		if (stat & ATA_DRQ)	pr_cont("DataRequest ");
-		if (stat & ATA_CORR)	pr_cont("CorrectedError ");
-		if (stat & ATA_SENSE)	pr_cont("Sense ");
-		if (stat & ATA_ERR)	pr_cont("Error ");
-		pr_cont("}\n");
-
-		if (err) {
-			pr_warn("ata%u: error=0x%02x { ", id, err);
-			if (err & ATA_ABORTED)	pr_cont("DriveStatusError ");
-			if (err & ATA_ICRC) {
-				if (err & ATA_ABORTED)
-						pr_cont("BadCRC ");
-				else		pr_cont("Sector ");
-			}
-			if (err & ATA_UNC)	pr_cont("UncorrectableError ");
-			if (err & ATA_IDNF)	pr_cont("SectorIdNotFound ");
-			if (err & ATA_TRK0NF)	pr_cont("TrackZeroNotFound ");
-			if (err & ATA_AMNF)	pr_cont("AddrMarkNotFound ");
-			pr_cont("}\n");
-		}
+		ata_port_warn(ap, "status=0x%02x { %s%s%s%s%s%s%s} ", stat,
+			      stat & ATA_DRDY ? "DriveReady " : "",
+			      stat & ATA_DF ? "DeviceFault " : "",
+			      stat & ATA_DSC ? "SeekComplete " : "",
+			      stat & ATA_DRQ ? "DataRequest " : "",
+			      stat & ATA_CORR ? "CorrectedError " : "",
+			      stat & ATA_SENSE ? "Sense " : "",
+			      stat & ATA_ERR ? "Error " : "");
+		if (err)
+			ata_port_warn(ap, "error=0x%02x {%s%s%s%s%s%s", err,
+				      err & ATA_ABORTED ?
+				      "DriveStatusError " : "",
+				      err & ATA_ICRC ?
+				      (err & ATA_ABORTED ?
+				       "BadCRC " : "Sector ") : "",
+				      err & ATA_UNC ? "UncorrectableError " : "",
+				      err & ATA_IDNF ? "SectorIdNotFound " : "",
+				      err & ATA_TRK0NF ? "TrackZeroNotFound " : "",
+				      err & ATA_AMNF ? "AddrMarkNotFound " : "");
 	}
 }
 
@@ -1662,7 +1657,7 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 		cmd->result = SAM_STAT_GOOD;
 
 	if (need_sense && !ap->ops->error_handler)
-		ata_dump_status(ap->print_id, &qc->result_tf);
+		ata_dump_status(ap, &qc->result_tf);
 
 	ata_qc_done(qc);
 }
-- 
2.29.2

