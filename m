Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CE837A487
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892260; cv=none; b=h+utVm+1CyBOQNquNDQ1RRhq5Q52i8dfgQq/DfLucN7MgLlyTpVhUnjM29fB9PUnKdOlsCc0A2+B7l+CJnYG5rpvT+wny5kTHQJqekP/DoclbJDeGgWXEGSQ5/g8MTLMUbab6pdIIQ50dCfe4XBGuptgw6+0ClVHs0cS5MvDoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892260; c=relaxed/simple;
	bh=Fr6vIWHzoEK/IHHnS7kMjTaf3CDbcnlP99n14LxLBpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyEk5LA36y7Js7UrwnuJJRrQxIZ0kOMJCNbe4cD8yhdeNUgyh7D8ltXRtrevYiHZUMxSJMvQnmPHNBsFqxmRoDHhoAcmaDrHZ6VaJufrj8RB6LZOuiLsrRef1Ilui1DMFtSvJ9LjpW9xEspXPNJ0by48dOPAZxaO4WepTNOBw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZmqRQxZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZmqRQxZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceb096e675so10770525ad.0
        for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783892256; x=1784497056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lfXe2Fd3Jd3U8LKEcL3Fi16GHp5v+t05WNlpCspEzlA=;
        b=MZmqRQxZgXJjuF9t4ihh2FRCIJ5vmu/FaWURqTVnhmJEY93XOt3DZH9RM/OO8DVGD4
         0u609CQ13uNIxyzKfq1I7qiATckU+rLH5XU7TyNJ7zQeXVQ0ekOjfKzsDaL0bleBgC6z
         1krMvLJXQL6GRTdlfzKXPaafSaRU7F7eQesI387lW1CS0DCMQtRrF2WkX7jklQERsVS1
         lgHRga1ZhkLaD4Zl3UD0u2hHOHi75I1cqt0KsUXDqs0WH2hn8pfhpFLjLRALFDmnGj0Q
         il09Mw4MueTNtrrlJVSiIdU3fpNkTKKWSMrIu5K6v4/1XG7pGTEkW4HeqldSGgHLZDy5
         fSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783892256; x=1784497056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lfXe2Fd3Jd3U8LKEcL3Fi16GHp5v+t05WNlpCspEzlA=;
        b=jaQCZALTmpoPz711Vg6Dx7s8oCTfFgJZeORRI+PsjGluUhSVLgkpqHSiVlzgTvGxqF
         1Cbrz/ty3Y6jH4+LF0bguEhCshZ+X61oTZzRKnZ/Hc/5EvA+z8FJm/4JZZ62Thvg74c0
         RuevEDUccOArENphHTsyft278NcVpjVmOhr1v1Ig18aypkjrsaqMsg6zIyiW43Akb4LO
         XW0gwkDJJI5Knc4RjypPhbl7UmBnXZpdHV82e5JMBCcFTZK4GgE0/9BO+lnOie+T/PFq
         fZl6D3Uo8cmKvgTxdXjBYtR91F+DTGNVO95cH8+y2pExul+gmnjNQRFOCs+UsCPY+7HT
         xfig==
X-Gm-Message-State: AOJu0Yzs5E+7EU7v22u92nM5Aq3ZvBxlWB+8+1UXhf+57ESMAPZ6r+LY
	N6UsLqQFAFGrOLUubNz6x1QwTeXB/5MsD4yVTpfb2blB6H5rb8cDJcAWCXL3/A==
X-Gm-Gg: AfdE7cmpGhwU2FmQZahXHqdjHhOJO1usgvvkE0A6asALKIrJTQObCt/q15EfZzUbh8T
	QPO95Sr6toSN6L+ZiU9KC+xBihfrgPojGlQQewpTXGOZbwCgGaUs1w8WwsKemEqYh5SxZaYLnVj
	TiEv3KQJbjwpdGnvJgtWSJcw81Qg2m70fL+MNNC6zPK3CauAE3FzaafH94ya11myF3RY4Psm115
	xAodSv5weV+B92FL/p2kfJ0A/la9nPw3wqE3f8s9sSmBa5sHfTd+s/GwaVgQ4+s07Kh9PL9GX3h
	epQSdyB7K0CyKvU0/gYiaOSpAqFsjIKaiuUH3VAjH58+ajFf3g8HrPK5HBe7/l6if61fQyJcvTG
	wm4WX/AqiBJW9ZfPY4AsWKxjs5SX6vWSzj8xr80gKL0L0OsI9/nUpcy6/7uELZEBnggvlqKSf2V
	y+zdMKjvHCLp1MfyPMoSisGFr6yxBcxJz2qOOkn9ROf2t8uUoAkIEMwaPhh32nYpSd0JvKJcSFF
	PTDZbLX060QhBDrd8bdSM+sYFfS4jc83X+NMh+aOq3DF6DrHDzLir02+6CVYS6+iQ==
X-Received: by 2002:a17:902:f68b:b0:2cc:7c36:2c23 with SMTP id d9443c01a7336-2ce9f178346mr60043925ad.43.1783892255667;
        Sun, 12 Jul 2026 14:37:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfb7aesm89082605ad.29.2026.07.12.14.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:37:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 4/4] ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion bit-scanning
Date: Sun, 12 Jul 2026 14:37:28 -0700
Message-ID: <20260712213728.824420-5-rosenp@gmail.com>
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

The hand-rolled bit-scanning loop in the NCQ completion path has an
infinite loop bug.  When tag_mask has only high bits set (e.g.
0x80000000), the inner while loop left-shifts tag_mask until it
overflows to 0.  At that point !(0 & 1) is always true and 0 <<= 1
stays 0, causing an infinite loop in hardirq context with a spinlock
held.

Replace the open-coded bit-scanning with __ffs() which correctly
finds the least significant set bit and is bounded by the width of
the argument.

Fixes: 62936009f35a ("[libata] Add 460EX on-chip SATA driver, sata_dwc_460ex")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index bc543a408963..8e3fc713891a 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -607,14 +607,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	status = ap->ops->sff_check_status(ap);
 	dev_dbg(ap->dev, "%s ATA status register=0x%x\n", __func__, status);
 
-	tag = 0;
 	while (tag_mask) {
-		while (!(tag_mask & 0x00000001)) {
-			tag++;
-			tag_mask <<= 1;
-		}
-
-		tag_mask &= (~0x00000001);
+		tag = __ffs(tag_mask);
+		tag_mask &= ~(1U << tag);
 		qc = ata_qc_from_tag(ap, tag);
 		if (unlikely(!qc)) {
 			dev_err(ap->dev, "failed to get qc");
-- 
2.55.0

