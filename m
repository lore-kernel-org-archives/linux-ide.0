Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80C41F7D3
	for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2026 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237200; cv=none; b=rKoxRxBFh4tBPwYU1tFJeLsoP0oJ2o5kvEtigcejDezqh/mQ5x0Umdrdw0RWShxHD+pjNdTZu+e2dpAz5J+q5+vXmb5TEl0ir9J2+OaiCyv9M1NF+5trbzUI2QBcC9ft9loL7/u/PvSJ0L91ONhAPgduKsuJYmpBRNNNLlWKmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237200; c=relaxed/simple;
	bh=MnQJoN3Mf5kXGP10PunhUP1Z+2ZZ4C6cG7pMR/ocxI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rd/VF3Qa1J2HhhNNkfqwwIUSu1i150qO4aflJn7d0MZYa1e3V4MU61AOXOPAxQYXvpt5IGooe2xe9AFSuqz3dqsaznJczOmYOuv3iyfLmlL0MzPnXOjrVAWVbJDSFZYDt4KqGUCYZt8XEXXa/GtVR+sEpJJNt+U5YAlNDL+YSO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LptAD/Bu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LptAD/Bu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E477C1F000E9;
	Tue, 28 Jul 2026 11:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785237198;
	bh=9a9F7zhfWme7R2iNMU7aabMjAQ3f5V0pP+XSx/W3Eoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LptAD/BuUFVF4YqwKmSxW9koj3292qg5u/Wn0vgCCbsBYxIpMjblI3egFSeSBd+Ng
	 vCZ/eAZLP7Xlz9bGgQ6QOk3oeJaDBLsqA6Q1cyUWRIFRJtipm37YSs1AtSI7riKQqd
	 rPBQIWGBOb6/CbS7D0SNtPZtK35VMAAK8tgP0Uqxw1y7258oaLWyNQ7yrYFhsXFy58
	 5m+tHcyrHS/PET4HivwoqUPrS5y85IZA7JFv7S7wJAyj9RFtZW4QO/xDBQBGG8qr1Z
	 Z50LNQZYCCBGaVhjEmQDoE9g6xMiwKsBs/b7h9r9RL9s2qPfIXzaF9K9KjApzY5fOD
	 oj5DTQM3esBFQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Ronald Garcia Vazquez <ronaldgarciavazquez@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/2] ata: libata-core: Disable LPM on WD Green 2.5 480GB
Date: Tue, 28 Jul 2026 13:13:12 +0200
Message-ID: <20260728111310.722450-6-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728111310.722450-4-cassel@kernel.org>
References: <20260728111310.722450-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=838; i=cassel@kernel.org; h=from:subject; bh=MnQJoN3Mf5kXGP10PunhUP1Z+2ZZ4C6cG7pMR/ocxI8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIy+o7PLwzPybr+t7RJ48rx9U925lcZNzwos9OaWtak7 nB40560jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkiRLDP/vr9xkKX3i/lVF4 E1W69jdjWuGWwyvfT/xwbsPcCLZpZrKMDJNfqu7/LekS/Pf1rQbrExl67EdWa3/e5se3jEtsYm+ kACcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

According to a user report, the WD Green 2.5 480GB has problems with LPM.

Link: https://lore.kernel.org/linux-ide/CAGiKK17Fg4SgS+y0GzD3new44QzD_yPZU5V3ZeHdUr9mFnfn1Q@mail.gmail.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 15781b4f0489..961d03fbc4d9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4420,6 +4420,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	 */
 	{ "WDC WD100EFGX-68CPLN0",	NULL,	ATA_QUIRK_NOLPM },
 	{ "WDC WD102KFBX-68M95N0",	NULL,	ATA_QUIRK_NOLPM },
+	{ "WD Green 2.5 480GB",		NULL,	ATA_QUIRK_NOLPM },
 
 	/*
 	 * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
-- 
2.55.0

