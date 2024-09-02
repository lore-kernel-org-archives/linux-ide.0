Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20F1428E8
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725318440; cv=none; b=tAeeVeEQ/ZEHItreZNHX/dTI+sJddu3irQLdtXz11M+NqEzzABoyPDKvVA7bEzlcedDQD3xskXKKXHQ6aO0IFJltx2niIAe34DKHBQliZunJdGP/zFuIpT1Y29R0B9SLODZqLTsLrM5EZn3LcdkoLaMZpI76G2BJcz/A/ISBjDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725318440; c=relaxed/simple;
	bh=2uZkFjKIa5i0sFf5kGfcY6laQboBXHlaG1SK28KyRms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOVm3HjESr3DlS5wpg7tB/10pH13EbtC+9NrHIsT4HjLktRjLPUFEWQIv/a2DYG6SrUmMQgryhUBlnMZx41I742RzsR7P+jbKfqAsWCGCyLXLlLHzIjTvdGj7ZMFzZQFWCz4Bi3qu5AiYcz3uDk0n7QJrLgxD4rGpMC1CeOpthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5Cn8viJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Cn8viJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833B3C4CEC2;
	Mon,  2 Sep 2024 23:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725318439;
	bh=2uZkFjKIa5i0sFf5kGfcY6laQboBXHlaG1SK28KyRms=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l5Cn8viJx0qFXZSbnMh4c+OoDeFaUm51SDUBpN06aa34D3kbC8wUlsBuxGTiFsAn8
	 r1+PkmUEJIQ1f1tPFwINGLD6u18ZMafBZGeUkLwS2MVAB9XTEPY+vRxMbPWPysmBeU
	 2/n7JfY+Xhrg3pEC9IcaWnW037vvgAy1cr8q2zYQ5Rjr00U6VS3pPlfTc+l/9IOxme
	 nd8vuBnQGEVoWNLMXDmWgyo62Cm6QbBnDG8JBj3FXUmHmT0u2gwVYLdiVHX+wZwS/M
	 MpKvsiWIj+BQdSN1bT8t2xhgHW+xAv4aq63JVH+rhDV2fLOJIAmCRtTevjNi9B/TAo
	 4pN04hRpWqq2Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 4/7] ata: libata: Move sata_std_hardreset() definition to libata-sata.c
Date: Tue,  3 Sep 2024 08:07:12 +0900
Message-ID: <20240902230715.176522-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902230715.176522-1-dlemoal@kernel.org>
References: <20240902230715.176522-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike ata_std_prereset() and ata_std_postreset(), the function
sata_std_hardreset() applies only to SATA devices, as its name implies.
So move its definition to libata-sata.c.

Together with this, also move the definition of sata_port_ops to
libata-sata.c, where it belongs.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 35 -----------------------------------
 drivers/ata/libata-sata.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  9 +++++++--
 3 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b957eb900a00..b5a051bbb01f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -72,14 +72,6 @@ const struct ata_port_operations ata_base_port_ops = {
 	.end_eh			= ata_std_end_eh,
 };
 
-const struct ata_port_operations sata_port_ops = {
-	.inherits		= &ata_base_port_ops,
-
-	.qc_defer		= ata_std_qc_defer,
-	.hardreset		= sata_std_hardreset,
-};
-EXPORT_SYMBOL_GPL(sata_port_ops);
-
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
@@ -3676,33 +3668,6 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 }
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 
-/**
- *	sata_std_hardreset - COMRESET w/o waiting or classification
- *	@link: link to reset
- *	@class: resulting class of attached device
- *	@deadline: deadline jiffies for the operation
- *
- *	Standard SATA COMRESET w/o waiting or classification.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 if link offline, -EAGAIN if link online, -errno on errors.
- */
-int sata_std_hardreset(struct ata_link *link, unsigned int *class,
-		       unsigned long deadline)
-{
-	const unsigned int *timing = sata_ehc_deb_timing(&link->eh_context);
-	bool online;
-	int rc;
-
-	/* do hardreset */
-	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
-	return online ? -EAGAIN : rc;
-}
-EXPORT_SYMBOL_GPL(sata_std_hardreset);
-
 /**
  *	ata_std_postreset - standard postreset callback
  *	@link: the target ata_link
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 124e2b2ea3c0..40f70de94fbd 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -706,6 +706,34 @@ int sata_link_hardreset(struct ata_link *link, const unsigned int *timing,
 }
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
 
+/**
+ *	sata_std_hardreset - COMRESET w/o waiting or classification
+ *	@link: link to reset
+ *	@class: resulting class of attached device
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Standard SATA COMRESET w/o waiting or classification.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 if link offline, -EAGAIN if link online, -errno on errors.
+ */
+int sata_std_hardreset(struct ata_link *link, unsigned int *class,
+		       unsigned long deadline)
+{
+	const unsigned int *timing = sata_ehc_deb_timing(&link->eh_context);
+	bool online;
+	int rc;
+
+	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
+	if (online)
+		return -EAGAIN;
+	return rc;
+}
+EXPORT_SYMBOL_GPL(sata_std_hardreset);
+
 /**
  *	ata_qc_complete_multiple - Complete multiple qcs successfully
  *	@ap: port in question
@@ -1654,3 +1682,11 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
 EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
+
+const struct ata_port_operations sata_port_ops = {
+	.inherits		= &ata_base_port_ops,
+
+	.qc_defer		= ata_std_qc_defer,
+	.hardreset		= sata_std_hardreset,
+};
+EXPORT_SYMBOL_GPL(sata_port_ops);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6552e90753ae..d52ae7723c05 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1104,8 +1104,6 @@ static inline bool ata_port_is_frozen(const struct ata_port *ap)
 extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link));
-extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
-			      unsigned long deadline);
 extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 
 extern struct ata_host *ata_host_alloc(struct device *dev, int n_ports);
@@ -1229,6 +1227,8 @@ extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
 extern int sata_set_spd(struct ata_link *link);
+int sata_std_hardreset(struct ata_link *link, unsigned int *class,
+		       unsigned long deadline);
 extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned int *timing, unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *));
@@ -1256,6 +1256,11 @@ static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 	return -EOPNOTSUPP;
 }
 static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
+static inline int sata_std_hardreset(struct ata_link *link, unsigned int *class,
+				     unsigned long deadline)
+{
+	return -EOPNOTSUPP;
+}
 static inline int sata_link_hardreset(struct ata_link *link,
 				      const unsigned int *timing,
 				      unsigned long deadline,
-- 
2.46.0

