Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2703FB7D8
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989346; cv=none; b=Q3fosORKKcAFLa04MIXkf14+juzenwZAyUkkv+Y3/klHI32fykymjW4LwYYBQcpEeE79gFI6vv10F/A3+m9o6u7bK/Rzr5S4eWyzN4zAZCAjA9OEMk+9URo48PuNmDaDWMuY8+fjql7dwM91LwwCda/JijP0Yt/AUTA72j/f8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989346; c=relaxed/simple;
	bh=K9nsuz847tPKwAlY3q0dKcwnpXqUw8chQE9jvma47/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ige6yq4cnufnisD0KkkHsEnRXqo6/9xFbJTp32+wGAX+yOF8DO/yZNy1nU8QffX3Rrv/7icwABAqTRSancahLDYYBStg35ypQ9CI/bIdYWOCu17739PP2yk/1LTdlwAZ45cI7tEQVyc30ciGWbOickBPfF3vbYWOY8aEkIxuyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPSSpXX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPSSpXX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF1E1F00A3A;
	Thu, 28 May 2026 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779989345;
	bh=JpyXZWH1D8oyxdLE9qs0PewKwCtws6YLCgTgexKG49E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YPSSpXX8Q/8zFkdxKnJMsgrAHZ3aecaqX59XhzUxFNx+AXdswzYCMZNB/+3zpxL6v
	 YgxHKZmtsLNfI6sT8Vo1s+ePRt1z1756kPZ47OAYZ/SsfOeOOyPyuiL2zx1RVezHgf
	 J0QJTJbikrjjpj7SpyILnUmtIkIVT0LpWkeKUiTkzHgY+h39bGgUmD1ZFyDuHGCQFl
	 BMHcP6vPhUzQV6E4o49NGmJwfzNSxEmTD63ZKoRqfbDcwa2I1JZDDR/nAB1IGccV5v
	 /Vast3kUSjiEBJhpxQZelo69ghMGMxpZ5MpD/EVEOBxRUcNS5d6Db9SHpAxqXZNbEi
	 7WuoWjAEkjNMA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/3] ata: Annotate functions in the issuing path with __must_hold()
Date: Thu, 28 May 2026 19:28:59 +0200
Message-ID: <20260528172855.703631-8-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528172855.703631-5-cassel@kernel.org>
References: <20260528172855.703631-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4746; i=cassel@kernel.org; h=from:subject; bh=nf/cPrSw/ogydN8M9M1Yb5XTJnDDiDbImbgrWSkOeeo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIkqsPZRUWM3xisDBTfkC72WSic5Tn776LkJZvFTktrH LxSZybeUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIm0cjD8T9/EYnkq8Pa3z+qb vv9S/Orx5+LVu/G3plltnvV7zSR3H0mG/xV+D1Sd2USeRGlnf9jq6nb87Y2Z68/N7FjMF1zPNru knAcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Bart Van Assche <bvanassche@acm.org>

Annotate the following functions used in the issuing path:
ata_qc_issue(), ata_sas_queuecmd(), ata_scsi_qc_issue(),
ata_scsi_translate(), __ata_scsi_queuecmd()

These functions are all used in the issuing path, so context analysis will
be able to verify that the ap lock is held, from it is taken in
sas_queuecommand() or ata_scsi_queuecmd() all the way down to
ata_qc_issue().

Commenting out the spin_lock_irqsave() successfully results in a compiler
error on Clang 23.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Co-developed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 1 +
 drivers/ata/libata-sata.c | 1 +
 drivers/ata/libata-scsi.c | 3 +++
 drivers/ata/libata.h      | 6 ++++--
 include/linux/libata.h    | 3 ++-
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 830ce49587f3..6ff61eff245b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5161,6 +5161,7 @@ EXPORT_SYMBOL_GPL(ata_qc_get_active);
  *	spin_lock_irqsave(host lock)
  */
 void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
+	__must_hold(ap->lock)
 {
 	struct ata_link *link = qc->dev->link;
 	u8 prot = qc->tf.protocol;
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 5e5be6bbf32a..b0706c30da05 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1377,6 +1377,7 @@ EXPORT_SYMBOL_GPL(ata_sas_sdev_configure);
  */
 
 int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	if (likely(ata_dev_enabled(ap->link.device)))
 		return __ata_scsi_queuecmd(cmd, ap->link.device, ap);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c4b53c94c82b..b82a421e2242 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1763,6 +1763,7 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 }
 
 static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
+	__must_hold(ap->lock)
 {
 	int ret;
 
@@ -1848,6 +1849,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
  */
 static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      ata_xlat_func_t xlat_func, struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	struct ata_queued_cmd *qc;
 
@@ -4505,6 +4507,7 @@ static void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 					struct ata_device *dev,
 					struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	u8 scsi_op = scmd->cmnd[0];
 	ata_xlat_func_t xlat_func;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 7f9b889c9239..902c53baa109 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -88,7 +88,8 @@ extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
 					u8 subcmd, u8 action);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
-extern void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc);
+extern void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
+	__must_hold(ap->lock);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern int atapi_check_dma(struct ata_queued_cmd *qc);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
@@ -167,7 +168,8 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct queue_limits *lim,
 		struct ata_device *dev);
 enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 					struct ata_device *dev,
-					struct ata_port *ap);
+					struct ata_port *ap)
+	__must_hold(ap->lock);
 void ata_scsi_deferred_qc_work(struct work_struct *work);
 void ata_scsi_requeue_deferred_qc(struct ata_port *ap);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5f6bbe5d504f..c400aa3af93f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1314,7 +1314,8 @@ extern int ata_tport_add(struct device *parent, struct ata_port *ap);
 extern void ata_tport_delete(struct ata_port *ap);
 int ata_sas_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim,
 			   struct ata_port *ap);
-extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap);
+extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
+	__must_hold(ap->lock);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
-- 
2.54.0

