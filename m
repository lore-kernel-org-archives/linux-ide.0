Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4051C8621
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243339; cv=none; b=K9C6kU0M5Ngo2ogayrSrO052cLaZfTjIpZt3apoOPjzbk6BkdOv2RDCTvM12yjQ3iNRCPtlOgk+m09QeqR4fhT6K7f3IfBsBRoPD+OCmRcL1mBNQCTwte1Ak/o93jYiCJmxjCXNHd2AgzwNYc9CqVIAQ/isaSMjuSaEodQN5CLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243339; c=relaxed/simple;
	bh=mDjBa05Wd8XWRi7YnZRidzICSK8bLE0v6Bob/2IxjeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THuEXZCMKtTVe57T43AmZB24CPO+1EhhuhwkXHAy44l/RrVpwPn2ibhWGB1GiRyG+N+dDGbHZHnRHVvOPayBbLulzJslsrI6Ry8wjyMnuzB2pQuP1B8qF6N8UbM1oND8U9CuSZMj1GFs7SRITrl/Y6jXt9b8nkmindswO0klV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9A520kz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9A520kz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E036C4CEE3;
	Wed, 14 May 2025 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243339;
	bh=mDjBa05Wd8XWRi7YnZRidzICSK8bLE0v6Bob/2IxjeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9A520kzugARobUY8CtcGv2RSRrlxNASG4+pp6lag/UvgB59T4wx41It5e9nzaKub
	 BkMdjYRrV4M/Mzt1bqcuxelYY2O0b3rrX85uZIGggT17nE6lsOmD7Ewe4uHepDwIXC
	 oVZw0I9ybuW9c3M9C4zxviH6Juh+Eu0i3AeFV/LifnSsu1UQVqBN4bf5W4oWmsfVKN
	 L+HPw4u9XxPVf2R3W3vEmtS7s9LdwDdEOWc4n9N8LkX7VaLidd6gpHocBeTXrwryLR
	 KEJ9uUwPZYRFQS+rL1zuFvV+TzxNNwmr62UhF89Tu4uCMj8b4W6krjPcTpppfRRvTI
	 16WktIXGosHGg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 1/7] ata: libata-eh: Update DIPM comments to reflect reality
Date: Wed, 14 May 2025 19:22:11 +0200
Message-ID: <20250514172210.383801-10-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514172210.383801-9-cassel@kernel.org>
References: <20250514172210.383801-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=cassel@kernel.org; h=from:subject; bh=mDjBa05Wd8XWRi7YnZRidzICSK8bLE0v6Bob/2IxjeE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJULjod3+DA4PvCOOHyNQHzMHb+lWKt71+1qx/+OVsr7 OVZDrdlHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjInihGhhsqms07J8Q4Wn/7 EHLF65J2dWT31cO6K1cdn3vi0JyKC9yMDA+LJ0hEamxRlZVYesXf/N37I+5hq96ZTjQQ2Lrlj1t GGwcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The comments describing which LPM policies that has DIPM enabled predates
the introduction of the LPM policies ATA_LPM_MIN_POWER_WITH_PARTIAL and
ATA_LPM_MED_POWER_WITH_DIPM.

Update the DIPM comments to reflect reality.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b990c1ee0b12..edbc5d7572d1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3443,10 +3443,11 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		return 0;
 
 	/*
-	 * DIPM is enabled only for MIN_POWER as some devices
-	 * misbehave when the host NACKs transition to SLUMBER.  Order
-	 * device and link configurations such that the host always
-	 * allows DIPM requests.
+	 * DIPM is enabled only for ATA_LPM_MIN_POWER,
+	 * ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MED_POWER_WITH_DIPM, as
+	 * some devices misbehave when the host NACKs transition to SLUMBER.
+	 * Order device and link configurations such that the host always allows
+	 * DIPM requests.
 	 */
 	ata_for_each_dev(dev, link, ENABLED) {
 		bool hipm = ata_id_has_hipm(dev->id);
@@ -3505,7 +3506,11 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
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

