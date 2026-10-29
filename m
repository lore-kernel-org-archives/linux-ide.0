Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309141;
	b=I9IyUr7dpEaKG3pDRCR8TK2HNOr+xkNFBiAJ+zBZxXuvMvG6s5+pD8Fs/dkoIvYkwYvC
	 BZmNuaiCqiVCKguJDv3AHuKKJLsplX4o9+fP63Q0qcX9ai1noTlQgOcdQV/ak5CfmQ9m3
	 DhsUF/g0I8UO9sHUciA6eAeFGO3uPoXuDehenVUgDxIzv5irB3++alm2CD2/28PtVUZjI
	 XIIfJvC3JSCxI/xp4wP4Bc2EuOFUil0ARpd8+gf+IKHKpncVfkQui4GJ16vTo6ntYHXOV
	 uBshs73zn0SoacOc2ZJv+0qPBRRub248u4tJXrcGYFiqArn7WX3N2IKte3nFHvQ+Apg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309141;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=LpNaT8q0SGvIEMd/N1soAJa02WC3uqlIifzAi5jpoGQ=;
	b=EVfAWay515jMb+k+t4fh8RxM/prNO5CSPdeJ0+Pho/MTB3nwOXXLkJa/dFfnJHVedTYi
	 IkqbDKod1mBxEUuFzAp7nnYJIRJw7Nq2GGHsFyuqnhG5vwiuvhSM5zFSWJa11JjWfwL0l
	 ZEXFp808U5Di4X/Uilb+4IiqksGk6ImPq9Lo3mSaXJvUOcfyXj4vX/ZL6edsgdn3iv1mZ
	 VBGZdIP/CmQ69IRgK047kp3mG6BbebeIQ0UQnARw8sfwlQ++C0P1+4BDzf2vLP61r3SC1
	 wBapjikgNPb2xmQ3TtJjRAO+iGfSnB3IF5MdrEsk+it1hulH5iLIywUrHEPiXvVsdAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WUvQjBbA;
	arc=none smtp.remote-ip=209.85.161.99
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29A606A33A
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 21:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE29A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WUvQjBbA
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-6dd059478dcso23233eaf.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309140; x=1793913940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpNaT8q0SGvIEMd/N1soAJa02WC3uqlIifzAi5jpoGQ=;
        b=YVF6Rh8/CVjN8ITo3SCBPtH1L84EUsozCtNCMq4dF2eyFB7E9HfgpuVvR+E2UWVyPp
         1zFtR/BC3Fxpx/P4TvHWVjjJNZlva4FD/DLcpChMePh9gSdmbb7S+zKS42WJCerls2lY
         QjjmnvZiJC5h6ASw0GRf4hJY7l4w7GGonkoqw3uph8H5dkHpH41MBDr/xEXWOIj8oNuH
         zLKVyS/FRbdwIROMXyWmBojuTvYkcCf6OYABdVVKKcTfZ4koXL5fGMVHjBePtPXxdyN1
         wxhuBukRLJOwMlnxf54YecdYlRGRDvEwDxtSAnbEEf+iAHwQ4zdX8ecAYBr6sqI6leBu
         BH0w==
X-Forwarded-Encrypted: i=1; AKwUvBx7sFlC/rpH8Mn9GiORTkQZUa7BQrPnoRh4jmFi5IbkC1uJvnfqeidUgNolByk64rVkfhH2aaQq2RE=@vger.kernel.org
X-Gm-Message-State: AFq9FYICFd/euh2SDojJTz6iGN0/nQVgS7B8+PiZT7qviUX277FAgMRQ
	tT9VNnuADywfE4FA3d2tg8jg6nyvC7nATuCZlvctOHWzXCfUC2w8kK6tt/oHO3BCIEV/NVt46om
	blZ2axVtF/Uc3SQbDXQ0LL5l8ZGueELdvB4s8moPdBBl1gINd3KDms2cE7U4n3Vt+mbgyUmEK+u
	QsNfUuaZc6tdqOcVaR5NDpSqYGrHw4FMuWaBIPHks46cYphqcNb5YQoiL98RLBwBIdZt+pT+DUp
	7AO8cFZMy8k/DUio8L1114=
X-Gm-Gg: AYBFou2DsTv8FCl1RVqsSxAIadyrQiMLE9aR24EefOVEmiKrZbPoysgfOXW3rjmqSeA
	mIdGGVMq+JOT5+Ef0WplAmcNCxLwyQzOPIxJA+UOmWKz5J77Z+uww0zn+mogE8gWYYH+MBsWJ3x
	JYdRrfLlVx2YalWJFniTss3dBvnAlghhsZ9cHU91wMdEEdo6y3B7zC1ros80UyUTLEhMU14zsPe
	nc4hlbksoeT0OweogbUZsL2mShaEgosrivpPUBRtKrXr3vjSE/3e9qkpv6V/+iYN/43n0WLsSJK
	L9lCMW9RX4UjuRZk3J6rNKe+t+ylbdK5P4QYIIPvCY6T2bmXZda9L1mdPcFTZP+0RXQUObtEcXQ
	B3xMKric8GJ6I8WJNkUgB6g3NU+vHM702RkIQjAzmOBFtZX0PRPmWhTdSiBnBH/wr4JSTOC4xNa
	lPnPSnCWYpa/wJe8USdRmiV4e3MyG68Z27UKZgr0ku
X-Received: by 2002:a05:6820:162a:b0:6e1:d890:3825 with SMTP id 006d021491bc7-714f29470c8mr454586eaf.18.1793309139946;
        Thu, 29 Oct 2026 14:25:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-714f3433198sm8819eaf.32.2026.10.29.14.25.39
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:25:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91b937ecbb4so1678956d6.2
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793309139; x=1793913939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpNaT8q0SGvIEMd/N1soAJa02WC3uqlIifzAi5jpoGQ=;
        b=WUvQjBbAg4yqi9P7UGCdvrxfdHIKMQMOWf90VpYxh6JjrSAdqAz7Jrjkdzk9Vcgpa7
         dzCdjhmcSqaYsEhR7PL4PuFyNRBQmbfkNOWYw5mmJxv3+a3wJddLsG6nD+lzePjD9kUj
         N0FwnX+JWSs5+tT9M9WconiPGTD4ir+cWu1D8=
X-Forwarded-Encrypted: i=1; AKwUvBywUifnuUE01SKD5uuUaGoWSfTvjgu6lUnGelaCT0EQmEQHAEkz1rSQcm6adLO7mB3kx7t2RXRXRf4=@vger.kernel.org
X-Received: by 2002:a05:6214:5f10:b0:91b:8296:3b88 with SMTP id 6a1803df08f44-91ca4ae90b0mr3372246d6.15.1793309138748;
        Thu, 29 Oct 2026 14:25:38 -0700 (PDT)
X-Received: by 2002:a05:6214:5f10:b0:91b:8296:3b88 with SMTP id 6a1803df08f44-91ca4ae90b0mr3371906d6.15.1793309138161;
        Thu, 29 Oct 2026 14:25:38 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca314fb6csm6384936d6.34.2026.10.29.14.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:37 -0700 (PDT)
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
Subject: [PATCH v4 5/6] ARM: dts: broadcom: Use noncoherent SATA DMA on BCM958625HR
Date: Thu, 29 Oct 2026 14:25:12 -0700
Message-ID: <20261029212513.4126083-6-florian.fainelli@broadcom.com>
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

