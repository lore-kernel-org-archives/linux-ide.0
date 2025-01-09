Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D080192B85;
	Thu,  9 Jan 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445276; cv=none; b=B8uQZaJ33/SdsRq+2MwV1TXPuAuQTZZEa6xx8C6TP9Vhz0ilxvAkkHEFrMRK5XHa6rmkaeCL8KRPeSHa4QZy+/6FWfpLlY+TZ2+df0GZckNYE5nhnz8XemGDdSiuw3CzEq2z0GFcu1ZmgqBTVGlxczX9WxpurccGMkkCilhyqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445276; c=relaxed/simple;
	bh=2Un9gXMgwtuvUVTY38kPXNx4b2v2Co8gUYT+FxydgD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lM/DMAcl5EJHnBhLW8Tzo+nYDvOFkRte/xEgtFTRsf/OhpMzMMTaRpGhz7/gzvLxmnrLruBbLTovZBQViaO5n9AwOAJjQdfWRVckEzapJ9DcX9Fi+/J9dHfkPrFFg47J/u6YKiIllVw4TFBMHPMapGGd8uiYe9qKJxbVkhKhPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNQ/IdVg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNQ/IdVg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43626213fffso15084275e9.1;
        Thu, 09 Jan 2025 09:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736445273; x=1737050073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOk2x7xENmwEqdSaUTlpdBQVwEKSsAxgTnKrDsGxtIM=;
        b=YNQ/IdVg7d2xO7XGvQUj4QrSdpH7GV5iXyb4ezyaFT2d0l3NLhDxEOiabMDmTNQO0B
         +UPFBvUYw6ZqWdeeat7mlQ84aL8RiSew2GV0k/3Qx0Pxg1KyFbfwHYn2Z2cC8XXxMI1W
         wrUL5ssRl2cXFDzxg6/r7wgKONQd24jpRwXQ8IKjNUJ14Wsuc5QwmvH9YK9pflw3CWFG
         Zzt4fvPlwmS290eey/U0LTJp5GFECvXLXUsYtAgiHRXATQ6rXqkb/QqiUE8ehu6bCtHw
         oI6uKeuAhYOCoodB7xaegZ+JZV6AunYME5/Od5ygydxAtN5gQAkoqgB76xarfF2OUD2E
         ioTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736445273; x=1737050073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOk2x7xENmwEqdSaUTlpdBQVwEKSsAxgTnKrDsGxtIM=;
        b=KZBJD6q+3LSgR6XmwlTv/AVP6QMhR9lZCr44ylmNPtvzm5Etz1jr8aFGFyKAtIyvXo
         +2TDEUHKJF8nJJ8OkWF0TRAWuyLKSd22DQk4jmNldwpZbfHuvoN1uUySOJN/LPYj2p7n
         SAZs+GGPaYoZd2XMuvGvBrsbKCEgGnbiXWZgUJQvHyPEKQ45iuMffiklDpwNWf8Akz26
         UQxDxPjMjNWELEr3pyVlSKrgb7CZaR2iqj6t95uy33HuBBBtkZ68Lb/MM3H0ajYyBB3z
         4kwvYKwozJLICVArns4Mv+FHvlDik6MwDxnds76dzFLLxIGxNThKwtD34qPl97dRlSyc
         ouXw==
X-Forwarded-Encrypted: i=1; AJvYcCU3XULZiK+/9WkhVZP+qwhGNB13+UFyddWAxQclponn5QlfDiqL01LPL9FaXlsb/X9ce8lH8SaKoqg=@vger.kernel.org, AJvYcCUcxgPN/muly3zdCVTefcTujLjRp733W+UxYmcL4o4+U3eW74dQc1eQcjObBLvLm08PCDjEvU/qr6ywIi6X@vger.kernel.org
X-Gm-Message-State: AOJu0YyC/76Eq49BFgPGsXNDsIdTPGUO+7tiDVvYRcDRLOuuumuYkjz/
	oXZ/UMT0rlCLvXU54XL2a9d2jTOu1owUXf9uO4TKC7q6lLSrTknF
X-Gm-Gg: ASbGncuCIHS4FN1X8pL03eJxBo0tIz5OS/7tBEhkO016YY0kYVTdcndeoUSvaY/oTST
	KMHdaJ0QfYyamq9iBcPDk6xQ6WziM/Ct/TtQCisQGRK34J4lUBpOLlhuTbX88uw+l4ejva3Bfeh
	PrXxwgp4CtKYvmM3SNb3Zn5hx6wV36fvqmEySepuCa9GkkbFjwBqSLi2wVSsSXOJ8K1Jh8surMK
	ZkhYboEG+gxeC5xTrFaJeslKIchcxS8fvIlh3+2wNoFNgwvzKE1cKel
X-Google-Smtp-Source: AGHT+IHGie1IgFEsaAjE8vS5MyvybPqWWZA9f8slWVYYtG0WUXP2nwc2HIpa2oE3hX0LhSOeOIyEoA==
X-Received: by 2002:a7b:cd13:0:b0:436:51ff:25de with SMTP id 5b1f17b1804b1-436e8827fc8mr36979505e9.7.1736445273171;
        Thu, 09 Jan 2025 09:54:33 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da66fcsm62521375e9.6.2025.01.09.09.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:54:32 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ahci: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date: Thu,  9 Jan 2025 18:54:27 +0100
Message-ID: <20250109175427.64384-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v2:
  - Split serie in single patches
  - Remove irrelevant 'Link:' from commit log
  - Link to v1: https://lore.kernel.org/r/20241229-update_pm_macro-v1-4-c7d4c4856336@gmail.com
---
 drivers/ata/ahci_st.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 6b9b4a1dfa15..4336c8a6e208 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -176,7 +176,6 @@ static int st_ahci_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int st_ahci_suspend(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
@@ -221,9 +220,8 @@ static int st_ahci_resume(struct device *dev)
 
 	return ahci_platform_resume_host(dev);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(st_ahci_pm_ops, st_ahci_suspend, st_ahci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(st_ahci_pm_ops, st_ahci_suspend, st_ahci_resume);
 
 static const struct of_device_id st_ahci_match[] = {
 	{ .compatible = "st,ahci", },
@@ -234,7 +232,7 @@ MODULE_DEVICE_TABLE(of, st_ahci_match);
 static struct platform_driver st_ahci_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.pm = &st_ahci_pm_ops,
+		.pm = pm_sleep_ptr(&st_ahci_pm_ops),
 		.of_match_table = st_ahci_match,
 	},
 	.probe = st_ahci_probe,
-- 
2.47.1

