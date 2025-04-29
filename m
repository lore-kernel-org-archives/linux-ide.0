Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F482C60;
	Tue, 29 Apr 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945198; cv=none; b=LxLB+LJnVDaVhQHCoa7JRV8vMgo/9eNE0sw7tIkdxEzZhxMiPaW0dCc6xeYB2x/z/hRoeTcRbET4i4IVN9XAbROywq9wXYsnrRN9qV+0cLcwkOiyRvMqfi+WVOVWdhuX68QhlERrszY+/aAIUxm76xnuFm91DksGBtVt4yDgj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945198; c=relaxed/simple;
	bh=3RZNSX29Jv+If6fc5muob9gaXzGOAzO2DMlnY5IqCU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYqsUEEIbUCtk7Zx0WI8awjIOX+pduBLFomSlJVkFsBwImg+zKl7M3dTBBPU56v8bCP1x2LckYqXY3n1+hCDbaxbV/EUV3sDSzpv0lTTCg5COw1uZ7gTsf5WL8Pow587mgxapNkuNRwrYb0K93AfKEcDomTtLNC4A1+LpVZZmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+2XZf6X; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+2XZf6X"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bee278c2aso481041fa.0;
        Tue, 29 Apr 2025 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745945194; x=1746549994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4Hw1TIMeERQTrUtpW0uXbvUlSgS8WZbDLXGHsNsft4=;
        b=k+2XZf6XTsF+mqFOo+e3m6YVcgBIZ88VToJt8WUPBkXQ5GBmn8qjnrTdr11JRU5qzl
         SMO0taXMDSwaw2cPF+gqokljYZEtO592opVCpWtqGa7sL0K9DrEo1vqoBZtqscZhxzKy
         mITJPns6EsJoAMshOFOr4i/LxUBs5htimP1Xk/cv3babYBiis193tHSlSDRrIK8kd6l3
         qlEDvA05zyCbPZY9x6KKo99tXcnPhNynyLh8vr3IHm7D9SdgW1UBUpTSsyrN1PJmVBJn
         YMR3OmLkYHgIB/XphoMtfQ4UM+W16ofkuGO5Zn4mTOKUj7yMxWbO6xICTRl2I4PpmDv8
         O3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745945194; x=1746549994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4Hw1TIMeERQTrUtpW0uXbvUlSgS8WZbDLXGHsNsft4=;
        b=ozZh2mDfSWuFGMilAsWJm8D2yiO88qVmHHjuSJuNklAPDNsU+DYeLAd2bmp0do15An
         bi2J944HmgmYWEEXf+6nA05Mi/0UGMMd9hnBD2u2RW3KJLAiVc1LX+hILKJ+Eky7y1re
         gPxKFs/DXFwSmfGD52E5V3C0VEapLEBjCJQTJPD872X0AcmCRizH6MSWrzLaH5yOHS4U
         1x4ki9DMJbF0sUi17MBvQiZalvuiaIfc0RvPq2ETmnngVco0iibml7kPj6zS6XLJhD+m
         0nZQvLkC/DW07ASeqW1j7AifsQ6WIm7yLa9CKeoMISeYqTQmsewsRj97eFS0jfy1CaOC
         M00w==
X-Forwarded-Encrypted: i=1; AJvYcCVttrcmg6n20HvTV6MV7D4Ki2xIThxwyhZO80Su3PzsCmx6fXbtPfpDLSjrKlpdpg5VtkFv08BJ0tKD1nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATbrO/Gy7oJyS/T4laZzo2Sdd1ZKvci2CEP9fZEU2TgUwM85r
	wWdHiIzG5+jS1ZUncmhaiCMwxBXio0sGauLCbqw64HHZnILG1JI9AMtBaw==
X-Gm-Gg: ASbGncuWA9qbCoWG86JT6/kxBuQB5GL+3Mm0uqXiFkev09C5rSJ9k9BrxFIMTn1Ta/7
	Hry5Ar3F+zaDYORLNvoUuxBr2jEd/XfJKZpcgyw0LTFLv9s437jZpbpk114Wu5CnNkQ99nvAJBj
	jjOcll90zIfr035ranZfreCTisGmsJ8I94Xua9MV7gTN1Cp4onrcIootyLs+5N0nz3max4qSOWG
	SoBbZwLOLsKIShGjXrbt/CSIGL2HQMS4ChT+A8YeKDj6bhlzuVjRpvIUATZHjHDK3tWiySHOpZZ
	DcYDJWOBNg/1UawhGVbe/+b0Yz++Geq18YielIXjubKzZ7XHNQGPj3TPflkB3C5nSSqsMHF/du3
	0yIzwi1TY2hYQ09kJ
X-Google-Smtp-Source: AGHT+IEgKrP+YThQpVKnbIAVfhuK8/aUOroNMumwcNZXNoIubHeuyCdct7uyX6L4TrHkKrTxuWh51g==
X-Received: by 2002:a2e:ab0b:0:b0:30b:eb0a:ed63 with SMTP id 38308e7fff4ca-31d46be2ab5mr13608471fa.18.1745945194038;
        Tue, 29 Apr 2025 09:46:34 -0700 (PDT)
Received: from localhost.localdomain (hag-hkibng12-50dee3-244.dhcp.inet.fi. [80.222.227.244])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cfb481ecsm24398551fa.31.2025.04.29.09.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:46:33 -0700 (PDT)
From: Mikko Korhonen <mjkorhon@gmail.com>
To: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>
Subject: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
Date: Tue, 29 Apr 2025 19:44:35 +0300
Message-ID: <20250429164610.68746-1-mjkorhon@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make WDC WD20EFAX-68FB5N0 hard drives work again after regression in
6.9.0 when LPM was enabled, so disable it for this model.

Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>
---
 drivers/ata/libata-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 773799cfd443..5c2f26945d61 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4239,6 +4239,11 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "WDC WD3000JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
 	{ "WDC WD3200JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
 
+	/*
+	 * This specific WD SATA-3 model has problems with LPM.
+	 */
+	{ "WDC WD20EFAX-68FB5N0",	NULL,	ATA_QUIRK_NOLPM },
+
 	/*
 	 * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
 	 * log page is accessed. Ensure we never ask for this log page with
-- 
2.47.2

