Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D622F6931
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249729; cv=none; b=kMGIgnBo4eirvwWrl+rKdrjiRfFwFJCxVpqW8faD9RIv2IW4w6Ar4et6EZ5Pk25g2Sn2al5uuON8FEa7gPZsQ8dVwBDT70upTXqyS/vlexd801dFUOsnYeQWL8sxT1bNjgUVJu1S8UGH0Io0/K7olP2FEWE9Mh3lhuCzKDlD73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249729; c=relaxed/simple;
	bh=De2hq3YnW5qs2FWHM2zV2NrbH8imiF81sp5XeUKauYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deub6NCqcCoRSLdBOVpxFCvbSu7HPsZjecVvUU0LBwaOHHiqLGZRbfE2M+gdIGiUumMnzXUXWbXTI042MWqs7TApfQVSXj+ROt1mFjKp/dx4/E3NXaU0WNueH1bBIQzSBYlrfsawZThLXpIsmGFCt7TEu2zhQNevetZb3NBPNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=X0MgWe9r; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="X0MgWe9r"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-46013161068so287800f8f.2
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 00:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781249726; x=1781854526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgxHaZ28asbAlKFnJXZL33XuIM5akG4qzu9IOMVomtM=;
        b=X0MgWe9reCg6mvFMq2W0WhDTqd+Un1LstplgmrebnuVzoBn7EP9tqJrCtIUnc17C+i
         qlvlVmTCV7iRlhSgh/YIgdg4w2N77WJuaP1XOO9THqfmfLn7th+Xb2ijdnsJV2grK5WA
         uIWd0Xn+nqOsHOj99lv4XPdpMojUcWnBYXtKd7l2JI3wswSozCV83R4t1nPAM2ZVK4v9
         op4NEn6blSgBOuIs94RWJZ9M2arT99qHGB7XpBbHj6kdc+GiNf0d/tyGySXp3mkR+nkq
         w4mnkTHDyfGkc/Dz//CYHh/qoQzULqA91uFaoEciDOS3j0tomf3Pib9WP0iMlXBzwB5p
         5xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249726; x=1781854526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgxHaZ28asbAlKFnJXZL33XuIM5akG4qzu9IOMVomtM=;
        b=NK57OqGAgK2dz/QLJ01ahvLPF1AJqQlHSFz/l7XWPPAqaSwmyWW6o08JBZFF+DY2wc
         SSQeWKVNXfCezQCv3+7GxjVwWYi+G7CznPL1Bg3tN6O01zTPOy3p29yqVsL7ktwMGhVp
         aE40Ukh4QejwxXmHLtJTNKeKxe6BgEMBbNUQOeZJd2DdaIzWDswOc2Hii3SM68tm2b7M
         ohRcpS6iWX1VKS/nfkkpymV7QTTS+/psCSJWcWa0IDnyMOVCMbFK04U+hq0euibXSDwn
         Q45Kr0shJWCjspZFxQafwG9xPXF0q5IcNRJvS+jJCnhnMet55gnPs/RJCj9C9QU6PFv8
         5DHA==
X-Gm-Message-State: AOJu0YznWPDUsI6G7vEk539RJJusapEBlSt2/MH1Sf8IwD0t4kEVhh7p
	BSuS2MjGKbOzdTpzokM+tFPVYU88RuSpVLbQlVRrPPdqqAsN3HkkgCIJkrBkWu1KAexJv3DGCBF
	DG/iA
X-Gm-Gg: Acq92OEftoWYQy05aEK6Bq3hdWauGddh1SL1HQFhbeAfghgUmY/WRvH8uJfM4U7aO3d
	DZrKMoLpzfRo/ycT0qwnaRv/6EbcF5RHz4T3XakGam7PB9fv1Xie96rVRk2NKIbeA6B1SaYvzFq
	DEAjsSiSmXU2mQoVeJm2QatU0fn9WMnuL5oUNS9kEoJm0XEUHNOTQfKnnjlgGpv7sH1LQYjcuA9
	D4FTIy3FYcIqo/B1zhTS33CgQzw6oO7Q8jMiDnweeEDpY16nS3AjzehIyiKs9JaCpHWIgnzPPkZ
	1ABdjLS6zC/Bak8EZ2q+m79EXBCyq1TXMlYnwbP9FGc3cWiZId+yTCCf0CjmXq44K+SVYAES8nX
	BuU8xf8p80aTJr0ru9qfNT991cbqJBomn7YOFlwcsVvQ01vhCtuAIKWmfIjT+OKIXEDAmAtQ8cv
	dePddYj/DHRaqYy814SP0nWEfdAxrWHJRZBBatllcz17433VvmwFvKJn4makhr5l04o+Y6GSqNQ
	kn0vT5+LHKj+g==
X-Received: by 2002:a05:6000:1842:b0:45e:f381:cd7f with SMTP id ffacd0b85a97d-4606da8cc8cmr2497181f8f.5.1781249726286;
        Fri, 12 Jun 2026 00:35:26 -0700 (PDT)
Received: from localhost (p200300f65f47db040e4e5c1e98e7f0ff.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e4e:5c1e:98e7:f0ff])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f263945sm3380474f8f.8.2026.06.12.00.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:35:25 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ata: Drop unused assignments of pci_device_id driver data
Date: Fri, 12 Jun 2026 09:35:11 +0200
Message-ID:  <75fcd02edb42a71cbd83f2de24ebeca70f978003.1781248923.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781248922.git.ukleinek@kernel.org>
References: <cover.1781248922.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5860; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=De2hq3YnW5qs2FWHM2zV2NrbH8imiF81sp5XeUKauYk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqK7axnANFq6ZjpPW1YN2r+tTXF6FtP0YOnPgGa 57ZuyVz5BKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaiu2sQAKCRCPgPtYfRL+ TgTIB/9OaUn4xJVy0gj8VXHcsZ30x/yuPorHWlV2yoH61Htwqv5wJ9Zlqu3rraUe6IaTmDMjB9Q +DrCP3WY9PRS33l5mLfiQRmtSIE+iyrHTfOWc9wYu/acJnffFIi2vwmGwQwKTbuTbAbkuajGaad 4cJYbXPKiaqAcRFo61ei516jg2FyS7mld0GTLulAmYvnL6OsROwE6rSnLS6eDELYPq/y4cN4brs h55jL/QD7AfHfEi/CKhKDqsyszLvQgdGHQuTGimZVZd8JsF9PMdyNBIn2RaksW1FTS08NcYrgnx PfRvrj76qYcSoDswCQ9lysjLSVIEefVs2fiOSRoid+ElvsFC
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The drivers explicitly set the .driver_data member of struct
pci_device_id to zero without relying on that value. Drop these unused
assignments.

While touching these arrays, convert the one driver not using PCI_DEVICE
to use that macro and align the array's coding style to what is used
most for these. (i.e. break very long lines, a single space in the list
terminator and no trailing comma.)

This patch doesn't modify the compiled array, only its representation in
source form benefits. The former was confirmed with builds on x86 and
arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/ata/pata_atp867x.c |  6 +++---
 drivers/ata/pata_cmd640.c  |  4 ++--
 drivers/ata/pata_jmicron.c |  7 +++++--
 drivers/ata/pata_macio.c   | 12 ++++++------
 drivers/ata/pata_ninja32.c | 14 +++++++-------
 drivers/ata/pata_sch.c     |  2 +-
 drivers/ata/sata_vsc.c     | 14 +++++++++-----
 7 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index 308f86f9e2f0..6154a2bf19be 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -526,9 +526,9 @@ static int atp867x_reinit_one(struct pci_dev *pdev)
 #endif
 
 static const struct pci_device_id atp867x_pci_tbl[] = {
-	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867A),	0 },
-	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867B),	0 },
-	{ },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867A) },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867B) },
+	{ }
 };
 
 static struct pci_driver atp867x_driver = {
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 45a7217b136e..84eb36d02d7d 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -248,8 +248,8 @@ static int cmd640_reinit_one(struct pci_dev *pdev)
 #endif
 
 static const struct pci_device_id cmd640[] = {
-	{ PCI_VDEVICE(CMD, 0x640), 0 },
-	{ },
+	{ PCI_VDEVICE(CMD, 0x0640) },
+	{ }
 };
 
 static struct pci_driver cmd640_pci_driver = {
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index b885f33e8980..d18286cbca1b 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -148,8 +148,11 @@ static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 }
 
 static const struct pci_device_id jmicron_pci_tbl[] = {
-	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 0 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID),
+		.class = PCI_CLASS_STORAGE_IDE << 8,
+		.class_mask = 0xffff00
+	},
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 9eefdc5df5df..dd93f613f959 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1368,12 +1368,12 @@ static struct macio_driver pata_macio_driver =
 };
 
 static const struct pci_device_id pata_macio_pci_match[] = {
-	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_UNI_N_ATA),	0 },
-	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100),	0 },
-	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100),	0 },
-	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_SH_ATA),	0 },
-	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_IPID2_ATA),	0 },
-	{},
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_UNI_N_ATA) },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100) },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100) },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_SH_ATA) },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_IPID2_ATA) },
+	{ }
 };
 
 static struct pci_driver pata_macio_pci_driver = {
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 76a91013d27d..88db9bd271e8 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -166,13 +166,13 @@ static int ninja32_reinit_one(struct pci_dev *pdev)
 #endif
 
 static const struct pci_device_id ninja32[] = {
-	{ 0x10FC, 0x0003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0x1145, 0x8008, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0x1145, 0xf008, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0x1145, 0xf024, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0x1145, 0xf02C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ },
+	{ PCI_DEVICE(0x10FC, 0x0003) },
+	{ PCI_DEVICE(0x1145, 0x8008) },
+	{ PCI_DEVICE(0x1145, 0xf008) },
+	{ PCI_DEVICE(0x1145, 0xf021) },
+	{ PCI_DEVICE(0x1145, 0xf024) },
+	{ PCI_DEVICE(0x1145, 0xf02C) },
+	{ }
 };
 
 static struct pci_driver ninja32_pci_driver = {
diff --git a/drivers/ata/pata_sch.c b/drivers/ata/pata_sch.c
index 8356f1f2a025..fadb5377371b 100644
--- a/drivers/ata/pata_sch.c
+++ b/drivers/ata/pata_sch.c
@@ -42,7 +42,7 @@ static void sch_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 
 static const struct pci_device_id sch_pci_tbl[] = {
 	/* Intel SCH PATA Controller */
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SCH_IDE), 0 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SCH_IDE) },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index a53a2dfc1e17..606284a6d387 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -400,11 +400,15 @@ static int vsc_sata_init_one(struct pci_dev *pdev,
 }
 
 static const struct pci_device_id vsc_sata_pci_tbl[] = {
-	{ PCI_VENDOR_ID_VITESSE, 0x7174,
-	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
-	{ PCI_VENDOR_ID_INTEL, 0x3200,
-	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
-
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_VITESSE, 0x7174),
+		.class = 0x10600,
+		.class_mask = 0xFFFFFF,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3200),
+		.class = 0x10600,
+		.class_mask = 0xFFFFFF,
+	},
 	{ }	/* terminate list */
 };
 
-- 
2.47.3

