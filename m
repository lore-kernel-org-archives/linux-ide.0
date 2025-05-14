Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB31C862D
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243350; cv=none; b=MTVfuxX2mg0aQPdApazCljLMNEhFSKbfDiYO/HqgANR6ucGRQviAM0GVXheL0jp/pGcEiuinnCE/8YFIE+CRAPIv9ArV4JBtZcf1XlKfczb6mne6jSBIFPK3dwEfw5xxPAUaIPjPB2FWa5IyUevTneacdipeYdCLIN1JQ+sg2Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243350; c=relaxed/simple;
	bh=ccyv/e1EqWVAFMibFPmQ0xGhJm+GB6ziuU24yc+Opto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxlI2iW9xJ7MgI5sTCxM+3CV5jP+TCUVwhTgEDCeBKH87Izo/qOzl+Dg4dRGOwLu8wFc2vdQSzfitWE7xfw0n0z3a+5o12lOE+fqTcZ7Bv/5/KGh4uNsk9l9nynv4elC2Ho60cD36jxaqkerYaaUU7+uvPV0dGcNQmvrg1ab4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICR/FnVN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICR/FnVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4410C4CEE3;
	Wed, 14 May 2025 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243349;
	bh=ccyv/e1EqWVAFMibFPmQ0xGhJm+GB6ziuU24yc+Opto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICR/FnVNFw0pm8fb5CTbGScmC5Q0uuuS0ZAK43DR0qu4TzWPkrZ0GFVgA1ipanmCX
	 cWOAdaUS788RU+dLeatbSpVgQP+weq3ISlVkMeTDbUlkrsdNAWhyS0JiAOsL6Cq5Fz
	 ToqlnXVpwsOXawqfgw2MIQBmH7L8fsQHkuf6qjVMxAVeLEBSu8xd/fECd51Wk3arzO
	 /TZNLG+jMpFnlcouEzQHmA43j/PebKWiciVg8aOyeSmB2qRmLIBhMQdxyzscw2EhFk
	 cZNWBg26Wm1Bw4JN6/AVx+MDU+IJ2qKwUBk2zMTc1hcwinWCvNffc/C6Xd7OBB/ZDV
	 ZMGRAKrA9hfEg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 7/7] ata: libata-eh: Always disable DIPM before calling set_lpm() callback
Date: Wed, 14 May 2025 19:22:17 +0200
Message-ID: <20250514172210.383801-16-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514172210.383801-9-cassel@kernel.org>
References: <20250514172210.383801-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=cassel@kernel.org; h=from:subject; bh=ccyv/e1EqWVAFMibFPmQ0xGhJm+GB6ziuU24yc+Opto=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJULrrMP2656uqzQ/eVTVMyztzasEZkk42+r7HTEm7lX aI9QY4yHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIeSzDHz7T4O47OcLCTCYv vjoypsacZzh4Iid88X8m2XknW9surWf4n/vob2btzp4J+ucEb2wNfGLpyNV8VlzY7qDDT6l/VRV MvAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The current code performs a SET FEATURES command to disable DIPM if
policy < ATA_LPM_MED_POWER_WITH_DIPM, this means that it will disable
DIPM for policies:
ATA_LPM_UNKNOWN, ATA_LPM_MAX_POWER, ATA_LPM_MED_POWER
(but not for policy ATA_LPM_MED_POWER_WITH_DIPM).

The code called after calling the set_lpm() callback will later perform
a SET FEATURES command to enable DIPM, if
policy >= ATA_LPM_MED_POWER_WITH_DIPM

It seems very logical to disable DIPM before the set_lpm() callback is
called, because the set_lpm() callback is the function (for AHCI) that
sets the proper bits in PxSCTL.IPM, reflecting the support of the HBA.
PxSCTL.IPM controls the LPM states that the device is allowed to enter.

If the device tries to enter a state disabled by PxSCTL.IPM, the
host will NAK the transition.

It is thus imperative that PxSCTL.IPM is written before DIPM is enabled,
to stop the device from entering a state that the host does not support.

While AHCI 1.3.1, section "8.3.1.1 Device Initiated" states:
"""
By default, a device that supports initiating interface power management
states has the capability disabled.
"""

This makes it seem harmless to not disable DIPM before writing PxSCTL.IPM,
however, SATA 3.5a section "13.3.4 Enable/disable Device-initiated
interface power state transitions feature" states:
"""
If Software Settings Preservation is enabled and Device Initiated
Interface Power Management Software Settings Preservation is supported
(see 13.7.11.2.26), then the enable/disable state shall persist across a
COMRESET.
"""

Further SATA 3.5a, section "13.3.7 Enable/disable Software Settings
Preservation feature" states that:
"""
By default, if the device supports software settings preservation, the
feature is enabled on power-up.
"""

Which means that it is possible that DIPM is enabled at probe time,
even after ata_eh_reset() has performed a COMRESET, thus, make sure that
DIPM is always disabled before calling the set_lpm() callback (which will
write PxSCTL.IPM).

For a LPM policy that includes DIPM, ata_eh_set_lpm() will still enable
DIPM using a SET FEATURES command after the set_lpm() callback has been
called (assuming that both the device and host supports DIPM).

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 91d97d98eed1..1727248f135d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3473,7 +3473,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			hints &= ~ATA_LPM_HIPM;
 
 		/* disable DIPM before changing link config */
-		if (policy < ATA_LPM_MED_POWER_WITH_DIPM && dev_has_dipm) {
+		if (dev_has_dipm) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_DISABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
-- 
2.49.0

