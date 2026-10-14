Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AA53FD44
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990223; cv=none; b=ktAtFx5HewonU5+Pqyw0Vba3W2xQumaMFxrH4dTDaw3Bg3bxR2Wdp0PG0bMLn+LJn0YIjG/HlIf5mVr/9DuclDG3mq1V6KF+IIAJkQOBh44bBDj79tBhPxq5lhpLdRe2IosvyvdHiSAmeD6AW0bFrcg/VAZQiX7+W2ba1gMr+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990223; c=relaxed/simple;
	bh=nbwia4fTHAG5lqcfsMU4Jt3mxsb8b9CS2cSxfIEl4d0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o6V8baV6vMrPtx48Dn7pwVojKthUceVNZ2XRD9VxIJ6DX/yEtClx9XEKABZHh5nG1H+TFf5pVLRi1QJiOrxIMOXvTzMfZ1JpheN0lBnYzhGL9ne25wMV5/H5qe1NJrEZ0fFfD+q98+fulFcXwQ2dkxONczEKsFUmhSOO9p7DYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgq5RO1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgq5RO1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913751F000C4;
	Wed, 14 Oct 2026 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990221;
	bh=0rqQ8yWIlpM5txTtza4BgXhvGG4MESlPg3tMDKGliK8=;
	h=From:To:Subject:Date;
	b=jgq5RO1vhC/rxdxArStuIxFF0A/64Ui0eYLpEUCDwQoBpt8PcGPZ6B4rir4H+tNx/
	 1QSvibJnEPcemb3DEP57+GHe8R1ZB2xWQ6Qyf7ZBZLXm5ffvol57NovHlWGLMRF7AM
	 iqFo1/sszig8mJco1b9DOAoSva0DaKnvxxYMrDzwWT4TrOItgaa2tIYOMP28z20Wwa
	 EbSIIvpjh1dDoIHicLBfEqYazHTfj1fgaKtVYBTiwg6Z/e6ig63FXhs94KTchoGjSZ
	 juRWRBcgzhKdaWK/yfch+Sr6KETpjkMcEPQR8Krudji4xOfmFZf1ZYo2b03r+nqE8k
	 neRWwd8fgeKRg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-core: always apply all quirks matching for a device
Date: Thu, 15 Oct 2026 00:03:39 +0900
Message-ID: <20261014150340.2410073-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ata_dev_quirks() uses the first entry in __ata_dev_quirks[] that
matches the device and ignores all later entries. Commit 38d431229bfb
("ata: libata: exclude FUA support for known buggy drives") appended
three ATA_QUIRK_NO_FUA entries to the end of the table, with model
patterns meant to cover whole product lines. Earlier entries already
match some or all of these drives, so NO_FUA is not always applied:

- "INTEL*SSDSC2CT*" never takes effect. Every model it matches also
  matches the earlier "INTEL*SSD*" entry, so these drives only get
  ATA_QUIRK_ZERO_AFTER_TRIM.

- "WDC*WD2500J*" does not take effect for "WDC WD2500JD-*" drives,
  which match the earlier ATA_QUIRK_WD_BROKEN_LPM entry.

- "OCZ-VERTEX*" does not take effect for "OCZ-VERTEX" drives with
  firmware "1.30", which match the earlier ATA_QUIRK_BROKEN_HPA entry.

Avoid this particular issue and make ata_dev_quirks() more solid by
getting all quirk flags from all entries of the __ata_dev_quirks array
matching the device model and firmware revision. With this change,
regardless of the order in which entries are added to the __ata_dev_quirks
array, all required quirk flags will always be applied to a device.

Fixes: 38d431229bfb ("ata: libata: exclude FUA support for known buggy drives")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 682c58889715..e53a410a817e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4514,6 +4514,7 @@ static u64 ata_dev_quirks(const struct ata_device *dev)
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
 	const struct ata_dev_quirks_entry *ad = __ata_dev_quirks;
+	u64 quirks = 0;
 
 	/* dev->quirks is an u64. */
 	BUILD_BUG_ON(__ATA_QUIRK_MAX > 64);
@@ -4521,16 +4522,18 @@ static u64 ata_dev_quirks(const struct ata_device *dev)
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
 
+	/* Get the quirks for all matching entries */
 	while (ad->model_num) {
 		if (glob_match(ad->model_num, model_num) &&
 		    (!ad->model_rev || glob_match(ad->model_rev, model_rev))) {
 			ata_dev_print_quirks(dev, model_num, model_rev,
 					     ad->quirks);
-			return ad->quirks;
+			quirks |= ad->quirks;
 		}
 		ad++;
 	}
-	return 0;
+
+	return quirks;
 }
 
 static u64 ata_dev_get_max_sec_quirk_value(struct ata_device *dev)
-- 
2.55.0

