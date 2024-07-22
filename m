Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A759748D
	for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721612055; cv=none; b=TpQvbao2u5TF4gC8K02DNd3c2hvysQgQJeEVJ1WoPH6zsTUTXkOJSu/ISqoHh6MNX6ogKduUT1xUv0IE+J5uEL0PBvpMTf9ot5BO58PHcxVRWQrm8UO4UA5qk5DBshqckuk+pIUIvojQUqaUT2sOiEbXuknYMIxV/WIlUQ7h5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721612055; c=relaxed/simple;
	bh=oDCOVbbnCTH3ChHzR7fuuqioWy05iWEvPv7tGC3aBo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aK4AWrVGc8AJE62p+BUg0FkFMB1VUJaBTujPiYEy8j8pkMMnPHI7y6e0bsv6/i8ILbvEZjKaK0cRhnkvY20sDKJ6h3PPXigjYuB/QofyxJbxcjI7J+7Bf8/XNrl8+xI1S0rpAomsXwh84xR4cPr1yjKIkEtbDRSjWWaW7Wvnvos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkEwHboD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkEwHboD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2ACC4AF09;
	Mon, 22 Jul 2024 01:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721612055;
	bh=oDCOVbbnCTH3ChHzR7fuuqioWy05iWEvPv7tGC3aBo4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rkEwHboDZLrfg/4X694zh49QmhD1IV8ALsX65M0Wt05H2WVDsU/C5RTJcjr79EwRc
	 8Qoc6oMBbT3U4DIZobNJ9PKhaklbIxWoeioCaovuwIBqpzd3kv6gra30ZCpyfR6dXn
	 g9jWba8KtCz+dZ8z13f4wR9TlgZtxwbVVuZ+9DITmkRzKlIj5cpkl/OuIA0fnlWAJF
	 TAlzwRzw0JKk/XiFcPlEyyreQ/fcg+irGqsowzuLyYELZ69TUwxMgaw3JzANztxuyB
	 6GMBDWQMa0eTMKVqHPxmCat+HKWiN5irnNXb28bTycnZzNkLBkdl9/s6ZGdrJdKVTb
	 1ZwCQCHm0Lk2A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 2/3] ata: libata: Rename ata_dev_blacklisted()
Date: Mon, 22 Jul 2024 10:34:11 +0900
Message-ID: <20240722013412.274267-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722013412.274267-1-dlemoal@kernel.org>
References: <20240722013412.274267-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the function ata_dev_blacklisted() to ata_dev_horkage() as this
new name:
1) Does not use an expression that can be considered as negatively loaded.
2) The name does not reflect what the function actually does, which is
   returning a set of horkage flag for the device, of which only one
   flag will completely disable the device.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 286e1bc02540..ee958d2893e6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -84,7 +84,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
-static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
+static unsigned long ata_dev_horkage(const struct ata_device *dev);
 
 static DEFINE_IDA(ata_ida);
 
@@ -2223,7 +2223,7 @@ static inline u8 ata_dev_knobble(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
 
-	if (ata_dev_blacklisted(dev) & ATA_HORKAGE_BRIDGE_OK)
+	if (ata_dev_horkage(dev) & ATA_HORKAGE_BRIDGE_OK)
 		return 0;
 
 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
@@ -2830,7 +2830,7 @@ int ata_dev_configure(struct ata_device *dev)
 	}
 
 	/* set horkage */
-	dev->horkage |= ata_dev_blacklisted(dev);
+	dev->horkage |= ata_dev_horkage(dev);
 	ata_force_horkage(dev);
 
 	if (dev->horkage & ATA_HORKAGE_DISABLE) {
@@ -3987,13 +3987,13 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 	return rc;
 }
 
-struct ata_blacklist_entry {
+struct ata_dev_horkage_entry {
 	const char *model_num;
 	const char *model_rev;
 	unsigned long horkage;
 };
 
-static const struct ata_blacklist_entry ata_device_blacklist [] = {
+static const struct ata_dev_horkage_entry ata_dev_horkages[] = {
 	/* Devices with DMA related problems under Linux */
 	{ "WDC AC11000H",	NULL,		ATA_HORKAGE_NODMA },
 	{ "WDC AC22100H",	NULL,		ATA_HORKAGE_NODMA },
@@ -4111,7 +4111,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 
 	/* Devices which get the IVB wrong */
 	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB },
-	/* Maybe we should just blacklist TSSTcorp... */
+	/* Maybe we should just add all TSSTcorp devices... */
 	{ "TSSTcorp CDDVDW SH-S202[HJN]", "SB0[01]",  ATA_HORKAGE_IVB },
 
 	/* Devices that do not need bridging limits applied */
@@ -4266,11 +4266,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ }
 };
 
-static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
+static unsigned long ata_dev_horkage(const struct ata_device *dev)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
-	const struct ata_blacklist_entry *ad = ata_device_blacklist;
+	const struct ata_dev_horkage_entry *ad = ata_dev_horkages;
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
@@ -4372,8 +4372,7 @@ static int cable_is_40wire(struct ata_port *ap)
  *
  *	Compute supported xfermask of @dev and store it in
  *	dev->*_mask.  This function is responsible for applying all
- *	known limits including host controller limits, device
- *	blacklist, etc...
+ *	known limits including host controller limits, device horkages, etc...
  *
  *	LOCKING:
  *	None.
-- 
2.45.2

