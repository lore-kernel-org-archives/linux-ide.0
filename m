Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050FDDC4
	for <linux-ide@vger.kernel.org>; Sun, 25 Feb 2024 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708854948; cv=none; b=AmBtysrCsqenSKkQz44QyHNxlTy/JL04dkxzu/k9a5DcGZWD0+FbQB+GO5cQQ3fPm2x7a3HrDoVsrEiscspDWW+dQuqiUcFlcwdJmDiBT0aqF2vc6dGE4swC5EOkeI0k93HJFeuhMpDjmnNKRNJFPt3UhVQm+jzift4xgA4va3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708854948; c=relaxed/simple;
	bh=/IEm83YBH1OLn7nUraTDQZ0BzsCDeR8FJrqojEfnPc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cenm8cYb+lFiSjgSbYAaB/xLK32yDu9el8jEPFx6CPGBbjxq2IjV1OVUn3o4s0P0DdCXVFO0fnxAMotZtQPeuR7vVaSghF14/IgXbCd5X7ziMyXS4pYmLWVZGhZJCAi+Rejl+tvBP8urOPzMh5fP8nHDTMAhXFwP4C/h7tpNCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGLWyVgm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGLWyVgm"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512b29f82d1so2736299e87.1
        for <linux-ide@vger.kernel.org>; Sun, 25 Feb 2024 01:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708854945; x=1709459745; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8UXxqJbXJNtS6VFVlNBbtcKdCu9CfgNI2RxHA9OT8M=;
        b=CGLWyVgmbkFyBfD3pgBz34C5UvohcGxlxTJLtYnn088qdblXtnVvDeg9bYoGQbAgT8
         mABh5NVBLE+f34ekTyZsMNYJKiGMTycQ+Iqgo4AkjZpv8g9QD6ZqHbBtvibeP/MYauoB
         F/WocDhxZ+ZpjmdoTRaXszQb9rEH1BUZ0QSwznGPQr4sI0rFF2Izc+gaS1vqFHTJHxpt
         eqjePAl208/dp1fRGP3BSmCKF+4b52dMs1F6dvMMDuj5VhzqHRtWOZBrPYuCwaYxpB5g
         +PD+tNC5rajSoVeeYr/uLDoOIcl1nndheR3RyFQAISlccOjDwuGJiya98DsWxTTNihRZ
         PAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708854945; x=1709459745;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8UXxqJbXJNtS6VFVlNBbtcKdCu9CfgNI2RxHA9OT8M=;
        b=o1xMkq98mULCZDCHYJTwe8jen90dkqt8Or7m/wfxJB+kYGO2IyVUi/EAe887/JH8yV
         7LyY4s/rlZBtaP2oeBQ42Tra2kg3+nfrFN0yDa5tnihX/8wTyTUfupoXIccJklWFDvj1
         YIX6wwouaSWBRNfc124Gkj4WDagOPOHjFSSWzRMeiUWaQUSkJL3SS5+1nC1kqdbQf4cJ
         vWHmtbImTKvthYtCrE9Pmlwrz/n40Rz7YK9v8Pnz5SZzuLQYej46EMk8RzkYnl1t8TD3
         oh+SxetjZumrmo7Jv2fmJHljmzNEdxPciq1bn0rMMdCcxAMWVLT6iiFxrFP7RQMiaIUU
         mUrg==
X-Forwarded-Encrypted: i=1; AJvYcCUMi7steEy47Jizly919C/hEj9JvpZJtYSDhg1zYibkf69hkkkE7KMUvgFZONMaLSyHc8/kScyqXjNkbTHCFCvuNoW+RtqS4+bx
X-Gm-Message-State: AOJu0YzqaiC3RCw0z8qFF2HJycaTq2Kyiu2xmtX4yAPJZ1l+ApCdSTVZ
	rvu5zNwyRP9/E4Z1kYjyBP32CiEFe770ydS5ztq5WFElfxnRTe8s
X-Google-Smtp-Source: AGHT+IHyklGkuuqLbh/J3oskwY93yVBrkaIXISevVIBwxgsHIlR6oojcYTPFiBx+3dzF+Ea+ZTcd7A==
X-Received: by 2002:a05:6512:282c:b0:512:a371:3b27 with SMTP id cf44-20020a056512282c00b00512a3713b27mr3400881lfb.13.1708854944319;
        Sun, 25 Feb 2024 01:55:44 -0800 (PST)
Received: from ppc.Dlink ([91.223.70.172])
        by smtp.gmail.com with ESMTPSA id m25-20020a05651202f900b00511740efdd1sm471996lfq.39.2024.02.25.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 01:55:43 -0800 (PST)
Date: Sun, 25 Feb 2024 12:55:42 +0300
From: "Andrey Jr. Melnikov" <temnota.am@gmail.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci: stop using saved_port_map for quircks
Message-ID: <bc76towgdmpv3xilmhlerrshpubrd7feecl2tu6xanwtbkv3ze@zwizzrmcu43w>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Stop using saved_port_map for masking port quirks, use force_port_map
instead.

Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 682ff550ccfb..066e3118801c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -675,18 +675,18 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 		switch (pdev->device) {
 		case 0x1166:
 			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
-			hpriv->saved_port_map = 0x3f;
+			hpriv->mask_port_map = 0x3f;
 			break;
 		case 0x1064:
 			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
-			hpriv->saved_port_map = 0xf;
+			hpriv->mask_port_map = 0xf;
 			break;
 		}
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
-		hpriv->saved_port_map = 1;
+		hpriv->mask_port_map = 1;
 	}
 
 	/*
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1a63200ea437..cc705d3bdc50 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -531,16 +531,10 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		cap &= ~HOST_CAP_SXS;
 	}
 
-	/* Override the HBA ports mapping if the platform needs it */
 	port_map = readl(mmio + HOST_PORTS_IMPL);
-	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
-		dev_info(dev, "forcing port_map 0x%lx -> 0x%x\n",
-			 port_map, hpriv->saved_port_map);
-		port_map = hpriv->saved_port_map;
-	} else {
-		hpriv->saved_port_map = port_map;
-	}
+	hpriv->saved_port_map = port_map;
 
+	/* Override the HBA ports mapping if the platform needs it */
 	if (hpriv->mask_port_map) {
 		dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",
 			port_map,
 
