Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.144.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601766;
	b=qWdPA0DIO9Pb2rbvir4q9qUacU7nOXQLgibCsAq1oad5a55qkrR6qRnKdHaieQgnGOwv
	 3hZlyOP5NlHvzgwQ3LTEjhsGqmFcv0clag2K7XDkBi5V4E4+4PVOWQazuNxO1o69tnWnx
	 F4gfX3DXGPoCdQSRtItrtQKSq5NL8DgazFjlExjuMfTqXmyFjzjuQEaGqjlIb3ieIdukL
	 r9oFnp5eDr4ge0fEi9a4PVYJfMFpOe0PRtzmrG0oSFs2kNm42FYwOT0x0Y6oyyH4c4IBJ
	 U5SG47pShLUXkp3AAEGXPGI6aBDtxA6W+1haFXYk/fX9+IpDKC1jv2S65SXjJ2VEIIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601766;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aNnXVvaXvyleKG3InyKA6aUQiFIeS59wNHeFdWZvb9Q=;
	b=W+E8W5fXWGFgnku0Kbj7KdBvIwO2GhUk54C/K3hsRGLnNuYHWrcNtca3S4mDg77doV8B
	 gyNrSF52tZG2SXFiPguF6EcpH2s8Ad15BciHafJNyaRD4BPR44JlFxeXl0Vwk5KL82Cbx
	 QQUvj+MIafuwBjSVUI9KXseAe6UNZxWdDMsSPXYHm9xF9khbi0of5repC3QOSuEGx3dPz
	 rPP/SozyuSdIXGWw6kFXILEHYR96Dfa3v+Vkrkl6Ur4ED2yEBjPMqvrLLlMn6oAbU0mCc
	 nX6PlQKh/bDIW0POsMw38dOskkdOxfohZkuNaSeB1e2F54DZawbomb+bBRe7mU2WjyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=At57Jxgb;
	arc=none smtp.remote-ip=192.19.144.207
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39A60A2619;
	Wed, 21 Oct 2026 16:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA39A60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=At57Jxgb
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9033AC0003E1;
	Wed, 21 Oct 2026 09:55:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9033AC0003E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792601759;
	bh=zhQqLH9arwOmH4pppSryU99pgXQmSkM3a2f7ulKCCWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=At57JxgbZr194xW3uu4EA44toz1uKhthTscAzvL5yhkmzVkymHdDjB7a7lF3vlEYb
	 XX4Xex9+e4zbdmoWikoA+uLyS1TnxiIXEVB6Xl4MMTbCwQrieWesh5yne0nTs1oSm0
	 Owmfc7I+xG0ZE2jougL3hoT7CRj1BIUvTnKmPcSE=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 28AC4A83;
	Wed, 21 Oct 2026 09:55:59 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
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
	linux-kernel@vger.kernel.org (open list),
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH 6/6] ARM: dts: broadcom: Use noncoherent SATA DMA on BCM958625HR
Date: Wed, 21 Oct 2026 09:55:55 -0700
Message-ID: <20261021165555.652102-9-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021165555.652102-1-florian.fainelli@broadcom.com>
References: <20261021165555.652102-1-florian.fainelli@broadcom.com>
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

The AHCI controller on BCM958625HR fails with the dma-coherent property
inherited from bcm-nsp.dtsi. Soft reset times out waiting for the first
FIS command, subsequent engine resets fail, and the disk is not detected.

AHCI allocates its command tables and received-FIS buffers with the DMA
API. Declaring the controller coherent bypasses the cache handling that
these buffers require on this board. Removing the property restores
hard disk detection and operation, as confirmed with a diagnostic DTB
that changed only this property.

Use noncoherent DMA for SATA on BCM958625HR, matching the downstream SDK.

Fixes: 56e2ff0346a3 ("ARM: dts: NSP: Add dma-coherent to relevant DT entries")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm958625hr.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm958625hr.dts b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
index 3e86f3c2593a..f6717ca76aef 100644
--- a/arch/arm/boot/dts/broadcom/bcm958625hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
@@ -183,6 +183,7 @@ partition@700000 {
 };
 
 &sata {
+	/delete-property/ dma-coherent;
 	status = "okay";
 };
 
-- 
2.53.0

