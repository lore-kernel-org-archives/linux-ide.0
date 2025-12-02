Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4030EF88
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678108; cv=none; b=GlxSV546ix6qcrdVc2GBdRLzMt3p7WsxM93aR402xhfHD/0L7dkyb00jYILGnua+OM+SDdG0gte5RBdVDFImCmZRo8ii+RUq4XJXgoXbQWTIi/KNZOW/OTm2Zn2STZNf44acuzKf1q8q0sLhAWG4qCGBYGin5eAN6gZm62WNrx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678108; c=relaxed/simple;
	bh=dRWvMCz2pxjusjOUZWHUxmhbxEQThAKFvLtWDwPtc+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxjrM9sZYBRgVpz2IywLU6Q7xFEAhX0rTreTykjQdv34a3iRwh8fma1649pk7IzkVqtZ9Xk+LUsukvY7NCQT/UzYAacVfzhddq4obVfnVMsRgpvOSCHfCp31MO5uAWOVCO5Dl48mQFvh6mN3lIidEZYZYzaxxbntV9ueAwQuMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpRqiJPH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpRqiJPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA5FC4CEF1;
	Tue,  2 Dec 2025 12:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764678105;
	bh=dRWvMCz2pxjusjOUZWHUxmhbxEQThAKFvLtWDwPtc+o=;
	h=From:To:Cc:Subject:Date:From;
	b=YpRqiJPHcwVSX1jHdrVSaY3Cy3OvwBmGwhp2qZJVSzJM2XeEAQriuINt3QKmbaZED
	 hHJ4nK46QPES55V73MCKZ7klTHtrfIAyF//jT9fTgs6fsnfK2qd7FQhylUGw2v0M/q
	 dbLvrjq0w2ppb4q20p2nYm7a+5JkRAMa9RxwYP/xlYXUv04rUbLTzUcygRptlHxKdI
	 LjrwBaN5Uo3qhefa67YCyxoKxAoYsGWUidxqJ0VOh1reFmwll/u6SddcIoRUs/kxQr
	 bIoui2BQdfMaI+hTjZwXhcCe3MPBBtQhEMZeeVEJ88hC5hIUi8wKtAqUjqofFhaXMP
	 MIuvszE55Rt7g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 0/6] ata: libata: Improve max sectors quirk handling
Date: Tue,  2 Dec 2025 13:21:30 +0100
Message-ID: <20251202122129.421783-8-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=cassel@kernel.org; h=from:subject; bh=dRWvMCz2pxjusjOUZWHUxmhbxEQThAKFvLtWDwPtc+o=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL1bp40SJx82bFeui3cyKss73cey791n75+TLa1Ojjhe vySCWITOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARg6uMDJ+uLWk78e9Fg+pf 53MX3iY38dnpXHxQpH3yxv4zYms9/rQx/PdnMot7d/2719WE2tgD6/llzuSufbjsifomcWHWHvv Zt9gA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

a recent change:
commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")

bumped the default max_sectors_kb from 1280 to 4096.

It seems like a lot for SATA controllers are buggy and don't really like
this, see:
https://bugzilla.kernel.org/show_bug.cgi?id=220693

Therefore, improve the max sectors quirk handling, to only have one max
sectors quirk, which also takes an additional value.

This reduces the number of ATA_QUIRK_MAX_SEC_XXX quirks from 3 to 1,
while also making it easier to quirk additional devices with different
max sector limits.


The series is based on libata for-next branch, and the intention is to
queue this series up for v7.0.


Changes since v3:
-Pick up tags from Damien.
-Fix minor review comments from Damien.


Niklas Cassel (6):
  ata: libata: Add ATA_QUIRK_MAX_SEC and convert all device quirks
  ata: libata: Add ata_force_get_fe_for_dev() helper
  ata: libata: Change libata.force to use the generic ATA_QUIRK_MAX_SEC
    quirk
  ata: libata: Add support to parse equal sign in libata.force
  ata: libata: Add libata.force parameter max_sec
  ata: libata: Allow more quirks

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/ata/libata-core.c                     | 205 +++++++++++++-----
 include/linux/ata.h                           |   3 -
 include/linux/libata.h                        |  70 +++---
 4 files changed, 191 insertions(+), 92 deletions(-)


base-commit: 2e983271363108b3813b38754eb96d9b1cb252bb
-- 
2.52.0

