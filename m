Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3F1D6DBB
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317396; cv=none; b=t67jb9svS8ZNW45E63ssjk/5sGHuFQJGJMvmeERAriKCMFaQaRG7IYo0f8CLlwT+ymHKatho+x1p6sp1YRQqYEwsRxHe4EuQMmvfzyKM8k+CPxQ9iJtZLYvt+qzu1fHDKNUQEB8LlyKRahhexNCDS9uGLWqyMfEa3vTKjv3rUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317396; c=relaxed/simple;
	bh=5bt68W5uoFFbusUWCnmwNKep7ZRI/CIzEKCZVbIxLUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4k0+oMm4jw3/ElkpF7p61Lp5yElnfT00VEIMbi14v68OZnKNMG+mhcEd1hAv3e+HRXyes1f5jg92jZiTA6EKm7MDQ96sm6oKEO9qgn/497n9DKwVn9qm0J0G8TvOI6K0lc4guMeROrr/zOx8m9pKdR4X1V7CMhrAxfKOkaDzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ0WUh2M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ0WUh2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5A0C4CEEB;
	Thu, 15 May 2025 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317396;
	bh=5bt68W5uoFFbusUWCnmwNKep7ZRI/CIzEKCZVbIxLUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJ0WUh2MwYwqlF9RoaV2hZ7A0E8SBbdEh+IG6+bJDkzL6+x7MC3541hae7BNHN7Xr
	 kyd2HYOxnjYMskY+q6E9z2eoktcYsV1aOD/oXQcCSa17kwZvBSKlOEw8fEI5FtvoxP
	 JZo4d1Mf1b0PtdST2K5nx1ySFsS702QKuFAosq5u0lm7ha+vbELzybXNZmrGPlig7P
	 lE2Wj6HSEsZphlna7AhFNjmvPtCixWxaCrhBfTYqlxO7WBGy/yopBC52a5mvBPJGok
	 0z+45qzBtjNHs8LpaXWwORupI0l3llHsEZU4jLHs9g+MDW2sw4fn9nQYYvVwBMEu51
	 rwuRfYm56GOwQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 1/5] ata: libata-eh: Update DIPM comments to reflect reality
Date: Thu, 15 May 2025 15:56:23 +0200
Message-ID: <20250515135622.720623-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515135622.720623-7-cassel@kernel.org>
References: <20250515135622.720623-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; i=cassel@kernel.org; h=from:subject; bh=5bt68W5uoFFbusUWCnmwNKep7ZRI/CIzEKCZVbIxLUY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUP3V12OubHT0caM5eEJ8grPUh/oX8JVO2uhdlM4wql hx/eZOpo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABMJuMzwm2XDHxZ/hbof6t9D T3Ur6/Embg9gKl29wkz6wo3nrlVXlzH8Ty19npgc3Ts1JZ7d3O/V7VQh4+bYn8ysv3pm6dQeFmT hBAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The comments describing which LPM policies that has DIPM enabled predates
the introduction of the LPM policies ATA_LPM_MIN_POWER_WITH_PARTIAL and
ATA_LPM_MED_POWER_WITH_DIPM. Update the DIPM comments to reflect reality.

Also remove the sentence that claims that "Order device and link
configurations such that the host always allows DIPM requests."

This comment is written before 24e0e61db3cb ("ata: libata: disallow
dev-initiated LPM transitions to unsupported states").

Even though the set_lpm() call is done before enabling DIPM, the host will
not always allow DIPM requests. For all LPM polcies where DIPM is enabled,
only DIPM requests to LPM states that are supported by the HBA will be
allowed.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b990c1ee0b12..f39756a26751 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3443,10 +3443,9 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		return 0;
 
 	/*
-	 * DIPM is enabled only for MIN_POWER as some devices
-	 * misbehave when the host NACKs transition to SLUMBER.  Order
-	 * device and link configurations such that the host always
-	 * allows DIPM requests.
+	 * DIPM is enabled only for ATA_LPM_MIN_POWER,
+	 * ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MED_POWER_WITH_DIPM, as
+	 * some devices misbehave when the host NACKs transition to SLUMBER.
 	 */
 	ata_for_each_dev(dev, link, ENABLED) {
 		bool hipm = ata_id_has_hipm(dev->id);
@@ -3505,7 +3504,11 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	if (ap && ap->slave_link)
 		ap->slave_link->lpm_policy = policy;
 
-	/* host config updated, enable DIPM if transitioning to MIN_POWER */
+	/*
+	 * Host config updated, enable DIPM if transitioning to
+	 * ATA_LPM_MIN_POWER, ATA_LPM_MIN_POWER_WITH_PARTIAL, or
+	 * ATA_LPM_MED_POWER_WITH_DIPM.
+	 */
 	ata_for_each_dev(dev, link, ENABLED) {
 		if (policy >= ATA_LPM_MED_POWER_WITH_DIPM && !no_dipm &&
 		    ata_id_has_dipm(dev->id)) {
-- 
2.49.0

