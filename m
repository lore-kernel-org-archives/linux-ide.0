Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0135A395
	for <linux-ide@vger.kernel.org>; Sun, 13 Sep 2026 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789307938; cv=none; b=Cv9KH2QaF0v1uVqJMy0/MVRAgYvKWHZuH0QRtf1UIm4bsiR5urTpG6Nuf/9NbqUS7wXxaLbgyfIPgFNvkGYMxrO5VIasLDb8J0qgpBk7Y8orT3xyQkwIjuLqPUCgD2kAwcbpQ2jZ+alQO/P1WAVkMrgJm7rXcSox+4D3x8OMEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789307938; c=relaxed/simple;
	bh=LDv1+OlsMNEwyly5xAaY1zylV4luVmkXqBXkId+9exs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8cTPiA8IDJfPWrAEmTmsXyD3TUgqdpwI7HgrLR0FgvpWeT9CWGZ/lvB+9pv4YeqUQGF61Zal38DJ51zojTGrLmVWA4GIR6EfnJxZcNTXW2hiWdA5Jac9slwfQKEwPdEQPkuI6c/ds0uPMd/zKJRZyrR5eaOBu202rSgFL/b4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggGI53rV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggGI53rV"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-486e70f2457so1152650f8f.2
        for <linux-ide@vger.kernel.org>; Sun, 13 Sep 2026 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789307935; x=1789912735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W8rI9FjNryC/dMsJAkJgnE0z1ggNInUuzYKOSNnaZPg=;
        b=ggGI53rVBnfETCVp8Ja92RZd/M1iMEilTF8FX2xOduQ+dRAyexMZi0KVjdJINc6pb6
         hGsI7I+T/2UJqaGCftnI9w58tb6vP9Q3dNNzwhm9yziGBjLTNr764XTCNwAR37liBhQi
         T52OLRYbhb++oumXklQI9weLjRq5WUtaCiOBrZEJH1PzT1wBLsQlzJf8M+kKKdbkREU7
         7ICxKCPPwuKSahmM9XtXWvTmx3tnrSA3YSi1Qwaniri4x+OSgy9nH09QN+32ibqCMxku
         kr8Q8Sap2Qi3awm1cCL6jY0d2fglFoNp/vBauYQMapNO/XEiS5fZ4W87azuNxCx6u1ts
         ah8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789307935; x=1789912735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W8rI9FjNryC/dMsJAkJgnE0z1ggNInUuzYKOSNnaZPg=;
        b=kow6ixpASJGpZO/jUQQmhY3YBP/ZPd9D8ixBUJAxTNQ/n0FgwX3BYlcBgCe4yTaPGs
         /LgWQaqotnGJq7OnR66kT+6yNJu//65LMbhSxtpb6SSpDRPgVwqIdxM+iKm+oa/s6TdO
         CTm13XOoCAyMtU04kTv/bcxi9gq2wTZJaTvaesqHHdU//AkrwJYp3vr07sw5c6pz84mG
         V2xPHDyBWELWCzjafG2yLMApNaPxAIMOI/RMu5spoPj/7sW+KVKAbg7Lp9vS5DnSgl8q
         WlbNwIVBBtUpRpbCtzNcc+FZ1QmxQMtDeal7y3PSvyuoE093NaG/ldZS/OYw2+Bf11fx
         FMZw==
X-Gm-Message-State: AFuF++nNsrScE0z6ARTUYeiV8l3gWacS+31JaXB3u6ZnBbyK7vV8sHPK
	Y5/BBuNp6TCSgV/Z71eqh5/76LV3yawQwgBjMgBVt/jPygJlO/ovZ/N0Rv21150lB8s=
X-Gm-Gg: AYBFou2SGreluBogA8P1xeXUfav8igvRXDO+xp8ucfQzDALt8JvYLUJxkxpJEFfxlOh
	loWtGTQy39H1KZciuapQpdg3YlanyhIh+WXQ6/rxZo4eHp17MyyIObm40xcgN52QBMIK669zujy
	BXh/ChDIlw7bWfuieSni5rhbbDnecarR2cKJCtqFH6qUxynCFbmMRYhqZu4k1Meb9jRxODVYwFz
	q28bmRjxQeUYyT0e8QNEqx1wfE0MVkFVL/rZdSp4os54W60k70okBmNq9D6Fogr711+L1hQEj+s
	zy09HAQF4mS/gGLGb6O8ZOd3bDYS36DfnzLgIEcsRH3zHA0ztEj/sRYvAe8IVFmZZeUJsEpT3lI
	QEdCE4EVbas0zT+j2F6IH+DrlPQaBEaCkQ1dsnz8HsYqeek2T4zzQ8xzfokDNPfK2Tb/r3M02yo
	bFpdETraR5igwHe12Lr+rk8BpB4+tEEfKdmLhHmmWswWXxc9le9vcY6d0wJyRMC0YkNRTEQx8tI
	w==
X-Received: by 2002:a05:6000:2084:b0:486:f455:403 with SMTP id ffacd0b85a97d-486f455045emr10164984f8f.57.1789307934665;
        Sun, 13 Sep 2026 06:58:54 -0700 (PDT)
Received: from jo-Z6 ([2a02:586:e82e:5000:2841:2122:8c8a:f865])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33fc02sm18689243f8f.16.2026.09.13.06.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 06:58:53 -0700 (PDT)
From: Ioannis Barkas <jnyb.de@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Ioannis Barkas <jnyb.de@gmail.com>
Subject: [PATCH] libata: Fix HPA horkage to target whole model series not just a few devices
Date: Sun, 13 Sep 2026 16:56:50 +0300
Message-ID: <20260913135650.14244-1-jnyb.de@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 16c55b038033 (\libata: implement BROKEN_HPA horkage and apply it to affected drives")

Link: https://bugzilla.kernel.org/show_bug.cgi?id=8888

Signed-off-by: Nick Barkas nickbgrk@gmail.com
Signed-off-by: Ioannis Barkas <jnyb.de@gmail.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 59e87b987d..b23e1c3e4c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4248,8 +4248,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_QUIRK_BROKEN_HPA },
-	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
-	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
+	{ "WDC WD3200JD-00KLB0", "08.05J08", ATA_QUIRK_BROKEN_HPA },
+	{ "WDC WD2500JD-00HBB0", "08.02D08", ATA_QUIRK_BROKEN_HPA },
 	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },
 
 	/* this one allows HPA unlocking but fails IOs on the area */
-- 
2.53.0

