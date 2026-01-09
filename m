Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D29335BA7
	for <linux-ide@vger.kernel.org>; Fri,  9 Jan 2026 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969600; cv=none; b=uCzIsOzS+k7klgAaiW8k3enbs5/SmnBCqOSvHSjP4ASKZc0ZN5vVjfGwPWUoQM1bTSlwauYTeHu13rTkx7p5y6+YYFf3M13tZkhJgcKpErFrAac5qYG7ylouONfh5remcPPkULN/ZFyIWGXrMtET9n0nm3nmUzHmGVtgRNY97Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969600; c=relaxed/simple;
	bh=r8RAoh1ZluAHbG8ww4WXVNW1kQo1wctpSYrFDDaVmA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLaXxl30/S+w2mwmn4+GT7En4AO86JRTrV5BEIBghbDcjp++WPjsfdn9iHV30szjd78I2DYe9rbC33WvD08VlaymFTmrOMiBWQAJk6PNZbdD3aHWCPKuzN1N9towrjRmK03bDHWWQvxL4dE0kz6TGxcF0TpECQrRIrmw0SUEImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq2Dlifa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq2Dlifa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D08C19421;
	Fri,  9 Jan 2026 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969599;
	bh=r8RAoh1ZluAHbG8ww4WXVNW1kQo1wctpSYrFDDaVmA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sq2DlifaKKAr6HYUkj/6NsDhHRBTYxB0In22QILuYIcUsjLv0AYREiM6FUHq2+NdZ
	 MtQwux0V/lqlsjHxMn8/GHB5MqPBBbQ2Z9AUPETJjm7dWTht2hARRnHZDRuD/S2DgF
	 8xeuTqJTksr/p0uZ3t88d6gcImBSV/xHReDzpetA4Fc7QHpkrG0jRFhb4y785lEnZz
	 WJum5UNgnYnz+KK9vW25pTGegYpRiaSaBNGV4s6PkfR7WCYbLRa3xz9CHPL441IZF9
	 r1O59mNPPz6r1jf3n/xqsD331cKISBoCOlhkUvzQp3OQEXxchLuR2ZaF5OFnXtqtxZ
	 y9oJIZV4sqs3w==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/5] ata: libata: Fix ata_dev_print_features() early return
Date: Fri,  9 Jan 2026 15:39:52 +0100
Message-ID: <20260109143949.331105-9-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109143949.331105-7-cassel@kernel.org>
References: <20260109143949.331105-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432; i=cassel@kernel.org; h=from:subject; bh=r8RAoh1ZluAHbG8ww4WXVNW1kQo1wctpSYrFDDaVmA0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIThU157+14syfi/XaGh4y8YpMYr8iY3VZap5AWdv3p+ 7+HrjZ0dpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAitk4M/yMr/s4w4H5xypST 9fzvWVx5YuoJt0NWst3pYmS/4MR09Cojw3zrFK1Ir198tU9+bf5fIKyd/v52fkbfSqvglye+TxN 7zAgA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_dev_print_features() is supposed to return early and not print anything
if there are no features supported.

However, commit fe22e1c2f705 ("libata: support concurrent positioning
ranges log") added another feature to ata_dev_print_features() without
updating the early return conditional.

Likewise, commit b1f5af54f1f5 ("ata: libata-core: Advertize device support
for DIPM and HIPM features") added additional features to
ata_dev_print_features() without updating the early return conditional.

Add the missing features to the early return conditional.

Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
Fixes: b1f5af54f1f5 ("ata: libata-core: Advertize device support for DIPM and HIPM features")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1e8e35c10b35..7656aea7663f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2904,7 +2904,8 @@ static void ata_dev_config_lpm(struct ata_device *dev)
 
 static void ata_dev_print_features(struct ata_device *dev)
 {
-	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK))
+	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK) && !dev->cpr_log &&
+	    !ata_id_has_hipm(dev->id) && !ata_id_has_dipm(dev->id))
 		return;
 
 	ata_dev_info(dev,
-- 
2.52.0

