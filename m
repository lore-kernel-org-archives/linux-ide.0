Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF74C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhLUHWs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55884 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhLUHWo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C9AE51F3BA;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmFMVSq4W84yXFVsd5BF5m3/PRDBgq6bPpQ7WR+XXbc=;
        b=WR1bB4/H3gPf3y1LaDUgrGbqcsLhhkVPTA+7MwSvvYyJtZbwM+Q0PcfbmgHSQyqp7pWwpk
        l63rWVIPG1RITpPL4hC8Xvp430RZIKNuNRfRoSw+gF5t+e4l2Nu38slV/rvuXLwYTJzkA8
        uoWuM9jYYn3hd6xOhIepcER9ahRvi6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmFMVSq4W84yXFVsd5BF5m3/PRDBgq6bPpQ7WR+XXbc=;
        b=iKkYAWRk5FRvzmj99KLjZ9NUKqq7BafKdE6TBidd3rDK1kKPy0DP9tB5oWRRWrlMDbTvLr
        JfviKMfeS0lE/FDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id C44D9A3B8E;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id C28F85192386; Tue, 21 Dec 2021 08:22:41 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/68] libata-scsi: drop DPRINTK calls for cdb translation
Date:   Tue, 21 Dec 2021 08:20:33 +0100
Message-Id: <20211221072131.46673-11-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drop DPRINTK calls for cdb translation as they are already covered
by other traces, and also drop the DPRINTK calls in ata_scsi_hotplug().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-scsi.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b0b7ab46a03c..bfbb4cca4c17 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1469,9 +1469,6 @@ static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc)
 		head  = track % dev->heads;
 		sect  = (u32)block % dev->sectors + 1;
 
-		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
-			(u32)block, track, cyl, head, sect);
-
 		/* Check whether the converted CHS can fit.
 		   Cylinder: 0-65535
 		   Head: 0-15
@@ -1594,7 +1591,6 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
 			goto invalid_fld;
 		break;
 	default:
-		DPRINTK("no-byte command\n");
 		fp = 0;
 		goto invalid_fld;
 	}
@@ -1748,7 +1744,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 early_finish:
 	ata_qc_free(qc);
 	scsi_done(cmd);
-	DPRINTK("EXIT - early finish (good or error)\n");
 	return 0;
 
 err_did:
@@ -1756,12 +1751,10 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	cmd->result = (DID_ERROR << 16);
 	scsi_done(cmd);
 err_mem:
-	DPRINTK("EXIT - internal\n");
 	return 0;
 
 defer:
 	ata_qc_free(qc);
-	DPRINTK("EXIT - defer\n");
 	if (rc == ATA_DEFER_LINK)
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 	else
@@ -2512,8 +2505,6 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	DPRINTK("ATAPI request sense\n");
-
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 
 #ifdef CONFIG_ATA_SFF
@@ -2552,8 +2543,6 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 	qc->complete_fn = atapi_sense_complete;
 
 	ata_qc_issue(qc);
-
-	DPRINTK("EXIT\n");
 }
 
 /*
@@ -2663,7 +2652,6 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;
-		DPRINTK("direction: write\n");
 	}
 
 	qc->tf.command = ATA_CMD_PACKET;
@@ -4053,8 +4041,6 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 	return rc;
 
  bad_cdb_len:
-	DPRINTK("bad CDB len=%u, scsi_op=0x%02x, max=%u\n",
-		scmd->cmd_len, scsi_op, dev->cdb_len);
 	scmd->result = DID_ERROR << 16;
 	scsi_done(scmd);
 	return 0;
@@ -4525,12 +4511,9 @@ void ata_scsi_hotplug(struct work_struct *work)
 		container_of(work, struct ata_port, hotplug_task.work);
 	int i;
 
-	if (ap->pflags & ATA_PFLAG_UNLOADING) {
-		DPRINTK("ENTER/EXIT - unloading\n");
+	if (ap->pflags & ATA_PFLAG_UNLOADING)
 		return;
-	}
 
-	DPRINTK("ENTER\n");
 	mutex_lock(&ap->scsi_scan_mutex);
 
 	/* Unplug detached devices.  We cannot use link iterator here
@@ -4546,7 +4529,6 @@ void ata_scsi_hotplug(struct work_struct *work)
 	ata_scsi_scan_host(ap, 0);
 
 	mutex_unlock(&ap->scsi_scan_mutex);
-	DPRINTK("EXIT\n");
 }
 
 /**
-- 
2.29.2

