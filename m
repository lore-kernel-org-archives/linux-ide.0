Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638262FCC04
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2025 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319721; cv=none; b=gHZoCJUalqo9tzz0QNsJ7dvY6RiaaFMm4/aJtRKyNo0ec9ohbbeZ6PfkW8e5PSNV+mxqf+Rpug/ffkFiAKK/UGksiLXHNs4RLorUcqFWTIhaE6pU/nft+vT+C80VK3dRaauzCms/HISzi3/t2SmRGq5/qpAeA58K2jmSTYcn8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319721; c=relaxed/simple;
	bh=LbB2iCUcE00DbgA7r1uQ4Fk2wbRh+XNARz2+c2kHhig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9Q2ZbGBQwPsjDgDv4OwsdZGT1KCiqLyiDtSzVwIZouamf22t3qcVN1fcHHWQL94lZP5tOEcJS6/Ql1h4JgaecxJbcEUn+BJ6brA7SuB+06ubF+P+QUZcmwvg79HsFraYGaB71vtvuMsCE4Q3tt+SNuI2IS1zc1Yrh2mO0cQNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxVwNzMk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxVwNzMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FAAC2BCB4;
	Fri, 28 Nov 2025 08:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764319721;
	bh=LbB2iCUcE00DbgA7r1uQ4Fk2wbRh+XNARz2+c2kHhig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxVwNzMkuu1bIrfAN7FvUlxoSFs2PxAkKDxCt6UdWKgfMmazcHtvgnRNsVWuTeOUM
	 J90tUh2f3AM8JfoACTK3fvq8ciczwZHfaq36TRRSoq+jUPU296IFG05Z6pNnsqQWPA
	 tgpCDugZcOMkYl3gEqe6gkXMprCM8o4KUrQFzaLC+Ygxu9IvH4G2L8pMR2xoIQ0ylK
	 H5SVuvnlWT60hk5rSUlDtFDg5um3xo5taEmGSY8C3TLzJGFzQKmLvdeILV6CgJQuQu
	 aXjCyHljrBDMPL0c0gFMPTzNAMUz/st3jBeh1JG5WLkD7XZkkIxq5D6Cvwfe/ToArf
	 5m3BDI0W0mlGg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 5/8] ata: libata-core: Quirk DELLBOSS VD max_sectors
Date: Fri, 28 Nov 2025 09:48:20 +0100
Message-ID: <20251128084814.3798425-15-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128084814.3798425-10-cassel@kernel.org>
References: <20251128084814.3798425-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=cassel@kernel.org; h=from:subject; bh=LbB2iCUcE00DbgA7r1uQ4Fk2wbRh+XNARz2+c2kHhig=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI1Ey/xvPleVp1yMynk1IfYDJZVO0612Gc+W6nzfnri+ dCdF7R4OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRSwoMv5j2HVJuDljfydaV /V1vjax9QARz7cPVuc3OK/r2H33jFcPw30H1vIk5V8z1jHAtLnd5LTven/OmqW/jz1M/940h8Yk 4PwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP") increased
the default max_sectors_kb from 1280 KiB to 4096 KiB.

DELLBOSS VD with FW rev MV.R00-0 times out when sending I/Os of size
4096 KiB.

Enable ATA_QUIRK_MAX_SEC, with value 8191 (sectors) for this device,
since any I/O with more sectors than leads to I/O timeouts.

With this, the DELLBOSS VD SATA controller is usable again.

Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a3fdb73e48fb7..697188b990dd6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4064,6 +4064,7 @@ static const struct ata_dev_quirk_value __ata_dev_max_sec_quirks[] = {
 	{ "ST380013AS",			"3.20",		1024 },
 	{ "LITEON CX1-JB*-HP",		NULL,		1024 },
 	{ "LITEON EP1-*",		NULL,		1024 },
+	{ "DELLBOSS VD",		"MV.R00-0",	8191 },
 	{ },
 };
 
@@ -4129,6 +4130,12 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "LITEON CX1-JB*-HP",	NULL,		ATA_QUIRK_MAX_SEC },
 	{ "LITEON EP1-*",	NULL,		ATA_QUIRK_MAX_SEC },
 
+	/*
+	 * These devices time out with higher max sects.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=220693
+	 */
+	{ "DELLBOSS VD",	"MV.R00-0",	ATA_QUIRK_MAX_SEC },
+
 	/* Devices we expect to fail diagnostics */
 
 	/* Devices where NCQ should be avoided */
-- 
2.52.0

