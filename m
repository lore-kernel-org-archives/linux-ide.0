Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C930DEC7;
	Mon,  5 Jan 2026 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648561; cv=none; b=USHJXxWUg+HGuTRUYUnfR1xFQHpQsWgkmZZIu6d2jvvI/yyTG3EImeA3XYp48s3EbQk6UtSKChoYGF63A7lax708RHBxALN59Y+xwIj8ENqIZyFaLKzKmdqRYFJnNbd1+ZI1hBNRc5pI2M1wMDJ2N9JQ4Q+PGPxFN3XF1IbQnio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648561; c=relaxed/simple;
	bh=gVYsL4/DFgpYAuvKQiFU66WvWBX/KhYn1bwiAZv3A6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeiQ2tkuojQJTIJbJ1aOJwlSbs4ChEMVb3ZMQ5vSCIWha0jWGQS9aYiHixLfYZ3G0xtsMZrkNnxrdVTM4egJp+A1eprrwwpPPr7Vhd3nCCRXB0s2k+a8CSABB4WC5do/CI4oZ8FGmF01eCRsaDWwlsHE62rcjDleTJV5e3ZGO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2MaALHz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2MaALHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADFEC116D0;
	Mon,  5 Jan 2026 21:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767648561;
	bh=gVYsL4/DFgpYAuvKQiFU66WvWBX/KhYn1bwiAZv3A6o=;
	h=From:To:Cc:Subject:Date:From;
	b=P2MaALHzgyu5BOYP8S6XMsC6kOsCyqV0pSu3/nwrwME5psqvM+Q4O0o1D5bmLn5dP
	 9SDN6onVb7YGORXrlKfhSVr5R3X+ilU0+BRJqujWGMi2tjSrcdVfjAPYZLN2ESjAZj
	 MAbrbBJTqGG6gITJSaYf3FHgkadqN2s4/Zjmarff2r7ILeZTKT0b8pcKgExJ0iaf+y
	 ZpSAkkEKGJVLT5nT+dWVQgVNYvhD5beVG5P01+9BrMhmUVHnhA6Sx0if7JTIuscaOl
	 woSXyxGk7gkyaC1hUMx9jNOdawb0XpZo3qI+1MiETuusSR79fppWr/UY5RgRjuhtnS
	 bsAc4J4vmNN0g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: ahci-platform: Drop unnecessary select schema
Date: Mon,  5 Jan 2026 15:29:16 -0600
Message-ID: <20260105212917.3454753-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "select" schema is not necessary. It looks like it is there to prevent
matching on "generic-ahci" compatible, but that's not necessary because
this is the only place "generic-ahci" compatible is present.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/ata/ahci-platform.yaml           | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index cc35cdc02840..cd67926aae41 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -18,26 +18,6 @@ maintainers:
   - Hans de Goede <hdegoede@redhat.com>
   - Jens Axboe <axboe@kernel.dk>
 
-select:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - brcm,iproc-ahci
-          - cavium,octeon-7130-ahci
-          - hisilicon,hisi-ahci
-          - ibm,476gtr-ahci
-          - marvell,armada-3700-ahci
-          - marvell,armada-8k-ahci
-          - marvell,berlin2q-ahci
-          - qcom,apq8064-ahci
-          - qcom,ipq806x-ahci
-          - socionext,uniphier-pro4-ahci
-          - socionext,uniphier-pxs2-ahci
-          - socionext,uniphier-pxs3-ahci
-  required:
-    - compatible
-
 properties:
   compatible:
     oneOf:
-- 
2.51.0

