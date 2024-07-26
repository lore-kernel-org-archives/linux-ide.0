Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63701DFD1
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964000; cv=none; b=R00mB/HeNrLhzGRo47EV94fOt56c7dOJxSGKYwR4VGA9X/V6HufE0hD+vmP9Y6PHay3chmkyolo5r5XjUSVpSoiusWWwb+l7O6MRGL9ucmZheORl1PCi8NwEyCID4/GanD4Nap0PPREYZY/+Pey1iWToZk3lmhekFAM6ZTY4XMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964000; c=relaxed/simple;
	bh=Mst5mEWP8p7QHy5FjPTkDLDE5YiS/ytBqpoLPi6Q7lk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzhC2jN6j/6h7Q/eajZh29SVTNpsE5lHVNACmdN3HQpS0bXwQcNQoVkb9ljUZoOx3IRvsUab9VKLTXw7BRcaMR2chgHbwyZqgnJe6R9yjlFMHvFRBf18DG8Z0yiHfSyrHvvgnKKLBuwGvO+LO4VfjKA92Cp5pDWlsfEA/oLlu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1YL7GBH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1YL7GBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5439FC4AF0C;
	Fri, 26 Jul 2024 03:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721964000;
	bh=Mst5mEWP8p7QHy5FjPTkDLDE5YiS/ytBqpoLPi6Q7lk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u1YL7GBHolzE3FcDvc8Gag42ZMjNtGgYFlFswvkXFBXFoMPM9OM+0qOHEKMToE4yb
	 zGhCItw1ExgjvonfqU/IcJiEnTzRUU7mna5UmqBQA0KA9xJqVWQQ5foZWWtyaaHIpr
	 B6rQ+syMDvKJ9ngh/X791mAzM2ppvOcOi/4WXGFRtmQqpk29QR3rxUemUT5nIO/I+E
	 p04gPWtFsXPSWQVsyJJIcpRAszzCJ1gUO+LPcKOHTZhxE7LriB9aEJcakRwdTYRvZJ
	 TiUjITrfoze9B2o5UXCF6iTgRNkvno2DyfHu7ZvOJV+B4h4MGW51l7vFSE1cZaRgUW
	 ogPjYF0xsV8Sg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 07/11] ata: sata_sil: Rename sil_blacklist to sil_quirks
Date: Fri, 26 Jul 2024 12:19:50 +0900
Message-ID: <20240726031954.566882-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726031954.566882-1-dlemoal@kernel.org>
References: <20240726031954.566882-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the array sil_blacklist to sil_quirks as this name is more
neutral and is also consistent with how this driver define quirks with
the SIL_QUIRK_XXX flags.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/sata_sil.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 354b68ef91bc..3a99f66198a9 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -128,7 +128,7 @@ static const struct pci_device_id sil_pci_tbl[] = {
 static const struct sil_drivelist {
 	const char *product;
 	unsigned int quirk;
-} sil_blacklist [] = {
+} sil_quirks[] = {
 	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
@@ -600,8 +600,8 @@ static void sil_thaw(struct ata_port *ap)
  *	list, and apply the fixups to only the specific
  *	devices/hosts/firmwares that need it.
  *
- *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
- *	The Maxtor quirk is in the blacklist, but I'm keeping the original
+ *	20040111 - Seagate drives affected by the Mod15Write bug are quirked
+ *	The Maxtor quirk is in sil_quirks, but I'm keeping the original
  *	pessimistic fix for the following reasons...
  *	- There seems to be less info on it, only one device gleaned off the
  *	Windows	driver, maybe only one is affected.  More info would be greatly
@@ -620,9 +620,9 @@ static void sil_dev_config(struct ata_device *dev)
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
-	for (n = 0; sil_blacklist[n].product; n++)
-		if (!strcmp(sil_blacklist[n].product, model_num)) {
-			quirks = sil_blacklist[n].quirk;
+	for (n = 0; sil_quirks[n].product; n++)
+		if (!strcmp(sil_quirks[n].product, model_num)) {
+			quirks = sil_quirks[n].quirk;
 			break;
 		}
 
-- 
2.45.2

