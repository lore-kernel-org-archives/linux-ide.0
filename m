Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA53BB124
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2026 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617396; cv=none; b=AgbwlFnE8xVJF+NGNH+ZHWySBmcZ/mStFsLYhK3sbA0HyOgCy+Fec6EkIARTYXumax2JVrkw2n55g13LZEatN0oJYRBqXxwGOJc8E/peom/fMytHdRusrC3BvmMSMa8c6aHfjUHNf7qhnEGxBwrPMX/M7IMi8lyz4RX+wtCZX0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617396; c=relaxed/simple;
	bh=uI3m2lowB5Dl3Y/igicn36nVTjsXMEfps+6eZzxAWOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpduqgYFRtepGdygvvZSUCk1kxm7WE2LWszoN3vhqpT1x/bqN/qSeZ1ZxIOFljJ2BbedA9Urww0+ZZhs7gsO3ALH6Byt+0V6cMrKaQJRIsDFbogzGbocLWzhzWKr85a5Xx7dXhjmtoRS06Te9xeVTXoSBVqjyx8173EM/FYJuU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXbco2n1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXbco2n1"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so57336586d6.0
        for <linux-ide@vger.kernel.org>; Tue, 12 May 2026 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778617394; x=1779222194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnLxUC/iZwT1ghX2Qa1SQ+YBxWphqMru259ZubExWMk=;
        b=pXbco2n1mjFUYtzLJ8War3owwppnupVUttWq0aPotijXYzxqoC/4h2BY/t+holo9yn
         UvLIBo2WDBeGo/BSv9tWrCsCwjoZKgZD6N1RrhGUPvBiPvqk6VQJ2+DAKRrTpbFdiP0s
         6CRY/GcbEHZRomdzdxw92v4xZeWFLS3kUBlIr76kDEX98z1cDFFeOwyi+Y78MJjbfzzJ
         3frdv6TLcN2CipvdWUp3Lp80uS2CJ2reMEpB/Qn/9W4mUXXUGe0v+v79uORDhfUrpcQm
         yfucLBdYM8YcVLqkxn7y4NcQQMcwvO5FHoNbYgwwI3qV9O5UqusfUR8A6kUxEEQmLkJG
         kgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617394; x=1779222194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnLxUC/iZwT1ghX2Qa1SQ+YBxWphqMru259ZubExWMk=;
        b=Jrlh/VTIJkJiaQkCKoXoud6B+Nt7JyykGN4VCleJV3QoT8WvPALhxUV2kyQjcmKRlA
         5X2n12+8IjDHQ6PxObprvmoUAYhhlc1RcQJow3Q3ziI6dbiCzmMfGNSPzk2UVgQnKDlJ
         2IzPwjeA3JIKjCgSukuNZKD6OVU63lMgFXpxI9WfYaxvb4vGumpqq8sVCw0t4ALt9+rA
         Cv1vPnFdSPudIBwYr6gDVOCveMSY7KYUFasFSjVD06danL5htoMyJjkoCe/G2RExlNWB
         czpbyCxhYijM5c3UBlz51UBI3T2J/0DpbZEbFzcTu+HND2P/Ejux4ZIqq2D5sux0i7cZ
         U2Bw==
X-Gm-Message-State: AOJu0YzXhUwd5h3qwljoA9/ngKbrYhSIXz2kJF2kDbjrHXReyGGlv8uX
	IMv2B25bXd1L3YF4x9Glelmx2DMD+aWE+1MHIAmhXUKPMXaNzgR7IEsKQc1+7YJg
X-Gm-Gg: Acq92OF/zP0cLhwa6Dlw1mAujNK4eyWGRplBEL5KFlwRS64DdxZNXsVL+Fzl7z3Drva
	/Sd4fOjTJWzlju2BFak6QF1OzU1tvp3T7p6rcfOzTVBAxHGsnoeWqOZrrMh9hx06xDHIQh49aJv
	a8koMk46KqQ94eljR/bTLhljX/sRN1+j81dRKVspSiRSRyCfi0JOlS8TDwTnsnqyLm8SrZWG8PS
	Czs0RG3ctFvoqHbW4GWYG9dMUGKe8frIQKYIskvjSK50JPpC7ta/RRCHmEMBuSYyO3XZZ3pLv1K
	SSbPF4whjVDmQHMIGzwwCmIX46TBt7FW9jkcmMQfr1LTMmybQPPjYx6246h7hmtj8KZqKCGpWJI
	Z/xaQcIIE7HstT707B+UtHTdx058W/5moc8NWfJA/fFozQn7TUU4KUcUSneWmRzkxbFTbLV9NCt
	SoSbXk3X2qC1D6LM9j9p6GjwuvI+nTJHZ5ZKf0AcP89j/2rs2g5Wv3KMV328l9AGATNazJ4zASL
	vt/a56gcRMeSHSTIwYMvmROmoCjmEklND0XHcchhx2scg==
X-Received: by 2002:a05:6214:4f1a:b0:8ac:a91c:c8d with SMTP id 6a1803df08f44-8c7b1926dedmr7909376d6.14.1778617393884;
        Tue, 12 May 2026 13:23:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf88247a3csm129124806d6.11.2026.05.12.13.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:23:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: pata_arasan_cf: simplify ioremap
Date: Tue, 12 May 2026 13:22:55 -0700
Message-ID: <20260512202255.18484-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_platform_get_and_ioremap_resource() to combine
platform_get_resource, request_mem_region, and ioremap.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 v2: remove dev_warn
 drivers/ata/pata_arasan_cf.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index b1e281b64f57..a77fefd320c2 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -803,16 +803,6 @@ static int arasan_cf_probe(struct platform_device *pdev)
 	irq_handler_t irq_handler = NULL;
 	int ret;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
-	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
-				DRIVER_NAME)) {
-		dev_warn(&pdev->dev, "Failed to get memory region resource\n");
-		return -ENOENT;
-	}
-
 	acdev = devm_kzalloc(&pdev->dev, sizeof(*acdev), GFP_KERNEL);
 	if (!acdev)
 		return -ENOMEM;
@@ -827,22 +817,20 @@ static int arasan_cf_probe(struct platform_device *pdev)
 	 * support only PIO
 	 */
 	ret = platform_get_irq(pdev, 0);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 	if (ret > 0) {
 		acdev->irq = ret;
 		irq_handler = arasan_cf_interrupt;
-	} else	if (ret == -EPROBE_DEFER) {
-		return ret;
 	} else	{
 		quirk |= CF_BROKEN_MWDMA | CF_BROKEN_UDMA;
 	}

+	acdev->vbase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(acdev->vbase))
+		return PTR_ERR(acdev->vbase);
+
 	acdev->pbase = res->start;
-	acdev->vbase = devm_ioremap(&pdev->dev, res->start,
-			resource_size(res));
-	if (!acdev->vbase) {
-		dev_warn(&pdev->dev, "ioremap fail\n");
-		return -ENOMEM;
-	}

 	acdev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(acdev->clk)) {
--
2.54.0

