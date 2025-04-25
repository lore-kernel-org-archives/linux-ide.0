Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887317C21C;
	Fri, 25 Apr 2025 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609636; cv=none; b=JOMkz47iO6MsBpD5J8ekb9m+H9gUxf0UPuipZ/G2Zeo0Kagst7qJOJU0Stks4RieRuC15LrO1y1gj+Zz6mZvzO4NHDOsZ7eQ0s/+wY0B7vsUw22jft3YzWuego0f8oN9+Y0/q3ZmnrEuX4lOYOInHikeIk29AM/yl41Hjn+ya/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609636; c=relaxed/simple;
	bh=g9uoLweess0UFEoDVPSTAjUBbZbADxAufBW+76LC3CE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PuQZob1k/DGH2wyO+4K+NWvtmB4mq+mUUAGih3P+9oILsSAjSxhjFTn+HwpKm1T14ldXNzgdYkhmfp5C2kbVU2HZ39iprLM9H3Xh9r0PXNK6IY07Wjxh0Y9vHt9cqbpATaBUBjsBk7NCV5RE0bdtJShOI8BbtJlBOx/T7vtKBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eum0Yd1v; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eum0Yd1v"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70814384238so25100967b3.0;
        Fri, 25 Apr 2025 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745609634; x=1746214434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kc/neZMRjay1nZyyrhx8oGxyv6pQLxfgMETmX5ZmEto=;
        b=eum0Yd1v2890b2vinZv3Zw6njAACMvjmytykI+jCM8zgt7w6+76dapY649N4cvpY2l
         auk/+0JLIwCFZcJGaNZwC1mFaZHLACVMSYb2dijNcHMOJgi+HHPuWKRHZeh9D4mYV+y/
         z/4Tbjw/gnxtUJ9in0cDj028QA9o/A3EiWTqvDNoe7qaCfSF6204ZP6LD/pNe94Xk6in
         NwCnb/xVqSWONtV9k0O4ZJpnBCfHOudlP76UHS2U3Est6Oi6HRWJaW/tNuryAWAKoFg1
         JNXPYV+T6NZKcOETnn1DaSv/q0cJL/CtzxJ7kb+eNJH5hXilbnL3rdaoIVo08nn4edP1
         CKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609634; x=1746214434;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kc/neZMRjay1nZyyrhx8oGxyv6pQLxfgMETmX5ZmEto=;
        b=KIIzZ5GYvPAAQSnCBapezzsvrYepCd/xyQ0jh+5VW/aE/HhFx2FVbNWRMDapgnP5Ja
         78phRn4kJbhIDsvTsMD4y/aLbsOHFIJ13whiyZjt/mNrDbxaKHLVCGXTrXT07DDcm95K
         JNJHBloCkUM8aT6h9rhQYsj5ie0bE+18KZsxtq/+ROEMK7BJkcKT2vBUh3p7qAtQVaSB
         QDyk8PgmWR+Cb13Ct0mm9OGuv6WGefR8nqCDHvv3sv8VEg8TIUhpXQraLt/oSq/ALwmN
         svtdKVzx+axCSoQWHO7OG8b2aCXmi+VkgSV9rQHnNLbXravcq1WMkTPvdimFMYFCKmdR
         kwxg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Tu66xjePUQU7PYrRTorjjtAxjaGlUL/NkHAAbdIsjetaA2u8twW5nl7o7eRtmTT5MhDq841G46Y=@vger.kernel.org, AJvYcCUPvhUzmWc2x9rHCyQ1yFcu5SWZe8nEH92kq9aijZsmoQV6RfIsXfRDURJvnPPWL7Q/l5w7fli5z1/1RBBd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4YN2AlTGHyGpukdXI0EaQrNUDAuhA+pbGVEBq2oRvxyBYzlw
	RMDF3PPxubVf3dQtYG4mpAvkWyvFaj94flzXbmsJ5JCbZGOFXdv5g/lZaHRur7CSrqU6y8WdWDx
	BIVpXm25hiNcmHaMVfANiSD/m85SE5Q==
X-Gm-Gg: ASbGncsBTU44Q82Fn3xe3BfxCUaL6BNfFTCCPuVXf1IJMkNTvWiLqYDbrpW1Z99oDOZ
	+Tx/fD0/oPOii9YuKelvSYbqUqXLJopYTRTS6ddauz/7lKmD60R9NnHlYQVE4Ni+K3b3yF2G31W
	QJK4sUQX96/+WYIMaFuR7S4Mo=
X-Google-Smtp-Source: AGHT+IF4h/6M8r2AxTAJ5kvndU2HLttpz+95GrNi4OfE2k8/eGw7eKVI70YUgPiSRB5UzhfyKI+FlG5XtQjMLS7o6fU=
X-Received: by 2002:a05:690c:640c:b0:6ff:1fac:c502 with SMTP id
 00721157ae682-708540c7572mr54412357b3.6.1745609633676; Fri, 25 Apr 2025
 12:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Fri, 25 Apr 2025 22:33:17 +0300
X-Gm-Features: ATxdqUHoo8h_wvWqc5HIIys87snkBzHx1zyXv4mfHFsFAh3hio4siqhe-Ttmuak
Message-ID: <CAAZ0mTfSFZoL_CS9s1L0JhfaoyMGJ6Up5Z9_YvU-pX05MOZ99w@mail.gmail.com>
Subject: [PATCH v3] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make WDC WD20EFAX-68FB5N0 hard drives work again after regression in
6.9.0 when LPM was enabled, so disable it for this model.

Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>
---
drivers/ata/libata-core.c | 5 +++++
1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 773799cfd443..5c2f26945d61 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4239,6 +4239,11 @@ static const struct ata_dev_quirks_entry
__ata_dev_quirks[] = {
       { "WDC WD3000JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
       { "WDC WD3200JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },

+       /*
+        * This specific WD SATA-3 model has problems with LPM.
+        */
+       { "WDC WD20EFAX-68FB5N0",       NULL,   ATA_QUIRK_NOLPM },
+
       /*
        * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
        * log page is accessed. Ensure we never ask for this log page with

base-commit: 14a3cc755825ef7b34c986aa2786ea815023e9c5
--
2.47.2
