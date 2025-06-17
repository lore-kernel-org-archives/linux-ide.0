Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D22E7642
	for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2025 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163212; cv=none; b=coZPiR58oCwWhczNz9j08g9wtQnJrM6Fzl/R3uq7SxOXdjlkKMhhJ97y9lwrRsKuoJ9xdP88w1V9AWlgoBIZQrnnBr64ms4By5ZVBKWXQvKffOCEbWUkpfO1wGdHgxwLUB1VDMgpRFxCXIz7W37t+iPnYC7frnAS2U2tBDA98U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163212; c=relaxed/simple;
	bh=t4t2RswDC9UqCh4+aki1ErRdHTL0/TEBdq8HmMPiF/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCabIXmi/5AZJLB4qsq5QZ0+ulI7eiw4RY8RG6AhDLd4UOTUN8Y53eAU+LMYxjrsg7aK0kdq45+cByffFt1TYsjQQ3H7WVu9BC0gC9YH5Q43xU7RUQOcVKfOgVK+RFdAbwsA6FvUrPCRO1I3W+Pu+zXhufQl3Lo1tKOMIfQtFLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwTwMpbQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwTwMpbQ"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b6a349ccso3273104e87.0
        for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2025 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750163209; x=1750768009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igYh9IkdN5B9jUIZ6Tfvv1PTLQ4g4UcjAfwwoAKTM2s=;
        b=WwTwMpbQrHB3HMsWCNd2ewj9hNfngDXTxMm+45Cnv/TQmYU0AHybJIXfNET2OkVcUJ
         cHzz45hVeDND4Xd3GjXR+/VBDj61iDKwkPi2cFVcqZSee+zB+ekipyJrv8c4PcOkODe/
         vTTxeXpeIWhDdPUokab14T3ps1F1PXFoapAra/pFhWjlkajH7nzTe7PBYwvdYcW1Fen9
         fdW7jFP52wUZmC2yVCKcPh5svWK84eIupUcWklGirih6PwAyLDhwbV2AGRL/2a6acPMX
         VPrMeK4aImeGO6C/DS7Fo5WiNdK5JLLaxaLWlRWofyppTSi8OQTEBChF7Guh6Sd4m2Xm
         edHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750163209; x=1750768009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igYh9IkdN5B9jUIZ6Tfvv1PTLQ4g4UcjAfwwoAKTM2s=;
        b=o7gmT+mG1jmoEmvZKevov8uKdLhLgf7gKLDOJlTm9+6y4W79yQGpJ+5qebMD1sTsBw
         VBbJpTCafRc+PBImK017wVxQJyrI9rk7sh2FzQtjCdD6prUFJjNfBtAQJetJoQls2jZP
         IoVo5xRJdUlrMisPC4vH0Qyk+BwTcJ92fnE6ZmqISftw+kNr3TpULuvqyXaB+8qoTeXS
         ruKVNpHUa5OC9/+M8LT1Z9AQOG6LALx7GDy1DItXw0cYJoa9/Z7zR7eFBjc/RTuZ4gC9
         5PhJF+gQJMfV4rsvRyTozJ5SvvPbklabrgUI5VgH4e84DGcjusCzITdSRR8/5BTTv721
         GEWA==
X-Forwarded-Encrypted: i=1; AJvYcCUAZ+i1p/IWeqKI7w7sO7obYyaqjAzT2RFgce3BN/J1HUmRPX7oeUtlSWN9wlwlDAPIjMOuCo2IVCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi13/HVHMccDykqnOSdlRvA3Cz9QGrl11SMqaK3nGKQArrVmdD
	r0dD7vBpxpsl53f6bYMDZjmFSur8V4l4mEZ88j76m+xdhl2IgAGcCpiRwdrXhw==
X-Gm-Gg: ASbGncu0dkskLPvyusbtjRPNKbrEEejovmvB4iyCSbwAywEleLOX6URnTC8yq0e8mQW
	6OGfRPqXfC8L7l5xfK03hLtT5DzHPUt869fsRVAcrpgs1IsNwEFB3OxjKtxl70spIYz2pDjipYg
	kKFyWpIVSPIAd/YEz1C9Gb4iwjGmF2HrjvVBswh6gG5I89qtUfpGnr3pU/5UtTwB71Qr0DKhMc8
	X2Os3wwjAWJzBBUBABPmD1jtfUowdugwe1zGV1pjg2vrRU2C4mNxwkVCjGD+1n0cESlcgOLGNYN
	KIieiYHRQt3g67GafMkqdJAbyM8Dvk64gfaw1CUld0lnoCjnKuShoFQa3CiMex1RUKxmUqTDHEt
	T3ZUrkVwu6IbyM7G8iVWYW6VfbZKf08aakY5oQGCbtdJSLmDi
X-Google-Smtp-Source: AGHT+IGG72SLyE0axDY957665Dzk0iuN7NqAqvYJk70Tct3WmeVC9s4Ak+tGxWZZZIFRDils6uu+DA==
X-Received: by 2002:a05:6512:3b86:b0:54f:bf00:6f38 with SMTP id 2adb3069b0e04-553b6f46c60mr3445433e87.45.1750163208563;
        Tue, 17 Jun 2025 05:26:48 -0700 (PDT)
Received: from localhost.localdomain (hag-hkibng12-50dee3-244.dhcp.inet.fi. [80.222.227.244])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1ab307sm1882002e87.137.2025.06.17.05.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:26:47 -0700 (PDT)
From: Mikko Korhonen <mjkorhon@gmail.com>
To: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org
Cc: Mikko Korhonen <mjkorhon@gmail.com>
Subject: [PATCH v2] ata: ahci: Disallow LPM for Asus B550-F motherboard
Date: Tue, 17 Jun 2025 15:15:48 +0300
Message-ID: <20250617122609.6818-1-mjkorhon@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asus ROG STRIX B550-F GAMING (WI-FI) motherboard has problems on some
SATA ports with at least one hard drive model (WDC WD20EFAX-68FB5N0)
when LPM is enabled. Disabling LPM solves the issue.

Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>
---
I think we might include the comment about the non working drive model, as
we have tested only one model and in principle this could also be an
interoperation issue. If one would need to enable LPM for the motherboard
and happens to have a working hard drive model, he/she would know
why we have made the patch in the first place.

Changes since v1:
- Fix typo and one line comment style issue.

 drivers/ata/ahci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c8ad8ace7496..b9b8ee356fcd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1454,6 +1454,21 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 			},
 			/* 320 is broken, there is no known good version yet. */
 		},
+		{
+			/*
+			 * AMD 500 Series Chipset SATA Controller [1022:43eb]
+			 * on this motherboard timouts on ports 5 and 6
+			 * when LPM enabled at least with WDC WD20EFAX-68FB5N0
+			 * hard drives.
+			 */
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					"ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_BOARD_NAME,
+					"ROG STRIX B550-F GAMING (WI-FI)"),
+			},
+			/* 3621 is broken, there is no known good version. */
+		},
 		{ }	/* terminate list */
 	};
 	const struct dmi_system_id *dmi = dmi_first_match(sysids);
-- 
2.49.0

