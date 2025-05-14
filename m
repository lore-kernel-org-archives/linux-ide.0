Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED627A442
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243343; cv=none; b=SO32DIxDogkcqzHipcjJ4M8ptEicdvDG8yrBivdzmdcRN/W1OEmBYSqD/K/cVori/dWHgn34EOMqy8ai9tM5cFzsVCZXJpzffsVXto5Smh9iublIGdm6JsTUEuDI1KOpXSnmpqXpu/Zedex5g7m6iecscpiSIqmYoWgAnT5FQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243343; c=relaxed/simple;
	bh=TfVU9Q3Gio1x6PcAyoMu/CPf5FnDV6ol5beHp5ojCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEwPQuVeUzqs9hYZ7xsg/z7NgI+D7Q9b1hbQBWCcoEx/xc6yfMoQ2H7b9OA2etcc55KRKnv8BTK7BlpeeWqyJ7PpLuZt+QCOnvp68xp3yYIngGDolaAsMW2SGl7nu+zWdIc+pDPQRnbOwYvETBFRMXwSLDpJnJzBdO18cZhUHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuEvL4CT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuEvL4CT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEA4C4CEE3;
	Wed, 14 May 2025 17:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243342;
	bh=TfVU9Q3Gio1x6PcAyoMu/CPf5FnDV6ol5beHp5ojCCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LuEvL4CTsn6kK/asa57im4p3Pv3+R0okU22LAw3dVsazPtdOcJnrJX7Z2MJK21xha
	 ct4Q9YohloA3nvTBxGwuKCLObICnzfawCKVuBbyxH4TMgy6VRm/i1M0VBcoFHGUDEr
	 0LJ15TlAVSXLnW2BoiQNrqrBPLFzJXR3qAfIhH0VTpjeIvI5eFd1jjcAbT9TkC16qo
	 GtrvZ4SdZBB4Gw0mITG5t4/0MPKOWiEeIdnNJSQzo5Q2L+dg4crmRzgwO+8v/4eI9f
	 S3/ddhRmEHB8ZffdXrNeX0h+bFOjQEHXDgjWZFhsu04zg2iuVHsx9D1KRzIQ/vz4f5
	 B/jxJ5QhanAIg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 3/7] ata: libata-eh: Drop dipm variable
Date: Wed, 14 May 2025 19:22:13 +0200
Message-ID: <20250514172210.383801-12-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514172210.383801-9-cassel@kernel.org>
References: <20250514172210.383801-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=cassel@kernel.org; h=from:subject; bh=TfVU9Q3Gio1x6PcAyoMu/CPf5FnDV6ol5beHp5ojCCk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJULjo71Vdfd/ujOil9TpV3kmx0dmLIu6SuXqErXz/KC y+8dcSlo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPxFmZkWFV+d+2Gd32s655/ W/os68C7e3YrPqX1psZYNtoJr2M15mH4K79xkSBbovrynTdv53Zp7cuULIqTC/H13xkw85VYqGU LIwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The dipm variable is confusing.
Drop the variable and inline the expression at places where it is used.

This will make it easier to perform additional cleanups.

No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d2ccdb9a2840..34167263af87 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3458,13 +3458,13 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	 */
 	ata_for_each_dev(dev, link, ENABLED) {
 		bool hipm = ata_id_has_hipm(dev->id);
-		bool dipm = ata_id_has_dipm(dev->id) && !no_dipm;
 
 		/* find the first enabled and LPM enabled devices */
 		if (!link_dev)
 			link_dev = dev;
 
-		if (!lpm_dev && (hipm || dipm))
+		if (!lpm_dev &&
+		    (hipm || (ata_id_has_dipm(dev->id) && !no_dipm)))
 			lpm_dev = dev;
 
 		hints &= ~ATA_LPM_EMPTY;
@@ -3472,7 +3472,8 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			hints &= ~ATA_LPM_HIPM;
 
 		/* disable DIPM before changing link config */
-		if (policy < ATA_LPM_MED_POWER_WITH_DIPM && dipm) {
+		if (policy < ATA_LPM_MED_POWER_WITH_DIPM &&
+		    (ata_id_has_dipm(dev->id) && !no_dipm)) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_DISABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
-- 
2.49.0

