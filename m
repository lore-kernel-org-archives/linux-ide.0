Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA4311C0C
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678114; cv=none; b=KYMtvnswKL1/SI4ESLQDOKQSSME9VM4vkjH9tGpiv3IY35GKftpz1kuW1M0n2fjOiVFZnJjCCINgtaKa26YUQ328nAZLnKg/YMdOK4FV9wTm4K0Yke55ttzeNj5AgbaSgJD4phKP0UxubiMxLgcTC5ryJIJZJWSy/47JIK0RITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678114; c=relaxed/simple;
	bh=rljK0o3LVNSrCiOwh/95t+pSRgIw9p8+scXodj7lYiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rk0B5tCO1jZ6VzetKmk1ZK+5r7W+U74JFlHK/1PdSIYbqJo2mlDhMMQHxNneUKxbb7eq49OM2mbE2Jr2fOj63kIc60DUq7YW6nCxylW65COfe8q2fG04RjXqzK5SqtlJrybiEo/yaGlKaAbBAZNo6FATkEV2Uh9bZE9c1+agogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYVniH7C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYVniH7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B915BC4CEF1;
	Tue,  2 Dec 2025 12:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764678113;
	bh=rljK0o3LVNSrCiOwh/95t+pSRgIw9p8+scXodj7lYiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYVniH7Cn+5Oq2/GG35vq7ChiH3uX88TVeiTH4CEQ0sPjQz81Cyh1d90/UdM8vtPf
	 iK6EQ/WuTyE23OmGMHyPy1BQfNfMEsEJHeGp9XLN2R16XCTt84HB8ZFb2M4FPPG/7S
	 qq91f6szv5ssc8Huj5v4fwrzU9VSHAZbJDwYgEf4ubGC2IhzEl44sjztzT2NZkfFXU
	 BzAzEHyK//TbqMyJvaOvSilAhBRO8YNab8Jxk21OPFKPBoBoMsPNsPhjCe6FrRm+LV
	 Xh1DIjnCyUG+VqsJqyHKnCTbzXJ9ejLH3jK7Q+B7fmNTFHH3QycIyBOKd7U4Phr/iN
	 ND4MyHZp6vFLg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 5/6] ata: libata: Add libata.force parameter max_sec
Date: Tue,  2 Dec 2025 13:21:35 +0100
Message-ID: <20251202122129.421783-13-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251202122129.421783-8-cassel@kernel.org>
References: <20251202122129.421783-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2071; i=cassel@kernel.org; h=from:subject; bh=rljK0o3LVNSrCiOwh/95t+pSRgIw9p8+scXodj7lYiY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL1bp7bNvttb/qkf1kN+1dYCK5b+Nx1R8gh1b/T058cW P/Q0E3mXkcpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAmMv04I8OyDcdnb79bwP6p 596S5KVXRdjy3d+v13ycJ63hclRqok4vI8Pk9Nu2z69YaHaafPPsZtXd05gcznbuwx7uFT0eIae KXjIDAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a new libata.force parameter called max_sec.

The parameter can take an arbitrary value using the format:
libata.force=max_sec=<number of 512B sectors>

e.g. libata.force=max_sec=8191
or
libata.force=max_sec=2048

This will allow the user to set an arbitrary maximum command size
(dev->max_sectors) using libata.force.

We cannot remove the existing libata.force parameters "max_sec_128" and
"max_sec_1024", as these are a part of the exising user facing API.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 drivers/ata/libata-core.c                       | 1 +
 2 files changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e5..e47113cbd2fcc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3294,6 +3294,11 @@
 			* [no]logdir: Enable or disable access to the general
 			  purpose log directory.
 
+			* max_sec=<sectors>: Set the transfer size limit, in
+			  number of 512-byte sectors, to the value specified in
+			  <sectors>. The value specified in <sectors> has to be
+			  a non-zero positive integer.
+
 			* max_sec_128: Set transfer size limit to 128 sectors.
 
 			* max_sec_1024: Set or clear transfer size limit to
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9a8da530e123a..2905aceba7038 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6536,6 +6536,7 @@ static const struct ata_force_param force_tbl[] __initconst = {
 
 	force_quirk_val(max_sec_128,	ATA_QUIRK_MAX_SEC,	128),
 	force_quirk_val(max_sec_1024,	ATA_QUIRK_MAX_SEC,	1024),
+	force_quirk_on(max_sec=,	ATA_QUIRK_MAX_SEC),
 	force_quirk_on(max_sec_lba48,	ATA_QUIRK_MAX_SEC_LBA48),
 
 	force_quirk_onoff(lpm,		ATA_QUIRK_NOLPM),
-- 
2.52.0

