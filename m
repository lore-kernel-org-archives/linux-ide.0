Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042295;
	b=tbsgoinMgYiVKtaAAHtHGU1h/9mh2VI+tjmXAhB/Z/33VhTASrWSv48DvyZuFro3YZNG
	 UNj2MOLu3Vc2POPRv3eMZJxQAc/nT+TKNS60Vy+SQe5MTZj6PdcewzZ61hxZPdXs5yGXW
	 RURKmr5BpivcNycnsBHi2lg60giZS2UStK5cqvh+YVoFo+/2Qq8AD/tQrGFYgLgsDiiho
	 yJCQt54DH6tDQLcnaB0nH6xlgOt6YP3wYNFlzLzyUvRZKoUbU72NavHGcoAnK3BzeVBoF
	 nNHPHLxfr1ZqAmAjQilNGAEW5FvXU7TMitICvSmLVnvZIoQnm9GZ0ERfHCE43bzMEuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042295;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=1MIbl2zx8FaPW7oX7ST7fbgJ9gFOgJZeuRxXV0E1qzg=;
	b=0wkjqa2cqhzyqoe12s3f5Sx4r8XKO67Ncwc66+1DJLFAOWeH45GJ6PrCW/XI2MCxOvrr
	 TCecuOdWNbpBwQTZSh9y8Bi3VXHdwo/360mSZBByLkH+Xc3wDEhtFx5yrLZnOK4txHMAm
	 rOiR77vgIE5zCZRsp4dodr5HIl397tM7PmWbJEnZx5K0eftUmhgUPC7sPkngIinW2/8fD
	 3tqLUc6MOJs7cI2ksoiR3vZBD/qknBXibA0VpJJflvJZChqLNmtPL7daBQaM2qY5BL/cP
	 AEOA71nB0l8hOM5Di5RPwsrl7ysxo4m9OgZO51V13dyx+MM+MJZlYK83+JBe5HElQhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ZaQw6+6z;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61BE606A33C
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 19:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B61BE606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ZaQw6+6z
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso2451763a91.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042294; x=1793647094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MIbl2zx8FaPW7oX7ST7fbgJ9gFOgJZeuRxXV0E1qzg=;
        b=Giy7VMsWCuDiOYYwOuoI3nKwusBIFdAp20vmquvLbMAfYgQzI9HqfE1Nvw9JE/esLA
         WsIpEuQRVhuJrMt7TiMNHj/4CIM77Lb9NQRz3UCpH4pjekyrXBt5+41LeHkpCMPj7E84
         k7onZj+gfiCK0getMRzqs3WC5YVEoSFLXvSleeX09a2STtz7L274eB4s3z+KZtIWbCYT
         FRQzMh7HQTZ5Idpf1DSSveYgKF6TIQgjGufu0WrI7wmOgLh950z3HNN4v624GegCqm8B
         oP6mXrwr8g2T5mAPXZxGQmdrQrWjt7XmEyM3wJb1gYf7Bv4QAY/G6pUQq+okR/Af1sED
         2xPw==
X-Forwarded-Encrypted: i=1; AKwUvByvXFBjH37PXwHK9MFe0nwj4C6Pqs5IiRNNLk3PA5+Isz9KitFAjDEutdgHIIi0XBaCzYoh3BQM9wQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYYTVO0aiM67NKsJkAC3kk8NhovYwJNB4b5OoKcIrwmIdv7ZzO
	7SC0UIQMuLPJeD55/q88j3gWrQpTLCEPePWAW/i2M3PsORNsPXkfuUfBckD5aGVN63t9dXBZSGP
	aRE0l8H/MPS8izKUsmCuEZTVGz23RTEfepQFFVryaxnEE9wejtTZ97e2YW3DIeEtmIBMFYkxUOg
	ILrRXojkyq6LWCnyFahleBGCif9f+3VciB2bjB+rK6bEArCPTzkhfWcKRUNOKAZVccd30mW8WQh
	tkzJjUn40VysZFVL7HRqpI=
X-Gm-Gg: AYBFou0Ne99ZgFy5I/ZJs8mBbfvL4hac9wF9oOQ4SC4oRJp0LDQPmhycQw/vAx51Fiu
	Uu+Ax8XK+f29FlNUi5+3JWJW2j7gNAVLfZxldS7DIRyhxgam7ZAn2mmRnB1rz8WTpi2UlSHredg
	UfnV4nQ1JoIxHuNPzpbIVb7wntOP25sZa9s6mS6JXLOKaSTu3pJASSM68Yio+P5iUjW2uFXjnW4
	zJRZrO6KJDj5mOMlJ5kVpRdCM67ero1ZRhYNFxTfCuE+KltHxBnSwM0RcNUCcFbDgDyFO3W8WnY
	xg3hytb0kTPHs/aFkJp6Odntzo0mYqh8zl3/tH+mS1BIyRjsMpZ0Z3/YuJhTgYUs/YigX6krR71
	AWdX/yeN9C/65ubV0LG3QlVSbEcBFcY9BWqnTnoPO35ZE5c4swSbCmwW5tatMspTpaxIy427CO6
	nXxetGjvlouQTWYjsIgxJ90r/sQx842QjkOyOJ6DbW
X-Received: by 2002:a17:90b:582d:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3adeb13167emr5566566a91.51.1793042294120;
        Mon, 26 Oct 2026 12:18:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae404ce404sm357532a91.2.2026.10.26.12.18.13
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:18:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91bebff9fcaso120407296d6.2
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793042293; x=1793647093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1MIbl2zx8FaPW7oX7ST7fbgJ9gFOgJZeuRxXV0E1qzg=;
        b=ZaQw6+6zFxoBEbQe/sz92TQ46W9SM3oo9ELw08440qjow1aYBXUv1cb2a/dcY/Y1MM
         QgWcuh3h4Nz93wJV7hYyzRuzrRGhby+o2jok4D+0UePsTnegdEdZ/zqtpSCZEE7WpQYk
         frATGascxUN4IK5iHAPC7pjDVhdNWPhhd8Ggc=
X-Forwarded-Encrypted: i=1; AKwUvBxm4TK6i03HbBksyQ+Bc6Xqyw2B/7dzSxgnbT1dPwMVFmyL79UCCt2PCv7JPvUgfDcVfowxVwGS2Ys=@vger.kernel.org
X-Received: by 2002:a05:6214:3c8e:b0:915:e5c8:5663 with SMTP id 6a1803df08f44-91c48cd11edmr127063406d6.4.1793042292651;
        Mon, 26 Oct 2026 12:18:12 -0700 (PDT)
X-Received: by 2002:a05:6214:3c8e:b0:915:e5c8:5663 with SMTP id 6a1803df08f44-91c48cd11edmr127062806d6.4.1793042292066;
        Mon, 26 Oct 2026 12:18:12 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c62063dacsm33430996d6.37.2026.10.26.12.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:18:11 -0700 (PDT)
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
Subject: [PATCH v3 4/6] ARM: dts: broadcom: Add the NSP SATA IDM registers
Date: Mon, 26 Oct 2026 12:16:16 -0700
Message-ID: <20261026191618.3178830-5-florian.fainelli@broadcom.com>
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

The NSP SATA description omits the IDM block at 0x1811e000, leaving the
interface clock and core reset dependent on firmware initialization.

Supply the IDM as the third controller register region so ahci_brcm can
perform the downstream clock/reset sequence. Extend the AXI bus range to
cover the complete IDM aperture.

Fixes: 8dbcad020f2e ("ARM: dts: nsp: Add sata device tree entry")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm-nsp.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi b/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
index 6a4482c93167..9dbcd810e27b 100644
--- a/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
@@ -168,7 +168,7 @@ periph_clk: periph_clk {
 
 	axi: axi@18000000 {
 		compatible = "simple-bus";
-		ranges = <0x00000000 0x18000000 0x0011c40c>;
+		ranges = <0x00000000 0x18000000 0x0011f000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
@@ -538,8 +538,9 @@ sata_phy1: sata-phy@1 {
 
 		sata: sata@41000 {
 			compatible = "brcm,bcm-nsp-ahci";
-			reg-names = "ahci", "top-ctrl";
-			reg = <0x41000 0x1000>, <0x40020 0x1c>;
+			reg-names = "ahci", "top-ctrl", "idm";
+			reg = <0x41000 0x1000>, <0x40020 0x1c>,
+			      <0x11e000 0x1000>;
 			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.53.0

