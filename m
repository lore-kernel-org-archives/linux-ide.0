Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36384AD24
	for <linux-ide@vger.kernel.org>; Sun, 19 Apr 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776637486; cv=none; b=XmJqzZmIg9Jku8VzoHj4cCGcpY8OsOjSlzF0DCxKpmYaRO7/FBv6kYSX1fCAxN9v7TiLG1KCxQvCFO9/lYDxb35lhU7jorxfD0OKM6BBvHIWMa4/82dCjDm8urGk9wFuq6JTdhJJ9edT3dUiJ362jnaoaYt3xQPkJ9uBCUXCl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776637486; c=relaxed/simple;
	bh=HokyC2nDUbRTJYDs3PhWlBf/ZTkZR5B5P0FWV4QeBLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6eI7l0rLi8nEkddNOQOEadytfeidZuX2nM8udO/ho4pVAXRI3nSfPHA5GJLyBK3ByXw2nSYMYVPrLfg0Bn4dKBQ4azSPnOgVJT9C/7Jw0xlc0IUqraaGLgI3aVVLoFr4zFnw7Op67bHEouK0Jq2ZZGdA925SbrmQspgAEMAsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekiMwlWS; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekiMwlWS"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38dd9f0fdc6so36405061fa.0
        for <linux-ide@vger.kernel.org>; Sun, 19 Apr 2026 15:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776637482; x=1777242282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpNJcvd4vFonahhQxxRKSX+/5Qv/TqiQwoW9F6azc/c=;
        b=ekiMwlWSHWkdNYZO2uvYuT7Ef7GXktYnaT4gnlpbBPKXQPBbz2CMLsq4QTBO6JM7MM
         9PR+jjofyRZqmScMVuTPy9ViueG/4LyG91jd6pjRmrNNZYQy05BLNXKe9+lfRMTe7+CK
         W2occPBGCeoumuRDhxV2JOo8+LSY58rWuK8T6IrvnSJyFwlp74C/yNDPzOsyv9kGFc5R
         lUmIOt4iAd3E4UZfu2rM2sPUXUUN+ENYjl0la8+WdafHlvqNVaSOuLEDMpawe4Z7+3+E
         EYPV4MqFVoS0XWwlPOaHiSyJXi6MlZJCrMKSDtUlrILnZ4kEL0EeazoDwl0sE43mnJ8B
         dXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776637482; x=1777242282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpNJcvd4vFonahhQxxRKSX+/5Qv/TqiQwoW9F6azc/c=;
        b=qpItPiQCcgKu7MzAv/0RxaoNetnMPOKvW/g+zQJMzOiIohjUJrfTMxmi3jPtNgMviJ
         bfq74qItzWCfU+SolbazX4OXEcNQAKlGyiPllCV2jJaBWrMMBLoVEd05ScTpAAJ9nveF
         7W21PFUc2e7EI+KTe8hz8//ioZ1BgI2MumCHELsV9rCrlSH8f7P2krMztsBn57KB5uOY
         V9pvs2tL8nIr49Kx14qwNTMIZRPWnkY3bgSELBdgcyip15g5zTg97uyGwf63JYrsEQoU
         +7QHwyZNdwuK7u/f/FgY7glDOVBJYFtckcvkOCpfi15lTtLzZW/SCBVmZxYOxPybc+fD
         kaDg==
X-Forwarded-Encrypted: i=1; AFNElJ+yorrz+GCxJdXju0uZ0pFFq3ijp/0mi5Na5uaJURQLhF0W855Pm57YCdsj3SiM2iChmBlAR0pCSgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhPyNS1B5CGkqDGGGBqbrVPISB91XZuTqstWZSxmvmLm5Xe8+C
	zTN/tHFoQrptvrxiCGYyE4tfSWwbOtFi5eHKzSDHBoM93rc5TgyfvJ7MF7EOead/lCHiYA==
X-Gm-Gg: AeBDietbBVyDt+gklfI6+yX9y4jpKVc9Jx0KGiW5B2NOaYDX3hP5Db8uwmqIeFGUtC8
	DYa9VP8HLvNNVdxbEWk8XmUkIoL5wf4LpbbeJ/obpFYYskt6n1Rmow01hEGPHeosVgOpVSl4VSk
	g+ZL8oVZwP4xBnOamNmOhP7HJfv3kC79z1WaRseHNb0Rm7vqKji48A0nwr9aB9k3kVcSrUzUbPP
	fobrj9vyb8IO4z65+55qfASLCCgwR4HEFiITAFd6u+t1Rb+1FzqF3anXm7lCRO/DQ5S2UT90Sx4
	rvctb+dkoRQYFpiwHq3G9O/T7kDSYbQ61an7Xs+ZAZoWOUJe2avrzy9g9k58KoxAVaCg15bDezH
	qJwD4/SDXVkqKz3MnwWHmeFBrT5SajqWIQWDEBHL3RehHOzvnnUtnLlLgyihd6pm+oeCQ55ZkhO
	HiGaAAbkVeSsdoGTf6Jq5ye5K/N0MBokjdJM7aRP6qbu543egSLMc9pLvFMT7ouA==
X-Received: by 2002:a05:6512:3502:b0:5a1:3d08:cfab with SMTP id 2adb3069b0e04-5a4172a9d81mr3298109e87.23.1776637481976;
        Sun, 19 Apr 2026 15:24:41 -0700 (PDT)
Received: from localhost.localdomain ([85.143.146.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad0fdsm2554297e87.13.2026.04.19.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 15:24:41 -0700 (PDT)
From: Rand Deeb <rand.sec96@gmail.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH 5.10.y] ata: pata_sil680: fix result type of sil680_sel{dev|reg}()
Date: Mon, 20 Apr 2026 01:23:55 +0300
Message-ID: <20260419222355.5842-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit dafbbf5c57dd6ae01d20b894bc2200e9d9834c4e ]

sil680_sel{dev|reg}() return a PCI config space address but needlessly
use the *unsigned long* type for that,  whereas the PCI config space
accessors take *int* for the address parameter.  Switch these functions
to returning *int*, updating the local variables at their call sites.
Get rid of the 'base' local variables in these functions, while at it...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/ata/pata_sil680.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 7ab9aea3b..fe60f884b 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -47,11 +47,9 @@
  *	criticial.
  */
 
-static unsigned long sil680_selreg(struct ata_port *ap, int r)
+static int sil680_selreg(struct ata_port *ap, int r)
 {
-	unsigned long base = 0xA0 + r;
-	base += (ap->port_no << 4);
-	return base;
+	return 0xA0 + (ap->port_no << 4) + r;
 }
 
 /**
@@ -64,12 +62,9 @@ static unsigned long sil680_selreg(struct ata_port *ap, int r)
  *	the unit shift.
  */
 
-static unsigned long sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
+static int sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
 {
-	unsigned long base = 0xA0 + r;
-	base += (ap->port_no << 4);
-	base |= adev->devno ? 2 : 0;
-	return base;
+	return 0xA0 + (ap->port_no << 4) + r + (adev->devno << 1);
 }
 
 
@@ -84,8 +79,9 @@ static unsigned long sil680_seldev(struct ata_port *ap, struct ata_device *adev,
 static int sil680_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned long addr = sil680_selreg(ap, 0);
+	int addr = sil680_selreg(ap, 0);
 	u8 ata66;
+
 	pci_read_config_byte(pdev, addr, &ata66);
 	if (ata66 & 1)
 		return ATA_CBL_PATA80;
@@ -112,9 +108,9 @@ static void sil680_set_piomode(struct ata_port *ap, struct ata_device *adev)
 		0x328A, 0x2283, 0x1281, 0x10C3, 0x10C1
 	};
 
-	unsigned long tfaddr = sil680_selreg(ap, 0x02);
-	unsigned long addr = sil680_seldev(ap, adev, 0x04);
-	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
+	int tfaddr = sil680_selreg(ap, 0x02);
+	int addr = sil680_seldev(ap, adev, 0x04);
+	int addr_mask = 0x80 + 4 * ap->port_no;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int pio = adev->pio_mode - XFER_PIO_0;
 	int lowest_pio = pio;
@@ -164,9 +160,9 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	static const u16 dma_table[3] = { 0x2208, 0x10C2, 0x10C1 };
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned long ma = sil680_seldev(ap, adev, 0x08);
-	unsigned long ua = sil680_seldev(ap, adev, 0x0C);
-	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
+	int ma = sil680_seldev(ap, adev, 0x08);
+	int ua = sil680_seldev(ap, adev, 0x0C);
+	int addr_mask = 0x80 + 4 * ap->port_no;
 	int port_shift = adev->devno * 4;
 	u8 scsc, mode;
 	u16 multi, ultra;
@@ -219,7 +215,7 @@ static void sil680_sff_exec_command(struct ata_port *ap,
 static bool sil680_sff_irq_check(struct ata_port *ap)
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
-	unsigned long addr	= sil680_selreg(ap, 1);
+	int addr		= sil680_selreg(ap, 1);
 	u8 val;
 
 	pci_read_config_byte(pdev, addr, &val);
-- 
2.43.0

