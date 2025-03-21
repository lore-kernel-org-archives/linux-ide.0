Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFBE1D5174
	for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570064; cv=none; b=V2Q0pjLURNcv6vGem9XWZ1WgBjWU1WoXb147Be7LB+0xYCZQaNfrQCBAPDv63PuVH+oS5K8PsKIrHEJc7c93GRoJSAB3qX+JPdq3KvnTEKYbEV7vAwpPE5uOHNg5++p8x4a2rZhJlRYITqEtoDvy/sxTcO2OC+i0eDUjDpm+0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570064; c=relaxed/simple;
	bh=PcjryRlrJ0EzTEA0KQuSX5b/a9W1a1f8F2Cggo9W6AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+PZpTNNove8UFt3e2/uVcSxxpo+11qI7FDG8LKC1xfBcq37rKgT2Juiq2k2Rb+fOU+QL4buf/J0h8O5nue5+KO9TzTg0cyqAKmN1XSaU0+omTmAedIPwACcuxjgTWKHz4fdqUBS/lKf5CKZhGcDHWJ3kQ6wRRrPhuV1WH53L5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAq5O215; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAq5O215"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39133f709f5so1149088f8f.0
        for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2025 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742570061; x=1743174861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw4PtT/lB2aWDcr15yYUQR1jwUEUAys+a1iOBtSSp1Q=;
        b=iAq5O215kIPJF0iCXF+oiRJBioumgiHNZc8n/Y9sDV+YKPKCD8IT5jCAN9X0bVXldG
         JulIDsfc3X9yLX5Fu+yWcv4rTt1dsyfh7IZbxmy8Nxoj4GJT3jq6wWu3QZQjEC4nc5zR
         mUTDe+fM1iwMzOsGCuXC/ck3FrjDnYML0uB0Ay0oDkgXxf11iZPl1g7+JJ7Oh1mxwhON
         1/0xj/3aqTxd9pM4L+EIfh+Kls2E74tpMLSmwfmNFqMMzT0SYN0oeyEf+x51RtlWsWt0
         0nQVvpsxh7ODegEk8+vGxuhG9BGf4CeJHEM2s9+n8wQNTEM5nl0/Eeo9H76RSZqBFzUS
         hXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570061; x=1743174861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bw4PtT/lB2aWDcr15yYUQR1jwUEUAys+a1iOBtSSp1Q=;
        b=YMHkys/SUQgmB+/W+B/YH50TmIyF02eYuTPK90fwp4G7mPIrV9F15mXsPD6XGb/fvE
         Yjwh7ZtNTlCXBCa3CfvxukOo8v5HimAow6F2o9uhfekUMAjjGhA90hAGthrNDVL68xCm
         rgN8kwOKiF5Drbi8H8R9JFCztL0CZSN+h15mwGtEFC6sNknW2kLBPOY7O74TUYn+qs34
         ltjPPNyJKiWCcXKei7L4tWYveWsYTCdy/zgmw9iOX1XqsbMzKj/KRG8ChB5+qn5ujYCE
         t1KHB+0QBbMJLPeIhmtwxMws3B1VRxHqalyMc0FgMzWMMzpiyqpq30fLKqpRbGO2qpt5
         XVHg==
X-Gm-Message-State: AOJu0YwqJ9EgFGWL7wxkjb01Cu8m0Gu3JPK4kVZZnbDh/D52lgtWwAoX
	g0jMKugJ3yXb+lvZvEkrGvxDVi/CekDUvaUasAVTxNaGp+3pxPHIkyqKxhsr
X-Gm-Gg: ASbGncusQbhL8fKtgl/FqH/cFs+m5GiKFBi3IlX7fOKlSYvOyeOpTIEV2Ksh7TNJ3fn
	7uXVZ3cvpG/gZhOON0XIqosa/ZRssZalXHT/0uo4R/C90jw1TRD7Vgy8kljVrMaX1HxEQGJQmRV
	HivtC20YlzIBiMlpzj1DSqVl77TFKO6homhalBjaRVtPDQ5JXnv/Gb6/Rf3p8+/fKQom2ysEzfF
	nXIyI2Pt1iTY/CqmhSucpNqZ6CoZQx4ZDpjbRhTjhF7xfl+GiI+rWMRvsiRMQVnGqwgfDa5KL0I
	/etQdWgQOQ9dRYxpy/0+Hhtf5KzMYB1ecn5D1pC6+eo=
X-Google-Smtp-Source: AGHT+IFb+0/dKo1TFb+Bbop6PqLIYlIpYGZM0/yO4W/9OX7j50q+loM7JMu4FwIcxCMdHv+UYNsMRA==
X-Received: by 2002:a05:6000:1ac8:b0:390:e853:85bd with SMTP id ffacd0b85a97d-3997f9371f1mr4613702f8f.48.1742570060076;
        Fri, 21 Mar 2025 08:14:20 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:91ef:3e94:acab:b42b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f32fcdsm82352145e9.7.2025.03.21.08.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:14:19 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH 1/3] include/uapi/linux/zorro_ids.h: add more cslab warp id
Date: Fri, 21 Mar 2025 16:14:14 +0100
Message-Id: <20250321151416.338756-2-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321151416.338756-1-p.pisati@gmail.com>
References: <20250321151416.338756-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 arch/m68k/amiga/config.c       | 4 ++--
 include/uapi/linux/zorro_ids.h | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 0147130dc34e..a76bc9daf38a 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -182,8 +182,8 @@ int __init amiga_parse_bootinfo(const struct bi_record *record)
 			dev->boardsize = be32_to_cpu(cd->cd_BoardSize);
 
 			/* CS-LAB Warp 1260 workaround */
-			if (be16_to_cpu(dev->rom.er_Manufacturer) == ZORRO_MANUF(ZORRO_PROD_CSLAB_WARP_1260) &&
-			    dev->rom.er_Product == ZORRO_PROD(ZORRO_PROD_CSLAB_WARP_1260)) {
+			if (be16_to_cpu(dev->rom.er_Manufacturer) == ZORRO_MANUF(ZORRO_PROD_CSLAB_WARP_CTRL) &&
+			    dev->rom.er_Product == ZORRO_PROD(ZORRO_PROD_CSLAB_WARP_CTRL)) {
 
 				/* turn off all interrupts */
 				pr_info("Warp 1260 card detected: applying interrupt storm workaround\n");
diff --git a/include/uapi/linux/zorro_ids.h b/include/uapi/linux/zorro_ids.h
index 393f2ee9c042..0be1fb0c3915 100644
--- a/include/uapi/linux/zorro_ids.h
+++ b/include/uapi/linux/zorro_ids.h
@@ -450,7 +450,10 @@
 #define  ZORRO_PROD_VMC_HYPERCOM_4				ZORRO_ID(VMC, 0x02, 0)
 
 #define ZORRO_MANUF_CSLAB					0x1400
-#define  ZORRO_PROD_CSLAB_WARP_1260				ZORRO_ID(CSLAB, 0x65, 0)
+#define ZORRO_PROD_CSLAB_WARP_DDR3				ZORRO_ID(CSLAB, 0x3c, 0)
+#define ZORRO_PROD_CSLAB_WARP_VRAM				ZORRO_ID(CSLAB, 0x64, 0)
+#define ZORRO_PROD_CSLAB_WARP_CTRL				ZORRO_ID(CSLAB, 0x65, 0)
+#define ZORRO_PROD_CSLAB_WARP_XROM				ZORRO_ID(CSLAB, 0x66, 1)
 
 #define ZORRO_MANUF_INFORMATION					0x157C
 #define  ZORRO_PROD_INFORMATION_ISDN_ENGINE_I			ZORRO_ID(INFORMATION, 0x64, 0)
-- 
2.34.1

