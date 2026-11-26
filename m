Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728335;
	b=EwIF+A6GaoBGYTHzepLs4Pj0DQb7pwlFXM/FqSIymuOMKvd8ihRTDx0kv4CP0PnnkEHX
	 +qzbI38DwxqSUDB0Y+gCluqicOQOLVncWqPgmDVe/9BWFRq15dnWwsh4FhgH6BkSrYkim
	 pYMzYpEdzbcM8lbPo0h1XqUMyYOwZWfr2ybsGC6uTC8lWWt9I/2MHFzKuVW9uhjzf6Kuo
	 FtbHq1TinCPiz5+Nh+Vv20EHyx3X/sUKS+xZFJegeBZL3Qdsuik09vD4XBt6hvCqJuN7t
	 kR8bq0S2Vmva8N7bQAg4FBhLT8y25svqEm4+6ljXXwlXeRe5dgZRtvNvR9yICUn5KYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c5eeda9qiC62nEeMHC+7zZ2MMcAFNCCGVAvY//zFjIY=;
	b=4YK/G9hH4VTVvZYmrqAAYw45amY+znomP1yhEnq0GfAUbCZyN7ijfpP7ewuWbqAECKjW
	 ivP0sdg8bFdKIDTP20xLJ2ofSBgU7QSX8+HryToeVoyptgmbkK7sZ/VH+fkNmvr7910no
	 IuhwmTdKsq3ExKF3OYjHXP9S499+dgV1UaFYO6Hxvw0/xwFWU+wpzFgY3bNostSY31w+D
	 y84/vJuSZitIarD18h/yEd7LjDEbVLuDYZqcpT3eZKQYk+XFIocXWz+/uap6yynUQO5V+
	 HMfs21MS/UFeleKBkkiRai0WK4rWX17Z9G/MSAG63F9MVWVoZYx5cE0qVhqF/vwvvkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cVHut988;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF57606A31E
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF57606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cVHut988
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b532dfb874so70476a91.3
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795728335; x=1796333135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c5eeda9qiC62nEeMHC+7zZ2MMcAFNCCGVAvY//zFjIY=;
        b=cVHut988tmb8bptPnF4kHEwqu3fFCgzOThkzmWdKCvv+1Ax8ef08zxZ23riaYUWU8t
         2AEMfYHUH+9mzoRqTcavk2ii6U60jZym0lfxZe4E56St/EMjRv0CWrf4N3mWLVCLNZhh
         4uW/nBxH6BhLV6J8tbI3sW6/HDW/HVxdFd00yZvtbeKQivhhbg0Id8AL4hwEo4sq3ONS
         ucicIXN5T4dG+ChN/iuBe2p/5EbXWduj6YoaVmnd+kTvrjPSCP+rQunII0fLRMDcyuii
         d+4MDkqhPgLYj3MWErTJHbzFe6WVlHis/LXoLpEWqRavUeCuDLcyBcNC7pomaNeylG7y
         Q+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728335; x=1796333135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c5eeda9qiC62nEeMHC+7zZ2MMcAFNCCGVAvY//zFjIY=;
        b=Y/o0TsA3sR/roG+mywVy+dBgpEfRoB/8QCxzH9D+IZpSbe8SjAV39dknFFNuHzGBG6
         86vQGXz7uJcZStokBUnv0D8nGamk9JZvswwjILQKt/sSPnHYdcO3GZdOJEMYWI7vXl9D
         w8PpHdGD+FRF0OcakXyTbfRbyPbP5IWuheqY/p0F/hPW7Si1wVW0YzofXQo6tfY/h5MQ
         cCQw4ln0sfdYYrAIzp3kQw9i1xESdBiQ93JPRarSRahO4bqfkxXR0Ox3xW+8XS1ChgtB
         D5Z6lXTJ416TeM6Kw/zgp08rIaTkJoXF3c3P4VRWrYeF2To3XYTbduCYbs8iHvh/ugtH
         rEDA==
X-Forwarded-Encrypted: i=1; AL+hErHTNHPmELRm4O8kGEjbNiCKnrDVE3b/nLsQewzcb0WADrPGsc7DcIGuPD5he0xDrbFUkDwqa1rAC0g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YIpt3iNeMIXXbeu4+VXRtHGTu5OhH2Z5ezu9HEgz1tfjSGO2Z
	H3krAUvYCRn+Ep5qBQ915aY9yTb594Ml+9ekrTaQJKuG3RkOTmT3r18F
X-Gm-Gg: AZFdTZe0+2FP1eCeIhjGZStD41kIGnzgjljwgr95cX5TzLWD5hKlj9UjKbOvlLUTMYm
	+0g9WcoJIBW+sRo8iJAJ2riF26ne5tjFAmC7cZpbY2VAPaXC8NAmXFMfCwnP+Q8+EH6j7x15hhr
	XIOzH3MF5pPFnOlxN19dpfxOUEkHbU+99xDF1L0y+RXqySdg5nUPlu2bfd2M+/yvVi3p4AZglGY
	/GQpx/1bQ0LuogLekzh9a2i3T9issapNqGQl/kHTG7v8SgYkpmpyUr3FoyuIsAhTLrHWALRuCJk
	Zjze5bnguiU3NNQFKiGrmooMFDNKhmQzXvLL1Jn1DH+PUTkNe8UQvx78Q2TLxjfv6JyAZZgqM0v
	zYSjdjrxWkgpGc0br0xmCnpxnsFsNJCLdh9t9dHZTrw7WikQ2fstCL4dbUFAwV3FKqBhH1Hq9rl
	ACPMTE4mkvdLE7bcd1rPJF5V7eUSFmxjzSKZCJbmA1dOlRQSSViuSMqlYCsvpisrWEGHkwWP3uG
	emrI+6xKkUncpO6pU7YW3Mu6bxI+KGuFpJfJ4kDnUaIVVwGJca3ZiZPjCQOA8Dxg/hzFaMcIzay
	DzMBcaSNPfSqrfgyQyRKqa1UmVbRY1z9nRv4WD2YVXHfKYCIuA==
X-Received: by 2002:a17:90b:5888:b0:3b5:a3:442a with SMTP id 98e67ed59e1d1-3b500a34677mr6071730a91.40.1795728334841;
        Thu, 26 Nov 2026 13:25:34 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm33482401a91.7.2026.11.26.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:25:34 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linusw@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vireshk@kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v2] ata: sata_dwc_460ex: add missing newlines to error messages
Date: Thu, 26 Nov 2026 15:25:31 -0600
Message-ID: <20261126212531.28154-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126051523.14431-4-artem122novak@gmail.com>
References: <20261126051523.14431-4-artem122novak@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Terminate the error messages with newlines so that subsequent
kernel log messages are properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 486ea94a0184..c2bbd991a460 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -421,7 +421,7 @@ static void sata_dwc_error_intr(struct ata_port *ap,
 	tag = ap->link.active_tag;
 
 	dev_err(ap->dev,
-		"%s SCR_ERROR=0x%08x intpr=0x%08x status=0x%08x dma_intp=%d pending=%d issued=%d",
+		"%s SCR_ERROR=0x%08x intpr=0x%08x status=0x%08x dma_intp=%d pending=%d issued=%d\n",
 		__func__, serror, intpr, status, hsdevp->dma_interrupt_count,
 		hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag]);
 
@@ -498,7 +498,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 
 		qc = ata_qc_from_tag(ap, tag);
 		if (unlikely(!qc)) {
-			dev_err(ap->dev, "failed to get qc");
+			dev_err(ap->dev, "failed to get qc\n");
 			handled = 1;
 			goto DONE;
 		}
@@ -612,7 +612,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		tag_mask &= ~(1U << tag);
 		qc = ata_qc_from_tag(ap, tag);
 		if (unlikely(!qc)) {
-			dev_err(ap->dev, "failed to get qc");
+			dev_err(ap->dev, "failed to get qc\n");
 			handled = 1;
 			goto DONE;
 		}
@@ -707,7 +707,7 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap)
 	tag = ap->link.active_tag;
 	qc = ata_qc_from_tag(ap, tag);
 	if (!qc) {
-		dev_err(ap->dev, "failed to get qc");
+		dev_err(ap->dev, "failed to get qc\n");
 		return;
 	}
 
@@ -1186,7 +1186,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
 	if (err) {
-		dev_err(dev, "failed to activate host");
+		dev_err(dev, "failed to activate host\n");
 		goto error_out;
 	}
 
-- 
2.56.1

