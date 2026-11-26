Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729480;
	b=ez4D7vy+NfIoEjvFgv4qNXy89PNqmUceBK0YcqriomyNaWKhlmJfopBDGuwNhbdNxAhd
	 CiPmHpJ1gDmcCRp9+3lgo+0O9v2j8gEEC1AtCEesznBoUIrNXX7AJqI/5iOyi/iN9qwAA
	 lGE3MeFho6xSLSDlWrMZ89NgFBukiJYZjCwNa6oemtvMQ+80VIaufhvdhqIYhEhr4q7HG
	 cE4ARi27Rdg8Om+MJ0ukKZbsBOykE2jXwX3AihNOkdSJAaEVYsfGY6OhSDcaxKGsfPwVH
	 J36Fn3quKBDXpCb+BWF1ANlhM5Ch8K2QR2UaoVxJRABVvrGmvNeMeJ/vhpwerZiP8lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jYp66D5Imzo0CzQJ1wEzlIF7yj6HUJmIaReA3hk0gfM=;
	b=VoxvhQh1ySzGogg+j8YiftzD5sNSOmgIly/AkNsybHj2D+/tK3O7l7GEUteEPUrzC8LF
	 VEjMp26E0Df9+J1p/adQD7fFUxLUfqVhgnumrIFnqJsVl25QEUHdAzYwYSFd5jNhjK40t
	 cSNSfG38SbkcVM/w/Qyon5xn19ITtLJ5yivdTC65dnpEGkCJM0khhx3reNOidMfQZqDaz
	 c1OCrVlZMsQ/drAocsDsG0hLHUCnMliMFuNYQ3BxZYRp5ztwVZhPqmdjMKTn0WLFJSDl9
	 jFZk2arIS2uZQ27bi9VQc3tv6YwV0ShtmGrFGeU/8fF25bk+Mz4EGatCARtjE0zZL6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MeXNu6Rh;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C1606A6A2
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F4C1606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MeXNu6Rh
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b501791bb5so985082a91.1
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729480; x=1796334280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jYp66D5Imzo0CzQJ1wEzlIF7yj6HUJmIaReA3hk0gfM=;
        b=MeXNu6RhMH6NtS5M10r6Sypbi8N2FkGKpNVlD1XeOIsDQI8CoVkff0mm3nvHXsO85z
         iRxVfe5imA80a1cHAyMvcc0B8Fp4vsQQftUdRVLYY+A7VrId56kngd+gFCYvttASUlsY
         e7Yn8NFSR8yx5UYgmSkG/JzNXSmpkwLOHWWLY72mloBO07VdVKkNgTH/6IO2VrXvQAu3
         OrOrHY41DUmb2lv6EHL9UT9Lde06erqR702VmV6dYaMgYR1cRoJujBGsLku7owxHbrP+
         lUSHfIiKEjgJnNofp1i6b9W0iSi0UmzXKM6BvJJJRZ4OGTMv7gW71NVOIVnIXTn0Wteb
         WwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729480; x=1796334280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jYp66D5Imzo0CzQJ1wEzlIF7yj6HUJmIaReA3hk0gfM=;
        b=zuA7tNtX2rTpR6lenueIAiXTgkku8Jb3wYmYFjjXpCNUcDgp+kfxrO6I5Sk2g8ctPH
         a+WVfgE1SeAbikndqw2QlT/GSwWZaoLzozL2A5rZumjyR9uV4tokxOJRq4BbUpCk1baK
         Xan0UJZlsBmKKJ9PzUV0RlkSVqmOiqajEY30nSO0RBju+S/5yb+026NUMmbBMNDiZgDv
         Yzgxn0ZcPgq92f+c0m1+uw1wt90MDlkjRLo+iO1YmnFpOtv5K5KD03UWKkfLTyot+4uE
         rHot8kSOK9zitsHrD/r/y5lsQCTpPIKLQO3ZOSA0uE9ilsFfExhQja7nz1jEA4B9AQY1
         dQAQ==
X-Forwarded-Encrypted: i=1; AL+hErECepqGILNm1h1P5ikGN2Z09q1VUW4qQY9VkyiOh458qSagA68PDEhzaUalwvD8CF8gUSPflNWUXlg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z1hmYOdQV6+BPPwimwOPalE/0Hs7Lz6E4XrVZZ43jrhnrc6QD
	Ipnop2WeEllDn7MBe4xCxaShpXhMD/UA4dKY5+yznrrx1itFMRv8ndVn
X-Gm-Gg: AZFdTZdlNDKzMaTk1WsFfEe8l5hWpjy+fcG+DY/EdkZNo9b8pgibr7eW8oScW6iWQcx
	6Lfe7rsp4crVV0qUpm5zkOrxxuVPeI0YeOj+Janr27pwCECmXEv3vL4DIS86azCWnBv9UL5wDuo
	HmRVEIQGCkUDhuaRsp4P6AXHIt/kPtcRnigMFeRT816M77iMGuZ4SnSbHCGbZwxgo6FiWLU6gq4
	uzoC55Kv/nKkl4wpTlEfaRRl4q0TqAMF8LIiC6vTcK6wuDXlHlVqyBGjR6R5UwWio8/bW5dzbIW
	Ks9hREnZY5c+vNWKPuLgsnrgFlR9RKjdxmZMZkPWFG2eZB08kET++KjY9nhhBnwW36v8bHj5T5X
	zbfaGcLPk97DEvYMOJ17+8N2AjRA/LKMcuyf1yw4Rxwq6aAevjOY4D6773ng7dKxfSnJ2i1EtvP
	xIJoaZKlR42LMxbp2wuV/hUppoqoJcCxPxbaAWq16vjZ+1oZI1Lyw59Kqy/va1yalZgeUpKxMKq
	dZRVJM8tqyKVG0pVXkXlsQ5as5J711HRoctGFDP2vDuJLtVGXlk4SPFZGCZh9wwwcf8ujc+27BD
	GcHteYlbvOf8gkaGuRas8TSi+6Ph3Z5ZaiPoi23azczypGokEg==
X-Received: by 2002:a17:90b:498c:b0:3b3:8b61:c44a with SMTP id 98e67ed59e1d1-3b41c7d5c1cmr17865192a91.4.1795729479892;
        Thu, 26 Nov 2026 13:44:39 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm36176538a91.3.2026.11.26.13.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:44:39 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v2 3/4] ata: sata_dwc_460ex: add missing newlines to error messages
Date: Thu, 26 Nov 2026 15:44:32 -0600
Message-ID: <20261126214433.38317-4-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214433.38317-1-artem122novak@gmail.com>
References: <20261126214433.38317-1-artem122novak@gmail.com>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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

