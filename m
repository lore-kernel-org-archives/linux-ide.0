Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522A1FF7C8
	for <linux-ide@vger.kernel.org>; Sat, 30 May 2026 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101716; cv=none; b=hWkZNxB6Vv2C+bfCkzSnVosaywggxf0Wjq0wkEaPT7nne/xDyWUh2u2NortX9ccEiKvOaPkTW4b3cDpsYWuq59kShWzveU/qXuJhQeXH/HGOpEXetFrXkql1Ja6Hu+yzOYE6qOBO1Dtiyar0WCAVHasM2AlOL/t0ZGSvlXowJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101716; c=relaxed/simple;
	bh=jof8jAzXw0Rb5BCOmVEpdgEV9GpQ7Qgy8eSg3wcMZ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjuGNj1/DQGLheo6H59Il+8oDmLrFoq0Nhj33iXHTiO/sl6s8/mbgPzswWrfFPYCXDVbRJWwDCB8Wtv9GjmF/bSiVzoxpWETymDHEsKXVOPb9WWG9CLY+L5MGDJ9nvqSE0lVqAp2KcxCrn8wIRFmMgj+vWGhatAriCbRqdNwbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp0Wi/Q3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp0Wi/Q3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf114b0cf9so13188295ad.2
        for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 17:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780101713; x=1780706513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQZwpWi6lhEFzRyzbt9FIh0qakqtgNCNAKMGR2a1m7A=;
        b=Kp0Wi/Q3xOpbb86vf5rL7j14l8oXeWUDYNfB7p8eSFIANhpjyNwPR+egNTfK50B1FZ
         DnXx2Pp7goJF/ssYaDaN4xkzQQO+dlkQg2TFbwhEKEHEDn/1SSFtMozVL6qzQk+OW+CS
         QegcHmpv85cVpthKXPNpo2//Sa7aHLe1xtMdnoBJDbmJeUsZ47HsMhH2NOllpO9JGGpa
         Ir7jEbuR1Z+BQ5vHeCvNJ5nS0d/NM8F7ca6Rtgxs3BBEa6k2BLJJVg/ENQPc7wHEqaWO
         VM8mq87Qw2HL3GoWxzYbffg2v2nEqivW19hhwlAwp+fFZ9g4y+46P6tcF2dMOSYt/67k
         Sarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101713; x=1780706513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQZwpWi6lhEFzRyzbt9FIh0qakqtgNCNAKMGR2a1m7A=;
        b=MSZvm5MbZQnL8kwcuK4JnIgt0bZFqtSCmLE0v8o+vVMSJ6op5lT1+PxoMINeU3vvt+
         WVkvJ2e1quxoKh8lYSS4XCAIhatwfSx6sn3Ws22Yw1sQ/cwsFDtaje/0CaF2F6u1eRXo
         jb9nPR+ihOwwUCrKmeMDNIGW+pNbJQqvzwNITHfqAOTzGDouNid0owlt9aHBYuqEZLVn
         7W253dVZ+ZgP7rVnWTfN4bhAd347zk5cB6acs1vO5yh/mUA1aklhwFx25OBkQ0h7EhVX
         GkM5acmIguzIbLwrciAg21t+Dz8ZFRxzLV+b+s0MItF18AdjvZcPe/KCYF1+t7RyddPV
         7VLw==
X-Gm-Message-State: AOJu0Yx3UPKwblUP5TZWWUiI9H3Cvagly6UzD42KVYq/xcmKdz3ddJtB
	io0jb2uBbM42TO/bxTcTRoAP4rErmSzkyxPj5BYvtFlEAy9YFh3jPBK2uEFBWA==
X-Gm-Gg: Acq92OFulevbTM3zyby6sGzjae5Grq6Vc77biWOPY6fAT4lfc7h5qvF0bvS+DWNqF18
	imEHj2+ZsWBk8Bk+vW81+++6QSKNrXbBHQj7Vk8O8Fqx0pqXQCIEyWBjiPBxxTPphGiXweM/cE4
	A9QeRfl25TVQU4r4tfnAnCPtWXBb+Mk26qVWudXRcCPP1dviwoT+LZ6mRxWjhYId0E3dO4SII3R
	PTU6j8QEobvsKc+TzHEgHmocmarFJvYJXJ+/qzZAQIdf8D95Dcx0UABKo4bEVM5BTuvh6u6qsyv
	aqvM1nD9GjSO6syTgCp3u09C+M0qKOtDghIBWjHaW0m3c8ReKbSmK28katsjcenjMZK7qYMDe34
	1DbTfPb7alJc1216ow2wXgfa7nhYGCR6Ak2roy6+1/62EyWkcYpVXROGd382P0WJ+MxXtZcwG8o
	XLwDrZBj/Mo2RoWk4PXQuQn/VWj5QXmHTPutHD6TA3npdXYEmBsQGFZnWVEfw+UywvTvc8R+Qcy
	aR3gklhBHphfMihGMQ/TXjgg55PE6vAqv71ugn6OPE1+A==
X-Received: by 2002:a17:903:2f8d:b0:2bf:23cf:3eb with SMTP id d9443c01a7336-2bf3684befemr22359245ad.28.1780101713376;
        Fri, 29 May 2026 17:41:53 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1e095sm34158365ad.32.2026.05.29.17.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:41:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: ahci_tegra: remove devm_kcalloc()
Date: Fri, 29 May 2026 17:41:35 -0700
Message-ID: <20260530004135.43088-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine allocations into one by using a flexible array member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: Rebase
 drivers/ata/ahci_tegra.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 554f05e09f98..142ba2ae1c83 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -176,8 +176,9 @@ struct tegra_ahci_priv {
 	/* Needs special handling, cannot use ahci_platform */
 	struct clk		   *sata_clk;
 	struct tegra_pmc	   *pmc;
-	struct regulator_bulk_data *supplies;
 	const struct tegra_ahci_soc *soc;
+
+	struct regulator_bulk_data supplies[];
 };
 
 static void tegra_ahci_handle_quirks(struct ahci_host_priv *hpriv)
@@ -514,6 +515,7 @@ static const struct scsi_host_template ahci_platform_sht = {
 
 static int tegra_ahci_probe(struct platform_device *pdev)
 {
+	const struct tegra_ahci_soc *soc;
 	struct ahci_host_priv *hpriv;
 	struct tegra_ahci_priv *tegra;
 	struct resource *res;
@@ -523,14 +525,15 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
+	soc = of_device_get_match_data(&pdev->dev);
+	tegra = devm_kzalloc(&pdev->dev, struct_size(tegra, supplies, soc->num_supplies), GFP_KERNEL);
 	if (!tegra)
 		return -ENOMEM;
 
 	hpriv->plat_data = tegra;
 
 	tegra->pdev = pdev;
-	tegra->soc = of_device_get_match_data(&pdev->dev);
+	tegra->soc = soc;
 
 	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(tegra->sata_regs))
@@ -578,12 +581,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(tegra->pmc),
 				     "failed to get PMC\n");
 
-	tegra->supplies = devm_kcalloc(&pdev->dev,
-				       tegra->soc->num_supplies,
-				       sizeof(*tegra->supplies), GFP_KERNEL);
-	if (!tegra->supplies)
-		return -ENOMEM;
-
 	regulator_bulk_set_supply_names(tegra->supplies,
 					tegra->soc->supply_names,
 					tegra->soc->num_supplies);
-- 
2.54.0

