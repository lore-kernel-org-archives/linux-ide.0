Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCD37A4B9
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894808; cv=none; b=Bn3twrP41hdjpXu1ufmOc+V4QIEcEzzVZYauyyIyzKiOsVFaoTcxle4ldaAKjBCsqzECZtBk9lJ8/f30Dm1yMAKVWhSv5ee6SrYEAS29NR2jzGYi+LYRdchoXP0GCs1SAuu8vaoClYh9rpPG8JW/hfXsNUhbN+rB3Sf1yjhFRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894808; c=relaxed/simple;
	bh=mGnF1/20eiwzUPE0BA/TPkhUBOAS4W9MhYix2gXcmg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7dbrfBXQGPa8wOMmmiinzVK5djjutEQ9KWK492RK7BP8+RKnbnRrwxUfqbliNqUjt9B0KiaDzZCawwcDqKgrAO9Nksui7n50v7uFBOVE1mQTpvrj2DS1k2WwVmYn5og75zQigm9ZMqaDSHgvDibPNK2/Qeovc1Mi+yO5qV7LtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1isTaVg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1isTaVg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848595b338cso2806515b3a.0
        for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783894806; x=1784499606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rLyzRh4JtoG5CeVStkONBMN+JZqIl6E++h5b6mdVdKk=;
        b=G1isTaVgHPJ1v2b1MV5ggRGEUgf2u2ohnKROUjfuhkSD5u/r6pUWBSYWYTr142L0ok
         7elh3MK/gEGnM8OrT81ufJKsFvJARaOeIU1/sShZBMwqF5IZIA7IBX4WI1U1OgvdsIRD
         e4ZZzwCVcRl1oODLkg2ahq5K5zK9onCIDETSZNfOIWQwB2hPjJXeTDm6JvRAbrdCMWpr
         w/hI0nyvr95f7AMmb3QQLp4eSEl4SkHzODPtOXuiMLfBS21EWmCXNvflj629ZJC+Tzsk
         rdxLZFZurf8FOGNKe+GLDgwdi5mhgoRXcQl5FojmEN9LaDx94mbY8oxR8JSpwuct28Su
         DwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894806; x=1784499606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rLyzRh4JtoG5CeVStkONBMN+JZqIl6E++h5b6mdVdKk=;
        b=UUM4LdhH6KqXmVUkW2hy46WKK55EYqjWu0iTAhGfgfnLhPkmRjlGTwWTp3xk/LP9qD
         b6+WpxfPyhadBgYK2scoLa9dDPYMxmXlDnKXHYjbwOJRbp6Q5Tfvj8TVFooDG+AQBV4M
         RzGXcHKjvTBsXc4q00Y6ZYbjdIPes1veV7x85JwljJDo4qp77WaymdJ4wTq5Gzy0ZxJh
         23i2FP6QWR/vX53BM1Z1YFUoMoYCr6WR1QsGqik1fUKCJ5IsojpwE4lNRC5YvOdAF+jA
         Egu/+rtrNDwW81yenC2T2GpA02S39UA+nnG7t1w5f5Zkx3H40tdigNXc5PX7BOh5C70A
         uPJQ==
X-Gm-Message-State: AOJu0Yx131JGyFH+dK7lF0xjLb2EMhY2HN7gGgJ2yZH42Np5B7fQ8kUz
	kb64/FcGZfk2YQmTpQ1v8hRf7B5VuxE3d/wRo9mTmsCRhqlS7Pboa1KzexXmyw==
X-Gm-Gg: AfdE7cnYGKgwbFaZOy4nIJ2J4TQABbQEGcHiwfCqUkOk8STQeHaNLBbYYQHIRl6TYjo
	DJ+EwBRJJdiqC13sGz9Nqv5fQYxf6pUxXLjdqZA11RIEKwidNiHBJPu9tzNaGDe6JFEVDIv9lCx
	3+F/d/fNzleSz0gcENc0s/nG5Oy4Pz3o9r6Pt+baqe0EwE/9XAlL28HtUntl+rvOS4y/j3JhOGQ
	WOZ3QjVkVP7VQ/Bd42uqD3SJ1nzvgvktjV88PDiUb6xA+Q6dG3eGxnikauz2qcmFdrD8GhpEgpE
	BPsyuJ8P34StFdjSta4UhpA8nm45RMI5X33nwwJK1tWZMPt1pV0doS7ckeqjsDQoJWLbSNTNrjy
	NOY5AWK85q/QPodcjPs8eXb0e2zZgOzwgcg9rdcnkVu+QVscy0NJzxPlMQtHxvwO/qIfhJxzOeZ
	oVprrh+2c6MHy49/71frxjKUzap/Qid+P2Yfl+FZZjjjF4SOBzjvomt7q85tFnANBiVX39bNBUG
	LcWONjjuVqc/IYA7nLXYVI+Ew2ERGN08cLzvH3m+ZvoVgdmDRWP8it5CTiTRTpSCw==
X-Received: by 2002:a05:6a00:b4f:b0:848:2ab3:ddeb with SMTP id d2e1a72fcca58-8488963a14bmr5936479b3a.14.1783894806246;
        Sun, 12 Jul 2026 15:20:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm13170272b3a.57.2026.07.12.15.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:20:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: sata_mv: Use platform_get_irq() to get interrupt
Date: Sun, 12 Jul 2026 15:20:03 -0700
Message-ID: <20260712222003.1008136-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract platform_get_irq() out of the conditional block to run it
unconditionally, replacing the direct use of irq_of_parse_and_map()
for DT-based systems. This simplifies the probe logic and avoids the
need for irq_dispose_mapping.

Remove dead branch for platform_get_irq(). It intercepts 0 and returns
-EINVAL, which goes to the first one.

Assisted-by: Antigravity:Gemini-3.5-Flash
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: remove dead branch
 drivers/ata/sata_mv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 41647a56a9f4..a2bf9551a600 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4054,17 +4054,13 @@ static int mv_platform_probe(struct platform_device *pdev)
 				n_ports);
 			return -EINVAL;
 		}
-
-		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
 	} else {
 		mv_platform_data = dev_get_platdata(&pdev->dev);
 		n_ports = mv_platform_data->n_ports;
-		irq = platform_get_irq(pdev, 0);
 	}
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-	if (!irq)
-		return -EINVAL;
 
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
 	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
-- 
2.55.0

