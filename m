Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047CE1DF258
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317400; cv=none; b=RoRcsJ+HBSn1Zu60AGZZGlOZYFirt22eikItM2+ZTX6+8j3KWQcAK7sYts10LO+BBUngOwZOwa2vMz6Z03kfARsL3qI1XgK1T9H0yazG2h2pwEiCjCzglr1SlGI6AM88My9wer6E47tJl4qK+NFuDkklAt910o7M7zzZWy4aHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317400; c=relaxed/simple;
	bh=v2/ndUEd4ITyVdBnkRtjwtZjdT7y3ilsY9t8dY0WZ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAyfHeU2J/mfl8nWx0UcwNXa3BaxhbrduTgvvJ10X6+0G9L9UMKJruq2Bul23SWuyELN0pwDObnwAMWJkiCrEEAMXM2VRLX/7XNRIwQ23xR0C8kbVmMpj4Cqx7CNa0WczCaT0yK8DrH1fE7ITQgVpn8FiZ7j4IxYehL+Yzn371c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZgbTDFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZgbTDFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E81EC4CEE7;
	Thu, 15 May 2025 13:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317399;
	bh=v2/ndUEd4ITyVdBnkRtjwtZjdT7y3ilsY9t8dY0WZ9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZgbTDFG1Epk4TNY/xpfYcUoeX9HA7qP0GPYWIlxCsojhYjvZ0P/WEhQIwgAu5KPY
	 EpOypy9+znasJdcDkTYSIzxinFNIIlYpzMvx3LOdmPfsuLHhLFvCOc3GlzlbdbWkab
	 hjzV3T2Xk6TUTi4pgXDq7fxkUKc0tGXZcu6S1AY242TvVh55+m01wJUwUPcSMJBGD2
	 KVFHm7ClW965LeIjPrf9NZN6ec1KD+FEoEGzHVIkIReL5VgM7AT1lBZwjhXhSxD2ev
	 zuLgYNFuIKutV4K+DaX0b+kOjOYoElPomV1nxXRJBbuqzElbY8yNEi/DfhlybyuVZL
	 /iL2jnKtXfOtQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 3/5] ata: libata-eh: Rename hipm and dipm variables
Date: Thu, 15 May 2025 15:56:25 +0200
Message-ID: <20250515135622.720623-10-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515135622.720623-7-cassel@kernel.org>
References: <20250515135622.720623-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; i=cassel@kernel.org; h=from:subject; bh=v2/ndUEd4ITyVdBnkRtjwtZjdT7y3ilsY9t8dY0WZ9E=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUP3V/uBazTTox/OhUNu8nkzrMRevfCS9bk1raLGhqr T8nNl2no5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABNJU2H4p9f6YJ/+oiPr2YJ2 LU/k3LPYTdzcSHdjsMnh/pdFEaoPfBj+u00JlajZOTVYNey7s/6PG+1XYs5/ujuDc4VsRGKXvco VDgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Rename the hipm and dipm variables to have a clearer name.
Also fold in the usage of no_dipm, as that is required in order to give
the dipm variable a more descriptive name.

No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 89b7b2139a16..dcb449edd315 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3455,22 +3455,23 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	 * some devices misbehave when the host NACKs transition to SLUMBER.
 	 */
 	ata_for_each_dev(dev, link, ENABLED) {
-		bool hipm = ata_id_has_hipm(dev->id);
-		bool dipm = ata_id_has_dipm(dev->id) && !no_dipm;
+		bool dev_has_hipm = ata_id_has_hipm(dev->id);
+		bool dev_has_dipm = ata_id_has_dipm(dev->id);
 
 		/* find the first enabled and LPM enabled devices */
 		if (!link_dev)
 			link_dev = dev;
 
-		if (!lpm_dev && (hipm || dipm))
+		if (!lpm_dev && (dev_has_hipm || (dev_has_dipm && !no_dipm)))
 			lpm_dev = dev;
 
 		hints &= ~ATA_LPM_EMPTY;
-		if (!hipm)
+		if (!dev_has_hipm)
 			hints &= ~ATA_LPM_HIPM;
 
 		/* disable DIPM before changing link config */
-		if (policy < ATA_LPM_MED_POWER_WITH_DIPM && dipm) {
+		if (policy < ATA_LPM_MED_POWER_WITH_DIPM &&
+		    (dev_has_dipm && !no_dipm)) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_DISABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
@@ -3517,8 +3518,10 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	 * ATA_LPM_MED_POWER_WITH_DIPM.
 	 */
 	ata_for_each_dev(dev, link, ENABLED) {
+		bool dev_has_dipm = ata_id_has_dipm(dev->id);
+
 		if (policy >= ATA_LPM_MED_POWER_WITH_DIPM && !no_dipm &&
-		    ata_id_has_dipm(dev->id)) {
+		    dev_has_dipm) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_ENABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
-- 
2.49.0

