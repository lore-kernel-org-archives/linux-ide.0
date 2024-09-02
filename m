Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F317F394
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278045; cv=none; b=tBWyrsk7oe0zU4y+1k0i3bmKAgsOBUxRC1gUZMwZTIwcDWZ5rcqwJkL03eJ1nL4iVSCdPGTtevJmhsJaT1yNVODtJ7M7ZwUvT2PSS4/QI/mcM/poewE5BFagoygsrLQE3WU5PeZD/vYYHcQmCSNtnKgzkJEIXVeptQS9gA16O2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278045; c=relaxed/simple;
	bh=+kw9c3RIhMbvd/4EA6PjZDZOX+2cVW2WcxGd18GmQ2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3EHv8Npetr8EKz4svswcjVkdLfCB+7ChrPgc8IxNX7kEraT5P3XotyeqaY/uKwIRMZoaKDx2WT53wptWwzvCRPjKMmMTTDvr8qIQGptaCbBRO/NR4Wewq0yLDlSVB9Z2aYXUUptzFjF2865G3lGmv34zIiwoZCtCARZvoXMgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvPTuZSe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvPTuZSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650F5C4CEC7;
	Mon,  2 Sep 2024 11:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725278044;
	bh=+kw9c3RIhMbvd/4EA6PjZDZOX+2cVW2WcxGd18GmQ2k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kvPTuZSeasxAZns9zSP6FtGfZG2NjS/s1WNXxJrk9HEHDWixPYGZwJb4OguX06qIJ
	 fUs0yZb0G35bouAadRI1HrKaIPkiFDMJwpXnffjIeqw+LFgjEcBDjEIjUcTvO1HLOM
	 OlK0REgFB1JcfvzrILHyvxKvAu0Lj34qeNVdukPp3UP3q53xkYlrTsV0AgJTuE0UkD
	 EpXXxpX5kBnSs5jsPt3ujr1lIxZLBlgoJyNXhphG57eVr8p00D3nXp3pP3FZUzgRD7
	 Y2tipfl9gaJ52ukqXgp4B9sn4RIOBvaqAV+An8o283Xd8eC5e0ds48BbNGHWx+BLdN
	 nhoSqBBfRpHSg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 3/7] ata: libata: Move sata_down_spd_limit() to libata-sata.c
Date: Mon,  2 Sep 2024 20:53:56 +0900
Message-ID: <20240902115400.166881-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902115400.166881-1-dlemoal@kernel.org>
References: <20240902115400.166881-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the definition of the function sata_down_spd_limit() to
libata-sata.c where it belongs, together with sata_set_spd().
The helper function ata_sstatus_online() is also changed to be an
inline function defined in drivers/ata/libata.h.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 85 ---------------------------------------
 drivers/ata/libata-sata.c | 80 ++++++++++++++++++++++++++++++++++++
 drivers/ata/libata.h      | 17 +++++++-
 3 files changed, 96 insertions(+), 86 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5acc37397f4b..b957eb900a00 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -167,11 +167,6 @@ static inline bool ata_dev_print_info(const struct ata_device *dev)
 	return ehc->i.flags & ATA_EHI_PRINTINFO;
 }
 
-static bool ata_sstatus_online(u32 sstatus)
-{
-	return (sstatus & 0xf) == 0x3;
-}
-
 /**
  *	ata_link_next - link iteration helper
  *	@link: the previous link, NULL to start
@@ -3200,86 +3195,6 @@ struct ata_device *ata_dev_pair(struct ata_device *adev)
 }
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 
-/**
- *	sata_down_spd_limit - adjust SATA spd limit downward
- *	@link: Link to adjust SATA spd limit for
- *	@spd_limit: Additional limit
- *
- *	Adjust SATA spd limit of @link downward.  Note that this
- *	function only adjusts the limit.  The change must be applied
- *	using sata_set_spd().
- *
- *	If @spd_limit is non-zero, the speed is limited to equal to or
- *	lower than @spd_limit if such speed is supported.  If
- *	@spd_limit is slower than any supported speed, only the lowest
- *	supported speed is allowed.
- *
- *	LOCKING:
- *	Inherited from caller.
- *
- *	RETURNS:
- *	0 on success, negative errno on failure
- */
-int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
-{
-	u32 sstatus, spd, mask;
-	int rc, bit;
-
-	if (!sata_scr_valid(link))
-		return -EOPNOTSUPP;
-
-	/* If SCR can be read, use it to determine the current SPD.
-	 * If not, use cached value in link->sata_spd.
-	 */
-	rc = sata_scr_read(link, SCR_STATUS, &sstatus);
-	if (rc == 0 && ata_sstatus_online(sstatus))
-		spd = (sstatus >> 4) & 0xf;
-	else
-		spd = link->sata_spd;
-
-	mask = link->sata_spd_limit;
-	if (mask <= 1)
-		return -EINVAL;
-
-	/* unconditionally mask off the highest bit */
-	bit = fls(mask) - 1;
-	mask &= ~(1 << bit);
-
-	/*
-	 * Mask off all speeds higher than or equal to the current one.  At
-	 * this point, if current SPD is not available and we previously
-	 * recorded the link speed from SStatus, the driver has already
-	 * masked off the highest bit so mask should already be 1 or 0.
-	 * Otherwise, we should not force 1.5Gbps on a link where we have
-	 * not previously recorded speed from SStatus.  Just return in this
-	 * case.
-	 */
-	if (spd > 1)
-		mask &= (1 << (spd - 1)) - 1;
-	else if (link->sata_spd)
-		return -EINVAL;
-
-	/* were we already at the bottom? */
-	if (!mask)
-		return -EINVAL;
-
-	if (spd_limit) {
-		if (mask & ((1 << spd_limit) - 1))
-			mask &= (1 << spd_limit) - 1;
-		else {
-			bit = ffs(mask) - 1;
-			mask = 1 << bit;
-		}
-	}
-
-	link->sata_spd_limit = mask;
-
-	ata_link_warn(link, "limiting SATA link speed to %s\n",
-		      sata_spd_string(fls(mask)));
-
-	return 0;
-}
-
 #ifdef CONFIG_ATA_ACPI
 /**
  *	ata_timing_cycle2mode - find xfer mode for the specified cycle duration
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index ea6126c139af..124e2b2ea3c0 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -517,6 +517,86 @@ int sata_set_spd(struct ata_link *link)
 }
 EXPORT_SYMBOL_GPL(sata_set_spd);
 
+/**
+ *	sata_down_spd_limit - adjust SATA spd limit downward
+ *	@link: Link to adjust SATA spd limit for
+ *	@spd_limit: Additional limit
+ *
+ *	Adjust SATA spd limit of @link downward.  Note that this
+ *	function only adjusts the limit.  The change must be applied
+ *	using sata_set_spd().
+ *
+ *	If @spd_limit is non-zero, the speed is limited to equal to or
+ *	lower than @spd_limit if such speed is supported.  If
+ *	@spd_limit is slower than any supported speed, only the lowest
+ *	supported speed is allowed.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure
+ */
+int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
+{
+	u32 sstatus, spd, mask;
+	int rc, bit;
+
+	if (!sata_scr_valid(link))
+		return -EOPNOTSUPP;
+
+	/* If SCR can be read, use it to determine the current SPD.
+	 * If not, use cached value in link->sata_spd.
+	 */
+	rc = sata_scr_read(link, SCR_STATUS, &sstatus);
+	if (rc == 0 && ata_sstatus_online(sstatus))
+		spd = (sstatus >> 4) & 0xf;
+	else
+		spd = link->sata_spd;
+
+	mask = link->sata_spd_limit;
+	if (mask <= 1)
+		return -EINVAL;
+
+	/* unconditionally mask off the highest bit */
+	bit = fls(mask) - 1;
+	mask &= ~(1 << bit);
+
+	/*
+	 * Mask off all speeds higher than or equal to the current one.  At
+	 * this point, if current SPD is not available and we previously
+	 * recorded the link speed from SStatus, the driver has already
+	 * masked off the highest bit so mask should already be 1 or 0.
+	 * Otherwise, we should not force 1.5Gbps on a link where we have
+	 * not previously recorded speed from SStatus.  Just return in this
+	 * case.
+	 */
+	if (spd > 1)
+		mask &= (1 << (spd - 1)) - 1;
+	else if (link->sata_spd)
+		return -EINVAL;
+
+	/* were we already at the bottom? */
+	if (!mask)
+		return -EINVAL;
+
+	if (spd_limit) {
+		if (mask & ((1 << spd_limit) - 1))
+			mask &= (1 << spd_limit) - 1;
+		else {
+			bit = ffs(mask) - 1;
+			mask = 1 << bit;
+		}
+	}
+
+	link->sata_spd_limit = mask;
+
+	ata_link_warn(link, "limiting SATA link speed to %s\n",
+		      sata_spd_string(fls(mask)));
+
+	return 0;
+}
+
 /**
  *	sata_link_hardreset - reset link via SATA phy reset
  *	@link: link to reset
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index ab4bd44ba17c..3df17da08c7f 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -38,6 +38,12 @@ extern int libata_noacpi;
 extern int libata_allow_tpm;
 extern const struct device_type ata_port_type;
 extern struct ata_link *ata_dev_phys_link(struct ata_device *dev);
+
+static inline bool ata_sstatus_online(u32 sstatus)
+{
+	return (sstatus & 0xf) == 0x3;
+}
+
 #ifdef CONFIG_ATA_FORCE
 extern void ata_force_cbl(struct ata_port *ap);
 #else
@@ -65,7 +71,6 @@ extern bool ata_dev_power_init_tf(struct ata_device *dev,
 				  struct ata_taskfile *tf, bool set_active);
 extern void ata_dev_power_set_standby(struct ata_device *dev);
 extern void ata_dev_power_set_active(struct ata_device *dev);
-extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
 					u8 subcmd, u8 action);
@@ -87,6 +92,16 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
+/* libata-sata.c */
+#ifdef CONFIG_SATA_HOST
+int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
+#else
+static inline int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
-- 
2.46.0

