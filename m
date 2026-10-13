Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1153ED04
	for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920360; cv=none; b=EtR7xIzpmnxMruzBgyxv5+UzUfbSzATXpwVdwwKvxjkKQRsInQ97Gxi8wQm7/kmjl2/hUiE9K5vmFkXall1nKKTDHEDO8QYd8K8Jf+tA3dI4UySJ8pj5PxgowXYBJSiuurzMFhGo2PCI4Vc0IdEfB/jxGzEF2938VGzB9qMSACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920360; c=relaxed/simple;
	bh=Z8syZZ/2KNj6UHXMGK0cdNQ46RPUxIYy0B39l77Xd+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZz9p4BGsGE7PA1rqmf0AU5u3pQ8Nkwq12G6+hDzmAsjExuWCrXS3vn3g+RjcLOGS6CU88Rv/fi9vERbYwpjKnm+ryAT+oDxG512P17s4vwjyFRz3SST5cd38/ExsIqjN0T8NnE/6TfCAEA4PWNNtLcZIU1SjpvypjUjXym5p3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVGxoaCS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVGxoaCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABE91F000FF;
	Tue, 13 Oct 2026 19:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791920358;
	bh=0KPnmHvZYaarbZu+qMp+ewvMRq58qnGSEYp1iiAdAM8=;
	h=From:To:Cc:Subject:Date;
	b=BVGxoaCSevKdQGoboXq25sN/WgnvpkuknOcaITgyeQH8RuNMAxxCG3DyfGQ2V4DnT
	 n9kySh6eKx5P9prMSvJ6I65cglcpvLv6tpjv027juujb8KK9Zns3RRAXaxccE9I+Dl
	 4iwHSCq/n8DGJF7xAp7YBiWJMB3tgwx6PAfwTev0upFtqWu7tBRq+Dy8A6QVlgwMiC
	 8S47BFkjtVBi2uC5UDkhET677GQv9mtMxiCJB4UL29TOL0xR0jus0wX4od4+tCEdsB
	 DGFnTvhuG6DrQoO3fSa6y7x/GgqJyPT1k7pSOHO4UGISpQiiFI5xCZp02wCNwrNVzH
	 WUA6AgetIK7Iw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-core: Fix NO_FUA quirks shadowed by earlier quirk entries
Date: Tue, 13 Oct 2026 21:39:16 +0200
Message-ID: <20261013193915.174460-2-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3447; i=cassel@kernel.org; h=from:subject; bh=Z8syZZ/2KNj6UHXMGK0cdNQ46RPUxIYy0B39l77Xd+4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLOdTxm1Fhzbe5u3qsuZ3iu23Zf0mbPUEg9vm3W6Y7st 7d0labpdZSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAit3sYGZo5J9fbhi1mdTyx aKKC+pGMC8vrmBjq9074K3Bpv/elzW0M/z1KMne/eNjnldFufafa+cDZymNT1r66IFovEn9C4Oh vLj4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
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

Move the Intel entry in front of "INTEL*SSD*" and keep
ATA_QUIRK_ZERO_AFTER_TRIM in it, so these drives stay on the
ZERO_AFTER_TRIM whitelist. Add ATA_QUIRK_NO_FUA to the WD2500JD and
OCZ Vertex 1.30 entries. The quirks of all other drives are unchanged.

libata only uses FUA when it is enabled with libata.fua=1, so systems
using the default setting are not affected.

Fixes: 38d431229bfb ("ata: libata: exclude FUA support for known buggy drives")
Assisted-by: LLM
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 92233fb25051..cff4ededafad 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4323,7 +4323,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },
 
 	/* this one allows HPA unlocking but fails IOs on the area */
-	{ "OCZ-VERTEX",		    "1.30",	ATA_QUIRK_BROKEN_HPA },
+	{ "OCZ-VERTEX",		    "1.30",	ATA_QUIRK_BROKEN_HPA |
+						ATA_QUIRK_NO_FUA },
 
 	/* Devices which report 1 sector over size HPA */
 	{ "ST340823A",		NULL,		ATA_QUIRK_HPA_SIZE },
@@ -4459,6 +4460,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "Crucial*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
 	{ "INTEL SSDSC2KG480G8", "XCV10120",	ATA_QUIRK_ZERO_AFTER_TRIM |
 						ATA_QUIRK_MAX_SEC },
+	{ "INTEL*SSDSC2CT*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_NO_FUA },
 	{ "INTEL*SSD*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
 	{ "SSD*INTEL*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
 	{ "Samsung*SSD*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
@@ -4479,7 +4482,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "WDC WD1200JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
 	{ "WDC WD1600JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
 	{ "WDC WD2000JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
-	{ "WDC WD2500JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
+	{ "WDC WD2500JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM |
+						ATA_QUIRK_NO_FUA },
 	{ "WDC WD3000JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
 	{ "WDC WD3200JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
 
@@ -4504,7 +4508,6 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "Maxtor",		"BANC1G10",	ATA_QUIRK_NO_FUA },
 	{ "WDC*WD2500J*",	NULL,		ATA_QUIRK_NO_FUA },
 	{ "OCZ-VERTEX*",	NULL,		ATA_QUIRK_NO_FUA },
-	{ "INTEL*SSDSC2CT*",	NULL,		ATA_QUIRK_NO_FUA },
 
 	/* End Marker */
 	{ }
-- 
2.56.0

