Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670129;
	b=EJnuecXrSSt/SGTJettvzUKVDMQryjb8BTZ+4j4hCuFrCXCO/O8jJ+32nJrblVAWc4GE
	 jdcMLBckXYlHSXVkR/BGZek0JCFGhByPqFj7yrocJ3wUBp70a3ml5iVwRus55xD0V4yR5
	 i58lB1sOfueMm33SVHhm1RFoSHZb9HR1blND6fJmoigEPctZdrQrwuGFYKgBhoZnVO5rF
	 tspUhtmKMnYqhbUkJltprSwCxiNmyRgZgJiPothNzI85C7/xh4EhOfh86pAxpYqMSC9vI
	 3WzxFbdg6MdLjc1sP5cjX3cZ7/7UzmK6XJI55K1EQPBpCgJKUBjn6tZAoj4R7d6lV3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sfUbONIJRZzSkeN35/5DeaV5OhOzoNFoPR2PNqWhlkI=;
	b=g0vRFG4904euOmgVSHtLLRHvaPpxw4Pz6fT9XI0v2qFJzii6U7ZRGJuLlPXYEc1H/RcN
	 0dFzdIOrWN0SmrpSKHQVS5eKIFF0EhJ7s4v5INGqQnD7iRJ+wzHIF/u72JafRhTlB5nBo
	 SLkVK8S434jUEnqLagkuOvaTyb5a82vyalzcooD0/Rf/9ZaEwalZlKs8/IzGmYFpQ1fh1
	 ru16JD8bVHHlJ365Ki1G5+M5RRYfmaVc8bcnCbGTlRLe0YkgD8488apBzdtr/oMBAvg02
	 6ac3Wy+Hz5nl+uEJzDOay2St3R074c4UMRkOy3I4HYpwdzM1IqttOFelNxexEiUrMvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIP2iHs0;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62215606A33F
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 05:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62215606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIP2iHs0
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso3416958a12.3
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 21:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670129; x=1796274929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sfUbONIJRZzSkeN35/5DeaV5OhOzoNFoPR2PNqWhlkI=;
        b=TIP2iHs05QKdqbnsR8NUnCmlDN0vR0Jfs8j2dRxfBvrIUXtj1L71cPXJ/qR/UcOi46
         I+xw6w18BMP5oqUYGlEAVddRAROFQmCbAlBhZX9JcbyvKyQEsoW9yQTosrvukl6q4ezA
         5hmchn8hUcbp36m0xf5YiteVCRHX+umC1H6fvVk/5KHYAi4mud+JLRPMOJQHkUvYwCLh
         tkyosnQCFMi+Cf2qr2X+HE0ZsjrzxFE0cuXukwkr79vdIzjre8Pv1/XFoSuH4V/k/gkl
         3AdcLQck57ALoux15zK+Axbkjz1J7NKCoiyXjRctWGluWTjdghXbFxrkfsGvwEf0I5zh
         k5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670129; x=1796274929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sfUbONIJRZzSkeN35/5DeaV5OhOzoNFoPR2PNqWhlkI=;
        b=xMy4Jin/JZqbL36AUNQu5uI6Zv51KOZ5aQCcvkl/zrbDzuRz1lqnDzfvb42SAIgfnn
         /7FtJFYHGPkHpvBFtbez2NSJe757QOaLeNmm3ZZHF2JCWVl795Iixw8BBFnP2Oi0cK6g
         tdlYgQFFNsWUnwykCves5i44AkmVt1rsWf5F9bo98VmMZShR31/BD0LPaR/oV2SCINZA
         fyeYV5687AS8zXb8w+oTIqoD5UVvtllGZFv1pbP7ReLHOtO0YBloUgwdPsCR+59BwKBx
         fj0zwy8o+rJlOBedNT4K2dRPG24U7IApC6S1UQDRSlKybue4G/pQ2S0r7IoSo86rQaxk
         azGg==
X-Gm-Message-State: APuU4Z8y7SkrjpvI8D14EylK8GR1QahFX97dYPIbMAHCu9GaOWFdQlCO
	b+EPnAZTm4sBFSWQf/ZCDWLrJyZz/UqMQsmJiGtrlRZLSQt3CfzSYtXd
X-Gm-Gg: AZFdTZfvi2l/WU8UpwWKT+bYC2stqxK5GgjtMltyVhtiLnks5rgqekfm7WapQgLQsNe
	J5hQ/d8yXAeigBmBxPyn9YTWxeuHYGrDZtNaMxgoV4fzz7AoKRpFw479rIl9Awvxl/dZfRWb9I2
	It5ax/rGT3hNiJyhXbs8r+jC+EuTze4VWv6tNsx88v1INGaRC5EgZpLHqrEVLoWZADKKEQ5njCq
	iZYhX5geRrzKZqgMjdGySi0FZvOhbtx/A9UOLk1b33hE6H5kHf968bMZjD2tCCJkfRFzypaWWWt
	n+WWNrCTWl74tyY01PrWOM4wk/uLPX2rIP7Orw48nzTbo7nvTF2giMZ38O9umo54cQwiua9TVhx
	90VmIoruhXTUdVcn6xG+c5tTpIkd7LWWzcdLV2J3oaugCJBL/GHrKYkA8lIi6gkITjc3Zf3P/hQ
	VmOWbyzU21p4AFH941fskOOoXbx33Pta7TZipRG5CimjUU5Oz1xZQL5J5O2gpFs2wQOD29N7iX9
	/DG6yqzHDVot5fQfPyUiFWrav3fUW+p9pLUW0KhYtzj24mGaSp/C1CQZ9DvJzEdQq2n6G8xMKGt
	0WSba6mpEitn/VKIInzwNGukssRLbYrL+/OWke8Jom//ZfsxvNc=
X-Received: by 2002:a05:6a21:8197:b0:402:9f7a:141 with SMTP id adf61e73a8af0-4029f7a01cfmr12921594637.11.1795670128755;
        Wed, 25 Nov 2026 21:15:28 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm10179820b3a.8.2026.11.25.21.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:15:28 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: vireshk@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linusw@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH 3/4] ata: sata_dwc_460ex: add missing newlines to error messages
Date: Wed, 25 Nov 2026 23:15:22 -0600
Message-ID: <20261126051523.14431-4-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126051523.14431-1-artem122novak@gmail.com>
References: <20261126051523.14431-1-artem122novak@gmail.com>
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
 drivers/ata/sata_dwc_460ex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 486ea94a0184..f1237bb20a4a 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
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

