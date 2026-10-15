Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA44BD793;
	Thu, 15 Oct 2026 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057288; cv=none; b=QbWwjy7wdvy7USLVoyrAIvSNs0J+h0gRdGmc2va8llAU5GfE3KDMukN0VAYV8P/b/v+vVSbwqW8jZwMXi8EYSrXHAUg/mI9I7CtjsoxtbUeNRstV/8p3IdzsY7BR8ueP4UhgN92qiN4Rn6X9I39AR+E05DViaRSWv1S/eMV/ma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057288; c=relaxed/simple;
	bh=AHVl16u8Nmdgft6Es1YFSMWvOsZQdSb+e5AgPfjuwZU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RU3dIdII0tGzvyeRfsfmfqWGc1dVOiHA5IvBS//NiuXuK1umxlBxcKLpfS1PxGXmYT5ulRwyTO0TS9gIUroEq/Rsc+al8sBx9z1M/fKHW/N0D554gJfwkr9PFiv8FkE5GMxbjsTGjvynBqZCONv0E/RlxkeLxnVDZGC/7n+I5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Ub6BrGCN; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Ub6BrGCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792057268;
	bh=SC3j68DrnSO63s+MLypJJhw4RoLoRMm+AlT5J83nuJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ub6BrGCNHswqTPk7eHtdnLZRt1Vs9+zcIA408gYwww26NnWJ01H1f7GF+SIlrENKc
	 8XmaOOFBRw2uZoPHcYwbbIgNkO/cx/YuniE//fZL5lZiBg/FDwgRACOcPW2nEtm13o
	 +WS/o836EVnBdOzIVSkEvOds2OpxccF21xV9RS1k=
Received: from RE0700.barrietech.com ([115.196.186.15])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id A4531A6A; Thu, 15 Oct 2026 17:41:05 +0800
X-QQ-mid: xmsmtpt1792057265tvqse3pr3
Message-ID: <tencent_26064A115A53E4C6D00433C89E1894E2D808@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+/TTNrQSMJgidabGoEo0pmyAI1nt5nCE6kwg+CaNmVyaN0VIl4m
	 gEbI3oEBSHKvzTbDtqh5nze9lVRatpu+DXCRa0jGisWURhqKNSBD6agcW1036NZYww/6EB8f2gbC
	 SmX4WLdmfsWFezpG/r5nmsCwQsv+ymLGNK2+JUVoEn8hHhfO/zctUZDP5ctVifn0QY/JYZoFX3pb
	 orPOPePPFCP+P340b7SJzMQYpT5lL5kCwr+pYh/qwBmVsFxRfkK41WssFSZsge2HY04kc+eFSJHw
	 5PeocAykk+FTnEs6H0SKnYiAhM7Yjq1lNF6vWZGRA/68Y+ynOYuZ/GIFNnJsdz9VS7RNopIRPUuo
	 aBpxml+7J/PBhi3uRwik8jIr6VAcaGePOOAEZ87SEK90VizppcK49LOLkjHNu2x7RUZ+7Ey2XaLj
	 1CURSOfxnyyBFmWHLSN3qoFDdx/Gu1YbwU6wni0jLlGSCmywFSglNKoINodgzeKnJnCqiyBdHDJa
	 c1c2uiwjPDh3t3C0DlTJgtu+cNmFVpPQba6ScgnOnubeW3f+6yfM5IFvQVnoq8E6vK77Km849Glx
	 /pE8ocpuQ8WGg0g25Ltzyg5cloPxgI6q+u7kUwUK/LOobWjwtGs09QOzENvqqv7P1ClPj5d+cRm0
	 juARh9a0dDgDkmLKOmSr/ralYzhBlaodmRp/8zPeaNkz4tuPurqCgdYqKioLUlvCsgEtf1wsshQP
	 qlBuX98vB3Pd0aA5y6zEU5sDRNzDDw8BHDC2OUbxhWWAil+ah2t260ju3brCLXFP9jRq/wsd8L03
	 9CUp+fmbNDvVWdq1rwULwg7eH94lIkJYgzJ9tvNeoWOe9lSuYlBAJsI8jBh5FcN5cW1KoOSacKkW
	 4R7AhqPGSxyXwAFWPIJrQ2rT8/eDPrvyUBnChkHaMqhegIA4TPeyZZBOOQXGiCUElYrwM30Cqv5f
	 GWJGoCUsSw/gmq5BvLE66kdKT5nRCnZFZYXQqIx7eLfZkKOYrkL2XuNiJ7cJCi1OS/NF9Pr35gn7
	 uiHSOxjOFKRdSEc+0FWv7shrGMQneFoR4uqRZXjI/CXcGEfLTyTZwUuT5cNFzA7KiBBxFK0w==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: zhoumin <teczm@foxmail.com>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	teczm@foxmail.com
Subject: [PATCH v2] ata: ahci: preserve preset port masks
Date: Thu, 15 Oct 2026 17:41:02 +0800
X-OQ-MSGID: <20261015094102.312117-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atCHxGZDY4heAXwE@ryzen>
References: <atCHxGZDY4heAXwE@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ahci_get_port_mask() returns zero for absent or unmatched parameters,
overwriting the mask set by the Marvell PATA quirk.

Update the mask in place only when parsing a global value or a matching
device entry. Leave the mask unchanged on parsing errors.

Fixes: 70c1595c181c ("ata: ahci: Allow ignoring the external/hotplug capability of ports")
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: zhoumin <teczm@foxmail.com>
---
Changes in v2:
- Leave the mask unchanged on parsing errors, as suggested by Niklas.

 drivers/ata/ahci.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9b8c0935001c..fdce365969b4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1642,34 +1642,27 @@ MODULE_PARM_DESC(mask_port_ext,
 		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
 		 "form \"domain:bus:dev.func\"");
 
-static u32 ahci_port_mask(struct device *dev, char *mask_s)
+static void ahci_port_mask(struct device *dev, char *mask_s, u32 *mask)
 {
-	unsigned int mask;
-
-	if (kstrtouint(mask_s, 0, &mask)) {
+	if (kstrtou32(mask_s, 0, mask))
 		dev_err(dev, "Invalid port map mask\n");
-		return 0;
-	}
-
-	return mask;
 }
 
-static u32 ahci_get_port_mask(struct device *dev, char *mask_p)
+static void ahci_get_port_mask(struct device *dev, char *mask_p, u32 *mask)
 {
 	char *param, *end, *str, *mask_s;
 	char *name;
-	u32 mask = 0;
 
 	if (!mask_p || !strlen(mask_p))
-		return 0;
+		return;
 
 	str = kstrdup(mask_p, GFP_KERNEL);
 	if (!str)
-		return 0;
+		return;
 
 	/* Handle single mask case */
 	if (!strchr(str, '=')) {
-		mask = ahci_port_mask(dev, str);
+		ahci_port_mask(dev, str, mask);
 		goto free;
 	}
 
@@ -1704,13 +1697,11 @@ static u32 ahci_get_port_mask(struct device *dev, char *mask_p)
 			param++;
 		}
 
-		mask = ahci_port_mask(dev, mask_s);
+		ahci_port_mask(dev, mask_s, mask);
 	}
 
 free:
 	kfree(str);
-
-	return mask;
 }
 
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
@@ -1736,10 +1727,10 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 	}
 
 	/* Handle port map masks passed as module parameter. */
-	hpriv->mask_port_map =
-		ahci_get_port_mask(&pdev->dev, ahci_mask_port_map);
-	hpriv->mask_port_ext =
-		ahci_get_port_mask(&pdev->dev, ahci_mask_port_ext);
+	ahci_get_port_mask(&pdev->dev, ahci_mask_port_map,
+			   &hpriv->mask_port_map);
+	ahci_get_port_mask(&pdev->dev, ahci_mask_port_ext,
+			   &hpriv->mask_port_ext);
 
 	ahci_save_initial_config(&pdev->dev, hpriv);
 }
-- 
2.53.0

