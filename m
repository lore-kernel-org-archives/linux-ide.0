Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.144.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601765;
	b=yyKd4ifzGdBM7OQQp0Md9Bc5cSE+9YAjRU15Kv2kpsfKCuX9N+D5KckRhXgG3sACYqYF
	 Xn7G5iN3CEM/GHG1wJg19F3JjVeAV92boIDKCo7LWcrRHFVvp6B9j/PPyaywUYF9Q+/fh
	 63RrDVrIFZ9MyDqLx/B48Gk87IuGy0F+yjqCkjW9o1AG6UhCRtnBSsYTDUgdi0SyVBFjp
	 XfBXEpAOGNs8Ga+vkw+WjmwiOuSSIDwVzfmHP7AXRe61pSHh6iqRo46+39wyJ3zsN1s8+
	 gjEazov0yRlhwFbOBrWmvw4uLoylROk2tlTN9o5zd8TvWYMtFgWu4Eb5F/KRXGHsnvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601765;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MA5/QmONgwci+C4pVkhkGywYbmpIkNjdx6wsVgaOess=;
	b=ejPEFkD7P8YaY/pyhkEdiisCcqfZxb7t+YTupwectChHl5fokjLL1lfo63WoPnRCA3fb
	 uRqft8s3+DTeW4ql7sxcfhfGByrAiSMMRugOtGyp+ORJYo36Sn93/QmYy/4Hk6yZYNswD
	 qVeU+KbEdYpZaK+OB/cyyOSeZFPCV3o5pWW1wZy+dDMRTg5gZXvPQ9jg74S/4UUpK0jzp
	 Aobh/UofJJ1Xvm22QN2AGeFcww2NZRkZU2nL4Bo/sNi3bSB2kTbJVyfBcBGNQjiNDE+JP
	 44SYqfPAtRbOOclGAVFb3cgYU9LjnBakI/VV7naUMo4Lamxpxs0l+04RVTSLPgzyNJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=v7AAwuBm;
	arc=none smtp.remote-ip=192.19.144.207
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2238606A31D;
	Wed, 21 Oct 2026 16:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2238606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=v7AAwuBm
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D2007C0003DB;
	Wed, 21 Oct 2026 09:55:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D2007C0003DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792601757;
	bh=6GVZPRc9hzQNk3V64aFR1Va8z9AJdDTLhbLObj4P9jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v7AAwuBmrrv1JszE6sazLQhzW7YtLMFF5SbJBVr65RYo9cGwB6P5dWuBOarGfADey
	 rpiuFNV8C1WlIQ4f+yhhQw1Mmu4XnxBGOVz5qktjeBg3btdEchI9PeOdb07g30LuJh
	 O22W8K4GYabWfuORcRIISekdHOjyFfqJjiOzTTRA=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 69CADA8A;
	Wed, 21 Oct 2026 09:55:57 -0700 (PDT)
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
Subject: [PATCH 2/6] dt-bindings: ata: sata-brcm: Describe the NSP IDM registers
Date: Wed, 21 Oct 2026 09:55:49 -0700
Message-ID: <20261021165555.652102-3-florian.fainelli@broadcom.com>
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

Northstar Plus uses the SATA IDM block to enable the interface clock and
deassert the core reset before accessing the controller registers.

Allow an optional third register region named "idm" for the NSP
controller. Keep other compatibles limited to their existing two
register regions and allow older NSP descriptions without the IDM.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../bindings/ata/brcm,sata-brcm.yaml          | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
index fe7f091e744f..98529784b1fa 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
@@ -15,6 +15,21 @@ maintainers:
 
 allOf:
   - $ref: ahci-common.yaml#
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
 
 properties:
   compatible:
@@ -30,12 +45,15 @@ properties:
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
-- 
2.53.0

