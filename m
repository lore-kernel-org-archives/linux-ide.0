Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF27D194A60;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617104; cv=none; b=YqWze0D1doeEtBc1RJ9JpXIvyn596D7oQsBrO6Z95eXdQUW2Dy0HMayXiS4vrMr2sJwrEeadXJp49nJaoaifo4L6/6s2E7LhXD0xbQxzRRNXLDq0OTOZKgrngjIiCpoGbzSIvWwZweO5We0igzUlKEgXGOUqyQyMGIGTkWZMe20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617104; c=relaxed/simple;
	bh=8PZHxLuGyB8p9W0SYpe0i7du47O6eKqMcp9201yCNyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDwT/gjizt9wU43pMyqFfzY4qNlGTsYJxfgIMJUbS0IO8Iu6v66hcFowRdjtrUwG4vp6I+tufRPPVSGoZ+SXi99vLS4jVrb5v52d5HcFJ7K2xIgOGiAx6Usf/4EfCP5pJohsFYDh0n5BZ0Co4ShsWPubTHGh0LBoKg93Rh3qkKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbyWIj5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbyWIj5I"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B071FC2BD10;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718617104;
	bh=8PZHxLuGyB8p9W0SYpe0i7du47O6eKqMcp9201yCNyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XbyWIj5I+ABsudzfJXyMvjhzkKOtJqY7sWo5+WT+DITtRFZRetsV1KiGC3V8b4jIX
	 dHu0KTvT2VnjvX4wkOCXL0Ra0f8B+lxOFRn6+LLcq6y+sDQEUugTm1KCdaTsqhD9C9
	 M3ScbeZ7G2np/uvShmvqwptgmq+yACIfu8gNMm3+4VVAvUrhy8EyT1KSJjMwhiejsz
	 6UhEr58eXoTrXNMZChhACxBo2BmlgJS3FqiaW37y3TUAzLKD3dZgCy7GmBiFWsDF1K
	 grgEWf6YoRXTfC0qsiUaFuFHMk6m4n1ieRttho/MZ6ebuq9P9Nno/3SBEoWw4RKJmu
	 ZRjcHA1971epQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B72C27C7B;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 17 Jun 2024 12:36:54 +0300
Subject: [PATCH v10 20/38] dt-bindings: ata: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-ep93xx-v10-20-662e640ed811@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718617100; l=1576;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=6OKlqXkhYc1KxgobMqAou7XlLPWa3EvS+YST66zjGr4=;
 b=bg2kUDz6lKzFAGC3+6IfrSyywzwZyOMJmJje6uR9YGnvnZUxHQ9qkgcoyDCsCbYpcU4LfE/kno67
 9N5+xCVmC5XQGRfBxVPmxjL5KNlwIs41S0vTPA1DuWpMVZDDG7Y5
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


