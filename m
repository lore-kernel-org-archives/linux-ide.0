Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9935E53F
	for <linux-ide@vger.kernel.org>; Fri,  9 Jan 2026 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969601; cv=none; b=s3fQViVddZLuJjAyeF0Lm3S+OxFtXW1mYDONMpbozOGEWmGMTb+NZl2DssR4yclRmOZC9KPJ9Q6ulyXWScMo3Tyooe6JLGKQA2kpVtHLAp5FmhksT/qV0/XO4/MAA0iIOKvUfN92LgCJYGodit3HJyXMEuTnKkB+yhF2EV8w5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969601; c=relaxed/simple;
	bh=W9YEwrG4qavkDWkmEQJrIMFG9ufUFlkILgTHOGRZ9Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/ohBmIJkd/49wpBLaLsF7rXqQW490EBQIPkgr1lcTVluEkzKuc6jRA9nUfQQYTtfExS95Ga8efuXdG96rUZueg/TqtDkVnkdlIcirApxBkEI+rUA4F3ZIQpJrbsI6RqBXtEK2zz8+MmueAqmvBmG7nLK9a7DQyxhuCHEn5G6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czPuYbve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czPuYbve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D09C4CEF1;
	Fri,  9 Jan 2026 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969601;
	bh=W9YEwrG4qavkDWkmEQJrIMFG9ufUFlkILgTHOGRZ9Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czPuYbveEsuR6l69kKUNpdy9WXl4u7WmjgB9AM8NOG2tF0yJ1bVnzERTJV69TEi47
	 apv9LSTNaPwWiVEiQyImm3UWAUS8EpoD8WJPjiCpmzocYzWruTrpeYG5dgk35wHoza
	 DnaFWaq9Ogxgkq7cYBQGa4WYgnig/OUtjhIhT0TrAhEQhwhz+EtA5xMjhMOaIbxhdP
	 kaCMP4fv9w5UbwWus94GAE4goaiuG95YmIymepSnc7My2YIOwpwSLbWiaNgRhvWNRa
	 vmA+MtY4X0f+86LjnjK/crGDTFS26xIZ9fxFt+4lwzEPPJP8yUHg9botYTALykGG5h
	 ABw3Z6jlSLPIQ==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/5] ata: libata: Print features also for ATAPI devices
Date: Fri,  9 Jan 2026 15:39:53 +0100
Message-ID: <20260109143949.331105-10-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109143949.331105-7-cassel@kernel.org>
References: <20260109143949.331105-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=cassel@kernel.org; h=from:subject; bh=W9YEwrG4qavkDWkmEQJrIMFG9ufUFlkILgTHOGRZ9Mg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIThU0vGqeYTc+Q5Xle86tz988FLrEv5CojxP+fWSdyz CJq5vGujlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkegojw1KBxRPX9DVZnJ3U NJtn0yf5GbvWbnp4+N260NuCE1Inxexh+O/3a8LloO9HpU6nWixmXv4v81CloKXVvRNz2Fp6hA6 3pTACAA==
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

