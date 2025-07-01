Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F65CDF1
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328984; cv=none; b=Q37CY9/pxV2jbJBVXMHUDNJciFcm5efmc7OwZhj5I9NJ0HNnfxx93BV3Gg33KnM7m2gW6FCFeqpxKG8lNBMdViIpFF+svUM3yLfpljPOTvtjcbCpqqfqyg+6dfFteNyb/AkFMaVGHmopZJ9rXqPgI/wmp+yhFZeSAjNsTkk05XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328984; c=relaxed/simple;
	bh=5SxqJXdvzApPjuJJsCIbU9xXPj8J4aQQkzmepJXMBeU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF5Q98n4MaZOetQFARRkghXxp1xTcMozvpfZdH46GS8BnNmx/6pwHOK/+ythbgLmEzBitXmuTlrZu4E0ACcsxFZCcesqvelNAZ7zeNlIQ7yrF1gJhqhhCGHiesMhkdJhQqNH0dIhCGUX7hdJOLMb+tfqjWAdkQmG+pAvXF7KZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDBRvrRh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDBRvrRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1930CC4CEEF;
	Tue,  1 Jul 2025 00:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328984;
	bh=5SxqJXdvzApPjuJJsCIbU9xXPj8J4aQQkzmepJXMBeU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JDBRvrRhH4qHG/Z7xHf0jwSIVsHFYRvydnjRZLCWtzePYfLlmCU4riChlmYu/tv5e
	 c/1wDUUgEjof423AVOvKJAZ+Ri6l+eoyxiAYOnsKwSgSenkgAskWI1AjOBrEmAC1YD
	 Mu1ViPgM2dco216BcKQk6ODcyxJaRjg0yZD6bGZMg+0MYRGkBm9dqJbPexq7q9CF2a
	 p8rVy+4GurYcWDs+LJBSHxsh9LGvt2jnlhmU5Oa92DWMePKqi4BtxVIq285H1CKgJl
	 JIB2tqqXupZ0hZU/y6YYHZkDIySs93iFieEKDhA6cPL1X+kqSFUMIWXYdKQlum98In
	 NLQQQiNONBMQA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 10/10] ata: libata_eh: Add debug messages to ata_eh_link_set_lpm()
Date: Tue,  1 Jul 2025 09:14:08 +0900
Message-ID: <20250701001408.330364-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701001408.330364-1-dlemoal@kernel.org>
References: <20250701001408.330364-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To facilitate field debugging of link power management related issues,
add a debug message to ata_eh_link_set_lpm() to easily track LPM policy
changes done from EH context, that is, during device scan and
revalidation, error handling, and when a policy change is issued through
a host sysfs link_power_management_policy attribute.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7f5d13f9ca73..0f9c30f9bc1e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2140,6 +2140,8 @@ static int ata_eh_link_set_lpm(struct ata_link *link,
 	if (WARN_ON_ONCE(policy == ATA_LPM_UNKNOWN))
 		return 0;
 
+	ata_link_dbg(link, "Set LPM policy: %d -> %d\n", old_policy, policy);
+
 	/*
 	 * DIPM is enabled only for ATA_LPM_MIN_POWER,
 	 * ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MED_POWER_WITH_DIPM, as
-- 
2.50.0

