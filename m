Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039377;
	b=sBBADFUk9k1zS7fJsNdH7dXIT2N81CZ+cLLzEUXbu0s/thUNr3fvziYyoDQdzY6SxuPz
	 uO/h8J+dRuacb+cHCN9YnkUDLaha2MH6lK+gw1zym+AIkuSR95G3/PFJODgfauRxZaERm
	 Nf414zbFf4JHfAui9Fzpb/6MpY2SW3f97h+5LaXxlzxFBPvcc9esJHy2uOl/q1GglY4A5
	 AMTzMNigZGkbhhKehzbzFxUUn8YMSJUzCv8ngO98m+3qTDHG8rfqi2KUa9+KTxONmpi3g
	 1w1dTISyqNd4r9HyIzJVJPHBOemH+WPEpIqe6M+jMdaFwWkbpdX4K0Ib0BEbBvjR4gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039377;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=LpNaT8q0SGvIEMd/N1soAJa02WC3uqlIifzAi5jpoGQ=;
	b=mmC5MPMUkHHylCYcfRH3XSAi6cr+x7mZy4amxxx9YPvNiDnLQJRFPqQ+zkXyuSFrWLUp
	 MmFibPLCoQhzOv01k/IElWguCRYLsv9nt1QniStaL9DXxA1sImwMZE17XSuztsQIFhNYc
	 XTK1ZO8CchNymr+9PmXNJrXELJL2vGv84d8z519CwBzT/Tth8ktu6dAdn+JFMm46xRe26
	 mqarKIr8kaN8VhU8FkDC5E33w2P6YYH4PUdbVr4tj8gSHOvSo2XuIiBe5RstNyBa0uBVC
	 QFotXxZtF7b/5vtVbWvFA6hsxsnU31LGXOaN5UrZ7Qr1AuVf+znbuQO5kVa1Wh3L04g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Z5Qc5eoF;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145360A2604
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 18:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6145360A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Z5Qc5eoF
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so1166986a12.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039377; x=1793644177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpNaT8q0SGvIEMd/N1soAJa02WC3uqlIifzAi5jpoGQ=;
        b=SJmeBQj6FfCKGqRjjMSccRkZF62+ZvRCkv2ZPdGyG8czcf8VB4fwnW3HBEh7Q+MUOk
         nVE5gN2QtzWiAfo6BGFBqVE/G44WPiYuWcuZnK6bOztlVR6KgmRSIy+2CiXuKt1BdhHj
         P/tc+BSvxa5afNrC2mBbjEtnY0yjAlLT1SLQ1cCt3zAZyaq7j+O8S7sLxqBpzKVHwK9u
         aO5f7RjnkhlPqMcKlFiMWUKpI3jHio0ZjRJWJqRaPj8omI8+SQbDD+ZB5pxBbqJZVpfZ
         9LCgvLLh1/zJyerq7kY6CG3bR7O1Ekf/8lIch/WVCBCiYHjy5F1ozycPwd32i69EUJ3V
         rh8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzeHtE/AaNrPhKpPPfrGzTSLLYo+7fuImk/ldeylYqjLLAum6X5qE2/0sMpJhPSzm2X07Qc18GTJa8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJD005lMM1l/Hhjtus6LsxcwZi2UH6hEZuTViDeN7LpIg39WTz2
	d0MtJTa4BBl+9Der68lauyjYKQlzkrSUdX4skGlGt1b+PQma5WXcgwN2jauvdDSM7Zv0lGa7+WT
	c7qNvJ6TXg56Dr9FFU+uxFBfeNthZs+2D43jzxxdouNx9puEJyHb78uO6HoYc46DG3fORqwb/RT
	wsyRuczNacjn+znWcyQF59EDE0cM0Gd7ftiN2Dr85OIJjMP4pujbbsJ9tyG7ZsqL3A+M0qtolNy
	m+07PfiAqMM8XGbrqo11Hg=
X-Gm-Gg: AYBFou0G67JFkjuuouXf7QRiOaz06YysO8J6JBjkusbEvGnEp/qYbk3sTKGea2juDQU
	E7wG5ddyT8Sb8NALBssfgONFCJssEq5GUDGdD0tMOjILzA34TNwopECgmlInh2DkNaEuaiOreYp
	Kbp4wl0i3Cla+ggzj9BEdmrBv8uyS2v0BK4aI9fSEQIl71hru3grPOw/Tw5+4EMkrIPQYFx4hYM
	Lyjra8dWmJI0h9iUbaQkGOQysP/CkX1KeNJgzM6i1MaXvlajuio/Ln1SzHfmD5ZIudCwGN/q1YH
	siCX1VIoTR0SUX6o1bDNZO83I1yKQW1HUg8XPiW73dAEC7FHsnH1abYJqr3gCuORwqUzXMVLLEO
	sNMnDuSBbFpoL6thZ/Dq7788RvMDorJ5PBvkou574z+W1HH/qedrTCPoH6uawbZfng+ykqkXP2i
	KCYfkMD/QNwrbjjUU9AuTLaqy2HjICZjnUbuBs2Rbi
X-Received: by 2002:a17:90b:4a81:b0:3a7:cffb:8b96 with SMTP id 98e67ed59e1d1-3adea9da8fbmr6080599a91.18.1793039376726;
        Mon, 26 Oct 2026 11:29:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adeb83a327sm3478391a91.0.2026.10.26.11.29.36
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:29:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3580c07911eso16930eec.0
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793039375; x=1793644175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpNaT8q0SGvIEMd/N1soAJa02WC3uqlIifzAi5jpoGQ=;
        b=Z5Qc5eoFJ4yTzUPCzin8xMh/jZ2htI+0wdsdhJjzUK4MoQJ7oy0AgTTx8ItpkwKe7z
         OBiudo4wQiTgrzwHBHkSJzfyQ8IuCmDz4t8ato16mGpzTl/n6DQ0AGNIKROJcn2UDimn
         b4TQypDjMBTmsz0LYaXbHk79qv2rCuVkTxbvQ=
X-Forwarded-Encrypted: i=1; AKwUvBwVItuHgC9W44rtZOfWsneRo3rzcbo/Ey/pLznRqyd7EAC9nOxOrsBcEMl/P6SgD7LJCOl783nLSao=@vger.kernel.org
X-Received: by 2002:a05:7301:6189:20b0:369:f291:49da with SMTP id 5a478bee46e88-369f2914cd0mr8027372eec.40.1793039374783;
        Mon, 26 Oct 2026 11:29:34 -0700 (PDT)
X-Received: by 2002:a05:7301:6189:20b0:369:f291:49da with SMTP id 5a478bee46e88-369f2914cd0mr8027323eec.40.1793039374121;
        Mon, 26 Oct 2026 11:29:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm24657259eec.21.2026.10.26.11.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:29:32 -0700 (PDT)
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
Subject: [PATCH v2 5/6] ARM: dts: broadcom: Use noncoherent SATA DMA on BCM958625HR
Date: Mon, 26 Oct 2026 11:28:55 -0700
Message-ID: <20261026182856.3168686-6-florian.fainelli@broadcom.com>
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

The AHCI controller on BCM958625HR fails with the dma-coherent property
inherited from bcm-nsp.dtsi. Soft reset times out waiting for the first
FIS command, subsequent engine resets fail, and the disk is not detected.

AHCI allocates its command tables and received-FIS buffers with the DMA
API. Declaring the controller coherent bypasses the cache handling that
these buffers require on this board. Removing the property restores
hard disk detection and operation, as confirmed with a diagnostic DTB
that changed only this property.

Use noncoherent DMA for SATA on BCM958625HR, matching the downstream SDK.

Fixes: 56e2ff0346a3 ("ARM: dts: NSP: Add dma-coherent to relevant DT entries")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm958625hr.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm958625hr.dts b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
index a9b6aa04d573..53acae385822 100644
--- a/arch/arm/boot/dts/broadcom/bcm958625hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
@@ -182,6 +182,10 @@ partition@700000 {
 	};
 };
 
+&sata {
+	/delete-property/ dma-coherent;
+};
+
 &sata_phy0 {
 	status = "okay";
 };
-- 
2.53.0

