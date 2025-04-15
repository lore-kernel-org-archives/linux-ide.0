Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EA279915
	for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702231; cv=none; b=dxyLsPL0YT9r+MlINiH4xU0DdZNEP7H4U5Bd5XgaezzMhHYkmdckiGTFnfO9J+8FeQgyuulKcaTzp5m537erSeO1KGCTbOaOAZqmNSn6DmDLroOQVYpJ1ZPMj5IsUJ6E4iEaNFnqMXAZS99KrV4zliDExs/tLuuTzqThsKq/ZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702231; c=relaxed/simple;
	bh=tnWrOQ62iZUFDVAIY8wXVG37wEWAK+JeOdeF0XfEuvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pll26cKhEZT6nUx/W2XPGdfw67amD3zi0/mXursNOCu4KC01ZRqqmJSw8x+AxNP4uzttl8oBLpEFpest8jEEUSJ1UN5H6uzB1wkJO5PsDqgZ0U6wnalHJMkzMePxPy0q7tM15lG0afR2WnCcyfEklf2bJmJ9RVlVLY8IA1CTkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4OI8DOI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4OI8DOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809F5C4CEDD;
	Tue, 15 Apr 2025 07:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744702230;
	bh=tnWrOQ62iZUFDVAIY8wXVG37wEWAK+JeOdeF0XfEuvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4OI8DOIBFW/AD4OgguDSsXWY7zDcdW+TptKRxVco1dEHpKMyF2zERbdm/iGQVAsp
	 fpcjB81NF2GWVlrnM7ws+v/XEilP3HrdW5m0daxvxF3zFW4lodVmZe9UvJer403qnR
	 fU3/TSiTjQJAgxxpCCRMl/z3V+5/m9uVCgp5ugGy2g3gtbXnL4r0X50xoFu8lBUJ9x
	 uM7eBVOOspPiGjZFvrHE7pgLorH3KlVmzS1BLgztdsM5A4AyhMZYGzZVtaXP/lpQBW
	 SCoZmZAxLdUC9/R4cSGVZKallYR0UMdCQJW9ks+6oAM3vj0RWfmquR319MERYh/eDW
	 vB7A0lNaADDTg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/3] ata: libata-sata: Simplify sense_valid fetching
Date: Tue, 15 Apr 2025 09:30:16 +0200
Message-ID: <20250415073013.414987-7-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415073013.414987-5-cassel@kernel.org>
References: <20250415073013.414987-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=cassel@kernel.org; h=from:subject; bh=tnWrOQ62iZUFDVAIY8wXVG37wEWAK+JeOdeF0XfEuvE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/cXPFTur9xp5y1E7uyL55E9a15raaNgeuWac/ISqwp Tn8WaxWRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYSEcHI8Err9L6Pfbcb5sSp 29+dMf9NoZKW/82c/vDb3XF5h+8bVTAy9CTzCGV8WpUkxbl6p4Dx/tojOQvm6t841lGkukz69x5 FbgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

While the SENSE DATA VALID field in the ACS-6 specification is 47 bits,
we are currently only fetching 32 bits, because these are the only bits
that we care about (these bits represent the tags (which can be 0-31)).

Thus, replace the existing logic with a simple get_unaligned_le32().

While at it, change the type of sense_valid to u32.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-sata.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 2e4463d3a356..076953d18db9 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1509,9 +1509,10 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 	struct ata_queued_cmd *qc;
 	unsigned int err_mask, tag;
 	u8 *sense, sk = 0, asc = 0, ascq = 0;
-	u64 sense_valid, val;
 	u16 extended_sense;
 	bool aux_icc_valid;
+	u32 sense_valid;
+	u64 val;
 	int ret = 0;
 
 	err_mask = ata_read_log_page(dev, ATA_LOG_SENSE_NCQ, 0, buf, 2);
@@ -1529,8 +1530,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 		return -EIO;
 	}
 
-	sense_valid = (u64)buf[8] | ((u64)buf[9] << 8) |
-		((u64)buf[10] << 16) | ((u64)buf[11] << 24);
+	sense_valid = get_unaligned_le32(&buf[8]);
 	extended_sense = get_unaligned_le16(&buf[14]);
 	aux_icc_valid = extended_sense & BIT(15);
 
-- 
2.49.0

