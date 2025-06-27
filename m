Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C02264A3
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010859; cv=none; b=eeI99cknQ45iv2Ribs3EQysiMSFfmAk5qMNb0+jo6AE8DGE3jsNynhPfs3XBvD3vcSo1iWKa7LZJJ3i4yET9vEo0ImYBvC6Cl5GuKFSH3+48Srf/5al7bhgz095Dc35wjuin1yq7zDwt179SFIEBuKIXS7mb6QUwkcKr0Bmr9ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010859; c=relaxed/simple;
	bh=H3HmzWxYMS9oIqX8VlzNJpUvKrCtjRSLToi1ePdGhH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioYH67kMoEuMs0hxwAsoijmTST9lBjqmkVg29pF6fM5APbQKlJCW7xXX2EMiS1P1/5bVuxOhxulK0iCgr1ykekdR8Byl8wK7uf3Y0gUJStXg1GC2MD45IEnTa2e71YY502mJvkBBOc8XqiRmml3FB33njvkj5unOueKcdm7DAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1dGFjFq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1dGFjFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6742FC4CEE3;
	Fri, 27 Jun 2025 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751010858;
	bh=H3HmzWxYMS9oIqX8VlzNJpUvKrCtjRSLToi1ePdGhH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1dGFjFqe7sHuNyuzbD+2uFOdkpupRiiTyvXQTgQh4SMqDb3AlnN+D1soNnFksVQr
	 zqsdiG698CI56XqscRM14NtX3MUmg5YOQ2knPfYeQ2gk5YMvks7JlP7+O7SAcwgqp0
	 E5qS40SUqiQDUHRdK/wpekyTznwPMnNy3chSvRSsMqRnvFaC+fqyErkmCNxcffIYan
	 TyyIybfrlyyL2B8iLhnR9JJw25WtOc1IHuthgkId1GXaPt5rIXbaR1sdsmdKofr9oQ
	 fjUK0Fycj/ex6PH0XzuNdMHvvmEjaStqXrmDfSFfGk/6Ebm/0a+TdmWEFT4kf6H7Zi
	 AJXlJ1qjk9krQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 4/6] ata: libata: Improve LPM policies description
Date: Fri, 27 Jun 2025 16:52:05 +0900
Message-ID: <20250627075207.23969-5-dlemoal@kernel.org>
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

Improve the comment describing enum ata_lpm_policy and add comments
within that enum to describe each of the different possible values.
The enum values comments match the description given for the
CONFIG_SATA_MOBILE_LPM_POLICY config parameter.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/libata.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 721f0805b6c9..7462218312ad 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -499,16 +499,28 @@ enum ata_completion_errors {
 };
 
 /*
- * Link power management policy: If you alter this, you also need to
- * alter libata-sata.c (for the ascii descriptions)
+ * Link Power Management (LPM) policies.
+ *
+ * The default LPM policy to use for a device link is defined using these values
+ * with the CONFIG_SATA_MOBILE_LPM_POLICY config option and applied through the
+ * target_lpm_policy field of struct ata_port.
+ *
+ * If you alter this, you also need to alter the policy names used with the
+ * sysfs attribute link_power_management_policy defined in libata-sata.c.
  */
 enum ata_lpm_policy {
+	/* Keep firmware settings */
 	ATA_LPM_UNKNOWN,
+	/* No power savings (maximum performance) */
 	ATA_LPM_MAX_POWER,
+	/* HIPM (Partial) */
 	ATA_LPM_MED_POWER,
-	ATA_LPM_MED_POWER_WITH_DIPM, /* Med power + DIPM as win IRST does */
-	ATA_LPM_MIN_POWER_WITH_PARTIAL, /* Min Power + partial and slumber */
-	ATA_LPM_MIN_POWER, /* Min power + no partial (slumber only) */
+	/* HIPM (Partial) and DIPM (Partial and Slumber) */
+	ATA_LPM_MED_POWER_WITH_DIPM,
+	/* HIPM (Partial and DevSleep) and DIPM (Partial and Slumber) */
+	ATA_LPM_MIN_POWER_WITH_PARTIAL,
+	/* HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber) */
+	ATA_LPM_MIN_POWER,
 };
 
 enum ata_lpm_hints {
-- 
2.50.0

