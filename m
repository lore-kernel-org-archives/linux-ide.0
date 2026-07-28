Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D341F7D3
	for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2026 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237198; cv=none; b=fdWQ7zbI/fT+FnQvodyTbrnkPhrfkv3F/Np7Zf5eZJrqvYtFXwfL5x4tOWkMUGVU7QnIXOQDFV7vCZSm2kxas8Yygc/I5CR/LRBe3eTwyg2yfbprMFsT+mpkSqUIr2XbldV9jqiMZZPnAKQQWjsAi6ul6cXpQR6dXQrwgE18Ifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237198; c=relaxed/simple;
	bh=V2Z4KldsPo6Ir7BK44qwGgsfbzQ7opCebrHN8XHmWFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJThLJDiJFr7SVSb0/CgvhsmC3trKcIM0rNb5ysRQhs/XFvNkVLCbyomB/HqkzDT0/CTbqThEoCaPO9C4XpWUEsGnfN2h2QK79tfGPlZc67BypXpZInXNeh1yfhSmyhLe3q/WUuRct00yTGnCPsyq6yzgEwqz0pbifY/rG7Jfmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3E8+4kX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3E8+4kX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A8E1F00A3A;
	Tue, 28 Jul 2026 11:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785237197;
	bh=ME9ci78XrN0hYXWFxj0cagwFxIGXXSMiWB+A5fhYh9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3E8+4kXqrNlBLICGl15wfSgmzy3REO5VCFrlH/tTLngiGtiLrRkdocjty214XOol
	 qfvHWj6oir7HR6+BRPMz56v/IY7ar1IkqtHUr4oew5AcjBCkHEzap+nszEHXrwbXA1
	 aKXo4nj2d7JZ7fvi1sLYTjN267kx3kBid3c6WnbN+n+RWAxidZPYG9lHaO/ae71Oif
	 dR9t5dlrRyuevMO3gaDzgt3ggliRbnp9iVtc8sld+Ot/U++wIojHH5PpeP45YbesXx
	 PnBnFnOtQUMdvF8pijTvIbmzTyV+vq9rPeabGCMobQfuR0b8OJ8DkIwkx9DVsT3uMT
	 vZBmClQWC3dfg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Ronald Garcia Vazquez <ronaldgarciavazquez@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 1/2] ata: libata-core: Disable LPM on some WD drives
Date: Tue, 28 Jul 2026 13:13:11 +0200
Message-ID: <20260728111310.722450-5-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728111310.722450-4-cassel@kernel.org>
References: <20260728111310.722450-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=cassel@kernel.org; h=from:subject; bh=V2Z4KldsPo6Ir7BK44qwGgsfbzQ7opCebrHN8XHmWFI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIy+o6teBl98Gjbo7tTzDm6+3mm61298vJHkhLL972vE pJXOdxw7yhlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE9GsZGQ7t5mypXqL/fGnL PDe7idv69qmUnbXXM2O8/yAwqcX8jzUjwyzx/cez4h4q31EWXa/UNYFxaxnrvMfnar9sOW9u62N mxQsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

According to a user report WDC WD100EFGX-68CPLN0 and WDC WD102KFBX-68M95N0
have problems with LPM.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220693
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c43bd28b20b1..15781b4f0489 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4413,6 +4413,14 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "WDC WD3000JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
 	{ "WDC WD3200JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
 
+	/*
+	 * WD drives with LPM issues (irrespective of supported SATA speeds).
+	 * (Unlike ATA_QUIRK_WD_BROKEN_LPM, which is only applied if the drive
+	 * exposes SATA Gen1 speed support, and SATA Gen1 speed support only.)
+	 */
+	{ "WDC WD100EFGX-68CPLN0",	NULL,	ATA_QUIRK_NOLPM },
+	{ "WDC WD102KFBX-68M95N0",	NULL,	ATA_QUIRK_NOLPM },
+
 	/*
 	 * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
 	 * log page is accessed. Ensure we never ask for this log page with
-- 
2.55.0

