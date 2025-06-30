Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A91FBCB1
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264930; cv=none; b=gOaUK2u44sK1KV92DPotMeyAUvP9/+asXxPsTWAH7xdfg2l2ft01m2nC8izUfFC0hwwxStIYSKnOb6TL371ioH1gbwDA3GxMrvTjdEV5CbOYLHqD0ehmiyodhHFhtMNDE4uaCoUR5X1pzwkK7vqeIBHPi3E7GtaRpYXL488yK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264930; c=relaxed/simple;
	bh=00aCg4SUaqJN62R59JO26fiEh6ZQs5ftCnbJ2NMuyKs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkLsVFfCtoyDcKURAPFrjOHRUj/hqgtjIx656GSfsQVzdaJSSHd7MEPh2G4CEqTVFQbFmQdb8ip9oVrui3xJGTE4eJFCipCnyD/uIffLsqq55PuWouKCBD49XAD0zvN2cLCvfOKcmtousw1L0xfkNlJ1rYMWpAmEwzkYLHkNxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT8tjtlZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT8tjtlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A830C4CEEF;
	Mon, 30 Jun 2025 06:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751264930;
	bh=00aCg4SUaqJN62R59JO26fiEh6ZQs5ftCnbJ2NMuyKs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jT8tjtlZ7gch0fSgXIDh+bDGWaGYq5TbIpJZj8uE85AAN8ghSWUy6L/0bos7A4LSj
	 iSVC3R8MhlBZKtT24sdW+RDVdRGHVupmH01/wrxud9DMf5MfK+Ui9o6Km8OOlmufGY
	 5q080K3VL3C73iFPBvKVPYIA2SZfDjTVFZvhV3O603VshX0BXwRiHjBgkGaPve5dsB
	 H8Hbt3gUIIMditwurwbZCSO1rp/KJ1Dgsv3w37FAZpqxHOVwx0AQRjI08ws1LeDTlC
	 B2OtwkJ8jOUAGNZ3kYwl/9FcoeQv+JTuleQTiwYdQk6+h1tpS20p1D3dp82lwUrS1q
	 Dn8H+uEip8W3g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 03/10] ata: libata-core: Advertize device support for DIPM and HIPM features
Date: Mon, 30 Jun 2025 15:26:30 +0900
Message-ID: <20250630062637.258329-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630062637.258329-1-dlemoal@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify ata_dev_print_features() to advertize if a device supports the
Device Initiated Power Management (DIPM) and Host Initiated Power
Management (HIPM) features.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fdce96fd3ffa..d1dff9018a3a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2843,11 +2843,13 @@ static void ata_dev_print_features(struct ata_device *dev)
 		return;
 
 	ata_dev_info(dev,
-		     "Features:%s%s%s%s%s%s%s%s\n",
+		     "Features:%s%s%s%s%s%s%s%s%s%s\n",
 		     dev->flags & ATA_DFLAG_FUA ? " FUA" : "",
 		     dev->flags & ATA_DFLAG_TRUSTED ? " Trust" : "",
 		     dev->flags & ATA_DFLAG_DA ? " Dev-Attention" : "",
 		     dev->flags & ATA_DFLAG_DEVSLP ? " Dev-Sleep" : "",
+		     ata_id_has_hipm(dev->id) ? " HIPM" : "",
+		     ata_id_has_dipm(dev->id) ? " DIPM" : "",
 		     dev->flags & ATA_DFLAG_NCQ_SEND_RECV ? " NCQ-sndrcv" : "",
 		     dev->flags & ATA_DFLAG_NCQ_PRIO ? " NCQ-prio" : "",
 		     dev->flags & ATA_DFLAG_CDL ? " CDL" : "",
-- 
2.50.0

