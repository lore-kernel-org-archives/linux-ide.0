Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A280433B3
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220467; cv=none; b=d7GmbUz63Xvr+/LKNsSkGYa3zI712k1yDJwVqdek6Qa2n8csEgI2cXTbILSmlOjZ9Yy/FE4C1xECLrDwG80XLlOulpkR9CQyMiMBzdPpVz+pPPVa0zF2HOg5xPr6vd3Hy+8LG54WdDQMoThI0ACH6FrE5FP9tQVIneGCiBxn7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220467; c=relaxed/simple;
	bh=W9YEwrG4qavkDWkmEQJrIMFG9ufUFlkILgTHOGRZ9Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4+lzCw7rTD30SYFmgIlIXanj35cB1hj6zt8TyRiuf8mRArg0t8NBqkrCikYCNVTTWjGNjq0LiGAV2p4YQ1/SNse9f6eMMDboEQRMg/vCRpzFwICygosDJ6ORWyq1jmljRcvCZ2B2z/EUvkIkRz3AngTWdClgK/iS91Wll+qEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejLk8+rg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejLk8+rg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B688C16AAE;
	Mon, 12 Jan 2026 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768220467;
	bh=W9YEwrG4qavkDWkmEQJrIMFG9ufUFlkILgTHOGRZ9Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejLk8+rgogfGk17Hc9G+NVKU4dT1N7SHPb3CGVcMHj5XtD/lNVgcOFL3GHt1bzrRg
	 Sn+QT9rHnvPr7p4/Ue6Qmuv2Buav1EiLYmQqhnRxevW9msR1FkipgigQ4cTxGDJYp8
	 PmJEO90uRsD7gQQ3cuesxLgCNTCcmJdRDsx12BAxDfFjKvRTA6pvjYq3B732vTTMps
	 q/0hSqntcAlTPwi2GE2PQokfXvlxaTBnQt9f2HkCENkCmapHOgza1MsSpdBiyfsHIp
	 dkR0sMCmrOYFs6ndXHHTJE89DkQ9qm58ltaCg+NMObjb8v+M862ORsGSPy02Oj2gnm
	 0V6E/kx67BQzg==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 6/6] ata: libata: Print features also for ATAPI devices
Date: Mon, 12 Jan 2026 13:20:51 +0100
Message-ID: <20260112122044.143637-14-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112122044.143637-8-cassel@kernel.org>
References: <20260112122044.143637-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=cassel@kernel.org; h=from:subject; bh=W9YEwrG4qavkDWkmEQJrIMFG9ufUFlkILgTHOGRZ9Mg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJTnitdNE4xm54hy/O85lfn7p8LXGJfyFVGiP8/s07km EXUzONdHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIhXiG/75RT0K+cW3ODzvG 9iogdsvqb382rpjM/2+rYfyE29f3fMtgZNh37k5WYcz3+gXpX+UKJmQ2rNjD8Mw1c0bgj5St/zI W9DMAAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit d633b8a702ab ("libata: print feature list on device scan")
added a print of the features supported by the device for ATA_DEV_ATA and
ATA_DEV_ZAC devices, but not for ATA_DEV_ATAPI devices.

Fix this by printing the features also for ATAPI devices.

Before changes:
ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133

After changes:
ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133
ata1.00: Features: Dev-Attention HIPM DIPM

Fixes: d633b8a702ab ("libata: print feature list on device scan")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7656aea7663f..43072b1d9221 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3151,6 +3151,9 @@ int ata_dev_configure(struct ata_device *dev)
 				     dma_dir_string);
 
 		ata_dev_config_lpm(dev);
+
+		if (print_info)
+			ata_dev_print_features(dev);
 	}
 
 	/* determine max_sectors */
-- 
2.52.0

