Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B561C862D
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243346; cv=none; b=s2O8fR2akvaQrCJ6c+yYeXn2VouwoT/hTagkIJqBkIqF4/YbkzAAUMH8ve7UHZrkqLcEuTC7BnUUMXQjeJumUyBE/a1r/RNaJipzuRSLOputqYAeq3CW983oBFXIpB8QToMjezjJhlTNKuCluBigQZaNEIk9yHass9/p66deHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243346; c=relaxed/simple;
	bh=CK+rOheAx7sCe7yq8Rmfp3OIJkLxTh2EsbfZsX+t0tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1iLXaNLbHhQZkQLiECeLev/YWpLKDDF0KmxYjCDY6Zgx6Jcffod8JyDypXcn5Ls6HDhUBNxjiT2dxsNgfokdmkNF3mRAdY7x5zcENddD+HBb/6d9kMvOB5MxSsv+HBCQOYVMa7sfahnLLrzl5vZP5IB2OnojodQqI72TnWak+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njLuviP7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njLuviP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51337C4CEE3;
	Wed, 14 May 2025 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243346;
	bh=CK+rOheAx7sCe7yq8Rmfp3OIJkLxTh2EsbfZsX+t0tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njLuviP744ju/Vcdt52loaKRs6Nn9s2Ljgp3xMF7fQTZ5JWZgSEix/GfuH3rqjdW0
	 LDqG3fVMFNc0oEHoyAtyAsvx8rAmCfzCiI/oP7QydoX/NUqHrIWk77ewYlLXsQRq6L
	 OjafQe0vQdiEpTpGmIGTf0F8a7nxk7FB/jLoWT+sruyy3jdWy9bt3rGA0IqqsLeUNA
	 jZ3rGw3YiUdr+FFF75EhGW/9y5lxAMWdFrjQb5a5BUKYbN3vAvWOOPoqvuIzj/RRRG
	 NOkDT5wIc0mkMDhgn3/1NkTKiKQbyRekt+TT4xywr/7xCS6O2PpxHQ3QwLYrGvrmWh
	 VEYYTRLrMI2NA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 5/7] ata: libata-eh: Rename no_dipm variable to be more clear
Date: Wed, 14 May 2025 19:22:15 +0200
Message-ID: <20250514172210.383801-14-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514172210.383801-9-cassel@kernel.org>
References: <20250514172210.383801-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2129; i=cassel@kernel.org; h=from:subject; bh=CK+rOheAx7sCe7yq8Rmfp3OIJkLxTh2EsbfZsX+t0tQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJULro8e3509d1XXNkzb1/+HmgTK8hecLE1izsm8LLhB pYPXx/LdJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiheqMDPOvbKzMZO1T+HNv m2fdzwn91Rd+V0hldQnwZJebx1nKCjEy7HrULnf85uLemBDHG/rbVglVbr+hxvjG5a+U+IPUtOx z/AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Rename the no_dipm variable to host_has_dipm, by inverting the
expression, and and also having a clearer name.

No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 272d074b78a1..bc3654265053 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3432,7 +3432,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev, *link_dev = NULL, *lpm_dev = NULL;
 	enum ata_lpm_policy old_policy = link->lpm_policy;
-	bool no_dipm = link->ap->flags & ATA_FLAG_NO_DIPM;
+	bool host_has_dipm = !(link->ap->flags & ATA_FLAG_NO_DIPM);
 	unsigned int hints = ATA_LPM_EMPTY | ATA_LPM_HIPM;
 	unsigned int err_mask;
 	int rc;
@@ -3464,7 +3464,8 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		if (!link_dev)
 			link_dev = dev;
 
-		if (!lpm_dev && (dev_has_hipm || (dev_has_dipm && !no_dipm)))
+		if (!lpm_dev &&
+		    (dev_has_hipm || (dev_has_dipm && host_has_dipm)))
 			lpm_dev = dev;
 
 		hints &= ~ATA_LPM_EMPTY;
@@ -3473,7 +3474,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 
 		/* disable DIPM before changing link config */
 		if (policy < ATA_LPM_MED_POWER_WITH_DIPM &&
-		    (dev_has_dipm && !no_dipm)) {
+		    (dev_has_dipm && host_has_dipm)) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_DISABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
@@ -3522,7 +3523,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	ata_for_each_dev(dev, link, ENABLED) {
 		bool dev_has_dipm = ata_id_has_dipm(dev->id);
 
-		if (policy >= ATA_LPM_MED_POWER_WITH_DIPM && !no_dipm &&
+		if (policy >= ATA_LPM_MED_POWER_WITH_DIPM && host_has_dipm &&
 		    dev_has_dipm) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_ENABLE, SATA_DIPM);
-- 
2.49.0

