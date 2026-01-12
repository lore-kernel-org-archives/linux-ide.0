Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE61E4AF
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220461; cv=none; b=HxghwiYKa9s6x19HoylG91jYg6UfLAYLcgJMN1HHYkdr+iUFv91Xvq+R07/YouaN9kxyp9angiQ7ed3Uum5J3P4iXhdFNIm9RuRfzOXtkMMyaNsheBgSaXN2lLS9yEKcb3K1JBgIZGBrscQrB6AJRDAE6VT8Axyhim8kAsuNsDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220461; c=relaxed/simple;
	bh=fNim+94y4v8yNtiGQitFYsOisBHteLxBJyObQ3EAFOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otoLAIjNQxN/8FNOlZvYmDYVvj9EDkpZII4Y2y5agmTqPi0LDgwz3hpvOEhIvXkJ8sneb++lMduG55Xh3ret9rlfjknHwIAWGEbeXA3HgeG2bqpx6Dh2UFq2V7JgJ/jPTjH5eQYm2NUZyYjrmiukzHrBWJZy+nCJ2pOI58++F88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbKMqhYB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbKMqhYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DF7C19421;
	Mon, 12 Jan 2026 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768220461;
	bh=fNim+94y4v8yNtiGQitFYsOisBHteLxBJyObQ3EAFOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbKMqhYBGnVXY9m3hC7XJOv5Rrr2tlzjtrdiEtJZuGcSiE16jaIK53BdvkuqrfKcA
	 W1bZkHry7HHImLJWstIX8ELri2JYpgCxToNpGHKSq+QcgRu9DV3OP2EIM3t8zH7K/e
	 hUdmLUPLV3AG9g3c37osIkIV1ys5WJiHYL1VhZf+yNSAX0LG3V4zXd8VEHcvZGY5Pc
	 GmIAMtUaHHjwbmDzmLZvAhGU7ts3vf7PMkHJrLNgL1mCB1vEy8MsC6zUMG4ZtDa4PW
	 08TL/N36dJF/tllj4zEktQakmnpUkvtR0ngUjlixGMxvlTkU0WJTAU4LHd4QQyq5y9
	 U15i7AwHFesXA==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/6] ata: libata: Call ata_dev_config_lpm() for ATAPI devices
Date: Mon, 12 Jan 2026 13:20:47 +0100
Message-ID: <20260112122044.143637-10-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112122044.143637-8-cassel@kernel.org>
References: <20260112122044.143637-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=cassel@kernel.org; h=from:subject; bh=fNim+94y4v8yNtiGQitFYsOisBHteLxBJyObQ3EAFOA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJTnisKybZmnOc6d+urH3Ob3bMv/RIJPOFz7R/Om33Pq M29WCuko5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABOZ95Lhf51i8ZTD85qkOcpK IhJWf6tev+l8iu615TddFe0ELL7+SGD4w6s7W/Wbrvb3+mdmZetvm0Z2/GINmXAnKVd39wPRy4Z K/AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit d360121832d8 ("ata: libata-core: Introduce ata_dev_config_lpm()")
introduced ata_dev_config_lpm(). However, it only called this function for
ATA_DEV_ATA and ATA_DEV_ZAC devices, not for ATA_DEV_ATAPI devices.

Additionally, commit d99a9142e782 ("ata: libata-core: Move device LPM quirk
settings to ata_dev_config_lpm()") moved the LPM quirk application from
ata_dev_configure() to ata_dev_config_lpm(), causing LPM quirks for ATAPI
devices to no longer be applied.

Call ata_dev_config_lpm() also for ATAPI devices, such that LPM quirks are
applied for ATAPI devices with an entry in __ata_dev_quirks once again.

Fixes: d360121832d8 ("ata: libata-core: Introduce ata_dev_config_lpm()")
Fixes: d99a9142e782 ("ata: libata-core: Move device LPM quirk settings to ata_dev_config_lpm()")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b96105481784..1e8e35c10b35 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3148,6 +3148,8 @@ int ata_dev_configure(struct ata_device *dev)
 				     ata_mode_string(xfer_mask),
 				     cdb_intr_string, atapi_an_string,
 				     dma_dir_string);
+
+		ata_dev_config_lpm(dev);
 	}
 
 	/* determine max_sectors */
-- 
2.52.0

