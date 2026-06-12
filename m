Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC037AA63
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289173; cv=none; b=AXfDW9UFQxUwth7Iw4bJHIelRSUeVCUhjJ5HayNyCMUlxvx8mdhe2fSuXHYS1gg0THu5D+7P79R9KE2iuj4niC7EYu00/p7ugWpvr1ne5Uo27RR5PftBoZ3HbhJn9vpWEcFi/pwxxdhuBHEFdTmPVaoZTh+W7htpm9VJF3Je4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289173; c=relaxed/simple;
	bh=vdcxqzZIBnASsOu/CTvV2i74VZM4fk6zVEOwRKINJzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo0I8KFgWikxcyVbz7DtIUHTz7ARuyqqUDLCcJSufDM4ZhwCwf/htr3OdIw7ZCh7GGrcJNtNOzhAlooLEoJVrhugoK6+2MiXBN7DuGhZJLpfQ5qJZhPcAs6FiESKnXNrvfdnA8QP2VJp2AFnC78ttwLRvt6IIpNkLaq/CbsJr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDAI3njZ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDAI3njZ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8589498839so564020a12.2
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289171; x=1781893971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/hxZznLvcrzr8nyb0/DDIS1Ul53TJdw4xa5LWXplso=;
        b=CDAI3njZW9jzUe3qlLZMf6p2tJBAxRfd1TrooEO7FpB6rQm6i12fJ3qZ3u3OnsRD3t
         QHHATMrZKl4BTWF4jWrbETrs0Rur9X/o2Tn9Uu/qSU301bOG6JnWVrLBfIjokuDtndW4
         iM2dd09r7iM9/DyqrsYeonB7UAtiXxuer8DfKugpjvKu4XVSjo6qElKRqDQ9B/SxO7ZQ
         e1uvDqmJrkJMqA0ofehh7H9gpgf/aXktBN0CuoCpNTvcrvTEH9csrrzbbQirzikbvpzZ
         SJf38eb2AXC7YYiawgVW2gAr2avVh+WdvVfGL1XgX5Kmqc4yICVqV+ntNx3/SvamhfhF
         Vrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289171; x=1781893971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/hxZznLvcrzr8nyb0/DDIS1Ul53TJdw4xa5LWXplso=;
        b=owys8tD2Y3ZpcakILZCi72Ph3vg9aYboONb6AjCFB6tSYMdaelt76nB9n+1+OMPMs4
         +iE1IoutxlYyJGotFBK8CgGmcddhMPQ1tO2nZKt6s+LwHJjmfwgVReV0s5KbSyNT+cyt
         4H8SAN7vWb1UV04woPqbgAUk5/P8DtgM0wxWQWtTix561KY5R80qSXEckJ9+N7Rst3/N
         IhCuQBSU8tOA/V03EqBNY1EK/NdrT/oyHInJX03eR0nMCdBY1aWk4zzLlV9QOccUiWZ4
         vfXAUCvjU4OdJ2yD2iS7t8WAKDLMN7qVEz8xSj+YWJT2gMc9pMk6pz+nvpRklkS9uvLN
         d0yQ==
X-Gm-Message-State: AOJu0Yzf6qbV62cT50qQ9IqXumCYV4aNNK4wJ0qMTB8FuAzbfn/Y05DY
	jE45T85P9mgwv1vjzLi49Lr6nPEBNsuqnbndIEk2Mjejv9/ck2T2pUYOS0YuVA==
X-Gm-Gg: Acq92OGFYT1WoaCA93EvYc7KPfmvPC4E0af4lMD7+dqsrQLT45Zt3DZhdEhf9Bkb3E/
	MXqgCg/2lmntfRrmS9vve1F5HL1HimcYZHBJhpvVcDMQka+rSUj64oRVFPp1l7hI4Z2zkdR97p/
	nzrJ1lhMWa/ZE6sTlyl12RYkaD3WCTxxceGhtimBnk1z2dBF8aCsyXbYzBvnW/Ipip0S8YXMA9y
	Y5Xc6q421b0VNF7ZT2rcWvDlBGx+fcP1AgyLaGpkWuSMx2qpGZCoovgEZ0LWYTa+hS8xCWTH1Uu
	345QNYGugQ0KRs85kJWT46ckE2wLlRzIP3p61+lXBk2xV2ugQGVroYng0vAZjPW2CvR6k9FzcYg
	gW7R88bEDoKoPqLq/ii37/lS49H944uGLEpNloSA+jjQPc8Ro+gHBNRZBQr7zPKKrNYUmJZilj4
	OodwAjSO+z/ynTEiXspCrSDfansn22XHnmqBQx+vDL6yeykmptHeJr1qbkxMeKVtX7nqNjrFsjB
	ENC+JeIB5IkteVGZH4nHgKW1PpubimZGQ==
X-Received: by 2002:a05:6a20:9f8e:b0:3b4:71a9:cd8f with SMTP id adf61e73a8af0-3b796422c91mr770241637.41.1781289170855;
        Fri, 12 Jun 2026 11:32:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:a073:5e58:ab5:a167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm2795034a12.5.2026.06.12.11.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:32:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 4/6] ata: pata_mpc52xx: remove redundant irq_dispose_mapping calls
Date: Fri, 12 Jun 2026 11:32:25 -0700
Message-ID: <20260612183227.20446-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612183227.20446-1-rosenp@gmail.com>
References: <20260612183227.20446-1-rosenp@gmail.com>
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
 drivers/ata/pata_mpc52xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index b2e2f83aa9ca..4645de4cc257 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -797,7 +797,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	return 0;
 
  err2:
-	irq_dispose_mapping(task_irq);
 	bcom_ata_release(dmatsk);
  err1:
 	irq_dispose_mapping(ata_irq);
@@ -808,14 +807,11 @@ static void mpc52xx_ata_remove(struct platform_device *op)
 {
 	struct ata_host *host = platform_get_drvdata(op);
 	struct mpc52xx_ata_priv *priv = host->private_data;
-	int task_irq;
 
 	/* Deregister the ATA interface */
 	ata_platform_remove_one(op);
 
 	/* Clean up DMA */
-	task_irq = bcom_get_task_irq(priv->dmatsk);
-	irq_dispose_mapping(task_irq);
 	bcom_ata_release(priv->dmatsk);
 	irq_dispose_mapping(priv->ata_irq);
 }
-- 
2.54.0

