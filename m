Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF911374A18
	for <linux-ide@vger.kernel.org>; Tue,  9 Jun 2026 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034215; cv=none; b=UkjHjfZ4MoY5Pllfs/1DbjneppIj2srmnRDRWhxa3heKMRdMpu5Ewmy8jA7EyPYmN5xvhCwwlMx+FMVlVSm9ejy2hay3lD9lh8uWw+r9yvGc7F4sm2XweicZAslRLzzre65Ot2+WyAdkuLs0BDPSCRFd185h58zE0kY+V4wGr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034215; c=relaxed/simple;
	bh=XqjBLZIewikmafzIZ1I0WakYSpYhiLflFvH+OAvaGUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjT9soeGOafsVuXobw09p2eg1fhObPofA0dV1hskjiiAsHHGBfXVxc+0T6ijGm0FOaxNDF77Gs2XpYmA+WVQ9Ny8Y5UI7q6g6ES9nvpNDk4IZdYKBXITt1hgTQ9txRuc20rOsyxgS4RvJ7SttA12RokenH5JAB6LpNJegTOPaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlvcsfCy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlvcsfCy"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so3520281a12.0
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2026 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781034213; x=1781639013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP4RTugBF0O+yHDk5iqRwbV8b2jPQiiO46jM32LZa9M=;
        b=NlvcsfCyHO95pBjBq9lzlbZc1dICLtD04kH0crAsFipcJqbuivgi6OVR80n562eFMB
         aWTjupkkCG+tSa66jZdVHa/vjz3nx7xdZQVW7g0zb4GFlOEmeAl4Pw+sQZKj7siJpX/j
         v6bkw2mJOUWCtqHxq3BGIldh7bPCNwmKRiz5WnK75WeiTV1p6kN0WRDGhftj27TXTvuC
         8w4UOqAVbWawzgmuqaNnaU332Rua1sMpCHBKvUS1OHkXNpof8C1ahMk8d9SVWTN3xhet
         Go7yTM6wfRhyaEROGciTSFjpa91NJW4zB0Mb0fUpcPAqlqAe9cuW3IA/arSbscp+boJ6
         MAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034213; x=1781639013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PP4RTugBF0O+yHDk5iqRwbV8b2jPQiiO46jM32LZa9M=;
        b=ZjgocWkFOMDzJhW/u0GZu7V3ewz6/aO/0WMjYDELTFWUZ3Qjv1aMebUW2IpBz4cmXq
         XHzGDAcnn6tlB5dOo1qWIL2TPhG5Awz0tFanqfhi9hbEhnKmXqh5ERAuWdS4qAZvEOKZ
         VHSX69kzjMN4W0aUL+gIQPcB4IP1gDLa/9YknxRZkEik3SrvW6of8wCgulKSRAKCRaSp
         hnoNZ8NwoKOaXI5m0rWawW6VcgaSgD3TyzA2yweT0MfTd17vzMl5BPfgJMcKwIfHpPDl
         zPkGBZROUfuEWw1REDXYSHSQ3A9nJobArUORevap3tEqoPI65QP1KpqtAL3fc5EGKptu
         4EYw==
X-Gm-Message-State: AOJu0YzqzvIWJJlJ2ZnAXJjQaf43lRBWiuAsW9QzylfBuKkAAY93n/y7
	JdN9apEKfT2vOG7K386Fo6dQbHTyyfYyDICEhgnFD99WuXV5CFKG8NuM4UhL8EAc
X-Gm-Gg: Acq92OERKh334QtM16CTI6V4YbnNTO1mGRdtSjzfMOKDMUvusaJaJP5MwUG+oTPEMZa
	9yeVWbbYzCVaXnnxuWvF45uXZD1LtY36s/Vmz1pCjnUO/OAWD08FT4ol3VyaK5pdH/yH1Oqfa4j
	+SZkBgjeXHX/y7UTopDEdl3/XOau/NubZgV3CscShMrZTtzvZEO+14PXkTwSe/cpllkmzDJz7in
	EMuvC/k0L6y/rnUShYRyXYljKM/cJE70/sUrs1B/b205anbIFI+4Wfk1hN0S/RsVe9/zGyeDXgD
	S/x20EenP/+RM5OLipfeyiECIwn4ZlX4FDew1cmC/2BV3S2Ds2iM2lWKIwYa3oSx3BlcySD+9pj
	ECq9v6HbtCtNWGw8zTsaF3RnZtH6h0aZkdrkDyn2bNhjCe13/xIfsdTg1BL/8TtaHSpQlXXx4Ba
	kB+G9X+EJA0Ca0D6FNbkySwKcdGZkCbpQYF2Hm+H2vxMXFBRrs3g5VCsdM13rRt4KWk8Wr5Psqf
	yKirNWdz9Z9W0pC0aDAlR3NNeHPvduCZThf/BjiuEJPMA==
X-Received: by 2002:a05:6a00:813:b0:842:55b6:f5a1 with SMTP id d2e1a72fcca58-842b0d8a604mr21267445b3a.6.1781034213362;
        Tue, 09 Jun 2026 12:43:33 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828daf76sm22715683b3a.42.2026.06.09.12.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:43:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 3/5] ata: pata_mpc52xx: remove redundant irq_dispose_mapping calls
Date: Tue,  9 Jun 2026 12:43:09 -0700
Message-ID: <20260609194311.6217-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609194311.6217-1-rosenp@gmail.com>
References: <20260609194311.6217-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcom_ata_release() calls bcom_task_free(), which already calls
irq_dispose_mapping(tsk->irq).  The explicit irq_dispose_mapping()
calls in the probe error path and remove function are redundant
and cause a double-free of the same mapping.

Remove them.

Assisted-by: opencode:big-pickle
Fixes: d01159dffa15 ("drivers/ata/pata_mpc52xx.c: clean up error handling code")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index b46b83df03d1..d13cfaf285dc 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -795,7 +795,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 
  err_free_irq:
 	free_irq(task_irq, priv);
-	irq_dispose_mapping(task_irq);
  err_free_task:
 	bcom_ata_release(dmatsk);
  err1:
@@ -815,7 +814,6 @@ static void mpc52xx_ata_remove(struct platform_device *op)
 	/* Clean up DMA */
 	task_irq = bcom_get_task_irq(priv->dmatsk);
 	free_irq(task_irq, priv);
-	irq_dispose_mapping(task_irq);
 	bcom_ata_release(priv->dmatsk);
 	irq_dispose_mapping(priv->ata_irq);
 }
-- 
2.54.0

