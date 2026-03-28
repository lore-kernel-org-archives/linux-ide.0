Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4133E37D
	for <linux-ide@vger.kernel.org>; Sat, 28 Mar 2026 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725080; cv=none; b=iNwDYL+V85378MiuOkU34ewSuK7ezlIu/z/fnGUjyg+qZWqyakl0aKPx7p6b715cI0aknzM8S9RNdkveJebUMp2CuGL0zRrqpzic6kh3wSbd4oQ5Mv//5kjTyXmX42K5SCBh975USQ2CZ6+ViOWs4F6s3PED0oXurjuO0k7n73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725080; c=relaxed/simple;
	bh=n0HQlw14mlBy8VD4FMqmG3MO5wp4QGqgD7K1F5YngUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=etS3ziS7xZ/X+aFnscyLLM9hHxPBzCVjwWCD/bH7+0eEVZkHrgrgLKg54jfR1aQjz3mbhHe9kyZQ0cl+pdSC2SDZ3d5Ihie/gFXD6XPOa90Gh7gTFMoKKFs/ElP/2slaKtukevEbdeCL/XhHQ05R0x3gGJ+ZVbd9djnQ2Mxh8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYDr6hm9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYDr6hm9"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82418b0178cso1606442b3a.1
        for <linux-ide@vger.kernel.org>; Sat, 28 Mar 2026 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725078; x=1775329878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKR1Fjg9EIN1soZ4AQdVbiBT3aVB1LqBRdnYJ6CyzyM=;
        b=aYDr6hm94XSdtRfAJ20EEnJopJox+LYqx1jpSc14wpHVeQe66/UhMuB+QkMEv9pYst
         gK17UU0o9WSzflSPwZtpw6XYNmHij3BviflHqmEU4PhE0oTTlqlPSF4OFWWxHkdkhpbL
         94PF+DWF8XvI12YuSjKd0usIkrHlfaBQZ6DClmJxmF8S2cwkmvmQdI29R9P7mt2FtMGV
         N3aOmv1JHbKUqix3VAh4m2FS/cuzXnGF45GmVZ+DPqYteTdRFyh7pqKx4dSDt4+77k2W
         Pddnn9q+wL10rUPEXGAodx+WHZG+NnnN4USPPf5kGZVhpw3jeU+99JHlXXNc0CYjSbcw
         HcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725078; x=1775329878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKR1Fjg9EIN1soZ4AQdVbiBT3aVB1LqBRdnYJ6CyzyM=;
        b=E1IEIXW8rWy7A1cAvi8KnTi81WFl4oc7o9Z/YuBJGpIOj9RXvJwuB0tNl+Iwa2supC
         jMJj6S8vOd+admn4ha6gq5UJHaIkfor+ZPvjd7JLcdtfRE8eG0HcPKZt5obWMQa2N0tv
         3U+gfhFgJ1lKXiNJG2OmfEFIu0B+aMYTMnmxtNQi5FKry8p7VQWIQPbKy0Iq9i37wunM
         /OFCXkhSp2/KjyZ8dvUzakDFfvkuwBB6b79sE2NWeeFkjEphYs6A57VwQXHOHDGYMcKB
         xDUuIj2VS04aoVE2fRtfcnAnTCrtO95RpeAPHYgIN/DjVnCEKvkZny6slitIOKhIpBfR
         G2hw==
X-Gm-Message-State: AOJu0Yz1IHQoH2n0UYO5pLV3JlbLTO67TnoqMKDbUXrjEcKTkletGb6E
	AljW8ubtzvGYWMqmfRSfKVAfbKHJS76vgjOahrttwKn6JaJUreyq2xprhSmN3g==
X-Gm-Gg: ATEYQzyuf+UaAUlUesHL5PVAoTmqnKhUjhLlVc/x0KLwoZG1aq9OSm4zrz70P058vZu
	Zz78dcUACJ8ZVQt3clgPELhQHjMTZpfGuaEif6qzQIo3fDwPXs6kckm/p8+9Yy/b6tnpvFmJy3j
	Uzm5aHstW0EmkL6f+SDnIXIOOY/6CmnpnS6G2FCW26uwPTlqrNHNArXOMQ4lBzkiHZMXnlAeHNB
	ZZf5uFim8CP7+RqX90izo1RH7jB+MvWiAp6bZgy2IQxWvPxssxnc/mArMYjJoV7/DvdypXaB78K
	j4vaoakb4spWA4glLS4Zo6R6w62P86e49bLGCsIiM9Iw+63gI7R84IZdqw4qyCfuQNr0idp1Fv+
	9ItUrw6bc9dVcMTmrYq/xxTuHRta2qS3ienOORjAblvQhwSepjAb3pAM5oYxXdg/xEehRrGrPRo
	a6OKKc9qflAxm4nqyxSFN+QqF5l96GTnS3Qj0li6nv0F1oCHk0s01fDH8=
X-Received: by 2002:a05:6a00:3697:b0:82a:18a2:91b9 with SMTP id d2e1a72fcca58-82c9602633fmr6665277b3a.49.1774725078111;
        Sat, 28 Mar 2026 12:11:18 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf97abfesm1497851b3a.1.2026.03.28.12.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 12:11:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] ata: libahci_platform: use flex array for platform PHYs
Date: Sat, 28 Mar 2026 12:10:58 -0700
Message-ID: <20260328191058.311509-1-rosenp@gmail.com>
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
 v2: update commit title
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

