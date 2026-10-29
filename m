Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309132;
	b=iDvD+nYX9PK8PHbXqvO1gGlSaUJ0WrBnCmeVz6DDQe3DcrYZE0SI5X1/ibdarHZifGMF
	 REcTYj6NoiCD6ssJ1ARZ6Yq5DH+OAFs+8FPh4RUtMt8yiFjJ4QcBvyzSmd0RD0NsD37tn
	 X0Db+ye9q+G9zXtLkLaXht5KObpBuU28Qr0ZrTut9aoynmIYk7FYZ/EFfqJexIsrYDUtG
	 QE/GWSDCzh5TBwU9/Zc9mFRQDNnfslcQtyKZ3mfPNVCn52y5rg+DZpiid9pbah5qzV/CQ
	 0S3EifvuswOyxusBnLDGBYQevN4+BogBMIAHWO3W9e4YBmUEDgEwpbHJOohtZAVDbuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309132;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=xItqMuf2hx/dI3+KyoiZy/IYYq4i2pAiSjeOl4VY+ro=;
	b=KEkNfGgRIJtXP6n0jHjwSCyQVskKbtL3MdGt6YNw/aQwdmNGQBxXU/1MGUwKTDF7kUcA
	 wQOaFcGQ//U7hpGJBEdDnSKhpj4RkEWJeukstL+AAt52fYAYyutJAZT++RfaPLxPqOG0Q
	 wGBPab9JpGWbt21tQQ6uPJ8LueYAsRCYDBG1tbwLR62/Li39Zzj+yfrYS8BYb+0tzu411
	 oiSo7r8TYVR/lWircoorq9xke/oRbG0Vb39QW6Q0wX30zwxt+EjuoTDQHsgvUIJ12LkMJ
	 jKAQUUoy3y8lQTbU0l0oyC5tngp72gZiB5V2E41uF2hTqDxmcmsQCRJONtuPxyiz95Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OTmWrP1k;
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C43606A326
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 21:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C43606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OTmWrP1k
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ea7987517aso619885ad.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309132; x=1793913932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xItqMuf2hx/dI3+KyoiZy/IYYq4i2pAiSjeOl4VY+ro=;
        b=ltP3dyYpKmqaiDpI8cKg/0F/9iCifHSSPFWtQN1Gh+M4/WrgWIJglfoLdLJk2LTO0N
         NsMMxvMSkXC8V/eHhxcOLM2muJIZNYCvQjouHyoDFYRVoMZaMmYFoSVSBxCr78IidLG9
         tcY64U3AdRHXGV1oCmWVCBitimoF02MxRxnbldQ2AQY1XQb9xHNbmR7SmcbqR75XSmmL
         b1b//SHN5bpw3WJ9OOUEW1227xjkI1vIXHg7koNzGpxVw1iw/KlouRhyGowYcUEfU8ir
         w2iAkQw2nvbNSyrTBQ8nXqcrPDw1Xg9cFDK1tmus086z9wwpKCSuq1VyEn4lcPXQXy8N
         3S3w==
X-Forwarded-Encrypted: i=1; AKwUvByRD6y1Wd2kcNvMdtYahxZfyMLZSaV1EnML6/Lwr9SxQkBkZMK1NjEM+Mkt/S8o6d+DI1J/pyaBx7I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7GiYeYVhEqMkdL330s3mzpGi+aDQ5w6FqJ3EThMoWXNiGhpgh
	V+XCvKYGb41/9vRvR1wAV42EAWMxQc+w3gwWfkXidG/H4yToClGY4Ytqdr3VPee+b1wfNgIzQsa
	IO6tXykOY+UF0MmAiHsyWYA5ym062OB39rq9Nry2YtJ44YY/RUzu4lvUZ2MI+go0XGATfmGnxtp
	1ityY/us7UcdnU25TPBf+tTa9yrxktIW06cVxfylHyPaKs7BpJX+a3zt2HIbkHwiUCkifJbtN51
	EAXz4YVrGfG5tVZWKgRMNo=
X-Gm-Gg: AYBFou2++FfLeMATyfZyQEOWg33LDJeelRhDeb1x8DokZg36pV/mx3lQ5v/WxbDB5rv
	gAvJV6MZlinxEErqxv9epNaerVLoAhjSELu8Igpvu6Ktd40kv74G9Ygm2dz8lVWHC5HqB8dZX+z
	OqGqaO5UNTw7ckvCDuwFb8g1mSZEjMc/dpc1r+YWy86B7TcNTa2KJjmvymOkHN0Kkt9VlL7AxK9
	PiyVoyhdxYW0fGaLNcQboljuqCXVXFIuurh4Ol4PEWPNRXfQjlH9B2cCDtq2J6fYzLb3Pa2uxyO
	QDHqsuelRk4YkQs/9OcnF1vuiRj8JjuQcYfPBMC+hTk+2nWZyytGizs5UB8LPAPk1rGnmlh+wPz
	KcjMlXodGpmacq1XYexA3GpbEZF2C4oLocq3ZOwi8JoJPq2+TLF081gXMdcQW7JtabnhqWyEKQ4
	t0VlNRU8S5b89DkwgEDUzrG7TCztk4puvT/bpyBKTs
X-Received: by 2002:a17:903:244c:b0:2e2:cc25:b232 with SMTP id d9443c01a7336-2eb364f3256mr5368555ad.42.1793309131636;
        Thu, 29 Oct 2026 14:25:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eb3694bc08sm136295ad.38.2026.10.29.14.25.31
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:25:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c75523074so1866656d6.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793309130; x=1793913930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xItqMuf2hx/dI3+KyoiZy/IYYq4i2pAiSjeOl4VY+ro=;
        b=OTmWrP1kjFm7yan0E7zpJBlaxh6277d6lG2JwP1CzTSOTp9K5HyT0238nwP4+7H9vv
         t7ClBnq2jOSJXstLYqyNXRKF57xxHVomWELO+8azNuZgSdgro2Lj0OQNl1YML+VD5Bor
         sklx1dFDgzRkQhJ7JrQLJG41kpF3xRySoCoeo=
X-Forwarded-Encrypted: i=1; AKwUvByD0DIe+Or27IMn82mrhsgE5NAF1p6hIxyZUpOjobZcBaLEx6XugHZ/a65mISUYuBU057Gxr4+Op2E=@vger.kernel.org
X-Received: by 2002:a05:620a:404d:b0:93e:c691:a1c with SMTP id af79cd13be357-94421850adbmr65335585a.76.1793309130083;
        Thu, 29 Oct 2026 14:25:30 -0700 (PDT)
X-Received: by 2002:a05:620a:404d:b0:93e:c691:a1c with SMTP id af79cd13be357-94421850adbmr65332385a.76.1793309129450;
        Thu, 29 Oct 2026 14:25:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca314fb6csm6384936d6.34.2026.10.29.14.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:28 -0700 (PDT)
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
Subject: [PATCH v4 2/6] dt-bindings: ata: sata-brcm: Describe the NSP IDM registers
Date: Thu, 29 Oct 2026 14:25:09 -0700
Message-ID: <20261029212513.4126083-3-florian.fainelli@broadcom.com>
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

Northstar Plus uses the SATA IDM block to enable the interface clock and
deassert the core reset before accessing the controller registers.

Allow an optional third register region named "idm" for the NSP
controller. Keep other compatibles limited to their existing two
register regions and allow older NSP descriptions without the IDM.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../bindings/ata/brcm,sata-brcm.yaml          | 57 ++++++++++++-------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
index fe7f091e744f..9a48f7e36fcd 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
@@ -13,9 +13,6 @@ description:
 maintainers:
   - Florian Fainelli <f.fainelli@gmail.com>
 
-allOf:
-  - $ref: ahci-common.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -30,32 +27,19 @@ properties:
           - const: brcm,bcm-nsp-ahci
 
   reg:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   reg-names:
+    minItems: 2
     items:
       - const: ahci
       - const: top-ctrl
+      - const: idm
 
   interrupts:
     maxItems: 1
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - brcm,bcm7216-ahci
-          - brcm,bcm63138-ahci
-then:
-  properties:
-    resets:
-      maxItems: 1
-    reset-names:
-      enum:
-        - rescal
-        - ahci
-
 required:
   - compatible
   - reg
@@ -63,6 +47,39 @@ required:
   - "#address-cells"
   - "#size-cells"
 
+allOf:
+  - $ref: ahci-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm-nsp-ahci
+    then:
+      properties:
+        reg:
+          description: AHCI, top control and optional IDM register regions
+    else:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm7216-ahci
+              - brcm,bcm63138-ahci
+    then:
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          enum:
+            - rescal
+            - ahci
+
 unevaluatedProperties: false
 
 examples:
-- 
2.53.0

