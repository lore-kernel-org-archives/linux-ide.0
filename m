Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729944AB77
	for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760560; cv=none; b=Bt7mndAn0FOYt5dFdVWhUZxfqx5hPnRz+gKKz9FcloEwEocQufmVuIEelDnW1/oo9UAHLb9qc5o3NUD0KDvyPLYOEO7OqTLBVCK06ozNY8H2GDLRSoN9RZkNiPPhXTIZ9B3c4cTie7ZsA2AzDEkNeXaEboVugOYCIoyjoJY9wN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760560; c=relaxed/simple;
	bh=HQGlk2jl7ZC+13dfdxTEbZHJHqvV4i8jOzqjxsh4j6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAFBqfILtPPOjicNgYHQf/rypCLvp6j1x43+hVLkzX7Wl9cR1b8Qt+C3jZv/Y37kAyMbHgBBXDrP73l0TdyR9WA+i1avHG7qIQVywKyOr/omshcmlvSEwxPfYp/iaP2OOi9Yg1KL6mo5pfYh4R4FQr/t4baT4jxypcpaUujI5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=is+LowLx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is+LowLx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2531f453eeso56911266b.3
        for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787760557; x=1788365357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3SfMexikYcT8YK2CbCbuAPa/0r9Mzj0fUEaGXF70ERg=;
        b=is+LowLxfNBC1vEWkyp05SondawUdhpYxBQkovn09KvKpdir13f4o2qI7UaFYxNdOA
         7c9QrtQwIhuYIC4jijdwUKevvDLysplNZMdkHCoUZKTDS/r4Ud4+ckrM0iqa0NARGDP0
         6IRES4TnQvRlBBK8dmLpGbyHiSsec+JMfZhGl5UwUcyXB3aedZ/SUv3B/tmViJr0PiI4
         8Dwdc6s8Wu20MDrlDjwRCsWHry89MQNERBMHWFENA3mMXOqwjK/Ww4W19hymCos4xmEz
         Uzl5r+gJlBvMav3WruvkXbsMRV41pB5sxSdGQSJyS5siUXi/I7AMtLItJTnM3uSnisbF
         TA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787760557; x=1788365357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3SfMexikYcT8YK2CbCbuAPa/0r9Mzj0fUEaGXF70ERg=;
        b=ISNCy6oqXukVD10S/SAmG9GY7+DonrTX3whrIWie7IO0yIcTZgjyMFoKvMOMJHHeHl
         lrVDAqfyunmev7vWZPzBTMr1YPIdDOYq8GWyK6s48e36dM1tHPW6JNFySOGLRcLMIpya
         awEpTvmKQGg9CWQUbpnP9AfUqN99mEeD6rIIzxVmo3AFNePoBa+1G3g9NyFr/LBUFQK/
         Nb4TS4AGYezZr2v4HUfUkPN8VfHJb5PTzfjIUNetdGfcjN/OZWNL/YTuPnWa/hLSEX4Y
         g3Wo81XmbTkGhihPtimhHx4xzR/w8nR6H1gH9pUntUJi+H+6F4vP7jyh62mKMMlVFRVZ
         Lkiw==
X-Gm-Message-State: AFuF++kqxlPjOBFhPPKr8+oW0B2csH9D0jt+bOSsa+QrdLHOSSqLx3I8
	MWCRwIzFurUpEFj+shzDYBYRhynfcpq1WxHJrebADy0b/cwmO4g3p89Q
X-Gm-Gg: AR+sD10awJINzKRl0sZEQD2LGCkK/0wfY3mKkp6kHzjEO3b7I7TCYz26wIE9Xtqf936
	7MgOuBEaBYQEX7dWOeTnd69ny50NoMdhpaagYPD40GNOmDEwbhsfcHWFhHb1SoclxRyboApnM/X
	FLofKkjEsR2dUV3z1ba1So3eHNzcuB69cz6dzUVzFstk/i9w3himUgCqoIUhy9PE3Th9SO1t87p
	3ApS/WI3/QV0iabxbzZxoHX0P0T1KGYUcwVdx/JcYyrEc72cutSmZlnHaaWhIXrplgePgAp5hFN
	Y3wP1sqCb8cR3EyLf3q0dg5ciQI1xKE+EvUgmUxQr+hJS7pfQLVxn0Jypg975Vg1xTPzhVtagv9
	His30e8U6j25A2fUYyiE3t4AdOsmEPpteDlL5/6Q32pLYYb+uryhmndBsV2PDUo5F6YhuskEbvx
	D7YolxsQrDNPF299A44XGbtxU28D8jG2mDzhJVAJheuCBSdOdZGppk8TUZHAL0F5wuV28apelFF
	yyszk7s92q9vYRq0be3vQqRPHSCCY0dmn5C5oVFeBWOgB5/iOZOj1QKwQ==
X-Received: by 2002:a17:907:e003:20b0:c25:2d27:5652 with SMTP id a640c23a62f3a-c252d276b10mr421093966b.11.1787760556808;
        Wed, 26 Aug 2026 09:09:16 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:78ce:12f6:160d:28db])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b43absm558705766b.51.2026.08.26.09.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 09:09:15 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] m68k: defconfig: enable PATA_CSWARP
Date: Wed, 26 Aug 2026 18:09:11 +0200
Message-ID: <20260826160911.460165-3-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826160911.460165-1-p.pisati@gmail.com>
References: <20260826160911.460165-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the new CS-Lab Warp PATA driver in the Amiga and multi defconfigs.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Assisted-by: Claude_Code:claude-opus-5
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 arch/m68k/configs/amiga_defconfig | 1 +
 arch/m68k/configs/multi_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 8b7efe20dd12..794bad30f5f0 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -284,6 +284,7 @@ CONFIG_ATA=y
 # CONFIG_ATA_VERBOSE_ERROR is not set
 # CONFIG_ATA_BMDMA is not set
 CONFIG_PATA_GAYLE=y
+CONFIG_PATA_CSWARP=y
 CONFIG_PATA_BUDDHA=y
 CONFIG_MD=y
 CONFIG_MD_LINEAR=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 2cbd6bf20a68..3a9aa52d00e4 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -310,6 +310,7 @@ CONFIG_ATA=y
 # CONFIG_ATA_BMDMA is not set
 CONFIG_PATA_FALCON=y
 CONFIG_PATA_GAYLE=y
+CONFIG_PATA_CSWARP=y
 CONFIG_PATA_BUDDHA=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_MD=y
-- 
2.43.0

