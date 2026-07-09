Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D32372EF1
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564332; cv=none; b=VRQIhmIVXeNFrfy2vJZ2WbUYCyAd5vLkfNmta+sgKNW4/3WCsszRJ/NtmbpV96UwDKjHDc4lsnxC0gv2VroLF4t4lD5rm8MOEAFt4CG8W8MgMzgtjj51cfxNSlOendoON04gsdHbrXy1Blb7LFamVVSFDRxTghaPklGTe/+tuxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564332; c=relaxed/simple;
	bh=nFd8VNJfU3myVZBHymp3cLlppbZEAbYTvyZX1OHSZpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4roqsRqkgcfshkHCZM+7xXBK8MMtGln70KrO7ODghabveN6LB6SeO0TKRT1YXCtsFQKu3SK1YlEkLdQi7PEHlPhNjSGqigDD4Q7OtC+j+SnQWKnNac8M32Uf9R+QoceYyas7fpzaLKj9cy4BSUB1mH5v5+39HipVRqnBk22bQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsyYVzou; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsyYVzou"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so458211b3a.1
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 19:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783564330; x=1784169130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TmOxRfgq8x+l85tT02jD5PytU+B1L3p5EI6y3uwnQjA=;
        b=GsyYVzouryA2QSsYyfyW6uMRAMgjzEqpHIziHVcOcEPla9lrdIEoWPvjY+U0EHfwKs
         /4yX9W5uRlglIOcE3llgxSamRPA2i9RZwWvGQvGRBODWH34B/AhOXS8uGPdR3BPO1th4
         Mu4NSjUHyPQm1kZjCCEA3Ac1fMrkr3iUkqMrgNuB2KRXEheAv51vn5+F4YJ0UAYOxyjR
         Ch5PYvGfI7q+qf5FdJ6OuTMHsmGOeUlsUBtlYRLJmn2XZfHWuvQ8HQgz6x7W862iNKgx
         /3he+O/2sePjOlO9Jw9AYkSZVAN/k++yXRaJqDDRiB0yvuxsfZWqJO7pCsoSNAUJMwPh
         36fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783564330; x=1784169130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TmOxRfgq8x+l85tT02jD5PytU+B1L3p5EI6y3uwnQjA=;
        b=lgu4BImcmWEbTGOAGOAPAKc3C97rj/b2ZE2SlRUNArDdwIdsY2LD4jvqLerQ+Pmrlt
         e93o5i20L2oeE81+OE5C/ENLT0+ODBXH0McKBuQAasqbwWQTU/9bEQacIngP8XUEbfnH
         +ZO9v+Nr0YzJgGrQKBNzS7Ud1PbxcJWuJpDz7ZGkAWaVCiohZLhWK3c5z+tbN9V66853
         bv9yWWgWLXgQZk8I2b8BNEwi1fm9wJVQuZGi/J7KwJ2DDJO/OcyeRQ7JSdsbn5wlhWqC
         JyAYy6W4G7NnTkARmLL65ZVJuX3As/kT2s5TeyKzRue0q8qZ5AhpRpjdR+ilU+8n8zBc
         ORmw==
X-Gm-Message-State: AOJu0Ywu03G5SdBvfQz7DLgPt0u3iVE2fBLpt+3kDSdgrj8k1tNx2J6J
	fBj8xM/W56z4NbokjC0tsAxyCj7RlkldBTBNHQtjbfX+S1tBxjzrWV1N+5CQ6A==
X-Gm-Gg: AfdE7cnSl3XDfI4wurcrmBBK9uvH7/HvnbqihAqVxY+zjss+EpoqfzYRGwf7X1h12XY
	iFw8NzY+LVvFUe15zXSAqFyxpItDSr5OxbXOMLPbwKe9zja8FrzjjjaE/PTI0B4WcFbChq9yZwK
	VCKuEzSYYaql/oTJo80bS83J+sno9jF3X8+530dpTEHQbEzAya26pfrxxWWPgDl8iE+suYqoy/v
	Q9c9wJtWbyMEwBA1sYIYfVdWWaxXyZoPLInyK1Fs/gNcD4jxAb+tvh1jAqejITQOh1d4xV2TJXJ
	6Wg3zrlSXcC08/pE/X3AW3H9sLaUF74V6V+tCh79CkBxGaSygm7xiQ2kD60OFveCLJ+lW6jA1Rj
	0MbqiFcgi3kO/RNE5jxbMqoeeXtu0/fa+FGoHJB7QTnC/QzfKcdk0xC2vYsp4eg1AkFw5inC1Qi
	N2Fd5BbDJYezjMG4m/t6OsSyWG42A9jlQUUycIAHneTIxa5OQEfX2a1WG7UYLH5uRMycYZ97bPk
	wD174KccQZXNheurYsDnMPeM685sqxnSzCVTy8m37lZcQiQbMVCi/yjbIxLVlHBxg==
X-Received: by 2002:a05:6a00:848:b0:847:9803:ec6f with SMTP id d2e1a72fcca58-8485aafa6fbmr885416b3a.10.1783564330465;
        Wed, 08 Jul 2026 19:32:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm7935954b3a.14.2026.07.08.19.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:32:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 4/5] ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion bit-scanning
Date: Wed,  8 Jul 2026 19:32:01 -0700
Message-ID: <20260709023202.2132165-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709023202.2132165-1-rosenp@gmail.com>
References: <20260709023202.2132165-1-rosenp@gmail.com>
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
index 097b060a9ee6..08d40e287bac 100644
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

