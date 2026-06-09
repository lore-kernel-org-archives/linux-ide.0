Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC1C365A0B
	for <linux-ide@vger.kernel.org>; Tue,  9 Jun 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034212; cv=none; b=OM4k5zPER5R2BhsHc+d+af1OWsk+EzhwgIFbC1tfzY6MWwso42knSMCdL8P44mPQUrHXnlJmyBrllQLf2XLS1mPS5i1bxGmMS61dIL2G/1kZBmPsIuR5G6D24kxQYt/lj/+i1cQLXzxxHXDCElp9plCck41T3ll/utpbCSxo8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034212; c=relaxed/simple;
	bh=hhKYJazjJge73y6yNe5PGiyzjbkw4XoIZrmixT/ypn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JChZA2NFfWRZVCvVxvrffYBxRL3tcYWhZgb5+/7oRil3SvUynwM4H6eI9XK230LHthNJ3yE30Ar+52MTO4M/5txkIYba69n1HAY4uL2Nqe5szaZmisX1bibp13KWzoX+8En9qDTPifrfToJ34NWRVams3orGDlzZoaVjbP2gmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBmzPx22; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBmzPx22"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f626a65so2578780b3a.2
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2026 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781034210; x=1781639010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZebOJ0xoX4ZIU1H13OA9Ye3a+JpFQ7aYIL/Bsme9n2s=;
        b=gBmzPx22MlQpYpYHd29TKdRfdFF/p7/923B4uJVe0IUcozOwJ4M01v4mDrl7qWckV2
         z5M/ueUSIcRZL6QvzLKDLXMd+PgZEtR1eQD6MBqmkowfFR6CsalDN7iFViYieqXDdNps
         imp85y3Uct89Xn8swIHx8lLysFdOUqd+HkLJvTHMaJOH/C5WWs64vSo2kR0rQOaaoID1
         pkq03/1JwZIk5/07gA8DZoLPWP/VfDMsEAAs2QzfBuNKIdCDxOcTThufLnb6va7rrUXn
         O93/9trNYXXsZS0dLXGlnwsfFLqTqcb4sxDUgM5Iw2Mk/UUtjB3jQemdYUE+dxZXC8/U
         gBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034210; x=1781639010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZebOJ0xoX4ZIU1H13OA9Ye3a+JpFQ7aYIL/Bsme9n2s=;
        b=ZKpawe/kLR7u4bS+jtHJwKIr4TPmk9OXzCXUMHKAhqL9/9ZyoE0neSkBTQUhOIL66m
         TU0bxRsFTmmZjmIE5qTw/QfMXW7YXSjYfzs+fJYqfS7ma2tEZ76AHz7uqR52nNNIXgxl
         Dq18CM67CrVexLK1I7my47VwIo5GI2JF7vW0KhFzD/dxYyC1m//xUT6Fd6+kGNAsHIbL
         VKPZXHAa3aJNOtbvGnQX9EgwYNmXVyX6rklISt6kuHZNHgAqaq1thTOJjVZJKT10eEzi
         WvBFd5KLhZ7SRt6SwNT8mbqESN2+9U03qRzZu3pHUdwJFatLsy7sUk+IVq8Hz8U1yih+
         59EA==
X-Gm-Message-State: AOJu0YzWNMekQpe92/YnllLQ1imLqoYvs76T5efdz8SXfcSrE5cFlhqF
	n/sCmXamN1DMxhFw9wmvB8/ddO/v/r7bHbokubR2mGJSro11NnOjB0zvCYGhwDDW
X-Gm-Gg: Acq92OEcdPxe/QLEamGayJnxjueZMsVC0hoNiEEVHwfWBew4f6V6Mb+l0i49jWExM2d
	sQ8aeT6gk28Z8+AAdizj86tbkrGaZI1iz7rSmBq2LdRFzgaEODiSidFVDfQPueykksVDaXS/XQe
	JDzibFLPr62h16KPfH2vRHqbZsqHh7JXlBWSgA5OqLxRucS6f6bHdqCohM4J3QT3IJgNtiCHJ0p
	ZA/zWqrJZq+Vv6Cp/C0Hi6Y5lCZMQuv+GqNX3O+DP0Elix6bI05FOJ0t/I2Fgdd08ZoN36JgPTj
	/wSCQcA0s+CmNur8eRwUkOYtV8MFOHEqa9b+proOHBvIZLxp3jLWXcriDNAlV3xaBsUocPvicWX
	gBj8p2lT1soJUfNrpruR3bqqdOm+kI/7TB+IS0uhbud3XcN1mn3TBp648foh29tXkFWCyQ9OKsG
	LhWnsJCFWD/3ReTjKkef+bQXcXkDF6N6qiq1GrOEZexp5/BQpByfZiFPtFU48qYUBKhELi9FTqd
	eoya7EISUnE3KmjtXeUSvTzCFkgwGNaDPnsUwpLyMngmA==
X-Received: by 2002:a05:6a00:b807:b0:82a:5d55:5807 with SMTP id d2e1a72fcca58-842b0e1c8b1mr21630502b3a.6.1781034210504;
        Tue, 09 Jun 2026 12:43:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828daf76sm22715683b3a.42.2026.06.09.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:43:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 1/5] ata: pata_mpc52xx: fix NULL pointer dereference in IRQ handler
Date: Tue,  9 Jun 2026 12:43:07 -0700
Message-ID: <20260609194311.6217-2-rosenp@gmail.com>
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

Assign priv->dmatsk before request_irq() to ensure the IRQ handler
does not dereference a NULL pointer. The handler accesses priv->dmatsk
via bcom_retrieve_buffer().

Assisted-by: opencode:big-pickle
Fixes: 6b61e69e7bc1 ("powerpc/mpc5200: Add MDMA/UDMA support to MPC5200 ATA driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 210a63283f62..fe445d6aaff6 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -766,6 +766,8 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 		goto err1;
 	}
 
+	priv->dmatsk = dmatsk;
+
 	task_irq = bcom_get_task_irq(dmatsk);
 	rv = devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
 				"ATA task", priv);
@@ -773,7 +775,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 		dev_err(&op->dev, "error requesting DMA IRQ\n");
 		goto err2;
 	}
-	priv->dmatsk = dmatsk;
 
 	/* Init the hw */
 	rv = mpc52xx_ata_hw_init(priv);
-- 
2.54.0

