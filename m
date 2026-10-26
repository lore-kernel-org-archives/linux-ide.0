Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039380;
	b=36O/wTLfaBpak62Cp9v92Mb6IGa9xYAxtSOHLyKrLCttpCJIUxUeSneUGWI6nZIe/Zso
	 LoIxZOIBbjqhCG2r1V8uCdHMRIc/Gg4LJHqgMDjc1/UbtA7f2WQ0pdD5wdiKSpoEH6Vlc
	 BzrZ7hfsjlXGlEi/P+6BmWIqriachDSyWxTwOel0FjeQyLzlgH1lkTWVchCl0bR+dGuFQ
	 s7Ro7iuxmkguVY5SD2C74YOaYO4GXE9J5spjYNtakjAk/b2U3s4XS+1fZv3EGKF/u1DAT
	 gftxvsV9ryS0xE9Mu7vYlNHC+CzPK59kDFMO4uqIlu/qIuhGodxwapIRcVwCsKXu1uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039380;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=1MIbl2zx8FaPW7oX7ST7fbgJ9gFOgJZeuRxXV0E1qzg=;
	b=nFasGnzMWMq5S1026VM7SW3pwbP7He8dCe2DNvGqF/rj9ts1S1LXBTCcEzzscM/imrDJ
	 FEff3e4ZsTvynGtzfYEAs8/kPqCvVPeItt++8XEDfMRhyJMgB039gNOOXBuXZSfsOUmXu
	 QdkZb7OeBcCX4jfJoTssO9ncM7JjlrGkpTdncsMbp0z+Nbg6StwF6A6bJw6GTCQmdOMTe
	 snKtukeDdcbJF+LAMn7NkDBNsPpvidtAD73w9uZHirot968TKK1EtkU80BkMBL+U4rBKP
	 HQPyTfZ4qVCmZeiJgZ7QR1vxWrWBcu3wEguBL86301OR5XYEj9z4NqHAb3nQyAHAcaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EDbe8JyM;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A450606A325
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 18:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A450606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EDbe8JyM
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so2420206a91.3
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039375; x=1793644175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MIbl2zx8FaPW7oX7ST7fbgJ9gFOgJZeuRxXV0E1qzg=;
        b=xz+sYaI733ZGhQmrzM5UIkP4NCgI97gSLnnjNGMmplMSrg4Dwn9Q8pb0IVemgm/chh
         B7VPNR0KN/uLPyiuCk4SeVg/rFatwryYEMEB5g5/86cj6JQ5Xh5ZFlMd6R1g0f96TBQc
         i6zi8Bk7Kbu0/yXYWGck/p6z24lK+N0RPItdYiI0pelpQrKduGIuJUOLJedfVImadNdU
         7fsXwizdqCJUg1BMjWZiJcSIXbUlunMH4B8gaVoK8arqFwoEJq/Z9oRx0FE5S9cIzIDu
         5X0141bCtJNRIeGYBEoLIG7yBq3OWoE8EB4lFoG8+qb/GJqablOhULXNiAXsr11Aj/rN
         tEKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLoM4BI1AZLh4RF97tpEuXbrViG3UEpZy+7zR+FZinrD4c3o4CUr7bVIbLA2qJ1bsLPohR1hft/rc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhaor0qeZpnL+HfhYCniTqSXhaLYCF7dnMgxXjsujfLIAm2uC6
	sIQXMglTIo0qalVDHfwy4W543r1pQv8oXYb7gKz7FYR6WCq86XZDnUnPQjlewXpjxuQ/7t5j/pz
	qtO8AMlR6btfjB4Tphp4b33e9aNb2siXXIkfeGKoz0zjmq1Weno5PLhx9XhZBTYcxOSd6zSMtJp
	sfpLCkPCgjoka12krkPQ/l3sJx13I7z9z/TcENdBVvxbD7teLM3CB11/PeXru31lNGznVBlbVx/
	Y4cKcronvLs1NfhXtBG3Q8=
X-Gm-Gg: AYBFou32xjX0BCZ5c3ur8eh9xouU88egFhGO9FUVOT0VEtROdc2rOBF4p2la7cax+kF
	sYkRF4kZgCIVfKSeiRH255hcBErX+zsCzqiy3cIpV/+6P2ET9JRT1XJkrwJ/xqy+FDTeiOeso4y
	FUDdvN/4ON2HdjUSqk4WK3jUajvwBvP2sNl+UcvBowkcxrNpnw3pwQ/PGMdlHJsN0QFXjrHcK91
	qr0J7SZWjdcZvbxyaTWYxo1Aykm/9TmGJM0xOR/5JuqmTu1WIAML/sn8DwSJIar0LmGMwHrb3P/
	mFd9ErglWcqmuwim1j60MnyCa/Et84XJZHveAPveWxFGfWUqnE7tlFgXuLnipUIZ/cqM/b4rZBb
	SLmSetjqe30pGVFn0iMpZjsxZl2Cd61/kTyfXB5+aD2yswUQJJzXCA7W0YCudUSCujryO7LXuX6
	fYd0/VP8Kq6h5Uf2YAhfRNoSIPwR7AQADsbAOyO5/n+RE=
X-Received: by 2002:a17:90b:1fc4:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3adead4b1bdmr6708965a91.33.1793039374650;
        Mon, 26 Oct 2026 11:29:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adeba6ac8fsm3433964a91.2.2026.10.26.11.29.33
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:29:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c5aef2a74so15640374eec.0
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793039372; x=1793644172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1MIbl2zx8FaPW7oX7ST7fbgJ9gFOgJZeuRxXV0E1qzg=;
        b=EDbe8JyM1HEA7j7H+aiMBu3jKwqskRBAJ0LqbkNmp0bd+lNRV7bq+OVr/KpUvuNCyd
         gpT6RbtbBWzxFxzPld2nJptYQjepp/WUVsyiLvvArWlPBuSEHON2OW+DbvZtzaFY1UQW
         EoJ3v3vDU5E5dWcXRkbx+/XnX+x/J9PlOT8b4=
X-Forwarded-Encrypted: i=1; AKwUvBwDbe1Mib3nNHCxM3mBWiYKwkbNb3+O2cCpk23RwLzZBY8Y2wg+J/oQoUQ3MipO1oWUym+YsWU0dFM=@vger.kernel.org
X-Received: by 2002:a05:693c:68db:b0:369:f7d2:d7a0 with SMTP id 5a478bee46e88-369f7d2edf6mr7300544eec.25.1793039371683;
        Mon, 26 Oct 2026 11:29:31 -0700 (PDT)
X-Received: by 2002:a05:693c:68db:b0:369:f7d2:d7a0 with SMTP id 5a478bee46e88-369f7d2edf6mr7300511eec.25.1793039370933;
        Mon, 26 Oct 2026 11:29:30 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm24657259eec.21.2026.10.26.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:29:30 -0700 (PDT)
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
Subject: [PATCH v2 4/6] ARM: dts: broadcom: Add the NSP SATA IDM registers
Date: Mon, 26 Oct 2026 11:28:54 -0700
Message-ID: <20261026182856.3168686-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026182856.3168686-1-florian.fainelli@broadcom.com>
References: <20261026182856.3168686-1-florian.fainelli@broadcom.com>
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

