Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C343FAE19
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989345; cv=none; b=mM770aU0yYrA2PUKAPExSseYPNLQMmXhk+IjiVY0N48Ife4Krpu+p+qw2WjwtwBjdqr2Z8M6QT9pRUd+etl68MIeh9l3DWnV9q0UOwMiLhSMeeysj1WJz9SMFFCVrF4VqLv1UdwAvm29igaUX83xU/0sgvrL7KaxSjR1cMDZWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989345; c=relaxed/simple;
	bh=PB1HYjb0pDo32FpqWQfU3E61f4lXA7RWrpHDNFxywfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUmfTP2EZiZ2AccckXIjE5RkRjtYuw4XIAIYk7qaQJ0WifmqJhoUSAZA3XjkS1edDwxNnJVLuQsFYMuLnLa/SmGR393tOHxs8vhvI3pOSBBirrf9XubiQlJ/uVw1N4UKSpVOSu0TmY62WJoCdO9GBiBxB7SSscKyossepFW/ikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ5YFrUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ5YFrUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E036D1F000E9;
	Thu, 28 May 2026 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779989343;
	bh=JJuK1zWXrwZlzwA+9rOsf8QvXoNZWv07um42rzuQJLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJ5YFrUCivPhvc76rhvHroWt8JKsSGrqZScxI/pFD36eaj5QLXW/+uCFtZ0EeEwmo
	 PXSbhYtqKDoN2Zai8EMB9+8oxLFRJ6ahRvrLyckGpL40JIp7vdSAGNhrb8bicYIded
	 z9rGyLCu+krUYgUws3mtI16CgdvIGdT5A4sBbxX+p/YMG4p5bXCxr8ST4/Ip7xBqwV
	 4p2nXot4R+in9hMr+DtsVkduzGsOQ0wGOh3tVf1ja49la1e1ZXviKnVc2VS73DZ++J
	 y6I1GVPzDXqeRsohsDv0W0MV9LF9FfdAaNA/GVstK5fuukaey/WBjcv1d2gDQHPsBW
	 vQKNUlKaFI2tQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/3] ata: libata: Pass ap parameter directly to functions in the issuing path
Date: Thu, 28 May 2026 19:28:58 +0200
Message-ID: <20260528172855.703631-7-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528172855.703631-5-cassel@kernel.org>
References: <20260528172855.703631-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5093; i=cassel@kernel.org; h=from:subject; bh=Xu6V4ORtLO0sFgC6z/NCrpYlz4rrmqGkHfBi2tq5x0k=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIkqsMr9f4f6omzPLJhp+Hv0yKdh4I39+wrm+x37VbGP 7WPaQ8vdJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAilnsYGZ5MfvU9VJiJeZp1 UOqOpHtpq+7P3aadWBuZcOzMrQkhvQ8YGZZ1xz7uNDlYlsDT/1d8yU6ms4UqWzfL6vFpfZJvfhm szgkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Bart Van Assche <bvanassche@acm.org>

Context analysis cannot recognize that qc->ap == ap.

Therefore, grow a struct ata_port parameter to the following functions:
ata_qc_issue(), __ata_scsi_queuecmd(), and ata_scsi_translate()
such that we will be able to enable context analysis in a follow-up commit.

No functionality has been changed.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/libata-core.c |  5 ++---
 drivers/ata/libata-sata.c |  2 +-
 drivers/ata/libata-scsi.c | 15 +++++++--------
 drivers/ata/libata.h      |  5 +++--
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7e9faf2bceb3..830ce49587f3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1605,7 +1605,7 @@ unsigned int ata_exec_internal(struct ata_device *dev, struct ata_taskfile *tf,
 	qc->private_data = &wait;
 	qc->complete_fn = ata_qc_complete_internal;
 
-	ata_qc_issue(qc);
+	ata_qc_issue(ap, qc);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
@@ -5160,9 +5160,8 @@ EXPORT_SYMBOL_GPL(ata_qc_get_active);
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_qc_issue(struct ata_queued_cmd *qc)
+void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap = qc->ap;
 	struct ata_link *link = qc->dev->link;
 	u8 prot = qc->tf.protocol;
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 2ee54d60ea4b..5e5be6bbf32a 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1379,7 +1379,7 @@ EXPORT_SYMBOL_GPL(ata_sas_sdev_configure);
 int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 {
 	if (likely(ata_dev_enabled(ap->link.device)))
-		return __ata_scsi_queuecmd(cmd, ap->link.device);
+		return __ata_scsi_queuecmd(cmd, ap->link.device, ap);
 
 	cmd->result = (DID_BAD_TARGET << 16);
 	scsi_done(cmd);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8bfd3ffd8b89..c4b53c94c82b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1680,7 +1680,7 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
 	if (qc && !ata_port_eh_scheduled(ap)) {
 		WARN_ON_ONCE(ap->ops->qc_defer(qc));
 		ap->deferred_qc = NULL;
-		ata_qc_issue(qc);
+		ata_qc_issue(ap, qc);
 	}
 
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -1815,7 +1815,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	}
 
 issue:
-	ata_qc_issue(qc);
+	ata_qc_issue(ap, qc);
 
 	return 0;
 }
@@ -1847,9 +1847,8 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
  *	command needs to be deferred.
  */
 static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
-			      ata_xlat_func_t xlat_func)
+			      ata_xlat_func_t xlat_func, struct ata_port *ap)
 {
-	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
 
 	/*
@@ -4504,9 +4503,9 @@ static void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 }
 
 enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
-					struct ata_device *dev)
+					struct ata_device *dev,
+					struct ata_port *ap)
 {
-	struct ata_port *ap = dev->link->ap;
 	u8 scsi_op = scmd->cmnd[0];
 	ata_xlat_func_t xlat_func;
 
@@ -4547,7 +4546,7 @@ enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 	}
 
 	if (xlat_func)
-		return ata_scsi_translate(dev, scmd, xlat_func);
+		return ata_scsi_translate(dev, scmd, xlat_func, ap);
 
 	ata_scsi_simulate(dev, scmd);
 
@@ -4593,7 +4592,7 @@ enum scsi_qc_status ata_scsi_queuecmd(struct Scsi_Host *shost,
 
 	dev = ata_scsi_find_dev(ap, scsidev);
 	if (likely(dev))
-		rc = __ata_scsi_queuecmd(cmd, dev);
+		rc = __ata_scsi_queuecmd(cmd, dev, ap);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		scsi_done(cmd);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index b41601ad9d11..7f9b889c9239 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -88,7 +88,7 @@ extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
 					u8 subcmd, u8 action);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
-extern void ata_qc_issue(struct ata_queued_cmd *qc);
+extern void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern int atapi_check_dma(struct ata_queued_cmd *qc);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
@@ -166,7 +166,8 @@ void ata_scsi_sdev_config(struct scsi_device *sdev);
 int ata_scsi_dev_config(struct scsi_device *sdev, struct queue_limits *lim,
 		struct ata_device *dev);
 enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
-					struct ata_device *dev);
+					struct ata_device *dev,
+					struct ata_port *ap);
 void ata_scsi_deferred_qc_work(struct work_struct *work);
 void ata_scsi_requeue_deferred_qc(struct ata_port *ap);
 
-- 
2.54.0

