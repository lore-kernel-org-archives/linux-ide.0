Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9991991A4
	for <linux-ide@vger.kernel.org>; Tue, 16 Jul 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127253; cv=none; b=e4rnDilJm4xa526Dg/pOsOYTUgGamMkVlvLAqEqPD5dVToFtzR5eAoJPrO/bJHNDIgpGaW2Ceyg9ITEkooycymTQ3fJPWLhcmt7uGk+DUm0DooZS0OA35iwUu4oUVOaTYZK4LwmY2qR4NB+FiinTPchVJjfIFcjoosgsoc/KN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127253; c=relaxed/simple;
	bh=AxX7wCkkfOj42QI7vsWajUNUXVUkZbWsJaH69GKrKh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmpKlg+U3H6Cmy466RQ8UqhuH7NuEubZf8KwlWBBvBhHXR7d/ADTI0Dt6ejpsLPU/9TzK9NsXeGiOAucrFtW/AyK08qF4YUxqoehFVFtULz+/BD4MkFjXwNTYqWE2a/5sBTIwFG04uOPUcW8qSRveL+xT4f1rXHah5+P9IAYyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QOIe+j4i; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOIe+j4i"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4279c10a40eso34101185e9.3
        for <linux-ide@vger.kernel.org>; Tue, 16 Jul 2024 03:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721127250; x=1721732050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q+vCguQf3NUUbSEhJNStzM73J6osU7HD6N++I0+lqQ=;
        b=QOIe+j4iAQRkbZsfJSAwQmuOEUSy9+yxy5yeoPVYeYGug54ETMs85nZ1w7aXQECGP1
         1fuOuA0usZZ5mojOB/w4ux6COxUs2H6ObCAfCZ+zEtOli6/GBf2CdmdJvCdsyT88XOuL
         INhk32lR8qPIrmION8tO9eipy/2HsV3/tHc2Hv4mNymNa2ni+7iG4R3a7hF81hehMJ+y
         OXcG/QrJXymAKW9bLHIiuYhHrWPVOkm+PPRcLnT3rs/WQWTAtRYhvnUZFIzWXudU9Yc2
         fU0inutXenNdVnCYgxmPHl6dlKtDGVM9I2SFB9OlBOPX8BRhEL4rn1oloC1mcq7nMuXD
         QQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127250; x=1721732050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/q+vCguQf3NUUbSEhJNStzM73J6osU7HD6N++I0+lqQ=;
        b=ExogeAEYU0eEMnM7Uo4IfBioJCcpFLeo0ll0W9V5QUAannohZd7mpo6oBV1ITDm3in
         XmdJEUA4pTCCiK1OVwxPNhvGb9Y8ddtguiblTmp+ReDnGXEDyeTG1rKwUb4cXKSLp2gu
         icZyCjnyj2dUlswbBh5PbXwpZWpIesjB3zWebJGcXHFlbONjrpTPva/qrM+SD8BVXQq1
         uIB7ZfW/D5qdP2u+AcMJqM/Ybd4R7xW6okQ/mf3TjAimvXWBpNkD4L+IinSvIsUBUGiB
         1rRVWlaXoJenZCp4g3EZNuKkU2jS96m9H8hXNMsSdQk/IM8ZBmwdYkUx7alE5DWlBvAw
         BTTg==
X-Forwarded-Encrypted: i=1; AJvYcCV9gIJtXHaSLcPgtg2guZdAXjat/Y/Iv24mhhUwCh2Ca25XHuBtq7KL/0FQTp0vnQ5eWm9fFy04LSx/FR/o6nPU/BvhZsd+TiFd
X-Gm-Message-State: AOJu0YzTKjGokie427FIzo7j4aMaIyOPOBQVT1RK/OUPLvgZ2yH6N47/
	AnumVyMCGsS9G/Mue7lqBVg6m5G4PakwdE1JATUjDZMAWjJbjnqatwmsEmEPrBo=
X-Google-Smtp-Source: AGHT+IEhjOcGQEmu3Anam4Iq8+f5K76T83y06jbOta7ND04zwcw7VGC98aRFKAmunjQoyid33YORuA==
X-Received: by 2002:adf:b30c:0:b0:367:8fbc:8892 with SMTP id ffacd0b85a97d-36826316853mr1075117f8f.44.1721127250680;
        Tue, 16 Jul 2024 03:54:10 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccbafsm8608295f8f.51.2024.07.16.03.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:54:10 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 2/3] dt-bindings: ata: qcom,ipq806x-ahci: use dtschema
Date: Tue, 16 Jul 2024 11:46:00 +0100
Message-ID: <20240716105245.49549-3-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716105245.49549-1-rayyan.ansari@linaro.org>
References: <20240716105245.49549-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove old text bindings and add ipq806x AHCI compatible to
ahci-common.yaml, as well as its required properties.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 .../bindings/ata/ahci-platform.yaml           | 39 ++++++++++++++-
 .../devicetree/bindings/ata/qcom-sata.txt     | 48 -------------------
 2 files changed, 37 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/qcom-sata.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index 358617115bb8..b103d2c44421 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -30,6 +30,7 @@ select:
           - marvell,armada-3700-ahci
           - marvell,armada-8k-ahci
           - marvell,berlin2q-ahci
+          - qcom,ipq806x-ahci
           - socionext,uniphier-pro4-ahci
           - socionext,uniphier-pxs2-ahci
           - socionext,uniphier-pxs3-ahci
@@ -45,6 +46,7 @@ properties:
               - marvell,armada-8k-ahci
               - marvell,berlin2-ahci
               - marvell,berlin2q-ahci
+              - qcom,ipq806x-ahci
               - socionext,uniphier-pro4-ahci
               - socionext,uniphier-pxs2-ahci
               - socionext,uniphier-pxs3-ahci
@@ -64,11 +66,11 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 3
+    maxItems: 5
 
   clock-names:
     minItems: 1
-    maxItems: 3
+    maxItems: 5
 
   interrupts:
     maxItems: 1
@@ -97,6 +99,39 @@ required:
 
 allOf:
   - $ref: ahci-common.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq806x-ahci
+    then:
+      properties:
+        clocks:
+          minItems: 5
+        clock-names:
+          items:
+            - const: slave_iface
+            - const: iface
+            - const: core
+            - const: rxoob
+            - const: pmalive
+        assigned-clocks:
+          minItems: 2
+          maxItems: 2
+        assigned-clock-rates:
+          items:
+            - const: 100000000
+            - const: 100000000
+      required:
+        - phys
+        - phy-names
+        - clocks
+        - clock-names
+        - assigned-clocks
+        - assigned-clock-rates
+
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/ata/qcom-sata.txt b/Documentation/devicetree/bindings/ata/qcom-sata.txt
deleted file mode 100644
index 094de91cd9fd..000000000000
--- a/Documentation/devicetree/bindings/ata/qcom-sata.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* Qualcomm AHCI SATA Controller
-
-SATA nodes are defined to describe on-chip Serial ATA controllers.
-Each SATA controller should have its own node.
-
-Required properties:
-- compatible		: compatible list, must contain "generic-ahci"
-- interrupts		: <interrupt mapping for SATA IRQ>
-- reg			: <registers mapping>
-- phys			: Must contain exactly one entry as specified
-			  in phy-bindings.txt
-- phy-names		: Must be "sata-phy"
-
-Required properties for "qcom,ipq806x-ahci" compatible:
-- clocks		: Must contain an entry for each entry in clock-names.
-- clock-names		: Shall be:
-				"slave_iface" - Fabric port AHB clock for SATA
-				"iface" - AHB clock
-				"core" - core clock
-				"rxoob" - RX out-of-band clock
-				"pmalive" - Power Module Alive clock
-- assigned-clocks	: Shall be:
-				SATA_RXOOB_CLK
-				SATA_PMALIVE_CLK
-- assigned-clock-rates	: Shall be:
-				100Mhz (100000000) for SATA_RXOOB_CLK
-				100Mhz (100000000) for SATA_PMALIVE_CLK
-
-Example:
-	sata@29000000 {
-		compatible = "qcom,ipq806x-ahci", "generic-ahci";
-		reg = <0x29000000 0x180>;
-
-		interrupts = <0 209 0x0>;
-
-		clocks = <&gcc SFAB_SATA_S_H_CLK>,
-			 <&gcc SATA_H_CLK>,
-			 <&gcc SATA_A_CLK>,
-			 <&gcc SATA_RXOOB_CLK>,
-			 <&gcc SATA_PMALIVE_CLK>;
-		clock-names = "slave_iface", "iface", "core",
-				"rxoob", "pmalive";
-		assigned-clocks = <&gcc SATA_RXOOB_CLK>, <&gcc SATA_PMALIVE_CLK>;
-		assigned-clock-rates = <100000000>, <100000000>;
-
-		phys = <&sata_phy>;
-		phy-names = "sata-phy";
-	};
-- 
2.45.2

