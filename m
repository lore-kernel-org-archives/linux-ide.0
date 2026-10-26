Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042290;
	b=3QqBMlzlLKJ90lARniUXjIujpiXy33hc4xp5Wc+HC9eBL9h6MLbBEhTLd8pKIztaoaL+
	 ZhzrK4/6OhX5gEQ7/WaP6lw2Vi3u9wreTZxfYGYuJ5ooO8M7yYbMP5ZtK4nrsus6tiTB4
	 igud4Bi40AfItKAtXPqOkJxcqP6GKIdzL3oXMbw+BQm/9t+SzMBjZDn86KZi60QguK2Eq
	 OELs7KMQY//XnIMIa8LhDNbMCuyzBceYQdb0W/b5u6eK4Dc7RmMTqmVAXK3NL5aCGD77C
	 oYn7B0mjJ/fOFGjobWB6cjvM93KIw0qdOgB5tlKhnZV39UMGjo0623SkpAdNE9HIqUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042290;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=MA5/QmONgwci+C4pVkhkGywYbmpIkNjdx6wsVgaOess=;
	b=LPRP1KGgOcvdUi5Y68lChWp7wrPDqetEhHHYBro1J8HzX91uZF5hFOlNonLN009vBnf4
	 2JE5CwXOlB/IuASOzwb4EfbKsgdBEXNhxDh1xIBfOYub9StbBwZN05XQRXW4NlNEdA9PS
	 kQ1lfXc/6Kou3kbKLkQiKmwGhUIESh40/4VOK9Ty6Sk5/bih6ZYi/NJA7wTIq8NjeJD6L
	 FP1JTB2o9muF08+M1w97CmHiwI5NM8GEU/Kh7noccBU1+tvkx/BjGuImpCWjr4+hVbeDv
	 xbtP96HtyeqGKjScxnFUFOdU3Ncli4UAtOiMd7Swb4SOcUv+vSUk+X/egT2hDOB/Tdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Gxvak8Yy;
	arc=none smtp.remote-ip=209.85.222.226
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A351606A32A
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 19:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A351606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Gxvak8Yy
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-93ece7a73b9so434572585a.3
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042288; x=1793647088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MA5/QmONgwci+C4pVkhkGywYbmpIkNjdx6wsVgaOess=;
        b=QUihfL8FVWv1flXE1kY9+iGOSFaNc4LLOfZc2fshr656qzXSTDS2IuS/JD5zmxRneP
         sEJqF+1tgWOgLDE8+/zaHBxQZITVShVNTvStD052gk4KxvnISSXcSSqxKaxWV+9hYVhR
         kVaZLYnhHqGaIyCwzEwFFyCIuEfevs/k2i25PIwp60eX1o/uVf9iSBcGmbmaiQF45OEL
         VXBujN4wtcprjamA6TSQkmauksZQ8RSFOHC0cSResToOt9eppZ1vFa2ei2s/izPUEsyH
         yDoVBT5yOFtbOlw5byQSuPKU+UpvtOcHj1QtM5kPK2hdALKecYD3dnEsauNI76OIzwPr
         0PRw==
X-Forwarded-Encrypted: i=1; AKwUvBxENR/AqAi4lUoRkqC7jAiqOwPi/OrKdie6aDSEizhtG2yBWr5vAkz9K63K1LzHUm4t2z/z8cTWgfE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjdmGL83cQK2UboSTf06xOHvl8a+6imaQjoVL4PULpBsDB1Uy2
	uzDj32Sw9coKTEDZcf6/Dp4WvqveYpuKnD4GaSPTAy8+7162eqWApx+kcT8/6ImwIH470dkRS53
	DGmOmLaRagdMaRFItqhGNCpqwTONeXeR973y0S3n0duIDVp9VKDwFWd5MhnVQr3/nr2PnC8ycbC
	LJVinikpcmi8+W/c3xrrzNT56/lih7rMUWlaiElovgZTSG/oj0FaJShfb8MjRRFloamWEFdMtkX
	JjGMCaNaUBGDYhB0bDElQI=
X-Gm-Gg: AYBFou1Bp/Fc5EQ/MJLg9nVgONchJjqMbi94xW463a/hF6Es5V8tMlatsEtPo/IOg7j
	xWKtx2DcrEPddvk7e60Mp8QXWHWYMM+zDYp2L7N6+W9huWZdvmWkwTcvJX/6C/ssgtqCqq76qhE
	OpqnQDZSgP0c9M7yknY3ZK+Lu3whgOiyIdA2drMlFzdpeYndCaIanXSxa2EN7lF6NZwmsZwFj3d
	qmhsbxt8yDG1NPm1oApcUxUoghfkstSV5AL0ESQY0gMRlvMQ/A8JXaxHD2w04+Qj3wJOHb9D5HJ
	aC9SKJjSqP5R+OKlr4vzDGn+N3X5CD9gvOoVI6fg91sRMAGKNQCKhBSiV+4nhO0TA6c2a7vkPdX
	shjvniUqfUV9J7+pz3T3Ft1Q2u73qjJthcCdcF6sQH1b+KI/TEwGbjcy2SMNnOnLqJmp+dXSY6t
	kbiJfZeISuh6VX2BkPdhyVbXwcOplxgw2ECCm46Xy6
X-Received: by 2002:a05:620a:4153:b0:93e:c12c:f13a with SMTP id af79cd13be357-940ef930073mr1180548485a.68.1793042288066;
        Mon, 26 Oct 2026 12:18:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-940f0a77169sm118020185a.18.2026.10.26.12.18.07
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:18:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91bcd0247edso39078796d6.0
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793042287; x=1793647087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MA5/QmONgwci+C4pVkhkGywYbmpIkNjdx6wsVgaOess=;
        b=Gxvak8Yyx5pIICvm7yrCD9e43FZdm2i6wKYuAyzHsTZaz/opfCV15pPrDJqqvzIxb3
         EGLVGpYTnSBrlufLuRjbNW8fmqp9BQHcdjv3C/QvZC68ggXNAA4R+XZk+SMK1JsppO3r
         miqZV+cXpcnFBukKpJEb3JcMicF2khkPWBKYg=
X-Forwarded-Encrypted: i=1; AKwUvByZhEFkQqQzObYiC2w4MGoWAm7cWtR0t96nsckWQJip6uO2/VjIsSb8DyFfUAfRzHDQLTxx3Lj/Azk=@vger.kernel.org
X-Received: by 2002:ad4:5f48:0:b0:91c:6983:8012 with SMTP id 6a1803df08f44-91c69839846mr35564756d6.4.1793042287073;
        Mon, 26 Oct 2026 12:18:07 -0700 (PDT)
X-Received: by 2002:ad4:5f48:0:b0:91c:6983:8012 with SMTP id 6a1803df08f44-91c69839846mr35564286d6.4.1793042286610;
        Mon, 26 Oct 2026 12:18:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c62063dacsm33430996d6.37.2026.10.26.12.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:18:05 -0700 (PDT)
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
Subject: [PATCH v3 2/6] dt-bindings: ata: sata-brcm: Describe the NSP IDM registers
Date: Mon, 26 Oct 2026 12:16:14 -0700
Message-ID: <20261026191618.3178830-3-florian.fainelli@broadcom.com>
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

