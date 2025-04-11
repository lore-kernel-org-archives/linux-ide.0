Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADC17BA1
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377936; cv=none; b=U9vXaIWUMLthiy3WutuKupswC0lEWLeu/PidMWJblNPvphc4ica1r5KxPQi4YU5GcgzbLCSuiEZ7HCVeSsIr+bFt/WW+OvTcJuFsgpTroL0E3jLROj+5f7sIDFV8qlZjxMLYNW6rp/XYKRRX32SAH1EjXTHNY35EodhREAicYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377936; c=relaxed/simple;
	bh=mHGXnmJwsdioxE1+eTviqC7RFK50U/GhWnVsAaY2qEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCqFITJU4F97ZQa5E1N1N3eR9Lp5bHLx9ThoGNseYE5BbGLSe7JO54fCBQXBjVNY+B4PsqDAPDPjg0zaMmQBqAd48ylMGgTF8jUZajifAK4m8coGDewxdL4sRl6HQd+21zrC2I/kOrUP5C6mupWkH02DMoywfuec7Bq9xVnp5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP92VCpt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP92VCpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25978C4CEE2;
	Fri, 11 Apr 2025 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744377936;
	bh=mHGXnmJwsdioxE1+eTviqC7RFK50U/GhWnVsAaY2qEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mP92VCptUGvkVpJNFW0fpMAOW61WyOq/1R9htF5keURo1hlEWDImAU0q82NZcEUR2
	 IctyWzXxgOXPgRTePha9HjjQX/w++yH9LzrxFhds+xGBrHREmdwHU5rdWkL7/+D5Ik
	 V1xbtmUm4gJANmFfNMJYRroKYWXYBRAsAoGYHs0lf87DAtr6IE6+ylrQ1SgZQk0EJa
	 5apY6lldVOHvcbYVaOz3HnLHT2/rI6DYTPTBBFw2ay0oOzPqQuDGRx9OE/lSXQRRVT
	 u4WDVKHjq0bqOpcdvbdQ87ZMposzwsXb/5vTrwAqjCts84t3F0gpun8/ENUDRJfXQn
	 5dylGHwojKBxQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/2] ata: libata-sata: Simplify sense_valid fetching
Date: Fri, 11 Apr 2025 15:25:24 +0200
Message-ID: <20250411132522.126316-4-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411132522.126316-3-cassel@kernel.org>
References: <20250411132522.126316-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=cassel@kernel.org; h=from:subject; bh=mHGXnmJwsdioxE1+eTviqC7RFK50U/GhWnVsAaY2qEc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJ/Srh13/sdd+ASw+b6mc5/5QvuXFZm5o2aFVW77V9Pj JfR2obOjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzE4RzDP9M6L9Zvb4ueVkYV Gn88smd5qtv2RPUvprwGkx4fem70RInhf1FimnK5hPvN9ymfWpyuSH56Wac14e29rQfPL8u7pik Vxw0A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

While the sense_valid field is 47 bits according to the specification,
we are currently only fetching 32 bits, because these are the only
bits that represent the tags (0-31), which is all we care about.

Thus, replace the existing logic with a simple get_unaligned_le32().

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-sata.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 2e4463d3a356..5ba79a1053ea 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1529,8 +1529,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 		return -EIO;
 	}
 
-	sense_valid = (u64)buf[8] | ((u64)buf[9] << 8) |
-		((u64)buf[10] << 16) | ((u64)buf[11] << 24);
+	sense_valid = get_unaligned_le32(&buf[8]);
 	extended_sense = get_unaligned_le16(&buf[14]);
 	aux_icc_valid = extended_sense & BIT(15);
 
-- 
2.49.0

