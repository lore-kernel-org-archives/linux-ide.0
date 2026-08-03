Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6A2F7F1F
	for <linux-ide@vger.kernel.org>; Mon,  3 Aug 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767412; cv=none; b=eSlPJ2sPKotYEDbl22En8lKK1Hb2EGK8K9BFqVI3R4bm3P72+g5Ys1oavf+Fq1G97ElLXpNfg54oqJyKJ1eLrnZVHeQqdLxlLr02uFYAL6zAvWZkrTnEpXKljE/aZDR3o4sN7QnV5G2jASx59ZTZfGLHPQr81b3LQLT23Wy49qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767412; c=relaxed/simple;
	bh=7+pp8IHZusvjKvk5Vf8L6JgnEri93qNj02pgHCqUB88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4DHpEjRGVgXLiHlyAdDTJAtSEqB4elDnvBaFIu7Efl6EyvrfkM/iHTifCi4UY0G5Vu2cgT35zokWe5bs/toaVi4j0Wkva9Sdp+X39okLtfaWGKfctrY9V17Ol/pERr0jfHbQ56pMpeGpe28bVVeSCm364h3zabuvcI8LDMNsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzuESl/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzuESl/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925FE1F000E9;
	Mon,  3 Aug 2026 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767410;
	bh=RkvDSBZ7pDuXtE84eolyCxxKnpEJUgTWyImV+dtZr6U=;
	h=From:To:Cc:Subject:Date;
	b=AzuESl/0Jev53/UM2r/cYJUdL+v+iLxhiLqyT5e6tF06dnDHw8hpQVvmUNK5CWEH+
	 vMhb/NOnekgXgBjbqBULmYjcZU+Mfeq0aZ5hTMp4w0aLJq/hUpdi2mMo74Ih40hSZY
	 jyQhA0YqiuNPknbNZZ2F/skRbYSkWaZdagippoWM5f14t/eFHfPTpTvxuj9oGird6G
	 kK5BHCC2rIkuY+Q9dO67D4Vk4umBjPy+HT67z/U88lfgY26l0+i09okRoM7Y9Ai/yP
	 fqjsd92qOfs1gQA4rwKNmRAX5o5qX43ll6v6ZfZF35Q9VvzV50OEGAp4+xBeNACf8O
	 Djuf7wmArqx1Q==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: James Turinsky <zerodata@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Disable LPM on WDC WD141KFGX-68FH9N0
Date: Mon,  3 Aug 2026 16:30:05 +0200
Message-ID: <20260803143004.362806-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=767; i=cassel@kernel.org; h=from:subject; bh=7+pp8IHZusvjKvk5Vf8L6JgnEri93qNj02pgHCqUB88=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIKlr45Ip8fqh7z+npEa3dLWXVysvDch7UXUxze3Vxr2 rh+hZ1ARykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbSeI/hf1ps4PySIwejv+rY 8IXJO+Z//P1jlUDwflf/J6zBRspH1RkZfktrdGdl11xQP+ee13HxTfCa3id7M6QYtCU7TidrukR yAQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

According to a user report, WDC WD141KFGX-68FH9N0 has problems with LPM.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220693
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 961d03fbc4d9..59e87b987d73 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4420,6 +4420,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	 */
 	{ "WDC WD100EFGX-68CPLN0",	NULL,	ATA_QUIRK_NOLPM },
 	{ "WDC WD102KFBX-68M95N0",	NULL,	ATA_QUIRK_NOLPM },
+	{ "WDC WD141KFGX-68FH9N0",	NULL,	ATA_QUIRK_NOLPM },
 	{ "WD Green 2.5 480GB",		NULL,	ATA_QUIRK_NOLPM },
 
 	/*
-- 
2.55.0

