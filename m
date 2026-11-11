Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364784;
	b=5n0nSbVPZ0+QfxkXyV5Sw9G0L0gug1gO21aC1h6n/3emUZt9j9KgbDp2pqNhceMhNjmR
	 siDnCXv3fid9F4PdkRC4FaTZmnKYQBAZy5FzqNg0t3bQMuZaCGGepwwOFGGWJGEGJoayi
	 mobLxRKklPVeARsHZKZyfeRLqG5l2Baj2J/0x19HQ/3W/hbe4rHwRytAelZPH1TbZ34TV
	 wOc7nICFdqJWNfkTnXP6lpxC1AXOlAOOCsYSXsuFBVU3Sj8mFVFCFFptrL1PNGKTsDDDE
	 /ZLSZwJ/6gqCForMbqq28YeaQnq+Hi0fLnff7EPwdTFkKqYQsDQWwahyP0bzZVOQnLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yWgatv2qYfrMiUj+V1Eg5nb2TyQSEHAlAGM5NfT6vts=;
	b=y9YmBMfi5cz8mDrPQl/sTx9JVe58EJQ/yQdIZYYhFjNMckfew7nMYLqL9YPFvRP/jCIS
	 ZXagW+glKHzwRQMPr+o4X38JsqdKJP1xO7AV+h+cm4EOHEizPjaBDwF+wORt5SOoRhmTD
	 sj9eF4UqDL8XZ2eVKpoZZ+E6yEJjMbmR8j3y7Fi1zZlGIZgfRrlBP5XaxMyajfd/iD1ap
	 H9ffgkmeFkZM3JvCZWJb6/4ZFraWQtVi3CoQcnDn6Amm51jHkc88amu1ed1wAEKbQPMK/
	 bWyyN81XeUwbU+yiaS+WRmMMO0DtPv3MrMzrYrYsk+wO/8wCxcn/kX9E11qKpo+EjRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Hqcs/u2r";
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F5606A320
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 02:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE5F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hqcs/u2r
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so1580739b3a.0
        for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 18:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794364783; x=1794969583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yWgatv2qYfrMiUj+V1Eg5nb2TyQSEHAlAGM5NfT6vts=;
        b=Hqcs/u2ra8lREdfSNyYvzfvusNIjK8yDCTNavHbuglAZMtxeAqPdHp41OpaHKumytM
         M0KodzULDGxmfa9IGX2fa/FIa5AE11/kxw5WARdSM3UARuoV6IWAUMY0bb/MI8V9nufJ
         mc0yt9tm8Vk8RUcJemGFiA9ucqcdIjvVSwvjn4dmP4YB14kJyIi9FUK3V700VI5lcN17
         2p226IILmpoUFnJl9jYOs75bXKgVA3ODQFQwF96zDGyjyJfbo8QjZ3An9Fw2hDgnIEip
         lCQByrwBrW45791C6Ts/4MEMtXOKLtZRovWFyvfMkT5vTe8A2sl401QZXJ7leMneeEFJ
         bQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794364783; x=1794969583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yWgatv2qYfrMiUj+V1Eg5nb2TyQSEHAlAGM5NfT6vts=;
        b=lWwX9xHPOCkogaDS505u2JklNdIHPebZ5EvjvQELLdgixNFghkSQIGzofsTItJhLDW
         3Kq3UIaDMwVaXbf7VM9dZ+BdC99qHzwWcpDdA8d9BRzfPTg8ahufjSqPqOWtmGWCoZVs
         ZatgQlFyvtvPNO5haSBLAESPiOx4babNrTX3tZhWrHzfddkqzI+3+qheMUQBX1KCLi/c
         B3LwrS9SYRV6gFUwVBl8l4yKiM665IJ/MjXuwZltCWMSJw6iSsBi+Ka7l7si1j/o7XwS
         enUshXW2sOrSeF+gEKDvCYt7JRXPBNqhUY74s8ywDl2K7U6zThW3JYMPi7OqSAISlygc
         4cVQ==
X-Gm-Message-State: APuU4Z+FFFDQGZeAxizU+867B6lLoSwbvkbR2QvO6s3CB122UWB3wfpI
	sBpzUg5q2mi68Neav3P85E3sDhFyHKsS3bgi1o/ruVx8rj+iSN7+wnAEjSlVeIVH
X-Gm-Gg: AYBFou1ia6Z9+lmwaU7x0sAGbVHbEXfWxMOcVowcm3H2bGOsX6qKI5YKwUJQmKPAk/I
	sLRxkLm9dat8rUdR3B6UbJn6zcXNSi08xM33/cC/8rGNbCS747cGlFReO6RpOq8JGcVdhU/B5J4
	MEvv2WkadzIzftnHEAotCPqbEd94qebcBMzpGnqjY4RyFMCmO66sAzfYhXTs+WDJCAb/jNLjI10
	cMXCIfNeWVSSB7TrdtjR80uqg0PnTARBlHA7S0gp8qsIcJ9w3t8078uwsouRabxE8oWv+Ii6ide
	ebHqXvu1P+OsAFQ4sAAn6Dz+qy2OVyhdhbWAQZvLaq2kq9taPDiJ1qQKpLw4vf36dmgHt0/RY3P
	AnePpnJ3QqbsU3AbGGK2CZckH5ie/jAiM9VK4C80LTyDeLHiSNlFqQmXUYBlt+QU8oBQBgGC+qJ
	wyDUZQolx0B+nHKLMbdcJzkyeGSh2nyAM9prt/pCKGGy9ArYke67H9CJnJQrVpH3CBVLhXOwVR7
	wDhOl/DgoKd7HmdsblDCCoDP53vkP5527dwFmKKRsD6kRGzRFUtuQw/hzrAdd6tTCK1lqcVdmbi
	bGbYBSdgIbE72EjH3Z0sQn2sb/RNpTIFNv4QAPUCo6s8AtuU94ds0YfnbqWAkYk2nhnlF8zHRxv
	y0BAEu81dLDgkEoX5mW1J0EfzoqTlPOXNtC7it4d5vD9aWlZjHBS15w2DYX8vL98uOr+IZcAgQc
	zm90FOgGuihMtiJjAcFbQaYkY=
X-Received: by 2002:a05:6a00:4c15:b0:880:b709:cefb with SMTP id d2e1a72fcca58-8bc1d3324ecmr1077159b3a.45.1794364783094;
        Tue, 10 Nov 2026 18:39:43 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3a55sm1488097b3a.3.2026.11.10.18.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:39:42 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-ide@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3] ata: ahci_tegra: use devm_kzalloc_flex()
Date: Tue, 10 Nov 2026 18:39:39 -0800
Message-ID: <20261111023939.75386-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine allocations into one by using a flexible array member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: use devm_kzalloc_flex()
 v2: Rebase
 drivers/ata/ahci_tegra.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 2b9b98643128..c6ec344c2e6c 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -176,8 +176,9 @@ struct tegra_ahci_priv {
 	/* Needs special handling, cannot use ahci_platform */
 	struct clk		   *sata_clk;
 	struct tegra_pmc	   *pmc;
-	struct regulator_bulk_data *supplies;
 	const struct tegra_ahci_soc *soc;
+	/* this must be the last member */
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
 
-	tegra = devm_kzalloc_obj(&pdev->dev, *tegra);
+	soc = of_device_get_match_data(&pdev->dev);
+	tegra = devm_kzalloc_flex(&pdev->dev, *tegra, supplies, soc->num_supplies);
 	if (!tegra)
 		return -ENOMEM;
 
 	hpriv->plat_data = tegra;
 
 	tegra->pdev = pdev;
-	tegra->soc = of_device_get_match_data(&pdev->dev);
+	tegra->soc = soc;
 
 	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(tegra->sata_regs))
@@ -578,11 +581,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(tegra->pmc),
 				     "failed to get PMC\n");
 
-	tegra->supplies = devm_kzalloc_objs(&pdev->dev, *tegra->supplies,
-					    tegra->soc->num_supplies);
-	if (!tegra->supplies)
-		return -ENOMEM;
-
 	regulator_bulk_set_supply_names(tegra->supplies,
 					tegra->soc->supply_names,
 					tegra->soc->num_supplies);
-- 
2.56.0

