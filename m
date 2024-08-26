Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6774131E4B
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657470; cv=none; b=VD7o5wNprIEKqTAEZl+ogJZNYtUZ9UwMB2HzlNz7OlaHTDakVxy0NL14H7rfiDx3QCrkGALG4rsu91EfILCTrdCrj8tw/M1fmPKY4MI4Tnf7riEqodZmy69BBzbr6buGGQd4FdUTvDSfDiGSbqaMUTD9Gz0BY66rnj3yTcFVKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657470; c=relaxed/simple;
	bh=jU9nreu4bp9n9GnpJBAFSuPiWZ5fbi8Ds6kcMojZ1UQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uchDu/OtgAuJ/bvEdnDlpjVGoG/VlRxqfzEdHMTNOm0ek6wvrNt0+TpDfYbHWvbvQ7ydr3IBffHkQIX9f3QrnFwbTjOQGne8sK7+SyNSe8tHBAWWUB0BWI+EDe45PmvEG3+YROTukm0/WXX5A73EUaHqjvu9swp9LqghRJ2lKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+La4PQC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+La4PQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D87DC8CDC1;
	Mon, 26 Aug 2024 07:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724657470;
	bh=jU9nreu4bp9n9GnpJBAFSuPiWZ5fbi8Ds6kcMojZ1UQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o+La4PQC3J2Y+ThG+1s/WQTeYse1lKy/Xa0Y1gv3YJV7goNSLeUGWZxj8yT2H6C3R
	 VvJiIGsL/YviC4CIan6ESSpK3hHLYnhoE0QkviOAkMgQxzympbEyVxB8zEJ3Tr3y2a
	 Ku9YkIwokG7tzOTAg+W6DYWtbRPXlr6rbKJWhN7K2lcv9OP5TGnUYCSTGCNbZII9ib
	 2z/jBARHgLpwELnlykk8ByPU1MRHDGJUYbEeAMoSXz1jzJOPbVRxlgODUMOvANzGUL
	 n+k0X+woff2M10GWYtkc4AvueRrCX1NPsH2y6R2+HerK4oM83QRTB3bg0C+NrYjsWK
	 n0/DPBiDLMecQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 4/7] ata: libata: Move sata_std_hardreset() definition to libata-sata.c
Date: Mon, 26 Aug 2024 16:31:03 +0900
Message-ID: <20240826073106.56918-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826073106.56918-1-dlemoal@kernel.org>
References: <20240826073106.56918-1-dlemoal@kernel.org>
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
index 549377b82670..286b5699dafd 100644
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
@@ -1656,3 +1684,11 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
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
index 0279c0a6302f..46e35acc611c 100644
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

