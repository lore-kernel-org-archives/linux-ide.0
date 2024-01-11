Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE44F5E6
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkkIfqkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ADFC433C7;
	Thu, 11 Jan 2024 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704992274;
	bh=tGRVcFEb87U9HU1HpZ1TCWwkaYeOtteFgQa332kODp4=;
	h=From:To:Cc:Subject:Date:From;
	b=DkkIfqkwOr1nZi/U22pLmuh50FKlCsjEIY+y5JepolR9p+qdLYGOZ5fOAahwrarOl
	 Fo9VPDmFsWqKoSIuLnpXd6wI+bEVaoegPFG2DC18svze612cMZ+Obefc8cnfRVmuUq
	 gVLl7l+n4xfjyqla3hZbBR+PEZGWydKV/O7Q7vXW1+h7g5x0Rl/AiCMduz3EZ0DIEY
	 +0AQr4JHtVpp3Lcsrh+uMtOo6u3pH+a8ME/XTD4iZei7LQOC59hUm5gZ/CuAbf4jxI
	 xqVxAcLq2uaGQO8r8rBojiX68DHXjviYWZ87ECql5FLCPVUNcdsWwmABnS6hRrF5CP
	 6j300mUGqbhug==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-sata: improve sysfs description for ATA_LPM_UNKNOWN
Date: Thu, 11 Jan 2024 17:57:44 +0100
Message-ID: <20240111165745.3653361-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, both ATA_LPM_UNKNOWN (0) and ATA_LPM_MAX_POWER (1) displays
as "max_performance" in sysfs.

This is quite misleading as they are not the same.

For ATA_LPM_UNKNOWN, ata_eh_set_lpm() will not be called at all,
leaving the configuration in unknown state.
For ATA_LPM_MAX_POWER, ata_eh_set_lpm() is called, and setting the
policy to ATA_LPM_MAX_POWER.

This also matches the description of the SATA_MOBILE_LPM_POLICY Kconfig:
0 => Keep firmware settings
1 => Maximum performance

Thus, update the sysfs description for ATA_LPM_UNKNOWN to match reality.

While at it, update libata.h to mention that the ascii descriptions
are in libata-sata.c and not in libata-scsi.c.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-sata.c | 2 +-
 include/linux/libata.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index b6656c287175..0fb1934875f2 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -784,7 +784,7 @@ bool sata_lpm_ignore_phy_events(struct ata_link *link)
 EXPORT_SYMBOL_GPL(sata_lpm_ignore_phy_events);
 
 static const char *ata_lpm_policy_names[] = {
-	[ATA_LPM_UNKNOWN]		= "max_performance",
+	[ATA_LPM_UNKNOWN]		= "keep_firmware_settings",
 	[ATA_LPM_MAX_POWER]		= "max_performance",
 	[ATA_LPM_MED_POWER]		= "medium_power",
 	[ATA_LPM_MED_POWER_WITH_DIPM]	= "med_power_with_dipm",
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1dbb14daccfa..26d68115afb8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -471,7 +471,7 @@ enum ata_completion_errors {
 
 /*
  * Link power management policy: If you alter this, you also need to
- * alter libata-scsi.c (for the ascii descriptions)
+ * alter libata-sata.c (for the ascii descriptions)
  */
 enum ata_lpm_policy {
 	ATA_LPM_UNKNOWN,
-- 
2.43.0

