Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56B27A45C
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243341; cv=none; b=sivVfHM1paM77Xdey0XdLIHzT2ybyuB4YYikLUjCxpQke9ItBToCKorCjCgFp4Mwi0339MWqZeLLS36RppDsf8cJXb/8Dchjfj69yT5rkJ/XfA+XMnE8HBGGU6v3ZRejbcy47CtdHxPYkyRmGiJ0qJsFOzDerCACNAEZVwF/+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243341; c=relaxed/simple;
	bh=0Ie4PnnAk3S4Lv0uSxyex5CY1wv1wnLmN/ysAwYVdw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkToZON8VpMY6k9+8yL8+O/Z6joi0AIJ5VJ6ip7+apirg0BS4hmlxSGQ1KL7CqG81dDo04Y8LDqX4cFVv2nth8X08iP6WoQL7vQuIIVFFmvMk0JpTKQCup3ajn3Fprm0wRuUhqdO6QCScQQiJOrlZkbDbYZY+tWfAVwhuXXcocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfsb2w2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfsb2w2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C66EC4CEE3;
	Wed, 14 May 2025 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243341;
	bh=0Ie4PnnAk3S4Lv0uSxyex5CY1wv1wnLmN/ysAwYVdw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bfsb2w2Tz7OZCj59514ijUjB1vKLNfT8cEZjFknZyjELNNvHDuaQ0GyTTivV0imbD
	 qFMT0HINjBBxRLj6UT6hNWeudQusS1Xlcac4jBL06hNhcRYnLfjE/mLr944BiCkx7s
	 KAdy1Ayy//68yoSWVG9AQZKOE5hUnS2VnPrVdOx07QFrs4wdVfYJ9oO3/qggJG2lmt
	 UON4/L61EzNdWB8bwp6BAo8OlmtUBZBU3DC/6dj5gxKcLCNiMkVC5XZpq+xywkgoKH
	 uzz8oXzQPtgTp7fMcg5xHSFzmp5FPfId+QtEmtkGEqO2u4J2gA8gQcmLLfu0kKBvVS
	 ph2pkIG8GOJig==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/7] ata: libata-eh: Add ata_eh_set_lpm() WARN_ON
Date: Wed, 14 May 2025 19:22:12 +0200
Message-ID: <20250514172210.383801-11-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514172210.383801-9-cassel@kernel.org>
References: <20250514172210.383801-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=cassel@kernel.org; h=from:subject; bh=0Ie4PnnAk3S4Lv0uSxyex5CY1wv1wnLmN/ysAwYVdw0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJULjor1D8++DQ8T2jr9sAjBZMa7XgievXdF8iIPstkv y+95IBaRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZi48DwVzTEbrtgtZ6B74KS X9+FJe5VhwlVO/8xLjnHJvPAWmqRDsP/kk9X3cxN5/xfv9Wra47ThJzIrie8Enq6zmXOTy/KOx3 jBwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

link->lpm_policy is initialized to ATA_LPM_UNKNOWN in ata_eh_reset().

ata_eh_set_lpm() is then only called if
link->lpm_policy != ap->target_lpm_policy (after reset)

and then only if link->lpm_policy > ATA_LPM_MAX_POWER (before
revalidation).

This means that ata_eh_set_lpm() is currently never called with
policy == ATA_LPM_UNKNOWN.

Add a WARN_ON so that it is more obvious from reading the code that this
function is never called with policy == ATA_LPM_UNKNOWN.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index edbc5d7572d1..d2ccdb9a2840 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3442,6 +3442,13 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
 		return 0;
 
+	/*
+	 * This function currently assumes that it will never be supplied policy
+	 * ATA_LPM_UNKNOWN.
+	 */
+	if (WARN_ON(policy == ATA_LPM_UNKNOWN))
+		return 0;
+
 	/*
 	 * DIPM is enabled only for ATA_LPM_MIN_POWER,
 	 * ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MED_POWER_WITH_DIPM, as
-- 
2.49.0

