Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6419DF99
	for <linux-ide@vger.kernel.org>; Thu, 31 Oct 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383669; cv=none; b=QOoSkf0zZDg2HK4Z8ugDHiieUsybicdXmkaM/M+xNDwBTUUrXQe/p6uLy0QYxxHc3y05TwiAShdkEqpMHpwX4Hb7LkbvINcnKmQo6kmRRptdgvwii7drWBopYWGQb4LuycBBctgFGsh+VhmbnETLFeVGVvHvyLS4zO8dyFSU9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383669; c=relaxed/simple;
	bh=g9hooItluK3QcCdStFILobSmd4YDVsQhVtT6YP1gSrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PULgfu9gYCvlckxrSvoPfKevM/sia8kznwRSYuNg9W5s2eqPXdyFo1O26hIW7t7s0UMFj60DOL3/mxpLyN1jN0g0jWkPUaBPT7fVVu8+sQRdK8L0D3H//OVKX5ih6D5DaD3mDrML2eKbh59eHMzFp8ZvC2hSdIlCGj8V/kYpuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXyQQ7FC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXyQQ7FC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3324CC4CEFE;
	Thu, 31 Oct 2024 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730383669;
	bh=g9hooItluK3QcCdStFILobSmd4YDVsQhVtT6YP1gSrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXyQQ7FCrv3N908KAICBZtJ4ctg3sxSm1YK9SiM/bla3D+xReZaJTWOOjI8Zq57cn
	 xMA1OtlTt2dr26M4lCnsRZRYaOy9s4sdjVQuiwG4ZRUOteZV13Yiiea3eYSEgN/lUT
	 En1BPIPlF0qONmPzZIymlsa9cNW2hSR/d7izgDnE7UVJzUIPBi/iow8FuUlzaT0bI5
	 T+wKlHEzuKu2/KGqTWb2jzIiUuzBUDz4hffTDIrJqJXcAnhv2lBglace15+PrXcBpK
	 gJYDARVle+NNQNanEbl/74J8Zw7FJvsdPCguAO17q/cqLmgaFVybcfmGaLT2MMWvCH
	 tAhA19r2829OQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Xingui Yang <yangxingui@huawei.com>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 1/2] ata: libata: Introduce new helper ata_qc_complete_success()
Date: Thu, 31 Oct 2024 15:07:32 +0100
Message-ID: <20241031140731.224589-5-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031140731.224589-4-cassel@kernel.org>
References: <20241031140731.224589-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5288; i=cassel@kernel.org; h=from:subject; bh=g9hooItluK3QcCdStFILobSmd4YDVsQhVtT6YP1gSrE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKV+5XlLG6KLb0rIBO++ubc6Ec6B/0en13qE99vyxl+r 78r+ujSjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwk+CDDX5F9C3g2XN9c+/Nt iWrh0vC0+vzpG6OvbNYXLFy5NfBQsCDDP7PoedOf/jN8WV5vYDFJLFnI5+J6u8sme5TLms90XeW 7xwkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

For commands that complete successfully, libata performs some additional
post processing.

Move this code to a new helper ata_qc_complete_success(), such that this
code can be reused from other completion paths.

A follow-up commit will make use of this helper.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 105 +++++++++++++++++++++-----------------
 include/linux/libata.h    |   1 +
 2 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c085dd81ebe7..2b7d265e4a7b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4776,59 +4776,18 @@ static void ata_verify_xfer(struct ata_queued_cmd *qc)
 }
 
 /**
- *	ata_qc_complete - Complete an active ATA command
- *	@qc: Command to complete
+ *	ata_qc_complete_success - Post processing needed for a successful QC.
+ *	@qc: Command that was completed successfully
  *
- *	Indicate to the mid and upper layers that an ATA command has
- *	completed, with either an ok or not-ok status.
- *
- *	Refrain from calling this function multiple times when
- *	successfully completing multiple NCQ commands.
- *	ata_qc_complete_multiple() should be used instead, which will
- *	properly update IRQ expect state.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
+ *	When a QC receives a successful completion, we need to perform some
+ *	additional post processing.
  */
-void ata_qc_complete(struct ata_queued_cmd *qc)
+void ata_qc_complete_success(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
 	struct ata_eh_info *ehi = &dev->link->eh_info;
 
-	/* Trigger the LED (if available) */
-	ledtrig_disk_activity(!!(qc->tf.flags & ATA_TFLAG_WRITE));
-
-	/*
-	 * In order to synchronize EH with the regular execution path, a qc that
-	 * is owned by EH is marked with ATA_QCFLAG_EH.
-	 *
-	 * The normal execution path is responsible for not accessing a qc owned
-	 * by EH.  libata core enforces the rule by returning NULL from
-	 * ata_qc_from_tag() for qcs owned by EH.
-	 */
-	if (unlikely(qc->err_mask))
-		qc->flags |= ATA_QCFLAG_EH;
-
-	/*
-	 * Finish internal commands without any further processing and always
-	 * with the result TF filled.
-	 */
-	if (unlikely(ata_tag_internal(qc->tag))) {
-		fill_result_tf(qc);
-		trace_ata_qc_complete_internal(qc);
-		__ata_qc_complete(qc);
-		return;
-	}
-
-	/* Non-internal qc has failed.  Fill the result TF and summon EH. */
-	if (unlikely(qc->flags & ATA_QCFLAG_EH)) {
-		fill_result_tf(qc);
-		trace_ata_qc_complete_failed(qc);
-		ata_qc_schedule_eh(qc);
-		return;
-	}
-
 	WARN_ON_ONCE(ata_port_is_frozen(ap));
 
 	/* read result TF if requested */
@@ -4888,6 +4847,60 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 
 	__ata_qc_complete(qc);
 }
+
+/**
+ *	ata_qc_complete - Complete an active ATA command
+ *	@qc: Command to complete
+ *
+ *	Indicate to the mid and upper layers that an ATA command has
+ *	completed, with either an ok or not-ok status.
+ *
+ *	Refrain from calling this function multiple times when
+ *	successfully completing multiple NCQ commands.
+ *	ata_qc_complete_multiple() should be used instead, which will
+ *	properly update IRQ expect state.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_qc_complete(struct ata_queued_cmd *qc)
+{
+	/* Trigger the LED (if available) */
+	ledtrig_disk_activity(!!(qc->tf.flags & ATA_TFLAG_WRITE));
+
+	/*
+	 * In order to synchronize EH with the regular execution path, a qc that
+	 * is owned by EH is marked with ATA_QCFLAG_EH.
+	 *
+	 * The normal execution path is responsible for not accessing a qc owned
+	 * by EH.  libata core enforces the rule by returning NULL from
+	 * ata_qc_from_tag() for qcs owned by EH.
+	 */
+	if (unlikely(qc->err_mask))
+		qc->flags |= ATA_QCFLAG_EH;
+
+	/*
+	 * Finish internal commands without any further processing and always
+	 * with the result TF filled.
+	 */
+	if (unlikely(ata_tag_internal(qc->tag))) {
+		fill_result_tf(qc);
+		trace_ata_qc_complete_internal(qc);
+		__ata_qc_complete(qc);
+		return;
+	}
+
+	/* Non-internal qc has failed.  Fill the result TF and summon EH. */
+	if (unlikely(qc->flags & ATA_QCFLAG_EH)) {
+		fill_result_tf(qc);
+		trace_ata_qc_complete_failed(qc);
+		ata_qc_schedule_eh(qc);
+		return;
+	}
+
+	/* This point is only reached if QC was successful */
+	ata_qc_complete_success(qc);
+}
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9b4a6ff03235..e6c80557a8c7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1194,6 +1194,7 @@ extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
 extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
 				       struct ata_taskfile *tf, __le16 *id);
+extern void ata_qc_complete_success(struct ata_queued_cmd *qc);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern u64 ata_qc_get_active(struct ata_port *ap);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd);
-- 
2.47.0

