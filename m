Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DCFC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbhLHQgh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37726 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 41D3A1FE03;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eais9MVe4k5WHbvq/dRA6+sCyUZhCgS82mSF8rLyAbY=;
        b=EiTK35xUjdCxUtXoxPyrY2/6LVRtKhwFy5q9mECuAb7cIS7uxrTZFXCgUrPQJEwKew5vZb
        BNn99wGEXPO7UOCopsRpgJefjs+nc72ZG4lH7azZj0m1zrh9F8c3qTvfX5I98laTgdo4XM
        Q3DyA5hIgSDsDDcBwi5lsIr6A1Sijn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eais9MVe4k5WHbvq/dRA6+sCyUZhCgS82mSF8rLyAbY=;
        b=0GBSnlN0Qfx8l0tqGdLCURoe3iGvD0ajvKR7ZJczTXjvKkVATXOnf3N3EgCD0lbgr/XHmW
        1kWsag5y8XYfxiCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 3F06CA3BA4;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 3C0A75191F7F; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/73] libata-scsi: drop DPRINTK calls for cdb translation
Date:   Wed,  8 Dec 2021 17:31:59 +0100
Message-Id: <20211208163255.114660-18-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
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
index 1b84d5526d77..4df7cbf6abe6 100644
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
@@ -4048,8 +4036,6 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 	return rc;
 
  bad_cdb_len:
-	DPRINTK("bad CDB len=%u, scsi_op=0x%02x, max=%u\n",
-		scmd->cmd_len, scsi_op, dev->cdb_len);
 	scmd->result = DID_ERROR << 16;
 	scsi_done(scmd);
 	return 0;
@@ -4520,12 +4506,9 @@ void ata_scsi_hotplug(struct work_struct *work)
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
@@ -4541,7 +4524,6 @@ void ata_scsi_hotplug(struct work_struct *work)
 	ata_scsi_scan_host(ap, 0);
 
 	mutex_unlock(&ap->scsi_scan_mutex);
-	DPRINTK("EXIT\n");
 }
 
 /**
-- 
2.29.2

