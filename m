Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042304;
	b=TsYbIP2gl8yN4ac6owePKcWQKKcU+iHst5aP1Jj5Y6cKU6aBRiMM0Dl1FnWMTIK93YdP
	 J2a0y8rISyEGgoNvb2V6FlMjoHMwh7KZzruSFgWmlKfL/Uo2vm+2S95OTb7vqIcclFr+K
	 nAHdAl2eoDgxPcD+9nddjPT9FwRkzuouxK1gmCY6Q+8Jx0fGLtEBs1uKrvr5b11UOSOXI
	 GX7QtOIu0EgXo7eGnKqe56kmyZq2YK85/atAI8yI7tws6GMkzXWBn6IjlFnyj5KNT9BI8
	 NpGxd+YLamZuumNXD30pa3tENP0jo6xU3Er+AtWWnt2XL04LSofhJquxN/cIckiOcTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042304;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=p/JejeyXs+a2BV9S3GP+DdWRq7anNloDPZ8ebf8LoQg=;
	b=AUveIePiCvR4FKEJ4ylpbGYH77RqMeqdEtdj/FAnvSiDgRClA19DRRMa5GzNCgmtlAla
	 Wae1d43XWkakbCNAiLnIxIsbCLmAvowVjnllYHMfAxNwosECxYUrOWUePaNyASFSjpq+X
	 b97azP4uazC99NK8nGANk7DqELVJAPdoeYViFm/B3eU0EcGcuoraN0wkoyc4MvScYPYUv
	 mGh+1LtF/lkpeJhql/4VTl8AaQWwqd51nQo7PkwXo2ZCf6VOWnBjCC1ei2mdQ44uLZqpQ
	 Y8bbvOMrm+0jBqM5MDI4kY7DtFlriFwM7sVp4WLCBmBW+tmBZtdbQLZ/PwbLAoPPaxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=XcvYzirK;
	arc=none smtp.remote-ip=209.85.210.98
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED27606A332
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 19:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ED27606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=XcvYzirK
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-84d5e56f876so2251014a34.3
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042303; x=1793647103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/JejeyXs+a2BV9S3GP+DdWRq7anNloDPZ8ebf8LoQg=;
        b=LW45JVqrPykejPogN1fAa6UjbChe4FyraDOQtJo44X+LafcMu3SdEN4FRyJtZDGSxI
         m1HsHX9+TNiu0jbN76M0/4UVRGVWwDQGghRKeqIGbkX5R7pgdXADDlxo4/XzqHTteJE/
         4b4Nx8TIzRJfzk5Qbes7ZnexpdkcDfKo9o2l9Sv4KiP/fl2aBejqgTy9DUWiUdefNo/k
         ao3Iz6YliMwX2Mn2xqeGzqOPjyS/51G5FbTlsN19dfQzCHG55Rey8XLRCA6NF3/7fMV8
         NejAIGXp5l5w0Jsdaf2oeyNEVBI5fxy8Bx0hSAsa7aJY7G4aMoltHovUu0RgaFFqJv9z
         6TDA==
X-Forwarded-Encrypted: i=1; AKwUvByfpUbqKQS49ZSvF8CL2RntnLrYg5/l7zSCBwQW8IrHS9RjxqWVG9LtNJ0dYXmxcsbTJNeZ2FbML/0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMYpe5SNryqFhvqMJbIaPnKOlYDdjtUiko4ScIL781gCrefHBJ
	wSy8lajELu34QflWDVjLg+YEFJQE5sD04z7AgMEPmKmBCT8WDwrtkf0FvrL6C4LYq7oOOVVZ//7
	dF++f+3AfVmh+gzn9uIPTxZOc4a6REdPZ4TSTX7pt7tgBlbDVp6Bz1NqT4/38HN+xab88xNiTGC
	4GfmB8D0s6oRnWt6SjLyQdQWk7QKbPsWdNwhlAXyuksUKhDY7remM99JgjHPG9mrc5TOEK4oUEO
	wMr3gLwktP+LjKExOjXjgk=
X-Gm-Gg: AYBFou2gJhWKtwCm8bkVTbHh+5E16GxfATf86i7SYTf5JB60ZcmOW6KjDxPmbXBOYGC
	DvIHGtwn7I61Xymg35xWFFLHl6UBpSTzZs04Phhmi5bFA/BL1+lSjZA3ObB2JHebrI5J2xN+NEw
	Gy4u0IgMkYjhYivY8k7dmhar+W7FO3nh9iMPRprWeN7CC06keDMfaHvInWKRfkWdhR/BphaJAQe
	39zG5dzbIg9xAnXUvPkyyJcXzYVx9Osx4aXR2srd5MWWh/M5YpA4vHqXXTMI7fhFAIH036lTkKP
	jf36Iwg4g3uskgR9S3+1S3JdRzIJSrYBii8tt+vyKrqAi+zCIDtN8amcweJuOv7bG0cb3kdEigK
	Jy7EwJ2EtpaNGaXvBVsO+gKV0P8w90W+kmje1N2KwPBzxxrLDqrdtQwWD4eFCXp3Arq19DRHmF0
	W1WA1OvFJMpdCJSH8fEFc9GpNDp8E3S+PfPx3BRF8Z
X-Received: by 2002:a05:6830:915:b0:826:b77:adef with SMTP id 46e09a7af769-850fe3ff51emr5434315a34.14.1793042303340;
        Mon, 26 Oct 2026 12:18:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-850fa4af679sm82629a34.4.2026.10.26.12.18.22
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:18:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-533928ef33aso41733861cf.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793042301; x=1793647101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/JejeyXs+a2BV9S3GP+DdWRq7anNloDPZ8ebf8LoQg=;
        b=XcvYzirKIjhjXk7bY8SwlMQKMqHjStk5+OICSrg8oX430GEdJLZeslTRrN5lZDvDiI
         z3ePH4/DqX5EaDMarzx1kAp73rs/bDKaBVX+bC8QzD4uUfYCZwkHlQyRC3Nv+l5D+Zh/
         Ti39SaROwdMLy2FTYegApSxhAMih0sTfsDTfs=
X-Forwarded-Encrypted: i=1; AKwUvBy3VNYEdtua5gkoFAWPJwLdNF8VgDqHcpQAComHTNYO4T0twcnuNrYpcO6KPty3mJvD3MZaFYXBBP4=@vger.kernel.org
X-Received: by 2002:ac8:6546:0:b0:535:a5fa:ee0c with SMTP id d75a77b69052e-5383b66652emr111406471cf.76.1793042301526;
        Mon, 26 Oct 2026 12:18:21 -0700 (PDT)
X-Received: by 2002:ac8:6546:0:b0:535:a5fa:ee0c with SMTP id d75a77b69052e-5383b66652emr111405901cf.76.1793042300941;
        Mon, 26 Oct 2026 12:18:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c62063dacsm33430996d6.37.2026.10.26.12.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:18:18 -0700 (PDT)
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
Subject: [PATCH v3 6/6] ARM: dts: broadcom: Enable SATA on BCM958625HR
Date: Mon, 26 Oct 2026 12:16:18 -0700
Message-ID: <20261026191618.3178830-7-florian.fainelli@broadcom.com>
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

Commit 77416ab35f57 ("ARM: dts: NSP: Disable AHCI controller for HR NSP
boards") disabled AHCI after reports of boot hangs. Both SATA PHYs
remain enabled, but the disabled controller leaves the eSATA ports
unavailable.

With explicit IDM clock/reset setup and the corrected shared PHY
register aperture in place, enable the controller on BCM958625HR.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm958625hr.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm958625hr.dts b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
index 53acae385822..f6717ca76aef 100644
--- a/arch/arm/boot/dts/broadcom/bcm958625hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
@@ -184,6 +184,7 @@ partition@700000 {
 
 &sata {
 	/delete-property/ dma-coherent;
+	status = "okay";
 };
 
 &sata_phy0 {
-- 
2.53.0

