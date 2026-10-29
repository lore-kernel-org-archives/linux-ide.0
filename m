Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309137;
	b=J4K4RQorSu/wet86WGUoFge4q6I3tL6NIYczoNmGONgeqfvjUk6AoL0/XubLLd5uCyKi
	 vUUNEr4nSG3ZfAgQE4r1rYmpHqPzAG5/JOiKH4rTztRnkHp5lJLG6cW3OBtFsbeprzvw+
	 ceuLk01cdE53tZY63GWsYl4cJZAQxLecZc1tnQb+HLRZzVDAjU+4yrY0kjGeqbJsPBmVa
	 g1/M2k6p7WzpdfsgtRSnnqBkskzALyyqkdaMUy8FRacPNknCzegvnnMtguZenmS0goB0k
	 S/Mr0eN6zNSYmU0qit5xNZ1CrGXpClwoGJvGlCyT6zdpR/RdemDMXdmpJThljnNrB3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309137;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=eG9L8JoEnV2/AJh4IZs2XwE9uOcVbAGkOowIPsI/5ZY=;
	b=nulwpoMfi1TMlfgtmxGOkKzJxz3+H8oW3406HKnqJiJdx8Lgc62Dzkk6vzQCW6cZULQg
	 SCKk0tYDkvUjP2TcgGv97GY58Q2e1mx5y+e5WZlc2jZZjRWD6wNfSi9zBwlrQ4u87S967
	 YiKmtlWxsbs9yINN52AO3ZXLpjxQhteBbJfxcnirf+Oi80BcR9Gc8XHrcGQIjuy0Tv5cF
	 2fqu6KbOyz7wrmYWZM2M046Ve2Hd8nWjI92+2+jaNN9DEEiZNKeVZ65f4+mhuAjkWCCrf
	 AuJ7NCV1TjsJE3zLxmrwtGJDlxNlSkDxk67qM9QE58mG96zyNEJt5YXUcLTDgGFeTGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LqgpgvPg;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB532606A321
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 21:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB532606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LqgpgvPg
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93e4c00d71aso232008285a.3
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309136; x=1793913936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eG9L8JoEnV2/AJh4IZs2XwE9uOcVbAGkOowIPsI/5ZY=;
        b=pOUR8HFxN/fWoLZdmJhnIfKRrbk6pKEnNsKwkoKMQntZRrHgW4Um8c/KZjAhYeGXMe
         i6idoIUYpicjUkrx7WhhhxZXwDRjN2ioRZ3bIVWUAqh+pb5ddFOOODtcxK0cXMnJ8HFM
         39C6LRXaTHMLS/R3JHlsnpnEqAJflxLmJYfipjl0eaogvwABkw4SAFzf6T9YVR+UQ2vC
         A6Aq6UBU5/pyDdi5IED67Ufh4yPonjql0UuhcA1gQaFPJVO0OU3aRPFeJbdLLutekLYv
         vR5kU0eFhsyeoAZXA7M4QrkL5iNYEMiGACgiudf1NsUpuhF+5U6qMdlzrJdJI7B0S6Nm
         c2Lg==
X-Forwarded-Encrypted: i=1; AKwUvBxd0W/Ijx5Egt5RZ+/xchrkJNp9VL2MHVqMdqXCmUge4aZrwRUaRKtyFaVdsEQofXsywBYQPTITPU4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIidkWAj0QuHtu2P81HoP+rfSqdVO12SW9SkFh19kxpB+zxhPco
	30HVDZKp6j+hJ31IhEQ9mlqTgGxH9hYClc4ZsWyPPYtuvG82sfITqMUyxNL/9lEL3vzTj2wOwoS
	RWlvZx63sf1WhZJ1hqQyAU5RPC5qL2ihxwtLGsjY12q85EzGa8ewqL8V6dU/vJ9pr+D4Sic1OQb
	h+5XBGku4Y4Agvzaxi2pJbrcs8A4erimpep39CwI/Z8sVlJFRuhw4km3rIWE8SmaETzDtu0c62W
	0H+XROZCwiYKc0SgYGnEJ0=
X-Gm-Gg: AYBFou39rswU5zrsn7bNWl5Wd55BYUo6WCBwMTw/DIeEmcoeyTDmrPhIKQryGGHbnqX
	WOGgaTFo0ufLJZOpBPqeWXvTXqjvLWIUxfbFKtlXzZmQtnm60NM8+A9/zPlwuOzcobfP8uou22B
	FDwKx1PeQCHZDg14lTZ4UP/SfhAcmXl7p6i01htUYtVb7G4o7plJLp+WLLKMRxs2nK8IfkvlDqW
	4ov82uS7b9lwdRRTgCX+Nkr3k7E+qPoyeqhOmr8ZYkdjRWQ90q+HFXvwSVAFW6NwnmiuwryBfGA
	yrQPqTVRGyAU9O+bzhCByefZ3ruH2KfMhpwX4QplPguuGBYepHm30K2/nJvkxaBK8U0VTWKDC/x
	bHAUtTvaUZQ9KG06hx0ZscOHz9/aJt2i705PH6GLv6PftTXoy+0uaMxbdOxG0xY9sknYasBNc26
	FelH+5iyL+kJDRXv279uUWXioUqccuWCF8yAJESOKf
X-Received: by 2002:a05:620a:4611:b0:93f:53d1:54c7 with SMTP id af79cd13be357-944217ef418mr83503685a.70.1793309134342;
        Thu, 29 Oct 2026 14:25:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9442121c4cdsm6565185a.8.2026.10.29.14.25.33
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:25:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c7886e8dfso1966566d6.1
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793309133; x=1793913933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eG9L8JoEnV2/AJh4IZs2XwE9uOcVbAGkOowIPsI/5ZY=;
        b=LqgpgvPgIyNpeL6HdQ7ov2NdCk69YlkDF331RJho5aooiN5Z8gzKRiDt3DPJvwyMwp
         GTWJlcFO/eje9HH2f/3fTSVkVc+l6yzc+hgZLGibBRQmnPu93AvXGvZe1T3IyE8gJrzq
         mbiMKzpxAeKlCt6qluEeJAmMS3BZmot815Mu4=
X-Forwarded-Encrypted: i=1; AKwUvBwCnFDXAxiC8BcSsmcRyzyplxbQ7dDYksg5QhwMtEwDWGRqzC5aeYS6+wE3rT+nl39vpi7kFRFDKMk=@vger.kernel.org
X-Received: by 2002:a05:6214:45a0:b0:91c:7a0e:3385 with SMTP id 6a1803df08f44-91ca4b7973dmr3564006d6.49.1793309132726;
        Thu, 29 Oct 2026 14:25:32 -0700 (PDT)
X-Received: by 2002:a05:6214:45a0:b0:91c:7a0e:3385 with SMTP id 6a1803df08f44-91ca4b7973dmr3563736d6.49.1793309132301;
        Thu, 29 Oct 2026 14:25:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca314fb6csm6384936d6.34.2026.10.29.14.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:31 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM ARCHITECTURE),
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v4 3/6] ata: ahci_brcm: Initialize the NSP interface clock and reset
Date: Thu, 29 Oct 2026 14:25:10 -0700
Message-ID: <20261029212513.4126083-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The NSP probe path assumes firmware has enabled the SATA IDM interface
clock and released the core reset. The downstream iProc config_AHCI()
sequence explicitly performs both operations before accessing AHCI.
Without that setup, a cold boot can access an inactive controller.

Map the optional NSP IDM register region and enable the interface clock
before releasing reset, retaining the downstream settling intervals.
Perform the sequence at probe and resume before reconfiguring SATA.

Keep the resource optional so older device trees continue to rely on
firmware initialization.

Fixes: 3ee2e6dcaa35 ("ata: ahci_brcm: Add support for Broadcom NSP SoC")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/ata/ahci_brcm.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 29be74fedcf0..3b6ed56f3e95 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -6,7 +6,9 @@
  */
 
 #include <linux/ahci_platform.h>
+#include <linux/bcma/bcma_regs.h>
 #include <linux/compiler.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -83,6 +85,7 @@ enum brcm_ahci_quirks {
 struct brcm_ahci_priv {
 	struct device *dev;
 	void __iomem *top_ctrl;
+	void __iomem *idm;
 	u32 port_mask;
 	u32 quirks;
 	enum brcm_ahci_version version;
@@ -230,6 +233,25 @@ static u32 brcm_ahci_get_portmask(struct ahci_host_priv *hpriv,
 	return impl;
 }
 
+static void brcm_sata_init_idm(struct brcm_ahci_priv *priv)
+{
+	u32 data;
+
+	if (!priv->idm)
+		return;
+
+	/* Enable the interface clock before releasing the SATA core reset. */
+	data = readl(priv->idm + BCMA_IOCTL);
+	writel(data | BCMA_IOCTL_CLK, priv->idm + BCMA_IOCTL);
+	readl(priv->idm + BCMA_IOCTL);
+	usleep_range(1000, 2000);
+
+	data = readl(priv->idm + BCMA_RESET_CTL);
+	writel(data & ~BCMA_RESET_CTL_RESET, priv->idm + BCMA_RESET_CTL);
+	readl(priv->idm + BCMA_RESET_CTL);
+	usleep_range(1000, 2000);
+}
+
 static void brcm_sata_init(struct brcm_ahci_priv *priv)
 {
 	void __iomem *ctrl = priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL;
@@ -376,6 +398,9 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Initialize the IDM before enabling the controller clocks. */
+	brcm_sata_init_idm(priv);
+
 	/* Make sure clocks are turned on before re-configuration */
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
@@ -453,6 +478,14 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	priv->version = (unsigned long)of_id->data;
 	priv->dev = dev;
 
+	/* Older NSP device trees rely on firmware to initialize the IDM. */
+	if (priv->version == BRCM_SATA_NSP &&
+	    platform_get_resource_byname(pdev, IORESOURCE_MEM, "idm")) {
+		priv->idm = devm_platform_ioremap_resource_byname(pdev, "idm");
+		if (IS_ERR(priv->idm))
+			return PTR_ERR(priv->idm);
+	}
+
 	priv->top_ctrl = devm_platform_ioremap_resource_byname(pdev, "top-ctrl");
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
@@ -493,6 +526,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Initialize the IDM before enabling the controller clocks. */
+	brcm_sata_init_idm(priv);
+
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
 		goto out_reset;
-- 
2.53.0

