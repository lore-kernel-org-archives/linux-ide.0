Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA014EC5B
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986843; cv=none; b=YUmEM1pTih2yD9rIwXTF9meNfKph+S29yKPmBkdkIaLc0FXgHmPCFz03Ihgi4UbZBynODqZPwMLu0mqseYL7o9iiXe2XXe+r7XcL+r9gX9qifitFt+EAVXOWFOzka55Gaw3NfNgGM0nbqb389qkQi5KxkLRzkVwNkBh5FtG4+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986843; c=relaxed/simple;
	bh=dj6PuInXFta/23e8j0gbtdK+Srm0l44lQTKSn6GwIrI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrrMOJ5NBDo8icDT6PkBk2GRpZNOLST/wOedvvSNuT06YywrA1gQkmKpdH/F2xXTJBt3bDshlb/0XZflVGz2d+l0T1aiIE3aGqtqvr/rLnDW3O5F1Uv2dNUKmIiplCmp9qUIIRR6Y9rO2PooDtCwY0LiDl5z/ZgconjL+IYTszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTPZyVok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTPZyVok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00FDC4CEEB;
	Fri, 27 Jun 2025 01:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750986843;
	bh=dj6PuInXFta/23e8j0gbtdK+Srm0l44lQTKSn6GwIrI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OTPZyVokBzefUfrn6H6QLlSj2vJEE0FMP9lbkrITXdvBmxA7d2w9MkrvmWCXIDEwZ
	 ObGWaRgh5ObzbD5P/NuKYl/SB6XDSQAVR6CdsZ+PS9j51trayf1NJFmCUHKEHLp2ig
	 0NZEBTUjSK8tfztv1mZOd+XqSS+nM3MHdJruhpzH5ruWxDuRtgFQlbIZC3PYSNDMsY
	 7fG567HHPExI7pARtU1V/H7SVcoVlMZisabI9G02KJGJcGL5RzbGjv2SawAuuKJKTV
	 e57rPbr+oeUftyRbAVG/srobzaVdO8EiUBMav/fROWGdQlBQMpol+Gsw5AI6wng5dY
	 zhqmtJ20KkFiQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 4/6] ata: libata: Improve LPM policies description
Date: Fri, 27 Jun 2025 10:11:53 +0900
Message-ID: <20250627011155.701125-5-dlemoal@kernel.org>
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

Improve the comments describing the different values of enum
ata_lpm_policy in include/linux/libata.h. The comments match the
description given for the CONFIG_SATA_MOBILE_LPM_POLICY config
parameter.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/libata.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 721f0805b6c9..f8bdf167bad9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -499,16 +499,23 @@ enum ata_completion_errors {
 };
 
 /*
- * Link power management policy: If you alter this, you also need to
- * alter libata-sata.c (for the ascii descriptions)
+ * Link power management policy: If you alter this, you also need to alter
+ * the policy names used with the sysfs attribute link_power_management_policy
+ * defined in libata-sata.c
  */
 enum ata_lpm_policy {
+	/* 0 => Keep firmware settings */
 	ATA_LPM_UNKNOWN,
+	/* 1 => No power savings (maximum performance) */
 	ATA_LPM_MAX_POWER,
+	/* 2 => HIPM (Partial) */
 	ATA_LPM_MED_POWER,
-	ATA_LPM_MED_POWER_WITH_DIPM, /* Med power + DIPM as win IRST does */
-	ATA_LPM_MIN_POWER_WITH_PARTIAL, /* Min Power + partial and slumber */
-	ATA_LPM_MIN_POWER, /* Min power + no partial (slumber only) */
+	/* 3 => HIPM (Partial) and DIPM (Partial and Slumber) */
+	ATA_LPM_MED_POWER_WITH_DIPM,
+	/* 4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber) */
+	ATA_LPM_MIN_POWER_WITH_PARTIAL,
+	/* 5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber) */
+	ATA_LPM_MIN_POWER,
 };
 
 enum ata_lpm_hints {
-- 
2.49.0

