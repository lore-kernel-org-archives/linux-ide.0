Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC201C862D
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243345; cv=none; b=FiJf1Rfc2nJC6vuh2kToBF8sLwzTpHd4F2AQ5ZtqgAFhuViL2lj1LlkZkVipGHw3F2EfM6JAAGVB7MGbmVq18GAARjWZ2MN7sUysRFSe+OTP+kykGJgK9cCy94VWzTNvuIb5zIM4kkcP6QHtQIpQV8ryT9NeoSx7eOoHGKCjM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243345; c=relaxed/simple;
	bh=KRfAdLuGPdUpuXHzws87DaIXgIbJUE86mB9AEh/PATE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+xrddY/9TpAcAbrVPwAFHIXFyK28L+HZdXWb/27ml2CikcFZkHGEh/MfENBdOFU1uVBm4dhaYP3zZ0jSG19vL1JG6xA6rE/vbIbbvua9cmcmB6UaufbcN2Z/czKhhqTeyFVB/qwit7eLyu1ae3aeiQf80917ZQEondk7J75QJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5tQx6i7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5tQx6i7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9066BC4CEE3;
	Wed, 14 May 2025 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243344;
	bh=KRfAdLuGPdUpuXHzws87DaIXgIbJUE86mB9AEh/PATE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5tQx6i7T5tT7iiqfo3wnfkWniejBtctGmePqQxGsBuRQicW6/oM98lytJR0SwdXz
	 8BmkH7l74MZaEvnW1wNJs8a85XwGQET1KOQHuXZnsnNMSeop01Iols3YgTYuOE4Vnt
	 A9N+BqGD2hlCc2PfNREvMYgJOxSdxrF5eg41ltBAjaAk8WQt2x5vtSREX2VlSmqciM
	 f+b+6w8wKd3qCfB1yFh1zONzJzkUqS2eIi9iMOy/F//fyO1EcD88GqPal8zCdNJGFb
	 O6FLA87xW9JTKQo+OgpAzNilsIoprIxHeyh0cTCo4X80nBa11JlN68grQfSidqftNl
	 Vu99zkjBUa/Aw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 4/7] ata: libata-eh: Introduce dev_has_dipm and dev_has_hipm variables
Date: Wed, 14 May 2025 19:22:14 +0200
Message-ID: <20250514172210.383801-13-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514172210.383801-9-cassel@kernel.org>
References: <20250514172210.383801-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=cassel@kernel.org; h=from:subject; bh=KRfAdLuGPdUpuXHzws87DaIXgIbJUE86mB9AEh/PATE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJULjrrvo0Kf+tzLTDkekfWvISqvvePnYwynGY6rPNao Ky6N52vo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABNpXcjI8OzVuTdb71xN6Jhh Xiep8vCXpwW7rfFE6bexN1r/N33fs5Dhn/WRR0vnP1Vd5vUv9nNrVT2L5b2irVHck+Qu/fw9I0+ 8lgMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Introduce dev_has_dipm and dev_has_hipm variables to make the code easier
to read.

The dev_has_dipm variable is simply the hipm variable with a clearer name.

No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 34167263af87..272d074b78a1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3457,23 +3457,23 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	 * DIPM requests.
 	 */
 	ata_for_each_dev(dev, link, ENABLED) {
-		bool hipm = ata_id_has_hipm(dev->id);
+		bool dev_has_hipm = ata_id_has_hipm(dev->id);
+		bool dev_has_dipm = ata_id_has_dipm(dev->id);
 
 		/* find the first enabled and LPM enabled devices */
 		if (!link_dev)
 			link_dev = dev;
 
-		if (!lpm_dev &&
-		    (hipm || (ata_id_has_dipm(dev->id) && !no_dipm)))
+		if (!lpm_dev && (dev_has_hipm || (dev_has_dipm && !no_dipm)))
 			lpm_dev = dev;
 
 		hints &= ~ATA_LPM_EMPTY;
-		if (!hipm)
+		if (!dev_has_hipm)
 			hints &= ~ATA_LPM_HIPM;
 
 		/* disable DIPM before changing link config */
 		if (policy < ATA_LPM_MED_POWER_WITH_DIPM &&
-		    (ata_id_has_dipm(dev->id) && !no_dipm)) {
+		    (dev_has_dipm && !no_dipm)) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_DISABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
@@ -3520,8 +3520,10 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
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

