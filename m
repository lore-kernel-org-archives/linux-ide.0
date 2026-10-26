Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039370;
	b=2VV18GOYDcPUlq8qgYnMEXiWqQ+3ORcDizvdXCjrnpv80TDhkQed7dR9ZrS9HPIKiGXZ
	 Kulo/fPAhK3ectdEg+7TgEgU3qk6ZmrAU6JLoRyF3a9AEdDP0tw5Xl8kLX9he0MeyWwFz
	 EjJwI7vmjPx2l1v/Ednck7AW+ERM9UiS+kd4Cfw2N1FpDKcixzW4uby3YF8GVtcwsiTUN
	 XXyFdw2ZEQjdxe811aXVuOCuGyX/AzmHcom5ewQ2WAvhOglvvYxOiTCbxpMlV+L1DyeEN
	 KBUUFoSgLTHNzXj0arRG5ZfQDgpY1sADeQf2AyeVKbmaoJMCEYQnS2Zet/VecluT+7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039370;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=MA5/QmONgwci+C4pVkhkGywYbmpIkNjdx6wsVgaOess=;
	b=SBA2i+0c16jnAnOBx9MT7R1A1Z8QOT1m5Ur8i/0rPyDhEbysDhZSHcG0wzQ80WZsRSpi
	 wYaa+1oMmzNFy+AUA63VpYJJCvt2oB56mTO+TeyyQm9ltT/iYdw469SZa1Jx7K7yAxFP9
	 NUYp5y2amv7IBul48+xTgPt1Ww+XPFTGx6Nj3g4SbGpjfn7UhnGVi5zgngsN4AVpZ0ng1
	 niygPmc2ZaocMQvgLLrjRhyD7EvCZQklJycT6KRLfUIaCmMcxci0w7Z/+S8a6W7cgXomN
	 64/oLtHu6Dsa2+Fi1IO02DzDktKfY8x5mScDQF6aVKQz7GfCr9pPNN8F4wUElOxzwyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="MUU4/c29";
	arc=none smtp.remote-ip=209.85.210.97
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417E606A328
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 18:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2417E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MUU4/c29
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-81ba09a5d23so4597110a34.3
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039369; x=1793644169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MA5/QmONgwci+C4pVkhkGywYbmpIkNjdx6wsVgaOess=;
        b=i/rN7ppD0mpLv3pVczyd+053svXQ4zHIug+HGw+qEw/WpWSouVliu5ZN5dMFpWzofj
         Thxb7e9xGLxu3OlfnJo0u52s8Ddf/1lrjnSGfjXAAltCNYhZuwIaMpDCJplBnBqE4r6D
         OG2mccQN6yRL/7z7Da4dWYaLpjxaC29dNDxx8RmxQ2hKwg42uIx6WHNj55gCNaaWdRk2
         kmDyVYq5h82bfYX5NcaYLQQGLEPTKO0+RvT76HDC/eGXn4HcUT4k6qGMld9qg94dHKOy
         Ua/9ggj77bFYwyb8mLLwvlhU7xyhhv36lP31DbC/fkAthsZ7xpgapsk4UwAbqPd/5ADb
         C3LQ==
X-Forwarded-Encrypted: i=1; AKwUvByrR+bgakjeJU/4oL72tpS63GvQdm3EoW4TkArG5DDqVe8vPK3D09+zGeC4nuA43oak4nIsSifnkm4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrM/u1fzeFdMRXs0st+/w5PKAtTmmwkJ06T7xiHmjlI/VV8iox
	hgWzYLZ/hXxhzVF9AUj2T8M9fNN9+aGwaAvfbRlAZr6Iyl1O9AirICh7AeHIu9XY9uw6RWDDK42
	cgr4JKA//L4as2I5rsouz2ITNXoOyC6/nZD6ngi5IREyuNHjZEhwSrHV/Z3gBw0w6nK5A/fVgWv
	YJTN+PtYQZxSO7qozotNqWxPW6aJbWxQj/XhEgYOLSWztWyM2lfU6SQbGDPVM/YKZ4DgUytcbFZ
	tOiG86vMV5J5pi1WQzm3G4=
X-Gm-Gg: AYBFou2uz+TDjM6vuMipnkSQVo8yzPwTStOHHMTj01vmPS2nR3VpjLp8TscT9UCrwfI
	9UieDwaPLoEF0NnO0pXdaqhhPpAJ8zEs/Mp2uz4pfDszR0r1OD8wMdU+fOi1ha667VZk4IxMbNc
	9mDEe21v8l9JlKao8/bMu98WLd9Ghmec+yKISeXvoBGkWQJRgedafPBNVPG0DKZwoXGhNj1gwH0
	fm7FKvgQrCIGnRdLni3vzpxFg7ae5HOSNM9hmRbw5rZyGia/GhP2ii4delk1BVPCtAGeB6XrtWh
	ZE1el3xDxKFcmGmh0AKgKeC3yeev5y/8iJVs1f+aJRTdY3YOy7jY/byM11xVp4hgebVLP6aalYX
	lqa9cmzp/4IOva6Dge4AOMDGGaNAl2pXSq1QdTdomBJ33sW4hDKsnR0ChkGvgxhLiuns9nJQujB
	us/cjSEfe3Yp0ZJMy1H3fn8NfKUoGpGEyrCma7PjEiqj8=
X-Received: by 2002:a05:6830:929:b0:81d:8057:9b7f with SMTP id 46e09a7af769-850ff7771a3mr5312653a34.28.1793039368987;
        Mon, 26 Oct 2026 11:29:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-850fb64d0a9sm75580a34.17.2026.10.26.11.29.28
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:29:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510d0baf63so9419432eec.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793039367; x=1793644167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MA5/QmONgwci+C4pVkhkGywYbmpIkNjdx6wsVgaOess=;
        b=MUU4/c29HqY8EX3beDgF2bM8mqMCuEwDUnaXImyYV5Dwq67/IiP2H4TlXWhDCnQc3H
         iyvMQgxJi1i1U2i/xss5I3MDw8RHv+u54ijs1u+OCgKtPgfNW/Qfj2e3+1AW6ysWo1Rb
         yS8JhtTvGSpBrWdbWMGF8Bq/I9kHb4dZ9WCjc=
X-Forwarded-Encrypted: i=1; AKwUvBxCLmIxm1088fy/OuLhzkRXxl/MczTtdsOHt3BET1fCBKS74zuWAxxnWBfDu0eOyPv5AcnvYirpamM=@vger.kernel.org
X-Received: by 2002:a05:7301:fa2:b0:34b:5ab2:e200 with SMTP id 5a478bee46e88-369e8455879mr10320918eec.14.1793039367391;
        Mon, 26 Oct 2026 11:29:27 -0700 (PDT)
X-Received: by 2002:a05:7301:fa2:b0:34b:5ab2:e200 with SMTP id 5a478bee46e88-369e8455879mr10320869eec.14.1793039366691;
        Mon, 26 Oct 2026 11:29:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm24657259eec.21.2026.10.26.11.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:29:26 -0700 (PDT)
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
Subject: [PATCH v2 2/6] dt-bindings: ata: sata-brcm: Describe the NSP IDM registers
Date: Mon, 26 Oct 2026 11:28:52 -0700
Message-ID: <20261026182856.3168686-3-florian.fainelli@broadcom.com>
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

