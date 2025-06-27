Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5E42AA6
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986846; cv=none; b=hn85iEao4EIICoyqseBPYH+CZp6V577rCjoW7ekh/9TAy+lmEfkl53tGS8PvTxnzz5fvwpG3qwTKi1wfmV30rhFQwVU5LP6WeSNILuPm4coALg6W7PESANLYSqxQuT4/z/LXbQEgaIb8kKqYzfOCsUa2dxry+4pfeDS/SMVybMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986846; c=relaxed/simple;
	bh=QVMu8FfCgCH8lwbuhRVvP8JQ0eL2frku/JT4z+IjpDY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YT1LxdwgaUXgvsB6WZBFGOkfA73xenidXIMXi8AoI9cc+A7b8FyCWGpclr90bK1h+r7RvfgfgqEtwHNJf+s88/ipXN3a/ESQrmgS5p092TdJ3qqAGXiI7fwvTwaarOCpPXegLJhuVLkGq5kVneaBqg1qqKKDfxQ11hvSnheEu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIqf7I+0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIqf7I+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E26DC4CEEE;
	Fri, 27 Jun 2025 01:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750986844;
	bh=QVMu8FfCgCH8lwbuhRVvP8JQ0eL2frku/JT4z+IjpDY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dIqf7I+07ZXz++3uKqfqQNdamo7K34d/c5JFX1PJk/pRAKxSUpt9L3Ci27AR3Ytjl
	 ihRfRiPcnCBS2jGPQYXfwdEDU5+vWbj7ZB8y5XuOsrLfHYMeJ1QIkQOeQ8kXOMPbAt
	 ruc8ohBpXRiAxF+bWrFAw4xNFtzdrVUPLDIKkGoU3PqiVAcrMJ8jAy5qnSvYupS4ag
	 DL5amGN3aseI6/N8JtFYrR9vBLyd0c3SJbB3Z2sJfAIJGOuf96yWyHyhZ+pFYEbOgM
	 ubX4qQHme0xaoMLiTSA2/tmbi3DOewtJSPMvwOcchlBe0dUxqMUsd2XJxdnbDgmk4H
	 hJvqD5AwdDvHw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6/6] ata: libata-eh: Move and rename ata_eh_set_lpm()
Date: Fri, 27 Jun 2025 10:11:55 +0900
Message-ID: <20250627011155.701125-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627011155.701125-1-dlemoal@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
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
2.49.0

