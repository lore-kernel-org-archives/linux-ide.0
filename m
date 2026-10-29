Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309129;
	b=JavmuSU0LgcovtpGHjEomZY8cbm/0MAfkCnGqeG0d6LLgBcn/HEQaGYg0Su8GgRuhCZt
	 4Y85oz32zNC3COf5LAoCG56Nd66xtCnDaHJsieqr206tVkTTE/7C4PTDS7JXuKS0kAbY+
	 01mGZxKJO1S1bZcgeI7yJskI0J4DVwfhR3QTTZB0v2Z7d8biienG32DYyDlCKnjy5Hceb
	 fBHPvtfElow2k8by7QCtFmgRXBUv5AaJje/l5/u1IplZHFNf1bOmbUFoNfo7OxNhg4o88
	 sV3e5hVIpoy8q9br0Yyv7XV/pX+RH4Twh9p4HRIFJNOLjXWddIi/NeV0sKeSycGfdFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309129;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=AaqGunwSleeDLPx2z6NkDc6zUunPgMcaEWPlGCr1dr4=;
	b=FiTG1WFEBdNpJxTZjNAz3udJHsHva7BmphD4bKt0AYXUzvKBC7UxEiXEbUHAL49/Ju0R
	 L2PxT9ukiIBm7syrVyFYxlj+qFo0lyueX3UHR+kCh0gZrKVf8SAa9tjx3r6/mbPUuEBFr
	 hExJ9cQX0JJmRLfWoYIPR7LE1cRfhj84Rqhs0RWykpS3ilQkH63wNt/S89rkst3vPgqsc
	 0lAEYAK994f6KXdKcQcfd6dP9rcXr4pbShJ7fMyQUmzMekiWsTG5AEl5g2H8xF7lB8us3
	 y4phu9AZmi7zOQwbqSbaoIitHqK0EQ00xcYM5zBcOvDej5YU5TpiNk6c2tHSACqUwCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=SYZDi6rA;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58986606A332
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 21:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58986606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=SYZDi6rA
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so672030a91.1
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309129; x=1793913929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AaqGunwSleeDLPx2z6NkDc6zUunPgMcaEWPlGCr1dr4=;
        b=au4gFSVEEDjBIN1wKptbEQXK0y+kRSYdVN0ow/KPte9/u7L/HPqGug68sI3O2XTDer
         FcqQIN7ViQAsgE2bjDt5eyDB/3haAJ0KQPltqT6yIAztdEsm25M3TwqwuRTyaVSd+7s/
         Q7hmwp/b3yoawCnTC0CJrXH0BnDCoUTJvYWmGP0cXpRjn4rL9qHj1w9s7QWulm8WZb9u
         aYX35k5IEcgz6ujbtxqzPFdMDktwlgLhcTnySbtMc4cuCaSIt1ZVTtyLKIIcgswYPexC
         CBNFdW17Y7ASkvtPTHblZUbryYLLB5FelhzGRRQfbPjk8S7bV2uGhkKP4AX7LcAzkD0P
         3hlw==
X-Forwarded-Encrypted: i=1; AKwUvBwiVNdiNhbzRpZl29qACbWZD1yROk9Fs+5BefzInJmsk3Kkvg5mYWTcYx5Z8cs1V1w5amsYBJar0aM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlLG3ozx4m/7LjFx9HkigH+smyqOPr26NlB/HXeBOaKvf6riEY
	gOj05xZu6WBwP+LhvO1C7CWp/unxTL3cpiJ2/MdVMve4k/lT7hlqO0ZeDaKP6B+jgr/uDYtDIXi
	zhg0QbQyPF52x8K28xNtlijk9nOCNoJflsfG3/zHFXwagQKrKeNLPEpVakAweQicrK1eDb+wzaO
	21x+tj03+P1YGp8jZUfkesgNC9zu+wzt4uHcVG/3fK4tb+Fsde2kMh9TptGRJLjgovNyE2EMnMF
	LLeQtqAG/9OJHKYot+Y
X-Gm-Gg: AYBFou3i7JHldmtO1TxlX1ikkWb6MSa9facz9GCFdBQPNKQV3Ots99A0VeJcIBNBdTe
	G9VcAh6be+w2yLaJaJbn+JWMyXzSu2dqakChS+HUZhPaZdW6z+re6v5Kg54fN5voM2D+y4KThR5
	4G/gDKils4AJz3Uw67bce1buC6URjNj93kOJ6OuKFxeev+PNPORpHEfHe683XsKkv+Emge7WSE/
	+lzbmEbkwz4mtVnqyvnog0Cq8WD6OfUdQLC8D64WSoJSQvXuXtKsvxVnzUu7+Ai1VobP/X49Qeg
	L36djSUaF37GmiBdt2oNdGJrBQbvOClzKskkLxl+wD1ZXKpQc4e/Y5KhPIAwqWhN7Wb+qbapTL/
	MhR29LKkJefz0UwxSfXhRLxX1lfbGYamizllcLvrRaEV66OqrWWsqnlNw2KBoc80xaC+k456NtI
	kOoCfCLVPLtT2x2tJaN3WtpYc0ELYW2mp15yFhBtyc
X-Received: by 2002:a17:90b:4c4c:b0:3a6:d2ac:74ce with SMTP id 98e67ed59e1d1-3ae8972b662mr105224a91.19.1793309128033;
        Thu, 29 Oct 2026 14:25:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e6ec859sm2854306a91.2.2026.10.29.14.25.27
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:25:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c938148eeso2353536d6.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793309127; x=1793913927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AaqGunwSleeDLPx2z6NkDc6zUunPgMcaEWPlGCr1dr4=;
        b=SYZDi6rATPJq8Zao52OYuJ6jxtqhnjs9qWKUQL3KRTs6AUtSiwJwrxjaXaM83bCBOx
         Cf3esCbw/lNiR7wzHgulnZUSc6iCsQSYKqPk4UQWM0Lz79C+8FBuYnfCdU+jq85bkyfH
         dySV1zu2AVk+7ojehfNw+sPmXsXWFB6ejNXgs=
X-Forwarded-Encrypted: i=1; AKwUvBw2+wWs9oOfTbXqwYTcDxNFkBbJb54SJ5tLpKtyZd3VQkkIgI8wJN9/M7zh6P7Iatij6Hv86hywpKE=@vger.kernel.org
X-Received: by 2002:a05:6214:2f89:b0:914:48c8:6961 with SMTP id 6a1803df08f44-91ca4b6acabmr3500606d6.17.1793309126812;
        Thu, 29 Oct 2026 14:25:26 -0700 (PDT)
X-Received: by 2002:a05:6214:2f89:b0:914:48c8:6961 with SMTP id 6a1803df08f44-91ca4b6acabmr3500336d6.17.1793309126431;
        Thu, 29 Oct 2026 14:25:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca314fb6csm6384936d6.34.2026.10.29.14.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:25 -0700 (PDT)
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
Subject: [PATCH v4 1/6] phy: broadcom: brcm-sata: Keep NSP ports in the shared PCB window
Date: Thu, 29 Oct 2026 14:25:08 -0700
Message-ID: <20261029212513.4126083-2-florian.fainelli@broadcom.com>
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

Northstar Plus has one PCB register aperture for both SATA ports. Its
per-port OOB settings use separate banks, while the PLL registers are
shared.

The 40nm MDIO refactor made all non-40nm platforms use a 0x1000 per-port
stride. NSP previously passed the shared base directly to the helpers.
For port 1, the new stride moves the bank selector from 0x1804033c to
0x1804133c in the AHCI register window, outside the PHY resource, and
prevents the second PHY from being initialized correctly.

Exclude NSP from the per-port aperture offset in both read and write
helpers, preserving its existing bank selection.

Fixes: 0ed41b33882c ("phy: brcm-sata: Correct MDIO operations for 40nm platforms")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index fb69e21a0292..b5fb9dff1ae9 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -215,9 +215,10 @@ static void brcm_sata_phy_wr(struct brcm_sata_port *port, u32 bank,
 	void __iomem *pcb_base = priv->phy_base;
 	u32 tmp;
 
+	/* NSP has one shared PCB window; its per-port OOB banks are selected below. */
 	if (priv->version == BRCM_SATA_PHY_STB_40NM)
 		bank += (port->portnum * SATA_PCB_REG_40NM_SPACE_SIZE);
-	else
+	else if (priv->version != BRCM_SATA_PHY_IPROC_NSP)
 		pcb_base += (port->portnum * SATA_PCB_REG_28NM_SPACE_SIZE);
 
 	writel(bank, pcb_base + SATA_PCB_BANK_OFFSET);
@@ -233,7 +234,7 @@ static u32 brcm_sata_phy_rd(struct brcm_sata_port *port, u32 bank, u32 ofs)
 
 	if (priv->version == BRCM_SATA_PHY_STB_40NM)
 		bank += (port->portnum * SATA_PCB_REG_40NM_SPACE_SIZE);
-	else
+	else if (priv->version != BRCM_SATA_PHY_IPROC_NSP)
 		pcb_base += (port->portnum * SATA_PCB_REG_28NM_SPACE_SIZE);
 
 	writel(bank, pcb_base + SATA_PCB_BANK_OFFSET);
-- 
2.53.0

