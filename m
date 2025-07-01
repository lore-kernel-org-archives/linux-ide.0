Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D703596B
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374534; cv=none; b=QpcEMN0eZtq1QwJ/46zhzzAEg4S4G9O/LIlb7UCI+w/fFy5/tgPFMujUNE3LeaEjBcijaqReFcFWXUcH5h6TsKjik8kaT3yGrVQ649JBFPsAn+FnLm6Ml27Lha8asFnkb6n7uShDzvK2+/wwzhzhrBa7ptTee/JsnQBCaHFRt/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374534; c=relaxed/simple;
	bh=NBUcG98p3yoMVzKDHAc76NRaiVYgA8sShGd+eDbldlo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqQdSJBVMMjNlwfzwkgBvE3BhyM3bsemVZpzy+Xlzhv3QCoYyHuIaXrWR4mwVz4PhfpcMAXvATsa1/+TzStbW9t7xuGc8O3j+ps7gwhS3c73v16onz8eJua8l8UJDifV0Xwvi01+Z6wzUDRR/PDeS0LQy7RYpD6bl+njjfKsQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuEpNDY3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuEpNDY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0FFC4CEF1;
	Tue,  1 Jul 2025 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374534;
	bh=NBUcG98p3yoMVzKDHAc76NRaiVYgA8sShGd+eDbldlo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MuEpNDY3yRiBaF8giiV/QHkS7OEtvt/6Bh45Kv6T0SAYiTUZDXd5WLlS6oLTtIyPb
	 ewDkk3sQlBzUbPuWYZrc8wBizpFPG9H1hbdqL5hn+h8ZU9yhWnUgGuEH1cwMzBqewf
	 iF1TW63UEV79UsbRTB6zYVeBQljtmnS1D/kVf1iOjs9SptsTIbbsF7eO6VNxAbcfty
	 h7fr0YOV3iamFxqZRXJ/xQSI3Ehjyjgm+oKGYQ09d0UGox4lD0yjoO1+d52iV3jwhS
	 Y+h5LblF6ZgACaWNazP9Zsmgm7ITOmjmSPN8AvPh8OgA5hjHFeN3KiGDnfmtgrHywS
	 DHG4JpbduP09A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 03/10] ata: libata-core: Advertize device support for DIPM and HIPM features
Date: Tue,  1 Jul 2025 21:53:14 +0900
Message-ID: <20250701125321.69496-4-dlemoal@kernel.org>
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

Modify ata_dev_print_features() to advertize if a device supports the
Device Initiated Power Management (DIPM) and Host Initiated Power
Management (HIPM) features.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 33b2ffd05af7..4619e66ae100 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2846,11 +2846,13 @@ static void ata_dev_print_features(struct ata_device *dev)
 		return;
 
 	ata_dev_info(dev,
-		     "Features:%s%s%s%s%s%s%s%s\n",
+		     "Features:%s%s%s%s%s%s%s%s%s%s\n",
 		     dev->flags & ATA_DFLAG_FUA ? " FUA" : "",
 		     dev->flags & ATA_DFLAG_TRUSTED ? " Trust" : "",
 		     dev->flags & ATA_DFLAG_DA ? " Dev-Attention" : "",
 		     dev->flags & ATA_DFLAG_DEVSLP ? " Dev-Sleep" : "",
+		     ata_id_has_hipm(dev->id) ? " HIPM" : "",
+		     ata_id_has_dipm(dev->id) ? " DIPM" : "",
 		     dev->flags & ATA_DFLAG_NCQ_SEND_RECV ? " NCQ-sndrcv" : "",
 		     dev->flags & ATA_DFLAG_NCQ_PRIO ? " NCQ-prio" : "",
 		     dev->flags & ATA_DFLAG_CDL ? " CDL" : "",
-- 
2.50.0

