Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD89285CB3
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482509; cv=none; b=ihwTvLBZDTsV2hTPCCZJ2rwdhzYEILRpQ7AP85o6EiVFztCqgmzAe/77LPjYa9WQ4mhoZFclijJbR/xNgiOYMfADAH+97aJghIz3XP7UJjmCQpp7z4cCJgY3YF9+YYEpmE1gbnU35ljsUGSbRFpL/WxSRHpMpPufcFOU3Fu0WnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482509; c=relaxed/simple;
	bh=9DyxsG/ZP5zr4YB2rzVbbFXKZaKNfglesOtQAad4LQg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9HgQlP96q/Jwv6vXp9BIS4E4fiBQCAkSRkPqgV02h+fDQM4LJxzsc799/NuKs8p4oEciUbTVIU0gpKt3fLCIWvOeCMT6fRiU1tnEUUr1e55DWV98ZV4ZRUcZLN7lAclUOMfO3WvgimB3d7sPOEIjWgu8+RUcw3XilMYmA1W9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNnUWX83; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNnUWX83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3768EC19424;
	Thu, 19 Feb 2026 06:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771482509;
	bh=9DyxsG/ZP5zr4YB2rzVbbFXKZaKNfglesOtQAad4LQg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JNnUWX83Bo/OZXLpEfROd8YpS+ywmDAbej4pOp33KDUoPnb8Pu3Nk/NyF5YR35XjM
	 ljuzRAxFS1ADc4r6x6GByhO7PuA7XYAdwxCKaZ+pVK61tTlW33CHUgeAyyEPq11MVB
	 TTaQkkgRA0tdyFPaZmq558pcQI6CboEExZdn1b3Me7ov5EwbjJr5lU+9159YBYJb1J
	 sftVsyOqt7R9mq1d1fYJpPesWwrXvaJ3FqHXQNctY5EP5jNGLXTN/5ImJgLgC9hBTz
	 ofgcO16+vvNNfA9vI1ualCKDGV7b4mAmCSes7apLIBXQz2F8iBjUiF5ChMTFwkv1Q2
	 Vw6gpBaxB3wgg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 4/5] ata: libata-scsi: make ata_scsi_simulate() static
Date: Thu, 19 Feb 2026 15:23:11 +0900
Message-ID: <20260219062312.1030867-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219062312.1030867-1-dlemoal@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ata_scsi_simulate() is called only from libata-scsi.c. Move this
function definition as a static function before its call in
__ata_scsi_queuecmd() and remove its declaration from
include/linux/libata.h.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 147 +++++++++++++++++++-------------------
 include/linux/libata.h    |   1 -
 2 files changed, 73 insertions(+), 75 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 41918e21d0f8..ad628b398fc3 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4420,6 +4420,79 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 	return NULL;
 }
 
+/**
+ *	ata_scsi_simulate - simulate SCSI command on ATA device
+ *	@dev: the target device
+ *	@cmd: SCSI command being sent to device.
+ *
+ *	Interprets and directly executes a select list of SCSI commands
+ *	that can be handled internally.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+static void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
+{
+	const u8 *scsicmd = cmd->cmnd;
+	u8 tmp8;
+
+	switch (scsicmd[0]) {
+	case INQUIRY:
+		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_inquiry);
+		break;
+
+	case MODE_SENSE:
+	case MODE_SENSE_10:
+		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_mode_sense);
+		break;
+
+	case READ_CAPACITY:
+	case SERVICE_ACTION_IN_16:
+		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_read_cap);
+		break;
+
+	case REPORT_LUNS:
+		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_report_luns);
+		break;
+
+	case REQUEST_SENSE:
+		ata_scsi_set_sense(dev, cmd, 0, 0, 0);
+		break;
+
+	/* if we reach this, then writeback caching is disabled,
+	 * turning this into a no-op.
+	 */
+	case SYNCHRONIZE_CACHE:
+	case SYNCHRONIZE_CACHE_16:
+		fallthrough;
+
+	/* no-op's, complete with success */
+	case REZERO_UNIT:
+	case SEEK_6:
+	case SEEK_10:
+	case TEST_UNIT_READY:
+		break;
+
+	case SEND_DIAGNOSTIC:
+		tmp8 = scsicmd[1] & ~(1 << 3);
+		if (tmp8 != 0x4 || scsicmd[3] || scsicmd[4])
+			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
+		break;
+
+	case MAINTENANCE_IN:
+		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_maint_in);
+		break;
+
+	/* all other commands */
+	default:
+		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, 0x20, 0x0);
+		/* "Invalid command operation code" */
+		break;
+	}
+
+	scsi_done(cmd);
+}
+
 enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 					struct ata_device *dev)
 {
@@ -4522,80 +4595,6 @@ enum scsi_qc_status ata_scsi_queuecmd(struct Scsi_Host *shost,
 }
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 
-/**
- *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@dev: the target device
- *	@cmd: SCSI command being sent to device.
- *
- *	Interprets and directly executes a select list of SCSI commands
- *	that can be handled internally.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-
-void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
-{
-	const u8 *scsicmd = cmd->cmnd;
-	u8 tmp8;
-
-	switch(scsicmd[0]) {
-	case INQUIRY:
-		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_inquiry);
-		break;
-
-	case MODE_SENSE:
-	case MODE_SENSE_10:
-		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_mode_sense);
-		break;
-
-	case READ_CAPACITY:
-	case SERVICE_ACTION_IN_16:
-		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_read_cap);
-		break;
-
-	case REPORT_LUNS:
-		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_report_luns);
-		break;
-
-	case REQUEST_SENSE:
-		ata_scsi_set_sense(dev, cmd, 0, 0, 0);
-		break;
-
-	/* if we reach this, then writeback caching is disabled,
-	 * turning this into a no-op.
-	 */
-	case SYNCHRONIZE_CACHE:
-	case SYNCHRONIZE_CACHE_16:
-		fallthrough;
-
-	/* no-op's, complete with success */
-	case REZERO_UNIT:
-	case SEEK_6:
-	case SEEK_10:
-	case TEST_UNIT_READY:
-		break;
-
-	case SEND_DIAGNOSTIC:
-		tmp8 = scsicmd[1] & ~(1 << 3);
-		if (tmp8 != 0x4 || scsicmd[3] || scsicmd[4])
-			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		break;
-
-	case MAINTENANCE_IN:
-		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_maint_in);
-		break;
-
-	/* all other commands */
-	default:
-		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, 0x20, 0x0);
-		/* "Invalid command operation code" */
-		break;
-	}
-
-	scsi_done(cmd);
-}
-
 int ata_scsi_add_hosts(struct ata_host *host, const struct scsi_host_template *sht)
 {
 	int i, rc;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 00346ce3af5e..db87c99e4189 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1205,7 +1205,6 @@ extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
 				       struct ata_taskfile *tf, __le16 *id);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern u64 ata_qc_get_active(struct ata_port *ap);
-extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd);
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct gendisk *unused,
 			      sector_t capacity, int geom[]);
-- 
2.53.0

