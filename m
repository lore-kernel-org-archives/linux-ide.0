Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454F194098
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010860; cv=none; b=aenIa1nE0w8Knvo8K15P2URk2ayOHuy2aOl6da2XJOZrTkk6QfWGdcx1OORrOZUiEkAw/1KQ4ErPg41Jrj4bQY4mXLpeJPU5kx6J8yx8iSuT68qili8q/9Gt3CGEML4Q8E08IcadCQFlFa6KRg9Ueyq1b/rTGuhhNLRO4ph/Xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010860; c=relaxed/simple;
	bh=1Yb6d8XosbkooT3ZaS5dfwFwoRj40XJl3HBOp268oDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw4kZoM8ZBTBr2eVUjAJRBj7U1Up2EV8bX1W3GgHCOv/3xR84OuAaeek+wGgChJOtdgXobgA7bTTKstE0UODaPkJA9vt3xceYtrb1475OvxBt9sG44cP9qbFSJ+ZlsRvKZdWUpj/XCvKJqD7CKWaC25aGlg9RdauO8pfP91WBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxIe0aYG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxIe0aYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4765C4CEEB;
	Fri, 27 Jun 2025 07:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751010860;
	bh=1Yb6d8XosbkooT3ZaS5dfwFwoRj40XJl3HBOp268oDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxIe0aYGjx9USmfDmumxT25D2x4rO5j+SIEfriSxtcDPY6r60IIdAIxPIa09O7CMw
	 2197/0iAUpBm/ys5lUQINNtr5OLS121EI7/j6KCToeVuEJtI5+TZKPYKYJHA1QfdHm
	 bh3l8ZB23+HTKisCXFF6+seskFncZT1rRSyWyEElBq/UKM6fFGZoA80L/MVoMJDgE+
	 BJ3fBkh3+xBEi6wFjBv2um/hebMn7FzrA3+ztt/z1QykkDmKihaJ9IUmhG76a+QJTI
	 J2L34k8UErCImpNiUcpRKKsBEsEqgu7UArpwVA08JDehjAJg20mvkAH3PJoqvdmQiS
	 K62rSVCjBCPVQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 6/6] ata: libata-eh: Move and rename ata_eh_set_lpm()
Date: Fri, 27 Jun 2025 16:52:07 +0900
Message-ID: <20250627075207.23969-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627075207.23969-1-dlemoal@kernel.org>
References: <20250627075207.23969-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the definition of the function ata_eh_set_lpm() to avoid its
unnecessary forward declaration and rename the function to
ata_eh_link_set_lpm() to clarify that it acts on a link.
No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c | 304 ++++++++++++++++++++--------------------
 1 file changed, 152 insertions(+), 152 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1f90fcd2b3c4..f98d5123e1e4 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -153,8 +153,6 @@ ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
 #undef CMDS
 
 static void __ata_port_freeze(struct ata_port *ap);
-static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
-			  struct ata_device **r_failed_dev);
 #ifdef CONFIG_PM
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
 static void ata_eh_handle_port_resume(struct ata_port *ap);
@@ -2073,6 +2071,154 @@ static void ata_eh_get_success_sense(struct ata_link *link)
 	ata_eh_done(link, dev, ATA_EH_GET_SUCCESS_SENSE);
 }
 
+/**
+ *	ata_eh_link_set_lpm - configure SATA interface power management
+ *	@link: link to configure
+ *	@policy: the link power management policy
+ *	@r_failed_dev: out parameter for failed device
+ *
+ *	Enable SATA Interface power management.  This will enable
+ *	Device Interface Power Management (DIPM) for min_power and
+ *	medium_power_with_dipm policies, and then call driver specific
+ *	callbacks for enabling Host Initiated Power management.
+ *
+ *	LOCKING:
+ *	EH context.
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+static int ata_eh_link_set_lpm(struct ata_link *link,
+			       enum ata_lpm_policy policy,
+			       struct ata_device **r_failed_dev)
+{
+	struct ata_port *ap = ata_is_host_link(link) ? link->ap : NULL;
+	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_device *dev, *link_dev = NULL, *lpm_dev = NULL;
+	enum ata_lpm_policy old_policy = link->lpm_policy;
+	bool host_has_dipm = !(link->ap->flags & ATA_FLAG_NO_DIPM);
+	unsigned int hints = ATA_LPM_EMPTY | ATA_LPM_HIPM;
+	unsigned int err_mask;
+	int rc;
+
+	/* if the link or host doesn't do LPM, noop */
+	if (!IS_ENABLED(CONFIG_SATA_HOST) ||
+	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
+		return 0;
+
+	/*
+	 * This function currently assumes that it will never be supplied policy
+	 * ATA_LPM_UNKNOWN.
+	 */
+	if (WARN_ON_ONCE(policy == ATA_LPM_UNKNOWN))
+		return 0;
+
+	/*
+	 * DIPM is enabled only for ATA_LPM_MIN_POWER,
+	 * ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MED_POWER_WITH_DIPM, as
+	 * some devices misbehave when the host NACKs transition to SLUMBER.
+	 */
+	ata_for_each_dev(dev, link, ENABLED) {
+		bool dev_has_hipm = ata_id_has_hipm(dev->id);
+		bool dev_has_dipm = ata_id_has_dipm(dev->id);
+
+		/* find the first enabled and LPM enabled devices */
+		if (!link_dev)
+			link_dev = dev;
+
+		if (!lpm_dev &&
+		    (dev_has_hipm || (dev_has_dipm && host_has_dipm)))
+			lpm_dev = dev;
+
+		hints &= ~ATA_LPM_EMPTY;
+		if (!dev_has_hipm)
+			hints &= ~ATA_LPM_HIPM;
+
+		/* disable DIPM before changing link config */
+		if (dev_has_dipm) {
+			err_mask = ata_dev_set_feature(dev,
+					SETFEATURES_SATA_DISABLE, SATA_DIPM);
+			if (err_mask && err_mask != AC_ERR_DEV) {
+				ata_dev_warn(dev,
+					     "failed to disable DIPM, Emask 0x%x\n",
+					     err_mask);
+				rc = -EIO;
+				goto fail;
+			}
+		}
+	}
+
+	if (ap) {
+		rc = ap->ops->set_lpm(link, policy, hints);
+		if (!rc && ap->slave_link)
+			rc = ap->ops->set_lpm(ap->slave_link, policy, hints);
+	} else
+		rc = sata_pmp_set_lpm(link, policy, hints);
+
+	/*
+	 * Attribute link config failure to the first (LPM) enabled
+	 * device on the link.
+	 */
+	if (rc) {
+		if (rc == -EOPNOTSUPP) {
+			link->flags |= ATA_LFLAG_NO_LPM;
+			return 0;
+		}
+		dev = lpm_dev ? lpm_dev : link_dev;
+		goto fail;
+	}
+
+	/*
+	 * Low level driver acked the transition.  Issue DIPM command
+	 * with the new policy set.
+	 */
+	link->lpm_policy = policy;
+	if (ap && ap->slave_link)
+		ap->slave_link->lpm_policy = policy;
+
+	/*
+	 * Host config updated, enable DIPM if transitioning to
+	 * ATA_LPM_MIN_POWER, ATA_LPM_MIN_POWER_WITH_PARTIAL, or
+	 * ATA_LPM_MED_POWER_WITH_DIPM.
+	 */
+	ata_for_each_dev(dev, link, ENABLED) {
+		bool dev_has_dipm = ata_id_has_dipm(dev->id);
+
+		if (policy >= ATA_LPM_MED_POWER_WITH_DIPM && host_has_dipm &&
+		    dev_has_dipm) {
+			err_mask = ata_dev_set_feature(dev,
+					SETFEATURES_SATA_ENABLE, SATA_DIPM);
+			if (err_mask && err_mask != AC_ERR_DEV) {
+				ata_dev_warn(dev,
+					"failed to enable DIPM, Emask 0x%x\n",
+					err_mask);
+				rc = -EIO;
+				goto fail;
+			}
+		}
+	}
+
+	link->last_lpm_change = jiffies;
+	link->flags |= ATA_LFLAG_CHANGED;
+
+	return 0;
+
+fail:
+	/* restore the old policy */
+	link->lpm_policy = old_policy;
+	if (ap && ap->slave_link)
+		ap->slave_link->lpm_policy = old_policy;
+
+	/* if no device or only one more chance is left, disable LPM */
+	if (!dev || ehc->tries[dev->devno] <= 2) {
+		ata_link_warn(link, "disabling LPM on the link\n");
+		link->flags |= ATA_LFLAG_NO_LPM;
+	}
+	if (r_failed_dev)
+		*r_failed_dev = dev;
+	return rc;
+}
+
 /**
  *	ata_eh_link_autopsy - analyze error and determine recovery action
  *	@link: host link to perform autopsy on
@@ -3123,8 +3269,8 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			 * to ap->target_lpm_policy after revalidation is done.
 			 */
 			if (link->lpm_policy > ATA_LPM_MAX_POWER) {
-				rc = ata_eh_set_lpm(link, ATA_LPM_MAX_POWER,
-						    r_failed_dev);
+				rc = ata_eh_link_set_lpm(link, ATA_LPM_MAX_POWER,
+							 r_failed_dev);
 				if (rc)
 					goto err;
 			}
@@ -3408,153 +3554,6 @@ static int ata_eh_maybe_retry_flush(struct ata_device *dev)
 	return rc;
 }
 
-/**
- *	ata_eh_set_lpm - configure SATA interface power management
- *	@link: link to configure power management
- *	@policy: the link power management policy
- *	@r_failed_dev: out parameter for failed device
- *
- *	Enable SATA Interface power management.  This will enable
- *	Device Interface Power Management (DIPM) for min_power and
- *	medium_power_with_dipm policies, and then call driver specific
- *	callbacks for enabling Host Initiated Power management.
- *
- *	LOCKING:
- *	EH context.
- *
- *	RETURNS:
- *	0 on success, -errno on failure.
- */
-static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
-			  struct ata_device **r_failed_dev)
-{
-	struct ata_port *ap = ata_is_host_link(link) ? link->ap : NULL;
-	struct ata_eh_context *ehc = &link->eh_context;
-	struct ata_device *dev, *link_dev = NULL, *lpm_dev = NULL;
-	enum ata_lpm_policy old_policy = link->lpm_policy;
-	bool host_has_dipm = !(link->ap->flags & ATA_FLAG_NO_DIPM);
-	unsigned int hints = ATA_LPM_EMPTY | ATA_LPM_HIPM;
-	unsigned int err_mask;
-	int rc;
-
-	/* if the link or host doesn't do LPM, noop */
-	if (!IS_ENABLED(CONFIG_SATA_HOST) ||
-	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
-		return 0;
-
-	/*
-	 * This function currently assumes that it will never be supplied policy
-	 * ATA_LPM_UNKNOWN.
-	 */
-	if (WARN_ON_ONCE(policy == ATA_LPM_UNKNOWN))
-		return 0;
-
-	/*
-	 * DIPM is enabled only for ATA_LPM_MIN_POWER,
-	 * ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MED_POWER_WITH_DIPM, as
-	 * some devices misbehave when the host NACKs transition to SLUMBER.
-	 */
-	ata_for_each_dev(dev, link, ENABLED) {
-		bool dev_has_hipm = ata_id_has_hipm(dev->id);
-		bool dev_has_dipm = ata_id_has_dipm(dev->id);
-
-		/* find the first enabled and LPM enabled devices */
-		if (!link_dev)
-			link_dev = dev;
-
-		if (!lpm_dev &&
-		    (dev_has_hipm || (dev_has_dipm && host_has_dipm)))
-			lpm_dev = dev;
-
-		hints &= ~ATA_LPM_EMPTY;
-		if (!dev_has_hipm)
-			hints &= ~ATA_LPM_HIPM;
-
-		/* disable DIPM before changing link config */
-		if (dev_has_dipm) {
-			err_mask = ata_dev_set_feature(dev,
-					SETFEATURES_SATA_DISABLE, SATA_DIPM);
-			if (err_mask && err_mask != AC_ERR_DEV) {
-				ata_dev_warn(dev,
-					     "failed to disable DIPM, Emask 0x%x\n",
-					     err_mask);
-				rc = -EIO;
-				goto fail;
-			}
-		}
-	}
-
-	if (ap) {
-		rc = ap->ops->set_lpm(link, policy, hints);
-		if (!rc && ap->slave_link)
-			rc = ap->ops->set_lpm(ap->slave_link, policy, hints);
-	} else
-		rc = sata_pmp_set_lpm(link, policy, hints);
-
-	/*
-	 * Attribute link config failure to the first (LPM) enabled
-	 * device on the link.
-	 */
-	if (rc) {
-		if (rc == -EOPNOTSUPP) {
-			link->flags |= ATA_LFLAG_NO_LPM;
-			return 0;
-		}
-		dev = lpm_dev ? lpm_dev : link_dev;
-		goto fail;
-	}
-
-	/*
-	 * Low level driver acked the transition.  Issue DIPM command
-	 * with the new policy set.
-	 */
-	link->lpm_policy = policy;
-	if (ap && ap->slave_link)
-		ap->slave_link->lpm_policy = policy;
-
-	/*
-	 * Host config updated, enable DIPM if transitioning to
-	 * ATA_LPM_MIN_POWER, ATA_LPM_MIN_POWER_WITH_PARTIAL, or
-	 * ATA_LPM_MED_POWER_WITH_DIPM.
-	 */
-	ata_for_each_dev(dev, link, ENABLED) {
-		bool dev_has_dipm = ata_id_has_dipm(dev->id);
-
-		if (policy >= ATA_LPM_MED_POWER_WITH_DIPM && host_has_dipm &&
-		    dev_has_dipm) {
-			err_mask = ata_dev_set_feature(dev,
-					SETFEATURES_SATA_ENABLE, SATA_DIPM);
-			if (err_mask && err_mask != AC_ERR_DEV) {
-				ata_dev_warn(dev,
-					"failed to enable DIPM, Emask 0x%x\n",
-					err_mask);
-				rc = -EIO;
-				goto fail;
-			}
-		}
-	}
-
-	link->last_lpm_change = jiffies;
-	link->flags |= ATA_LFLAG_CHANGED;
-
-	return 0;
-
-fail:
-	/* restore the old policy */
-	link->lpm_policy = old_policy;
-	if (ap && ap->slave_link)
-		ap->slave_link->lpm_policy = old_policy;
-
-	/* if no device or only one more chance is left, disable LPM */
-	if (!dev || ehc->tries[dev->devno] <= 2) {
-		ata_link_warn(link, "disabling LPM on the link\n");
-		link->flags |= ATA_LFLAG_NO_LPM;
-	}
-	if (r_failed_dev)
-		*r_failed_dev = dev;
-	return rc;
-}
-
 int ata_link_nr_enabled(struct ata_link *link)
 {
 	struct ata_device *dev;
@@ -3943,7 +3942,8 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	config_lpm:
 		/* configure link power saving */
 		if (link->lpm_policy != ap->target_lpm_policy) {
-			rc = ata_eh_set_lpm(link, ap->target_lpm_policy, &dev);
+			rc = ata_eh_link_set_lpm(link, ap->target_lpm_policy,
+						 &dev);
 			if (rc)
 				goto rest_fail;
 		}
-- 
2.50.0

