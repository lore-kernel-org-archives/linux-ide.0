Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0DA320A0F
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220466; cv=none; b=UVVr/7XbyxN1Zrj46APU1/5E0+kxWbos2SvrEfKYAo7gZTmE7eSUtoTTaWe8ee64zFQojmxx09S0HWREYiQAd83MRll3eF8L6lmsx/+n49AzqUmkMCF5iXFRf64gT57YoBoJi9q1X+/MxnJKfc4kznPLCMOWFMjzg9EBEfX25KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220466; c=relaxed/simple;
	bh=PbRsGz5IcmYkNGmAHOAqZK0LdLZUnM6SKJ+v3AlMHwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGoJGQBWBW/UEfqoW+v8z487iD3GqEdQqLOT7cSrLnpfIZSrnowJDsRR0I4xEXe/yrmUmW9Z4cyc6PJa5MDCfOGejgsfrtbtr12bw6a/V+swVT5FqMclQh/Pi0xVRSx9e7UQzRJUrcS2xWDff8+7K1Ue5MT5t4pXkC6JwOm/X3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpLDkUTM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpLDkUTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4421C19422;
	Mon, 12 Jan 2026 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768220465;
	bh=PbRsGz5IcmYkNGmAHOAqZK0LdLZUnM6SKJ+v3AlMHwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpLDkUTMM1GFtCbMuJAUm/wxmE4/UR6oepMyTAQkehu/H0Q2NvfkEmlCpKzikfTO0
	 5R7rpG47YBRQTcdsZ233QehwRK2YiDL/GwQ7uOg6UcYHju5PhQ7ieVwC+aJJJIjFyx
	 wiCMkBqc4QW+71q3FycJNAk+Mc3RiYWhyWMbP9IcS4KcE4Z6xcSBc6vl9ylEEOjio5
	 tWybnC5MlRezHN3J/DS1Iq1X9pJ0l1bXZyZvc5cQquzV9du1mjooid1oYfKqEoT+fu
	 DJ/xzGMr8f3Ns6p46JpKtDqUfGoJ7FVpge9wzgK1Hy8ZQwgcCANmfSsgidLEFtKRGK
	 V2YxdSG9iP6GQ==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 5/6] ata: libata: Add DIPM and HIPM to ata_dev_print_features() early return
Date: Mon, 12 Jan 2026 13:20:50 +0100
Message-ID: <20260112122044.143637-13-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112122044.143637-8-cassel@kernel.org>
References: <20260112122044.143637-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=cassel@kernel.org; h=from:subject; bh=PbRsGz5IcmYkNGmAHOAqZK0LdLZUnM6SKJ+v3AlMHwM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJTnismlHn4/As1d7/GvjLihblJqk7dnrfrsl/u/mTJv W7D8WcTOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRX5KMDBuydtTmvp/w9add rc+no3sLVr+9f2xTmEjd5bdxqeoP5i9g+O93Y7LMxK0fThkaTui+7X7zkKv8yWQXn6uG84xOfua VPc8CAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_dev_print_features() is supposed to return early and not print anything
if there are no features supported.

However, commit b1f5af54f1f5 ("ata: libata-core: Advertize device support
for DIPM and HIPM features") added additional features to
ata_dev_print_features() without updating the early return conditional.

Add the missing features to the early return conditional.

Fixes: b1f5af54f1f5 ("ata: libata-core: Advertize device support for DIPM and HIPM features")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d8397982144a..7656aea7663f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2904,7 +2904,8 @@ static void ata_dev_config_lpm(struct ata_device *dev)
 
 static void ata_dev_print_features(struct ata_device *dev)
 {
-	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK) && !dev->cpr_log)
+	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK) && !dev->cpr_log &&
+	    !ata_id_has_hipm(dev->id) && !ata_id_has_dipm(dev->id))
 		return;
 
 	ata_dev_info(dev,
-- 
2.52.0

