Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAD1DFFD
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252527; cv=none; b=IuFnvGXnEzBOWHi+2Xn92+rzsGpBqMPBtWeaZx/Z61bj0BHZTYAy9y9PJArFlpWwI3+xeEWg6yE9W8c4l2RUNjUr4mPR50BcjdgdWpBPqmRf9g4sEX2Y/PsfWFAfBoYzWyNYZ/i08P1CDKImgXFVsnrS7dm6bj1AF5GOjpx4dzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252527; c=relaxed/simple;
	bh=RCPp9Uf3HlobMkUHzc+LbiqpDKpB8kHX9XRhX5NJ9jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0HnLcuo+63SMPzoCw6v5KI/t5b7ymFMllDTNsPwgt6Yhe/8IbE3Z12lGcHqRpVSN0hdMsQvVF8cn24QJ1YBFu06f9QwwBc8iNM+/682V454mV3Brr20Bn6lILokurup3bLBUZEtAxbQrd4p9KGdY7INyxOyBa7k0lMl/UDRhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kbxRFeDD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kbxRFeDD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490c1915793so5446885e9.2
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781252522; x=1781857322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjYxZMHle7kM1Z7TryoA92PGleAxWUO0wF2e7W9mOj0=;
        b=kbxRFeDDDLJ+G4t1KNyf4WHKjIKfJgPRvzOKdqxN5UGsYJ8rxTdKvQETSS9ZQE6Dt3
         a9xPPx8Z6QIdnlTpAjJBTn0Nx+c5pvgIJw40hgmwPKmH+H8LHuDeD1/bmee4+KlQu+jY
         VnM/TWKT+NrdawohiX4T/Et87ToJCc222vE+UcvYgV2m/2LiKCqUgHdnx2XWIgGQKTzW
         17NZfvFJNEJL5T7GFORAj1pS5DfjayffuBW3P/KEnmTzrn3WVPwOY8FWkFgSq22RAiP0
         klATAsu5KLAC3GGqZS/C0H85MPBd53aAZWoVvT2giZ59nqJnBHgpDIOh0uG7fRbpO0PA
         X0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252522; x=1781857322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZjYxZMHle7kM1Z7TryoA92PGleAxWUO0wF2e7W9mOj0=;
        b=QuJcoqJbw9ZCgN+Tm7/3wbmyCeWmhv7IXFZdFn7mSNLTYs/rRyinvwXmvmVkmZDZI9
         egKo8oscp9izCyJ4nD9Ue+VHNgn0jRE1ouSOTVC5AhGHhL5ovW5VOgoUF/wF1ZtiMyDp
         qwln0UtCggM4a06jvLIs8y5Kt2EqI6yBo+Wg+O5MFRr+QHOJoTU0aEk094ffO5DzzHJM
         gVtbxpJN+XnpkYtz2RLo5XZIlIAz9QfRXg/rEUHQNeVOxCL8fpliGYuUf84vCdgdJwRj
         sCY/30Tluk2X8ZV0dkr+kxHMnBJoPqu5pA2b54VfG4w7QoaE6WX/4AEkxK40ePQL16pu
         y1UA==
X-Gm-Message-State: AOJu0Yxm6rGRN2NpOvnTr6PNCZ3kWRjAJK/UTq+IQ0xhfOW1KmX5QtfV
	JtbbyApD/wLCHXIAwAVDh9wBOAwwAZaVBg3ydi1e3iqPptyVkEXdwp9YZwn3JTydvVA=
X-Gm-Gg: Acq92OEyVU72yNpjljnGXUUuvEfbKwDc6hvj55iK2t4GXiMteGHcNQ0tAgDv4oQozU9
	y40GTkMOD9NfuemZCocsVxiw6xltfQxVe89t1R39EjSpX1ImFgUpbIQ3X7HGNdCfSoGN6RBLlLM
	oBa9X5KNFdWIZEhhEMGssjR+rLqMuqb47z0r7Vaf5HczFoVvmVd36aBiJLcHRjBW0ezd8g1Ry1c
	DkFcRnT3WKvWsACWwTREt15gVHAYjTaBF21t9i+Rt6pSVxc+KvfrYO6QHrjvy6j2fz8uWlucFHP
	m688vsxFwJ29x5QqVjjgZreYr6dRB/jK8BWSKf2EfDhqpj6dyQWy0xb8ljNXhPO36EX0Px4wn9+
	QhUO/W6LG8AUr4qAPNO9NcIHPBLjE2Xl2ep4F85DE6lzKVaqcxeVEObeuHoHUSPmEcG2S0FQBsc
	2o0yJZyH1w37PRNPiJwuze4sW4HLbPBnkO0VlZmlcPWvW+sX9A/GcTm2B1vyzRvzqS7+q/vJLqY
	Zh8PlzRLWmGXA==
X-Received: by 2002:a05:600c:4685:b0:490:bad8:329c with SMTP id 5b1f17b1804b1-490ec4d4f64mr22763115e9.12.1781252522336;
        Fri, 12 Jun 2026 01:22:02 -0700 (PDT)
Received: from localhost (p200300f65f47db040e4e5c1e98e7f0ff.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e4e:5c1e:98e7:f0ff])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f2e592csm3583369f8f.36.2026.06.12.01.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:22:01 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@wdc.com>
Subject: [PATCH v3 1/2] ata: Drop unused assignments of pci_device_id driver data
Date: Fri, 12 Jun 2026 10:21:47 +0200
Message-ID:  <75fcd02edb42a71cbd83f2de24ebeca70f978003.1781252168.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781252167.git.ukleinek@kernel.org>
References: <cover.1781252167.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5907; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=RCPp9Uf3HlobMkUHzc+LbiqpDKpB8kHX9XRhX5NJ9jQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqK8GdXZd3jvx/+q8DsMK5V1toj1P01bYE9YDGy 5XqMOnLg/GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaivBnQAKCRCPgPtYfRL+ Tg7nB/9t2HLoTjpN39bPVuCTAA1yePIs7SNPTaijsrhrpe154a5GhIHCbgzJHFnx93tz3OsGMJr GLM3BL/dAH1rdUZSQC9iN2TM4CpHY1T766FxtFKfugRl62+nt8DOERfFG9xmCccj14x2gnqs/N+ MGVM5kldE+nuaS59y2n8v62fnQOAQghmBEVpvTN1xm5qrdeGb/TL6TtxDJTg0NHSy8N0Mjtflx5 PUHwd6zBjUskdnP/Q1vyMbvd1HYnpIgcbYzWawCM5qAAbntnNMMHAaiMKYb11va8/gsVqjqYBou um66JY7ZZiDnzp+ksj3m4a60Mlow2ht4cFbeD3P3Qq+QF6T3
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

Reviewed-by: Damien Le Moal <dlemoal@wdc.com>
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

