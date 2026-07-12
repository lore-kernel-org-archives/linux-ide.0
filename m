Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39B379EC6
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892257; cv=none; b=LIZJ1M7SftEdd/z7U6T/BdoBAAk7ttTud9vgj9kg1xMpRmYwWEpCj0jVkfrWp0grIzPMxEMEV7kmWdLgAR61omopp65uzXSmofh7IqqADU0Qrac1cxx72+IuZ+liEOicdsC/TZ6elrt2ET40dkCcgrzuHIeQGfnsIfAGMhTVet8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892257; c=relaxed/simple;
	bh=keTxroWB1ulOIKLHrJ0vI3TRrY7IJd7VnUilIRrP4UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dea/lSRJhhIGmW3oO93zvyhqnTcZKxQMw53g3m+VVAiHL5jvyhm9twpKI+EzQuzKLHSxL4TerkM4F+Guonao1tsrAxLsoLVdpWjsCtnK2Karfh26mb5VOKdKUyDJ+vQysSS6iorI91sL/NjzqSIxOpLjwHI3yWKgYOMQ5ucAleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUyVMzUj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUyVMzUj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacf197759so36955555ad.2
        for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783892253; x=1784497053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ArRvRxqeT0i+T/S/4UgCHgV2A40U9Nyq7CnLb6H9r8=;
        b=NUyVMzUjmlpC3GtW3iMynLoVFKKLsouQfRuwnPMUWosYnS3oU6fsO4prldBnYxa/7b
         D/g5/ZPWS9rWi7cF1misqf+k7EzERATjqhKODKekecrBoUjlBLfIfbflyyBo6K+HmJ2d
         WZGWeIfvt7PCPt6O5Rtb4EQzth6iVgdrvimwZvzcGZYIdsR29mj1+2vaEzlmZ0wUYeyz
         D54sCIPEgoYGL6OT6RTpgzmhR6Cb0NbRZHbt9xcYB4SzpQx3owTexdB1e5pKa1Zqd1qP
         FblyiiKorPGIPIXfdY9hcEbVJ+a2gUDktnUKYDA8cplqm4TQYa0Hj5gOrlajFwGTkqKx
         ed4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783892253; x=1784497053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ArRvRxqeT0i+T/S/4UgCHgV2A40U9Nyq7CnLb6H9r8=;
        b=XwXd+o31f5lp/6aSbzIR8yji3Z1IXPfpQyMcIyo+4tmhyXukC5fGldm7ZnbMcW1K4L
         DOkS2BehIIR1Zd2L/W9H7fVgB7TDllX4FpeFKwQ5yd6gmoHW+ZcAfxrPPO+6I5hfxQA0
         nfkjkG6aU4ZqEkdXjgIFbVFsL+xdF8jq9BdfTNvL+uS1nv0v9ALr1i31l86x/P+zfrAR
         GxvZilUk2Qk6yOzvuAw6dDoT5sZs1uu1c5nYcs+qP5rV1Gpzf+JKTot5AoRMtoftA09p
         R2yJAYeYH1+duDZ0fEtbFKZDWfzjQqzMYnu7h7c4JKTGVTkU+oyEF+bFe7OtKWa0g5s8
         Mjfg==
X-Gm-Message-State: AOJu0YzVWz4xqetVcO7KM7dIfUJFNcuEINgpNohw3w0bXdutiCwe1Ibg
	uDgGmhhuaiQcmE+TNUpVxr8wPlne5HEzA//p1URdT4OBm8N5jkJ0DNZY+xHf8g==
X-Gm-Gg: AfdE7ckaTgecmzMJJsg7DANy2979/WRNQ/CtsHmsc1PGlie79gcNXsDK3Kb8tqVUu/Y
	IYknFTbanzqVVdw7n3IDeYo7RPGwdkTFWldbUK2pc4dC1EnLFEIGI/e3yB5vZOU/Zd1VX/7o+JR
	CSbsg0fzPt7j6GTiSoOI2qmlIg3GO9xkftbootGonekrQPEnHsufvgryTp1rGcryqxWNNddE9r9
	lgVKEpzCWlGCn9O3sP2+YW8o2xQbZxB9pO7KlHWB9YA5fn4eRRfELaZqYZN/3iFo07yGcKPRUY4
	prfuk0TiJUqBcVu+8rWaDaIKvr55mmv5rV3nUJRKD/JBF0+Jg9c3Bq8zhKiX28AveF0UxKNEDSf
	U1v0pIuJhoHruM4dTqaYh+VAf1znRqkqrMdUwlbJ+g6enkWYFEi9C1VkKBNSMx+mmubJR+1B36k
	pvaDZNyotuzuRFEPUwb6vOGschYjcth+yLhqtWkMGbi00Z6uAVSgl0eykfkMCn3Ed0f/q+xbMAZ
	uncjiODBGB1uyrP0PmeUDmoDW8l04QM74lX8WX6gXnHPEOuPDoUwxr67niE0eT1Yw==
X-Received: by 2002:a17:902:ecc2:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2ce9e59e1e2mr67782255ad.8.1783892253062;
        Sun, 12 Jul 2026 14:37:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfb7aesm89082605ad.29.2026.07.12.14.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:37:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 2/4] ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered
Date: Sun, 12 Jul 2026 14:37:26 -0700
Message-ID: <20260712213728.824420-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712213728.824420-1-rosenp@gmail.com>
References: <20260712213728.824420-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sata_dwc_enable_interrupts() is called before platform_get_irq() and
ata_host_activate(), leaving the SATA controller's interrupt mask
enabled without a registered handler.  If a later step fails (irq
request, phy init, etc.) or if the controller asserts an interrupt
during probe, the irq line may fire with no handler, causing a
spurious interrupt storm.

Move sata_dwc_enable_interrupts() after ata_host_activate() so that
interrupts are only unmasked once the handler is registered and the
core is fully initialized.

Fixes: 62936009f35a ("[libata] Add 460EX on-chip SATA driver, sata_dwc_460ex")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 092272753749..85c5e67e9175 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1164,9 +1164,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Save dev for later use in dev_xxx() routines */
 	hsdev->dev = dev;
 
-	/* Enable SATA Interrupts */
-	sata_dwc_enable_interrupts(hsdev);
-
 	/* Get SATA interrupt number */
 	irq = platform_get_irq(ofdev, 0);
 	if (irq < 0)
@@ -1197,6 +1194,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	if (err)
 		dev_err(dev, "failed to activate host");
 
+	/* Enable SATA Interrupts */
+	sata_dwc_enable_interrupts(hsdev);
 	return 0;
 
 error_out:
-- 
2.55.0

