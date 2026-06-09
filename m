Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E83D8122
	for <linux-ide@vger.kernel.org>; Tue,  9 Jun 2026 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034216; cv=none; b=j3Hq5lWn/vahfVcFXUIemS1QwQWq0sxdauc2aMMgOvPh368G+GaXH6lHbuFObzmar9IjX1iM9T+0mpWYEMvGqZnaKU5r0+gilqdys7gLi2kr74gsy4DFQ7R/wqWtmz5uutPD5Tp4WaryKwavaH+yXaHSExgwUkAbbQIsH0fQNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034216; c=relaxed/simple;
	bh=iQ+F1LVRsbcwtWCwsUa6r93L74x6r/2jwMTzP0acEJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IF7SiK57/VTWCZ5M9xnn2ADByAy5Nqu10W33IXU6D5pp3mYmdcIm1geUfH5B4b70n971I4toYZdkcneCes2GSwWZF/W+mAMwelKQFU99lcZ80hoO/Ql4CjcU6eis4BssA5DuJZ+Jm/eNN8GJ0+sCRU/fyDlG7+08v6xe92ix+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT0YiuWj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT0YiuWj"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423f420455so2532054b3a.3
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2026 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781034215; x=1781639015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpizmCsHLyRVs4lMrEe6oCdCgLtR+geOZwGifdCy2wY=;
        b=HT0YiuWjIdFtD8Kt6CGY3+VJz9rU4FGv2MxTBPMjLEiABdxPQd5PuhUBsiUDzh08Uc
         MXXL92BBqpY37ZSHAcYwyBfhF78AfJ0k29YmrXFaapAQQl4qOQxO5EqH4wdib73kpVGM
         utoqc1t1MX34YViIPfANqSq7Trq0QJp6/zZuqE+gM1TvXSH7H8LVGeE3pfl4jB404w3z
         cOOFViO0PzoJarBLrqRJW0CrMMJ7tHURb4PDMrPOQNYk475Qu2gat2vP3eIaMfAxcXx/
         OPeKiqK3tZ2Kf31YDbj55lj5oi9BG7Wi99uJ6IMd0mnFN8mdL6XObP4Glsa0CxVSbdWH
         BeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034215; x=1781639015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QpizmCsHLyRVs4lMrEe6oCdCgLtR+geOZwGifdCy2wY=;
        b=TxLP/L9miiiz9fhU3WbvT0NdrvULEND9yz3w4jOSwyha8RELBBPlaCPkulHk5r/Dg9
         wY7KjRjZWSbtLAT8c0tRy3VpcBMPTURCl0OBqHyhBONwEq4Ip4FqdDaoMGoRFgD+jilV
         PDE43FNMhGBO8EyRIg+Jmxi1aSf+H73sd5LtZv0CkizdxhG5lh1bi8WcgZ/1FLsGTpdz
         L6FcHnXsFEf8A3cH8zu4kiVg8X8a8fn0vjP//gjQhSJN4XQImEusmaSRNOTiMUbGERsG
         WwYet9glhnBiffU5NWKUhrnZbPx9me449dTEPC4KA4epUsZ65o+pOOtT2T+MLVAaviYx
         alWA==
X-Gm-Message-State: AOJu0YyOvOH0VnyUZU5MGQ6QUbdoquDVODiSaJoZZ57D2ktgFnbk8Oyl
	PaGADUbzMOKcTj4JvS7T8CN1MiZgMe1Im2THpg61WWF39gJaHm1ieBIiRLtqwUS4
X-Gm-Gg: Acq92OH3k0hC4kYR/aK7/Q0VGzqZ36/psfbZvx/Exo6gtTH7Xru9K6RWB3lDxbgprL2
	0/k8NWB+JZiIPCDUB1mLBOHZ9VcLx+nl3DkGuBOgQW6r3RU3qA45Y//N/T8TSyNlLAijRghBjl8
	u1NCiOMWgQK6nB+4Bpl2csYeEvLcUSgligLv/MdyiuHk37DwKjVmlTMhfoTRuVOAS3bIQuTLaoA
	JuH8LlkMXGWMxjVCxJ1ANKgA7UM0O1t5OC7fQXMfcY7cnAKj9YfrjYMV4xeXWeJGE5J8ygV5DL9
	yekrEo3ZIeumotdP8oBjRibDiFR14nz88XA9JesA+fa5BmWGmAdIslLm/+uj2LIXrziGoG2ttqm
	58EIDZsfxrPjKJ+fTNSTYhHfsZb69NFyXCJSIvUQ5qJx+lEAAaBARMQwio2GBaCE9FKYSesIwOZ
	qsZqqCtSkFB2sYvlte29GQBLTQqTT9yvgBmVF8bXDWDzKPfTljrSAvPeS946wOFM0LBm9h41IGO
	DJ+2XZCv7kUdPWoesOLLoklGlrMHLRYZaSvRFNrbE+mwg==
X-Received: by 2002:a05:6a00:f9a:b0:842:7296:dba with SMTP id d2e1a72fcca58-842b0e2fb1dmr23087891b3a.7.1781034214751;
        Tue, 09 Jun 2026 12:43:34 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828daf76sm22715683b3a.42.2026.06.09.12.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:43:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 4/5] ata: pata_mpc52xx: convert to platform_get_irq()
Date: Tue,  9 Jun 2026 12:43:10 -0700
Message-ID: <20260609194311.6217-5-rosenp@gmail.com>
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

Replace irq_of_parse_and_map() with platform_get_irq(), which returns
a negative errno on failure and integrates with the platform device
model. Since platform_get_irq() does not create a separately managed
mapping, the corresponding irq_dispose_mapping() calls in the probe
error path and remove function are no longer needed.

Remove most gotos from probe. Simpler to return directly.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index d13cfaf285dc..84a4cf42ef54 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -21,7 +21,6 @@
 #include <linux/libata.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -730,18 +729,14 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	if ((prop) && (proplen >= 4))
 		udma_mask = ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
 
-	ata_irq = irq_of_parse_and_map(op->dev.of_node, 0);
-	if (!ata_irq) {
-		dev_err(&op->dev, "error mapping irq\n");
-		return -EINVAL;
-	}
+	ata_irq = platform_get_irq(op, 0);
+	if (ata_irq < 0)
+		return ata_irq;
 
 	/* Prepare our private structure */
 	priv = devm_kzalloc(&op->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		rv = -ENOMEM;
-		goto err1;
-	}
+	if (!priv)
+		return -ENOMEM;
 
 	priv->ipb_period = 1000000000 / (ipb_freq / 1000);
 	priv->ata_regs = ata_regs;
@@ -762,8 +757,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	dmatsk = bcom_ata_init(MAX_DMA_BUFFERS, MAX_DMA_BUFFER_SIZE);
 	if (!dmatsk) {
 		dev_err(&op->dev, "bestcomm initialization failed\n");
-		rv = -ENOMEM;
-		goto err1;
+		return -ENOMEM;
 	}
 
 	priv->dmatsk = dmatsk;
@@ -797,8 +791,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	free_irq(task_irq, priv);
  err_free_task:
 	bcom_ata_release(dmatsk);
- err1:
-	irq_dispose_mapping(ata_irq);
 	return rv;
 }
 
@@ -815,7 +807,6 @@ static void mpc52xx_ata_remove(struct platform_device *op)
 	task_irq = bcom_get_task_irq(priv->dmatsk);
 	free_irq(task_irq, priv);
 	bcom_ata_release(priv->dmatsk);
-	irq_dispose_mapping(priv->ata_irq);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.54.0

