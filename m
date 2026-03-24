Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C67A26A08F
	for <linux-ide@vger.kernel.org>; Tue, 24 Mar 2026 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387012; cv=none; b=S2DUwSUBZav+u4dj8wPhHZgUnMrI9P1Alwsn5CeIaNALR38JnFe7q3ZHr6yM075hJWxpkwUU3PNoCO6ijuPzCdhAJHZ3lZ9NMRfFEtqfat+bythmk6xAJ+SyZqdWm+2OMdo3R7ZaleFXnHYYaSOlKUOICkLMe/mRlA7uxrkWczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387012; c=relaxed/simple;
	bh=FppXID+0J4nDRs3X3TyPmxeAe0SJrDM6eTzwu4T3obM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVeWl/h/7B/Km6eqznlMQpAWstu1Z5x+5HNVQp5rk6+ObBUR5QlnIwY4ajXcNWJHJ7mFBYV1HGcKiDzgUQ0YJ3drgrG01Xl18YwGzEYXY0IYewLa/UykpTvEoXjEVTBGZYj1qQcrxzXZQ3vI6b4UdTBU7xTffW8K1+dlTOEXsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkBQE7uJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkBQE7uJ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd8576a512so35794685a.0
        for <linux-ide@vger.kernel.org>; Tue, 24 Mar 2026 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774387010; x=1774991810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sm/4nEkrkeSiZOQFxxtUg+CAIgNYlGGhCoF4Utum28A=;
        b=FkBQE7uJ2pMeTYgZBvq0jjU0PHytkjtlHvnq8TbcrwCDNvsW6GZ9OBJJhYWkP8uJ6k
         iy0lyvXzd5n+oLOqkqn4ZmrHY3A4TXM6vAbOQguS25iiQR7yENL+oJrtOMo209CwrieK
         5viuE6J/TW+8nE3jOriw1UMHYHB77kBPZRJS8DKvoy7YFT8e757BkM7due+TxiRDEZYE
         2dHZjRrQZwIjrmu1EKDr7dQ7Xwea/BhEoME4r2NcKpO6nRsIKe9GMDjaSC4r423kPQ0C
         LwkQ9hpFetckb/y4TSzh/KzAXiMtfljQqK+QHMCTky1rESz6Zmu9Y4snYSv3J1os3ktP
         7qQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774387010; x=1774991810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm/4nEkrkeSiZOQFxxtUg+CAIgNYlGGhCoF4Utum28A=;
        b=hnwK2WbkjKM76HsSx7qfGLEl1j/lZIMOevwi9kDGZO9DDfTfvemuU8oFpySd/BpSZP
         gMidcL/3gkbxDU/ri95huuCZMMbW3fHbFgljCzP4vCMQoZONE75wybnroflnxpWroSNh
         DfkFpAlVRBI9LD1IBrk5eUVbHwptsvY/C206fD8TCKs/jyjV/LsPpTpgSLwc7/wqIQOz
         CQr70MSWnj80AYLsHMSPNk/nuYzJD8pkS5psSMFa+yFcJMOAQzC5+if6492Rb4nLhY/j
         w6VXy33xOrmCVBPY88wjQVcI8A0neNQ55SrOxNop++r/zMPgpWZBsegQ6ZgwHiFbwoeE
         OLyA==
X-Gm-Message-State: AOJu0YyYhIknT6fC5sSXfcBQFiHxeOeNMsk0GudVP5dKS81wPEdlfxP0
	kH5hmI9LCp1h0dUNAQfiN5rlCPR5tnq7BN3xtK6xKaj3nr6q0mHo40mbihctaQ==
X-Gm-Gg: ATEYQzxxJV4epq4hbBgb7xlnifyECmdkqepjoqiS8ngbc2UjDmGN2yZILoJo5lh7hmd
	wjBYLHSa95VkV2FtngP3IH/LkvcmKTdxzcqXZ0Jc4UEE1dy6eN2ApnzcM4sl1eFix5qg63C8CRP
	LO30aeev+M0JrIwWM1oR64FPosTEAPFMl2k4sG7qzwK8xXDo7THFsmtxQJN7Jb0o12ixNh11qpm
	WFs4HtyAGwFR4QmEsSIQXqWdoWuqQKxCbXkASe9AEDd3fjz75EPgNaxlYCeAvy/CeiSDDuCaEyy
	Yz2XjQQaplWxDJb+A7hoGhEHwCYhOOHP0rpHU02jwWGoQ5kik00R39FQf79bIwHoUkDU/VFaksA
	uY0IIANVp4zhqKE0gxZpcFGKopAi3He4lKRP5cPQubpW5SUoxpA9uixuTCnB4aLAylshGvshbbG
	ED0afAD4EZ0EbL/ysiqi1iKqGLt+oK5yupsD0skgfkNDOROF3tl62QIJs=
X-Received: by 2002:a05:620a:4149:b0:8cf:c4e1:9761 with SMTP id af79cd13be357-8d000561a93mr192888585a.20.1774387010169;
        Tue, 24 Mar 2026 14:16:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90bab92sm1117594685a.34.2026.03.24.14.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 14:16:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: ahci_tegra: remove kcalloc
Date: Tue, 24 Mar 2026 14:16:29 -0700
Message-ID: <20260324211629.26924-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
 drivers/ata/ahci_tegra.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 44584eed6374..5972fe04ff3f 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -175,8 +175,9 @@ struct tegra_ahci_priv {
 	struct reset_control	   *sata_cold_rst;
 	/* Needs special handling, cannot use ahci_platform */
 	struct clk		   *sata_clk;
-	struct regulator_bulk_data *supplies;
 	const struct tegra_ahci_soc *soc;
+
+	struct regulator_bulk_data supplies[];
 };
 
 static void tegra_ahci_handle_quirks(struct ahci_host_priv *hpriv)
@@ -512,6 +513,7 @@ static const struct scsi_host_template ahci_platform_sht = {
 
 static int tegra_ahci_probe(struct platform_device *pdev)
 {
+	const struct tegra_ahci_soc *soc;
 	struct ahci_host_priv *hpriv;
 	struct tegra_ahci_priv *tegra;
 	struct resource *res;
@@ -521,14 +523,15 @@ static int tegra_ahci_probe(struct platform_device *pdev)
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
@@ -571,12 +574,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->sata_clk);
 	}
 
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
2.53.0

