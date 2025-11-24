Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33404111A8
	for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002084; cv=none; b=NtcHInjirbHxYJOn4NSHKRvcjNxtP2mgyzDyuP1nDRpsklGCnVK1JUcqVfg+NpWWOCdEhCbNoiHN2/ylzdpRvYdXyLO7Lk+p75X16Fs7kQkc12IabZ2J5iRWNyzMLmpKKEg0CR9JAccRE+E6uX4EyYQH1s+GJubC0GgBYlSB16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002084; c=relaxed/simple;
	bh=HC7CQfNVEjb9ZZUK8Hz9FuvAqpn0F4s5ooERSM4tvMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kho+A5CT6nSko45IoBT/PvvYj9E8tRDbnb5yZW/CkFroh0FDhc+MTYINeIxEEek5tE9a5WyUaE5ie7yElDnKXsQCk55qahTvYx8Wt2gRUMClDunxhpF40NsdGzbkTV9jhXi48C9Rha4JKa6Iof8225v3phNArH6tS7nF/iHbx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhm0PG5B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhm0PG5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB883C4CEF1;
	Mon, 24 Nov 2025 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764002083;
	bh=HC7CQfNVEjb9ZZUK8Hz9FuvAqpn0F4s5ooERSM4tvMk=;
	h=From:To:Cc:Subject:Date:From;
	b=Bhm0PG5BF6VMMTJR9U3jwr9NPGt5SLKNJtT7vQxTjpXDfHEAXpp7WFvZW5iBY0oMs
	 2DQCx8GyV0QD2Zw/vZdRzA8N38wbtHdtEyQAmOYolP9ElP4LzITAxCqvr48jGzyVKY
	 ZtJMUpPknGQGtzsCHaQKu9uhslpFRtGFWeD3tLkLNF/cRtzf51KaNwPPTQfzYJWhsz
	 xedlQkLyoMMs1k7Vd5xUaj4GVQja8uKTIxchtO+5g2if86cazZ18PHwptpoelrFe3M
	 TWZ/zkUODw6K7QoWZjXqcCo7eMl9Q5QgexMLRmAPoEprH1rNxsDJYVTFNZB3jPIrOo
	 4ALb0mCJIytag==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Yihang Li <liyihang9@h-partners.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Disable LPM on Silicon Motion MD619HXCLDE3TC
Date: Mon, 24 Nov 2025 17:34:34 +0100
Message-ID: <20251124163433.3082331-2-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; i=cassel@kernel.org; h=from:subject; bh=HC7CQfNVEjb9ZZUK8Hz9FuvAqpn0F4s5ooERSM4tvMk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJVOiU3hsun/r6m63HZ64Hd1L68xvM3TGacUpusduLY4 eZi4VUPOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCR8xcYGTYyeFX+d/dtvGpx YMbCHJOlDnxO/3NkGmoCGzzXfr88eRUjw5Jt+Quyp/hd9jkdoPHkzHMHIdYcTbfbnj/Fj9xxm3m QgREA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

According to a user report, the Silicon Motion MD619HXCLDE3TC SSD has
problems with LPM.

Reported-by: Yihang Li <liyihang9@h-partners.com>
Closes: https://lore.kernel.org/linux-ide/20251121073502.3388239-1-liyihang9@h-partners.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Hello Yihang Li,

Please test this patch.

Before we apply this patch, it would be nice if you could try another SSD,
that supports LPM (HIPM and DIPM) with your AHCI controller:
Huawei Technologies Co., Ltd. HiSilicon AHCI HBA [19e5:a235] (rev 30)

Note: You can see if your drive supports HIPM and DIPM from the
ata_dev_print_features() print to dmesg during boot, e.g.:
ata6.00: Features: Trust Dev-Sleep HIPM DIPM NCQ-sndrcv NCQ-prio

Just so we can verify that it is the MD619HXCLDE3TC SSD that is not
handling LPM correctly, and that it is not the AHCI HBA that is at fault.

E.g. there have been some weird bugs with this AHCI controller before,
see e.g. 234e6d2c18f5 ("ata: ahci: Disable SXS for Hisilicon Kunpeng920").


 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f48fb63d7e85..a8f4d5db2c9b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4216,6 +4216,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	/* Apacer models with LPM issues */
 	{ "Apacer AS340*",		NULL,	ATA_QUIRK_NOLPM },
 
+	/* Silicon Motion models with LPM issues */
+	{ "MD619HXCLDE3TC",		"ID",	ATA_QUIRK_NOLPM },
+
 	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_QUIRK_NOLPM },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_QUIRK_NOLPM },
-- 
2.52.0

