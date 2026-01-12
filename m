Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C9433B3
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220464; cv=none; b=rZtk7Zr4qhza4F3owKY0iRRsiPrktevW1eBKgZz9Im4NQbHBcBOV12TxznL1EqKCX1H2B3DI557O1pxqDPx2xAIn0Cdgs7tEg2S+nRjxcAHAGEoCgY2l76myQCycYzV6SLrcsaqFdYGnQawuB+WktmEAuwuCNyXfwGX7jQ8l71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220464; c=relaxed/simple;
	bh=3rDT6Xp7txtk9B9D7NilwcGNDAzXuNwGu2v0x78A+6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4Prd4sUAmRMMXbtpx29ggAcnVkEDrySox+1I60RphdKcNDJoR1+FaHYiBvnJSLlbl2GrsyzsxJC+b9azi07vtU6gv7ee2KqOj48qhiKrjH5vcsYd5pK+ZfxrNZdvF4PuYnJXMwfP/xSJb6T862lD6/E1cNr0lQ627Vqgzg0tXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0npYX+r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0npYX+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295CEC19421;
	Mon, 12 Jan 2026 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768220464;
	bh=3rDT6Xp7txtk9B9D7NilwcGNDAzXuNwGu2v0x78A+6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0npYX+rMnGgxwt2JM5vG0dQ2Ro+A1z+e7r5q/duItelu0kFFhmBoGYxMYdlrTK1s
	 2baVL/BNEGbAvaajOZgM6Z/td0TwEMo4BYKiayG7arI/+O6/S1qAiHBvLmCz72fGft
	 YGIu81mezV6mdJKreQ/0qtGUJAPjhQQbqmR8hAE3v569e+xGW/i0IsnjXCbT2Nk6gL
	 dttMFQJnxEp15LWkWhWAwdRiBBFC1IGg8inDz55KQx5V4ONldX7DLLthq5YRevV8+0
	 nks96ieWJfc2XWirpruM49ZObP/UW/fVy2ry1FeUGIGwzeVVpfezP0BRFrp0KN3UCw
	 UN7QXjMcLIkHA==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 4/6] ata: libata: Add cpr_log to ata_dev_print_features() early return
Date: Mon, 12 Jan 2026 13:20:49 +0100
Message-ID: <20260112122044.143637-12-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112122044.143637-8-cassel@kernel.org>
References: <20260112122044.143637-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=cassel@kernel.org; h=from:subject; bh=3rDT6Xp7txtk9B9D7NilwcGNDAzXuNwGu2v0x78A+6U=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJTniv6n3/64WEi+6HyQzN4Z3zL9C74+UPxztXXe08+3 6XfcODB4Y5SFgYxLgZZMUUW3x8u+4u73accV7xjAzOHlQlkCAMXpwBM5F8ww/8Slw0Hb7d1XrM8 UXXGvfXJwpW+NV+K7D8LloTluJpN5alhZHh2cm+2UfqSz3bTuO1WX6150SK/KUdPQi1m6YtcGdv 6S+wA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_dev_print_features() is supposed to return early and not print anything
if there are no features supported.

However, commit fe22e1c2f705 ("libata: support concurrent positioning
ranges log") added another feature to ata_dev_print_features() without
updating the early return conditional.

Add the missing feature to the early return conditional.

Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1e8e35c10b35..d8397982144a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2904,7 +2904,7 @@ static void ata_dev_config_lpm(struct ata_device *dev)
 
 static void ata_dev_print_features(struct ata_device *dev)
 {
-	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK))
+	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK) && !dev->cpr_log)
 		return;
 
 	ata_dev_info(dev,
-- 
2.52.0

