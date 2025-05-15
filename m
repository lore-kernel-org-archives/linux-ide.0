Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6A1EDA23
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317402; cv=none; b=DzCDJbV4dYgQyDytaBzMqqN1lUKycHkcKMYnP9sPy5S9C/f3QVsfExEHam1saBLfRbVclIP3zbx6TCNj4jsGAy02ZaJVZFj7sexGM10ks9Kt+67+5vXykV2JTPvR+7ZB/uJLrmUcLVo7QXHgXwCn8KfyXNo6V5o7Hn3B3Lc/3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317402; c=relaxed/simple;
	bh=8hNFZCAW+YM9FyH4RZB/pqauaZ12weox2lNLmRt0nFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkAeSKlKHlTWJJ5dPDGey7H4ybO8mMu/mkAN4h5vxUKlvXzP8AvQjmDv3SGQ/vV9Jva9QwVHSNM17FJUG/h6OhxSnrgqkNmfmCHPWmV5C9LJR9oo/I7Te0qycHasE3NkEAggg5vomOAiv02prDti4LUh7X22mQaqHml+kWuMhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnsIqDS2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnsIqDS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB7BC4CEE7;
	Thu, 15 May 2025 13:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317401;
	bh=8hNFZCAW+YM9FyH4RZB/pqauaZ12weox2lNLmRt0nFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UnsIqDS2E/ZdOc+GrgMzyShhplqTgR34aO+4KPLZ4BiazE3Irlrz0OdbzK6eZJxtA
	 VbgrjHzeCuasGdK0Z7A7NPDe/O61RxWVMcCDCglzuu2iCrG1gnptY2OpOOtqeoBAIa
	 Rql6UxQHmG6HUkpi6PEpi3zImQKREgAzhnlIoxsIsMg6BBkhFn9UmmbRlNgU3Ar9dM
	 nSfa3uVOZUM1SHaq27JSdbMGtKUd55UuLLZVdQRDQo8i0+Wuj5ciRJcPXbg/I4D2ZH
	 /bFSUNbPbIfd9PVs07wYrWjeZxcm8Sx7wUtSbCh6RBOqcThVdmNeHzWLmxeJESpmos
	 zXAr7dUZ0l3pg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 4/5] ata: libata-eh: Rename no_dipm variable to be more clear
Date: Thu, 15 May 2025 15:56:26 +0200
Message-ID: <20250515135622.720623-11-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515135622.720623-7-cassel@kernel.org>
References: <20250515135622.720623-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2129; i=cassel@kernel.org; h=from:subject; bh=8hNFZCAW+YM9FyH4RZB/pqauaZ12weox2lNLmRt0nFs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUP3WzN5zW3z1b1O/shMhX4VnpkbmSku8up2/wVdk7o zz3t93ajlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzEfD/D/8qjX9TetcTKr3ee 9FH/1sVn9VNk92fU1S8rK2g6LLn4TxUjw4rEr+b3tppe8p+lJn7+Xc9GifyL7qvEr9ccnK7hddr agBcA
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
index dcb449edd315..0e36a7806cff 100644
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
@@ -3462,7 +3462,8 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		if (!link_dev)
 			link_dev = dev;
 
-		if (!lpm_dev && (dev_has_hipm || (dev_has_dipm && !no_dipm)))
+		if (!lpm_dev &&
+		    (dev_has_hipm || (dev_has_dipm && host_has_dipm)))
 			lpm_dev = dev;
 
 		hints &= ~ATA_LPM_EMPTY;
@@ -3471,7 +3472,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 
 		/* disable DIPM before changing link config */
 		if (policy < ATA_LPM_MED_POWER_WITH_DIPM &&
-		    (dev_has_dipm && !no_dipm)) {
+		    (dev_has_dipm && host_has_dipm)) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_DISABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
@@ -3520,7 +3521,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	ata_for_each_dev(dev, link, ENABLED) {
 		bool dev_has_dipm = ata_id_has_dipm(dev->id);
 
-		if (policy >= ATA_LPM_MED_POWER_WITH_DIPM && !no_dipm &&
+		if (policy >= ATA_LPM_MED_POWER_WITH_DIPM && host_has_dipm &&
 		    dev_has_dipm) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_ENABLE, SATA_DIPM);
-- 
2.49.0

