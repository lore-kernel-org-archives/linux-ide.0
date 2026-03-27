Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230DB25EFBB
	for <linux-ide@vger.kernel.org>; Fri, 27 Mar 2026 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579863; cv=none; b=LzONtyRjgafd0PJfeR+8T1fL94vVuYRz1MDCEQNGQRaSxLehgrJXRdGYRByNSJJcUFVZCZCOZmHIP7akAxF7YLhlyl1hRX2d21WHlEjydlYWLV0bDXgzWDq2TEOHTz/M92Gf/D9CGRX9ywK5Q2xGEyLyPSHY7gemfGt5WCm8HBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579863; c=relaxed/simple;
	bh=PhK1uiwCqLIJI3ueMcn4+tjHbQ8klTqD3ZDxXIovspU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Os9W7K3URYNdXO0G9ugMYW+st6ddCtjRN7Ld2N/QIWbzXrvr5KoISEjX7GBGhfoB/Y3lWtgomNs9+k2mWtJJhxGDk1jb5Cok9MeQ7T794ncKI4uP/IIGp6UGqvZQ3pEKZdJAuMpBwa8iwKUraTiBb2jO6CgOsC7iMTsBfKJlIV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7GaevoJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7GaevoJ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so1584475a91.3
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2026 19:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774579861; x=1775184661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SX5+VodhRV2hJI3/ddIJ/j9D3gWCV2wOSdzAThk9yJY=;
        b=I7GaevoJG7rZ1bxnX7qR8Kui4uSmkux6ryLsLZD6hq8B+GX0TnA0pc05IfFFHjs/q9
         zMd6m91ZmyrYv8ei9Erd3A4zT5ySD41DqlyBuwvA6LcojbUJUnXW7hdlQea3zDAPbW7W
         s00F1sNmOQNHHUkOTVI6+whocKZX4WgPs317Z12W5DR/0VBMkciNrBhIQmIRP3aIsr01
         GsCCbfOjk8WKn5egO3aF+zqV7wqo7i7yHhLEYV+Sn6xyjgaT/P6CZpHCxEQdD8X/ZBWI
         MUmXYlkuGO77gawLVV3ibONKFc9oebyhe5X6bwkbKeyIoibLVsI2s71g7MdvLeed24CE
         LcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774579861; x=1775184661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX5+VodhRV2hJI3/ddIJ/j9D3gWCV2wOSdzAThk9yJY=;
        b=MD2pJQey8Az3EnBJYh6Iju+7WBWbY/cf3lZLNJ33R6JBJ4H18WXoub7J+kijtwyEB8
         e1GziHlCELpQOZNBrMw+FbqGM8Imlg446G7M8al2L5MOXUJgbc3jwWr2xkuwqBvmEkmZ
         pBnHbnBlW+PPAFX+OTDH+6GHtoU41sLCvRrmKVvnLkYhe6B8rRUm8tGaqV917jWL0ZFv
         9zFGFdiNPI3651JybOqojL2gn/HTpGIQAOncfd9ap0xOl05hYh+xHDpn6Gm8HJo/t/sX
         hYFSRz/KBFAJap2PvY7WtVTTfMOY/oTenDl6Qwdgpxmjr/Dlj8nc/htCKpv1K+PXGReA
         BOBA==
X-Gm-Message-State: AOJu0YwZUyWyew7yWIS/fb/xROSErUATv2zWW+g/YS91LitU4Uuj9nKu
	lfl1lGEOlpgiqV7GI3TQpEEEEYcsKKSJ6hzYqwusIh2G/TO4kWwaih18RlJdYe21
X-Gm-Gg: ATEYQzwGjdl3xrRU2cBXYX7jZaFrBHpun9hVbpw8K8zNAdufKVar8/M3kfznXTGwP8T
	DIuxr8U8kLVyhQsnJnJgVDqhikkkgKfnCijI+Lffa8aZc02puDyAmHu45JWJ7UaYFuUJToKMaSI
	ZE5HcMIiUALpXMVyVp6rYotjr5fdzTbnxUmFYCQv2aH5tEqT2DZAlpMhB2kugz+ptz6pUm2x3rt
	SAT07YoJzfzB+iF3YmWnEfNuKPYo4cP8k2nzPcLBkEV5Qr9ZwIv4UK3L5dSQJNTJlPaNoC/KUrY
	PnZgl5TnP8KYyvvYpC+vN+xOwtP+Yl2XmCrxe8QSbU++4HnhwuzY2arJoaICnvbW0SZE6Bo0rsg
	42XX3DCUUwoVKyAuGZvfT2qdj2Q9HGfZ5Ro2Aam28UCfa1FiYK5BpZ2KlvyAiqbkd5k8iQwXTuo
	H92kn28PMPepC/b5/ypehqoAfysst02HodXn7vKX7QNxtjdQ7okqREPas=
X-Received: by 2002:a17:903:28f:b0:2b0:67a7:5c4b with SMTP id d9443c01a7336-2b0cdcb0791mr9021885ad.28.1774579861001;
        Thu, 26 Mar 2026 19:51:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8c6895sm54574445ad.64.2026.03.26.19.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:51:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] ata: libahci_platform: remove kcalloc
Date: Thu, 26 Mar 2026 19:50:43 -0700
Message-ID: <20260327025043.7565-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member with struct_size to combine the allocations.

Added __counted_by support for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/ahci.h             |  3 ++-
 drivers/ata/libahci_platform.c | 33 +++++++++++++++------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 293b7fb216b5..9e8b6319025c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -357,7 +357,6 @@ struct ahci_host_priv {
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
 	 */
-	struct phy		**phys;
 	unsigned		nports;		/* Number of ports */
 	void			*plat_data;	/* Other platform data */
 	unsigned int		irq;		/* interrupt line */
@@ -379,6 +378,8 @@ struct ahci_host_priv {
 	/* only required for per-port MSI(-X) support */
 	int			(*get_irq_vector)(struct ata_host *host,
 						  int port);
+
+	struct phy		*phys[] __counted_by(nports);
 };
 
 /*
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index f37247e7a5cb..6e072d681341 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -482,15 +482,29 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	struct ahci_host_priv *hpriv;
 	u32 mask_port_map = 0;
 	u32 max_port;
+	int nports;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
 		return ERR_PTR(-ENOMEM);
 
-	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
+	/* find maximum port id for allocating structures */
+	max_port = ahci_platform_find_max_port_id(dev);
+	/*
+	 * Set nports according to maximum port id. Clamp at
+	 * AHCI_MAX_PORTS, warning message for invalid port id
+	 * is generated later.
+	 * When DT has no sub-nodes max_port is 0, nports is 1,
+	 * in order to be able to use the
+	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
+	 */
+	nports = min(AHCI_MAX_PORTS, max_port + 1);
+	hpriv = devres_alloc(ahci_platform_put_resources, struct_size(hpriv, phys, nports),
 			     GFP_KERNEL);
 	if (!hpriv)
 		goto err_out;
 
+	hpriv->nports = nports;
+
 	devres_add(dev, hpriv);
 
 	/*
@@ -573,23 +587,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		goto err_out;
 	}
 
-	/* find maximum port id for allocating structures */
-	max_port = ahci_platform_find_max_port_id(dev);
-	/*
-	 * Set nports according to maximum port id. Clamp at
-	 * AHCI_MAX_PORTS, warning message for invalid port id
-	 * is generated later.
-	 * When DT has no sub-nodes max_port is 0, nports is 1,
-	 * in order to be able to use the
-	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
-	 */
-	hpriv->nports = min(AHCI_MAX_PORTS, max_port + 1);
-
-	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
-	if (!hpriv->phys) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
 	/*
 	 * We cannot use devm_ here, since ahci_platform_put_resources() uses
 	 * target_pwrs after devm_ have freed memory
-- 
2.53.0

