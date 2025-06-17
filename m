Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A94430
	for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2025 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141300; cv=none; b=UUw76uz9aBQywZV8tmFb9g0kJK+PTcV0cfoPq1dGW2tW6+BlEJHL1BFzTxpF6tsTKdKdUEMv5yEB6NmPnjUo8j3udxi5LN+OCF9QWYWcB8zaVGp8fbJVHglNlOHzgjrMYtajAs41fffE2W94Z6Vje2UDSTXk0km4HfD+ZrYkSkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141300; c=relaxed/simple;
	bh=B3dtqh54wvohJIQmFEllldNDDDS6va/ytc3mjU+lE0Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=M0qCf0Gzt8JzpEsfT9BC6oRHENj/MsQyP9ZFACdEcG623ekdTwALsI4uyz/c9Ify1jqDWpFrt/nxuQmNrt1TWrh9unDGDnYrH8q28SGynr/pxR0F2M2tfXjFb5U3G/1ICJZ7NculteZ5MYppqE+2nsy6uAHR/YeF6Dq0ovobmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHrQTZ3t; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHrQTZ3t"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553a4f3ae42so4661969e87.3
        for <linux-ide@vger.kernel.org>; Mon, 16 Jun 2025 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750141297; x=1750746097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHb7Uf2oEvqIQPlYCMOOrh/2mgAYSy2uwnF97sfwVxo=;
        b=jHrQTZ3tlC07+drS8brhKS8E79Z7hiyf1Wodfathuk3Q/ysQTKSmJvIkVa/+NlrkLz
         NJ1OsMac5ZjAoPNK6DaqGovpNdjT3wrhpwa+5Fa2njeAlVlhkojtYJHaYayTn19lBfrs
         QaWu1Pt59EPXvKsrifLWZ8vgNFVTbwWNC+61cs27uYNsEYIwMjxNbvFOa06fhSPmL4l6
         Y6quFEBDhMqK2TaxEYE1qanFH82R5VgeayLJXJ6wpJ9SF8GWTC5eJCrq9Yww1wXReaPW
         xLTmRoXnyk+EpJvRovygKZM6Z23RZsZTfrNWBs6o4Qn/jDt3+4HxcI4j94xxcqjvle4B
         JyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750141297; x=1750746097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHb7Uf2oEvqIQPlYCMOOrh/2mgAYSy2uwnF97sfwVxo=;
        b=oXT0nu8yWf2wcSGdwgR+Wvt7K8oOqLJiqYb2oQRI0VKHk1slzfyKE40JwU8JI3y7v5
         MRD/+ZbdYRmwleKXrO19ZRkTAhVj4X+i/Fxq1nvN395Un4tpowCJjd5KJWu8+unOQBQw
         qf+7Wpj5pa0j61b8SsV1gBXxH3caBcrZIg0zbMwriJRJW2mwylDz26tYJMXFR9W/eiZS
         RGix5rnHfdZg2O69rDT1btI8Ii6plZwVmz3spN9QwsE4xxjfFLYNeNCWvy/BozCwC7zL
         8QHFT5qmMW2Jm2i6acYAQpBCZUJX3M8W+c0odvBg/THq6wgb/1of/k+v+8YhOgbRiNLv
         7U7w==
X-Forwarded-Encrypted: i=1; AJvYcCW7H66HKgIAWZ47MCJ64z0EzVpx0h3FiqpR+8rvGhWpnMMSp4HWxNHGYrzo4x9/O/IaqqHqVlgtAdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZgC68BzyLlSR9hyUJL/uCPKs92Z+nWOMNKSC47St8j4k3ljqx
	CaArQrrzOIbNQqWEouewJgxKtB3vGEqWZJf/hfa8hoeyYMU77iiLUy/P
X-Gm-Gg: ASbGncvKPySnVBfHx4er+aNidHRb1rYhxiIeJkc8ryVYeILOp+ax1HT3zaae4fhEAU2
	3A2p2iCW/cR0ql15omFZ5uyNyjUwGJ7QZ/z+vNtnvw3d06nyA0rlLe+iWd/d1ejMx9RXZRyBZ89
	EvzCCAoF5Cb0U2KtfNthaxn6eJRigbJhESkBpbn8K0FT4Zf7JSp4z4Zy7Nc6gYdZDl7WGPph/X9
	xo0Y+8PDekQ8vfNRzwOXrPA6AQ70q95MeqtfTEukpVYAY48bvSrNWYdRDxbVuFV7Sal8YTp+jsq
	IC6vlNnvEFGxls6PHOWasnAOht0jPEDVcb11KrPeMkJRNc6CnRMVo9DzzooCgwU++dyXeRm2JNB
	w790UzQJg3oUjdP8Mq+8RYu+U7Qnoe9RGT8t4Jw==
X-Google-Smtp-Source: AGHT+IEyXNo/7pqSA5G5VmYSwG+m2mCawykkEFHgwcFXVDffa69M6LLrDgX/zhO74916GgptFg9bOA==
X-Received: by 2002:a05:6512:10ca:b0:54a:cc76:1676 with SMTP id 2adb3069b0e04-553b6f3123fmr3184952e87.44.1750141296403;
        Mon, 16 Jun 2025 23:21:36 -0700 (PDT)
Received: from localhost.localdomain (hag-hkibng12-50dee3-244.dhcp.inet.fi. [80.222.227.244])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ca1b308fsm161650e87.121.2025.06.16.23.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 23:21:35 -0700 (PDT)
From: Mikko Korhonen <mjkorhon@gmail.com>
To: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mikko Juhani Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci: Disallow LPM for Asus B550-F motherboard
Date: Tue, 17 Jun 2025 09:18:41 +0300
Message-ID: <20250617062055.784827-1-mjkorhon@gmail.com>
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

 drivers/ata/ahci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c8ad8ace7496..ae8c4072a5a3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1454,6 +1454,22 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
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
+			/* 3621 is broken, there is no known good version yet.
+			 */
+		},
 		{ }	/* terminate list */
 	};
 	const struct dmi_system_id *dmi = dmi_first_match(sysids);
-- 
2.49.0

