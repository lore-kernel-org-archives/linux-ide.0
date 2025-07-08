Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA45298258
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960345; cv=none; b=tcyIvHsV2eU7hRYGaLczga0Sy/ZG402mEomJD7SmG0zVOOqhviewvgsUTXGU4F9nCs/pqI6XuL0bHnAmzBdXze909e3T8WSow5o+tNgcdwMDZF0jeAA0keXYR3fsa3PdGqlRrlFSpFA9KFqAxvLyPFivUEk9FIYrHitxHIygN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960345; c=relaxed/simple;
	bh=TXl63IqT0lmlOiBhczZtvI/Jx/6HS+vx2wmfv/xxGf0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1Vc++ItKNBzJkzAtcJu30Vki6rE1+Dj55Ewq3e9nvz1c4EQFpG5CzcG2XCexFWBf0zXLKqJD8nbJreVn6kzsbwY9ZOJuIaLIjPQbxorpT9/PbX738uTjZ5BVX7VzfeBP2Z6phJnHR9WMa8ITtZDsVgyNtinsdqhRyuLItDdw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnPhlzYg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnPhlzYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BA8C4CEF0;
	Tue,  8 Jul 2025 07:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960344;
	bh=TXl63IqT0lmlOiBhczZtvI/Jx/6HS+vx2wmfv/xxGf0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VnPhlzYgsr5Rff1ojm4EA36e43DrUV1RXS8P/v9LRdFyorZrQfsz4OEHrIKPLdq0k
	 l+LInQiv2gddXY3c22SfIXJ9RvX2453NWE+iHhVHV97EJ6ZY/J42SsfdvrLv/+DvEU
	 +H6HIPiz9E2I9rhiyBFE9GUUUHuuzivIbwL5EKXOOkvhrTxJKprSXLS0Q7YMP1s5K+
	 jDV43yb68w5+xfdCTijJdKPNk5MBuE/vCUUvvgyzQaEDUKXPyuxCBr+Yhuohpcwr8w
	 QIpcfry9h3QEWtMckKKCCSWrsWoeuyfbbrSFqepHPqyHJokLg+AXcKo9tEd6rkpdZq
	 iLdV2ODAQX8sw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/3] ata: libata-eh: Make ata_eh_followup_srst_needed() return a bool
Date: Tue,  8 Jul 2025 16:36:46 +0900
Message-ID: <20250708073648.45171-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708073648.45171-1-dlemoal@kernel.org>
References: <20250708073648.45171-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ata_eh_followup_srst_needed() returns an integer used as a boolean. So
change this function to return that type.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 42aafb1ddb5a..436536112043 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2781,15 +2781,15 @@ static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 	return reset(link, classes, deadline);
 }
 
-static int ata_eh_followup_srst_needed(struct ata_link *link, int rc)
+static bool ata_eh_followup_srst_needed(struct ata_link *link, int rc)
 {
 	if ((link->flags & ATA_LFLAG_NO_SRST) || ata_link_offline(link))
-		return 0;
+		return false;
 	if (rc == -EAGAIN)
-		return 1;
+		return true;
 	if (sata_pmp_supported(link->ap) && ata_is_host_link(link))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 int ata_eh_reset(struct ata_link *link, int classify,
-- 
2.50.0

