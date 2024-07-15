Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D82186287;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032804; cv=none; b=SAj0xpQiSzawFe5IuMNDCUXTSlXYWIDIJfekQoHr0y/gn7fjqi6qTyVJidwwgwSYSHlQwkUT7tWcr7IEwJ/ux4uUXwmws7rsX9DpxGwvVSgtm51LREKYIFvrdtU/AFXxT4RKN26wUmBvc4Ut3Upll6UzEqSdvHq+xzRb38Szlfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032804; c=relaxed/simple;
	bh=8PZHxLuGyB8p9W0SYpe0i7du47O6eKqMcp9201yCNyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZ01owVbkDUiIQf1U2LO8aUo37avxZ9kN/MUKdEQgVicIAPfT1kTJBsY2JCTYwDkeN9a2p9Zger7uACWz8r98ANwe7GpG10c4kjj2YPIPidtDOdtEtAntgTW1vCHxnUKOeF1o/IkEefX3dikzOUsMWVkQxR8yXxqlJImO4rZTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzTT5wRz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzTT5wRz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EE1DC4DDF9;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032804;
	bh=8PZHxLuGyB8p9W0SYpe0i7du47O6eKqMcp9201yCNyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DzTT5wRzYBXWDlBn26g3e0NbfDDjVKkZk7RPmRvM3fMxBzbipsMyj9Joa6NkwhX35
	 Kv/lwyU8y/aYf84FrayfUnDxRuVR7z0Y3FgJPhtNe1eM750IVOw5T8Wzvt6Lrki+Xa
	 6AVmg+XF6WhAggIBLXx8zubPgMq5Blcrwdwb6KlGk7tp+eT5c8uHM4s9QsnbKyP8Bj
	 yyThOrQ9cUbigApkDIwnCXbaWIv0x7Kqo9aWG7hkFMMDQq/MucVJsXuKggWUmm37TS
	 VH/q5piRrgmoPNukGjyOTYDxDas9InhIldL5m+BgEU/BIe6vdfuKP0MnhBoNnO6XHi
	 xr1eCPfzJ3xiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0899EC3DA58;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:24 +0300
Subject: [PATCH v11 20/38] dt-bindings: ata: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-ep93xx-v11-20-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032799; l=1576;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=6OKlqXkhYc1KxgobMqAou7XlLPWa3EvS+YST66zjGr4=;
 b=EGrk56MeDUOQ7Xi8UhIT/mZ9Ylakj3dZkMET8q+wTtytLWpVfv+upfG3coKdZWlqIjmnJKYzYqkJ
 4zFOJC9PApermgbmcVeIOsq7IWSyzauCu4SUs7k5hWKRRR8YAst+
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC PATA.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/ata/cirrus,ep9312-pata.yaml           | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
new file mode 100644
index 000000000000..8130923fdc72
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/cirrus,ep9312-pata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP9312 PATA controller
+
+maintainers:
+  - Damien Le Moal <dlemoal@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9312-pata
+      - items:
+          - const: cirrus,ep9315-pata
+          - const: cirrus,ep9312-pata
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    ide@800a0000 {
+        compatible = "cirrus,ep9312-pata";
+        reg = <0x800a0000 0x38>;
+        interrupt-parent = <&vic1>;
+        interrupts = <8>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&ide_default_pins>;
+    };

-- 
2.43.2


