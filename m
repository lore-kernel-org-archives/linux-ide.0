Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042287;
	b=0ZP2kVnU4sO15pXZZDANVx8B9kp0FSRVJFcUWBWMzWltRaOzogXcOyjrVvWrX2jSxZr4
	 xgrwyTapO3klwyZPuLUo3AiYUG+6VL1G2sUtmNDS0PBaMN3BSgygukvYfaj76zyhIJUJI
	 oubQEIdCyDAIVUjYKC32Dp86uznG1qLQNvqygXrZ7UxQmaDn9WS+qVvob7yWk1SoanLxS
	 ZqmP3xRBcqi1sIjd2l0N+H8FT+hdChMNgWqw6jC9PiMaMe7Z+fM9eWv0fBSaJFBk7c18S
	 R8V8GBv4qPvxrPG/eqg1VaLjqs14Wmsi9sR92p7RniiNKo79NXMKD4Q6YFl/zsH/suQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042287;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=AaqGunwSleeDLPx2z6NkDc6zUunPgMcaEWPlGCr1dr4=;
	b=x6o3DHFwFybc/iKqTIMHGJd+p3OF1tYoUWnlVsRyQuyu/iknGzqv1Ukse1FCk2fSOW8h
	 u1NM00Y9RoElDXwuPxR+KILU8m9WF0W3Zez+if+us+WnyLcRmGGcQqjPxUqCYlMYEd4Ee
	 Td6QfGw5qQy5X6TACK+W/0vpC/CocOZxS3jcP8Gh0dKa9EY/IvzTuwMlNjYYpkPUGR90B
	 Kyqx5jPtzVTKBYl7q4QwEmiLxIRMvaiT54/LGZ0JcUO/Qr+ymRr0L2HcDFpYwNI96oTU/
	 l788wBQdFS098wd4NDR7Itew1bElWp6ui+Fc1JK/RRDpDI4suZ/2mHA1/8NiaTdGLNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Sza3ARwz;
	arc=none smtp.remote-ip=209.85.128.225
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F330606A334
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 19:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F330606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Sza3ARwz
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-8aea7b7ca0cso27150567b3.2
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042285; x=1793647085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AaqGunwSleeDLPx2z6NkDc6zUunPgMcaEWPlGCr1dr4=;
        b=xoA0fOwjcD6ORq3baqLDv+FbcIQboCGEnsHOkIykxEHIo5PgJ0qafPQR4tbS5LeGpJ
         X/PJiyYuKM7+vQxahEJaxOL/6P90FxqP0jmvCaqqPHUwTmQvfRGDg0q7AozcqcsSPIsi
         fR+k052munVOL46+8a5qvccXwAv4pnUGDpxRLLnaz6VuIvmiCroVtQGv0hcWK5P3dLW3
         ArRxisaXiVwA8GV5tXjvUgzwPoWu0EeKYQMLOWPL021MAkV02XymSl3Wg2thowTJ1FWh
         e6ALnpJNTiqFITuN6x0uA928OKzHv0y3GVxogvOgqKfouHOoKippvoddhjVW5eb4MaEm
         U/QQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfZxikKLA+It2d7+tsrOKkOKz3baLKgCJdYpASPP4ZuiTWHmx03dtQORtMrtR4Y0cby4g0wOejdEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJo6NTb1bX2m/r1meRYh0LeLAZtcPP5B40CK7tH1g1u6AGPWUnl
	VpzM2SvlLdm4STH+xTLvj6CYjq8N4CxdDztP25kubi6xOoFOslJEm+3e93RxwocqMqf/jRh/1NY
	nfQLFqEOXRP5vSTgLcLX6NOLHN4OyffDq9ZoyzFICIr/tOE++OhIxkmjNifqKuf1+ChiIVwe2E8
	jjhX0gGzsmVH7lR8G940/lh2co6cpjYkdOyGYY7i2zzaCmE+5DLGBcALtxps9ohrC4cjmOu2yKU
	6xTtbU95klcjC4znz6vefw=
X-Gm-Gg: AYBFou2bE7I7eDcuwYKOmoIJ/AWAIfLc5o7ur36r5C3EIeAGl7n86jeByPvGPAFlMRS
	Sjv6h0RPXL2MU7J9rzSm8xg/8U+tJhsPPxVF7ZG80eJ2LbplEgZiuwznS+SwK5JHb9iUvgEyS34
	LXWJdxr1sXhUIR0Jx6m3jHxywE9I/f79Gq+IYPjzHZE1G210fyF99byMLECZu0VWCgpCKDwjxSs
	Tt+T7wa8XYJOr3s0erC9HggwAq+JPiT5N5BELbrmZil5sJ/qT6kFUoEa5PTF9DOqefz+edAlTom
	NntbT5983ry1w2UQ/QH3ntdubFHQWeR1+hnxbS4Pv13Zs2EWZVYZcg2kHa941EwmX2Se7ZkFwj1
	SlXxYyuxU3GEmHp6X4w2UOjO05iobBpW4hOGZy0KIZr408+7aZCADNxfWV+lO52eQarC1JjO91I
	XLW6r9dlqYip7TobdU63myE+t9GLlWEMM0z2nptgzV
X-Received: by 2002:a53:d053:0:10b0:676:e85e:5ec with SMTP id 956f58d0204a3-67a45483981mr2620641d50.139.1793042285482;
        Mon, 26 Oct 2026 12:18:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-67a46113c9esm100016d50.35.2026.10.26.12.18.05
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:18:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91b7e7d5f56so87079996d6.3
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793042285; x=1793647085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AaqGunwSleeDLPx2z6NkDc6zUunPgMcaEWPlGCr1dr4=;
        b=Sza3ARwz/FoybdfoLdugEciq9efCUu2KQbzRgPcUXyGvjQmXEhBPy9Hdx2etuA66j1
         7wP59urS3PvzliPAHDImir29XAX0d1qddw/7/mEyuEsLJ+O5teF3mvqw8QKHMiGfGsAa
         kzQCui8ZhKI/cyTPjjekLUiiQpwApnaRjbTYw=
X-Forwarded-Encrypted: i=1; AKwUvBxGA0HBbF02imWSDrAO9C5yrvmJYtSN4PdwZ3bgnqtHIfAfDzYC5b5cRhWyI3nkgahFv1DT2jcNxew=@vger.kernel.org
X-Received: by 2002:a05:6214:5701:b0:914:5769:dcee with SMTP id 6a1803df08f44-91c48e36c9emr119686356d6.17.1793042284480;
        Mon, 26 Oct 2026 12:18:04 -0700 (PDT)
X-Received: by 2002:a05:6214:5701:b0:914:5769:dcee with SMTP id 6a1803df08f44-91c48e36c9emr119685776d6.17.1793042283921;
        Mon, 26 Oct 2026 12:18:03 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c62063dacsm33430996d6.37.2026.10.26.12.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:18:03 -0700 (PDT)
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
Subject: [PATCH v3 1/6] phy: broadcom: brcm-sata: Keep NSP ports in the shared PCB window
Date: Mon, 26 Oct 2026 12:16:13 -0700
Message-ID: <20261026191618.3178830-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026191618.3178830-1-florian.fainelli@broadcom.com>
References: <20261026191618.3178830-1-florian.fainelli@broadcom.com>
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

