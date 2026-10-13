Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABA47F3AB
	for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865908; cv=none; b=XEQCeU0ZX4qp9ofn29GaQngKRxap2rfPN9+SQsUxgvnr/+rZnpdfh2A7ZLPeie/eXG1wYVq8xsy45l8ktX1eH7Qbpkyt2/J2Jt3g1UTa5Xip+ITuAH6iHnhVZhxe33gkszitgaVQbDUYWjI6dfRm4Lg8T4CNM5WgjgjrdyJQoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865908; c=relaxed/simple;
	bh=rGX8tOba6jd3hMhu46fgZbE2VgAvJd9oVtGKO0IC7RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mS3eygCSUij62SGsNwopTeg3oFjdrDx7a2666vM1zJUffW6h95I8Pn5VFJ22JD+fyJmOlYOcmY4Y8ktQB0hWYoZq3f8qKgr6Y84YS4gLM/CYpUBgpk4wGdLnBsL0oXbDOGv0geIrww6ftMml40QyL8fPWmqpsM/YqbTS9Jat9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ+vjs76; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ+vjs76"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a166199820so15462735e9.1
        for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2026 21:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791865905; x=1792470705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJEMpJJIjBPL1CoD1ORxkrw98F0RUHFdKzuD8uz6jZ0=;
        b=MJ+vjs762yG7OMD6kPDfEpUUl/zZ2MDBKBkYy0PJ9AiIQHnQSCvsNUe4AxPvJujXlR
         sznshV9xcxfbTjCceK+Zgynrw4v1RjHL0d2wV6mP0nL53yz6h1FcNAlfVCDgBtSYlg5y
         4Ix2Kno54q2hESU7UKmz/muOteGpS4raYGmNixoT2kMch3pzFWxTr13ZNTkStLBM6r13
         FThbJOT0eZ4w6cwc3M6SR4ujRiBXaPXlh9sJR7CtAN0oLIFxHxCIofgKaQbHZ0dT2nIi
         B1RSX8Ztc7olFS74au/2H6WkQmO0OKEDUlQ5hkE2Na4H1OD0yjGfXKrRnDs2Vpsb9f/+
         +jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791865905; x=1792470705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJEMpJJIjBPL1CoD1ORxkrw98F0RUHFdKzuD8uz6jZ0=;
        b=Jzvl11iD6zLYQUhk/sRFZhBd/+vXNGtgPN8leZIFdlMX5KPPgKLuSmUqg1Crx0esmW
         iEotzkylzk2zgmHC+0zea2lR9dSAXHzK1zS7pmz7cfvBuALbZ1DPihWcEGRqz4Egs6eo
         wa2OGMU6IHFVHSujmOfEK87QdGwx9GEKIFWz2/KbopLcDWr98C2iXTTgRbrVn1yWDbYz
         MDuiFHoWZU/pFuRv/aPXpcVaLqoLyt3zLZOvgzIxCH/mb7ZEd2MOnXS7FGKg7X4lOgsu
         QZ2nJBwEsStqnY4dy5Ib1XMq7DQSt1cIEADBGDtZSosDfmlt+Uqkcz5KcXw/rDre6ehI
         FR/g==
X-Gm-Message-State: AFq9FYKQRp4cuBLjunjUEz4ErfOGQmMIARWPEtv2a5GTaMML8/GjZjEX
	PVm2htBdjhynZSUR2D/44TeVWhxlD314uAPCED1D/xKv3hTA5yJugK8gHaAznRSC
X-Gm-Gg: AYBFou2lIfpAFZDWFchzfdVM4TsCLhl6qjVEaKY2Decak3tlGvlU0eW9kqp/2OoUT9A
	Q5QGO9orRj2IOnm7DmPzwYM81ijiHI3d+3poUkw9JhLdhz/3GJYruye+KDMxvm/frB5kbr832GO
	B8cObZLo/B20rxj8uua8R9zLu4YzDWH5v3MPLpLICj/HwJnchg1dCrahiWukkHmBNQi10GGKA/O
	B35SKYXumXRIYgaOGWGgzIjT6OGQZsnQuLVazAifM5i1ikNcG5PmioOOkmnno3yKBEBV8wO3EpR
	HosiskihbmGYn47wf091FBxNRLh4xXbm0imzMRVNb+Zfb5Ew0kQLLcaBxKIPTvDP1D8lVfJo763
	5HM0QY/CvMmYuNeiluVDFwRf6HiLSvaj4AxgHbg/v5GfZcGfbEQK/nqjYEUgeYRXoBIyV8VzO9g
	+oY7A1D/F6dBorDRSPFheMEJAtVSWgWrvFtXidv8dpRDMnGAXsUpIzv27gmNauL8JQo+2OAPbU
X-Received: by 2002:a05:600c:3512:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a18e4913c3mr189922375e9.8.1791865905153;
        Mon, 12 Oct 2026 21:31:45 -0700 (PDT)
Received: from jo-Z6 ([2a02:586:e82e:5000:7fc2:feac:cb16:51fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18beacd2csm364086845e9.14.2026.10.12.21.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:31:43 -0700 (PDT)
From: Ioannis Barkas <jnyb.de@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Ioannis Barkas <jnyb.de@gmail.com>
Subject: [PATCH] ata: pata_atiixp trivial fix
Date: Tue, 13 Oct 2026 07:31:06 +0300
Message-ID: <20261013043106.77115-1-jnyb.de@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce mwdma_timings to match its members

Signed-off-by: Ioannis Barkas jnyb.de@gmail.com
---
 drivers/ata/pata_atiixp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 74ef9195bd..b4eb9c3f93 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -149,7 +149,7 @@ static void atiixp_set_piomode(struct ata_port *ap, struct ata_device *adev)
 
 static void atiixp_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	static const u8 mwdma_timings[5] = { 0x77, 0x21, 0x20 };
+	static const u8 mwdma_timings[3] = { 0x77, 0x21, 0x20 };
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int dma = adev->dma_mode;
-- 
2.53.0

