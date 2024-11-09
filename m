Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDEC11C83;
	Sat,  9 Nov 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731145985; cv=none; b=AIY5G05U0+5c/6bZHum/yi0HzbssXflX8A0y7v2Jvhd4h4nfUW0IT2aVP9gh90h2XohWor9obf4XTyMEwu3fSiYhR1fWEoP2x3rT/j5+D6AV/P2UrjqxlhSC/6B1WdO2gdFv1XVZkGyb9cDFmBV7pA+1zCGJUcYcL7IPi3U5SQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731145985; c=relaxed/simple;
	bh=LM2YrStHhWfImTBkjTG5bNjXWuyyGFfj1FQgnTM2HpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNlikmfxCxiXQzE7ui8/PPSB7GrEA87ho5glDmd1qroxwFsU5Lpd6HUaraI9ywuth64xHeYYMsS8k/bDratWI0InJ85rAXJ2RbkXDiNm9HqNZJvRqNBR5sSQhvcKfbjkB7uD4Uz3OmvKpdvofH3TbdjW9vzH29Q6a5Jq2Q8ZhG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=GlB6r8Co; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="GlB6r8Co"
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout2.routing.net (Postfix) with ESMTP id 4FF73603CF;
	Sat,  9 Nov 2024 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1731145604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+69KJK3zrl6PpqAifiS8qjg8S5oJH80PJf+IyWPC+S8=;
	b=GlB6r8CotjkQXfveXfLsZZSZtBqONyb1qwOYtpPE1to6m3N2tSGpxvi+PHqEybyZh3q020
	2EpmHJfojRfFYGAcP4FYcXzyM1B7WA3tS/fAPp3bFx3X3XohByixBOIessxnYPlQnaUWZ3
	3h2cs3YgXMB8e5eo/4MBsdPaABl4CFs=
Received: from frank-u24.. (fttx-pool-157.180.226.68.bambit.de [157.180.226.68])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 6E2C14028F;
	Sat,  9 Nov 2024 09:46:43 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 3/3] dt-bindings: ata: ahci-platform: add missing iommus property
Date: Sat,  9 Nov 2024 10:46:21 +0100
Message-ID: <20241109094623.37518-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241109094623.37518-1-linux@fw-web.de>
References: <20241109094623.37518-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: fc86e688-7b61-4350-916f-198d8262f45c

From: Frank Wunderlich <frank-w@public-files.de>

fix dtbs_check errors in following files:

arch/arm64/boot/dts/marvell/armada-7040-db.dtb: sata@540000:
arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dtb: sata@540000:
arch/arm64/boot/dts/marvell/armada-8040-db.dtb: sata@540000:
arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: sata@540000:
arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dtb: sata@540000:
  Unevaluated properties are not allowed ('iommus' was unexpected)

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
iommus seems to be added with
83a3545d9c37 ("arm64: dts: marvell: add SMMU support")
which seems not be documented in txt before i converted the binding.
---
 Documentation/devicetree/bindings/ata/ahci-platform.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index ef19468e3022..cc35cdc02840 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -84,6 +84,9 @@ properties:
     minItems: 1
     maxItems: 3
 
+  iommus:
+    maxItems: 1
+
 patternProperties:
   "^sata-port@[0-9a-f]+$":
     $ref: /schemas/ata/ahci-common.yaml#/$defs/ahci-port
-- 
2.43.0

