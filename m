Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E63596B
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374540; cv=none; b=RLv4/KmdEUFZkEoNSsSSZD5EBrBG6Iw4zncJJkev1++/YKqBZq6dJqHRwYKHax72TWxYrgK5kxUxT1Q6UqRgc9ODGxu6rdno2WNdTHOq6jGr2wjosDVqyt1FEYJpIvWghO7M0lDbBLfuNfWwM/RsIzniaqiGLNQR578sWCt7tkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374540; c=relaxed/simple;
	bh=lE7poR0W3FbvXfof8L1+sSh0mMQo6rpTy9KLwLcwIzc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDRLmUauXHxME5SoltYJe+t5ZhelVfC6wExdUsRffOUI2961esY7imtc1L04Xt39qDARB3hothfXz52M52ZdOIQggUr74djxGXUGacLyVi5IuU6c7psLgLqRIeZ0BW9J2bKj2Dzj2rXASZjvNxS7SeH94P1cDxutW2F5lY9R4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am99Guzu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am99Guzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9B2C4CEF2;
	Tue,  1 Jul 2025 12:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374539;
	bh=lE7poR0W3FbvXfof8L1+sSh0mMQo6rpTy9KLwLcwIzc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Am99GuzugEXEGKdYWpGTFUnad0juU6nu+26yvJnFVwNkXewOGrqZ9feyjK2lAL26o
	 mnFu1LteFxEr5sX8u+yMpYrb21tdvlmPHIyIeq+Q1lQIyvcuQV4iIs9cBvRQ7exD3l
	 5OvAJ1NCjIB2Ma9rXEJODkMc9TpZRcs3wWvAcrI5fQFfB9aZ6Qd5Rscj1IIbPZJjsk
	 5HWe+f2RZnjhXsAyMHWEpK3j9HvWzYzTxMjMqfcdJGh9VXSSSYAYNJXBvlQYkhMla7
	 97I+jb4fZCh/VYMc6WoqTNAhPxJnYzXJtBrWU309H8nCayl4UtXYBkts6mzaIpmn2R
	 AoqrEye6Oo1mw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 10/10] ata: libata_eh: Add debug messages to ata_eh_link_set_lpm()
Date: Tue,  1 Jul 2025 21:53:21 +0900
Message-ID: <20250701125321.69496-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701125321.69496-1-dlemoal@kernel.org>
References: <20250701125321.69496-1-dlemoal@kernel.org>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

