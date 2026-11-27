Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803386;
	b=KlDFO5V4DrJEJdSRACu5cjx6/e6QAbMcqVaB/56k1tksBkbN9/x4Dtc1l3XH7fRjyI/M
	 t7GMwg5bEZAwWt3ObDdxQqIbWvlaDFx+/1FEQVMrvUwNlbN7qNDGT9GCFZYXiv4LbVFOY
	 R/yf9/BaliiIlkZ0w5zrpWmnAlgCd2FXjS3R9uh4+c2yTHmlfU/4w6XYl9JXNvu/5/OC7
	 n16EEGBDSLL4q6kQrkuK8KYZ6dudr67FxxeihZv14Dq1fFWBhUIvHJpy3Wb9YrVkzz71S
	 U5OEnPFV/fd/g0ILcj1Z7hgKMghMWvWNs0dATwPLOKxAeoz2dUULUCPXjH6kZgLPZQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1iSCYIDLtB0LsuikUchSv5LqXfsReYNoVcB26J33mOQ=;
	b=DcVRG/1qvGaVFu9yApDbfx6foE5m3Bqs7eycatrzJF3pplhyKk92gvXW+mVELAI5hdmV
	 tAxlVGqTSOOgHNDigtItd20cFrDj/wpIwROfaVdMURlNQr+XO6d2fZmFnYXA6dy4f8dT6
	 Ga4gSqHvG3fBD7POOJoHsb+htewTd4/G5c89SlGr4wMsjOfW6qkmUILSNWCd3aY1zQg0H
	 aZ2VxUfVukG23npwM7WVqeDI+hITH0gaja4NWzRZlYMNhFI46mgyM9U/ybYay6448+3vY
	 TmDsJrGKyWEooIwFNk7hjP9PnWvCYir/LXYOm+AD/ySwqSN56l3hpg/VyPz+0elTG1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lh1ezFPt;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B5606A331
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 176B5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lh1ezFPt
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b402824d07so5502037a91.1
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795803385; x=1796408185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1iSCYIDLtB0LsuikUchSv5LqXfsReYNoVcB26J33mOQ=;
        b=Lh1ezFPtZhtn5aP+sOYvb9GIW7wrAyPQ93CufnodhSZN66N73uHWzG82e/IngQQCL2
         O1VomnajxlqCV207dfnazfpgfd7I6HLPiSrwnwQ4MZITZSeWaUjyt6Ecwmg+djfqrtWr
         7JHDrfxOJEoxH3i/fCd9ojwj/7MuMkTO65g/UYqh+BIrQF3u/og0RI+f8JU1OubbieJi
         lc0u7T2tj8f6KpcDg4bEu/W2o83Zu3qh/eAT1iyvikF9Q5hFEwA8R6ayTERqoUYRj+4s
         McFT9CgafAyGe/ln1VNXBHw5a82rxXaaYkMO01NKBTTCxwLjMTtyh5pDCLBAswfSarx6
         XMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795803385; x=1796408185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1iSCYIDLtB0LsuikUchSv5LqXfsReYNoVcB26J33mOQ=;
        b=BNKbcciDBSr2fMQLWJxbou1ESOktzbBPR4Vas/9DVf2zlwsYt3wWICdXZTfGSuBFlY
         W8oLO1M9lsKNgIfkiMKtYI8cmk2XIrMRJy9830wehLrChXKtUrczPCAbzCNLU3mK5vZh
         ++t6L1ONH9vqq3OsHPl5c/l+Isg7G6GSfRwR+Zjd7sviko+ObYv3tsEtsHlfOKbpKgOc
         vGL5KyxsRiTm3t+RBpRCqMqeEeUF+1guowa/MShxSP+3RGQPqHQH1/bAJWCnsjWOr6HU
         tI0ILKqz8j13RVC9AE8F4+61eoo6wqdMcMvyiUEwq5Rm7Ch1qI2WnFxuBxui2BQuw1Ba
         y+2Q==
X-Gm-Message-State: APuU4Z+vmXNwQf5ZOXCRECIulOREn0V7StJFjY1dbOFw9ISZ7Omh/Ylo
	L9ohaKUtkKpVJZaSEOiizeV49nj/dtRSKw/rf912DogrvxwiXflDbGSdchAylPTl858=
X-Gm-Gg: AZFdTZfn/rnx2N2/sKEWWuwxJinN3mujfOZQBJLP+1x5e9DPKzOLebPg3122qZrJwrt
	0Ox+72hCmXrLCyqF32cww3edbR1SelnqrvTqwr8PzDemzHyemJ16xW9Yq27J2nqrcWrfQCedZGe
	gBauevwfCo7utGzMG/pdMR7mteOhL8dEMi9i+plkVp5vxns0CpEI0mkdrZOKqaLCG+ffmFAl/ic
	Mbnu140Uxo8pUdsdONMPzRCaydN60VQFctBNc/EHDRikqdqMk3hjfwFRv/+b//ZD2dlna80mQtN
	is/tPuLOQxm7i4+NHhy2nv3Ul63/CVDenUN9RNooTk+zTtYmOysKHWTAoGYQddFLZGi9wK95nRy
	T6vEiBS9SDS6qi8lQRD3vBItp13JbWMI8A1LoaxJWf/2mQk+G29QfaxgfGHYc60XBiQ5RYYfjw7
	+233K9BEvTVxIWcl8CqLnOEhbZ0M45n919i6sDpcFapq1i83960Ko2bbHLsy9lgrHuWWx7YLBL+
	nZciz3Y3knQw2AwHBDHlvXSyJs4AAl8NxY5wy/OfSGfECXSOxcPZRjRKq3DynYjF/8CIz/o7FEF
	li/6UcAco/6ncs29Z8OANSqdB3KURlY4RsdgAUFky5QqhDrKLg==
X-Received: by 2002:a17:90b:17cd:b0:3ab:884b:65a8 with SMTP id 98e67ed59e1d1-3b41c9032bfmr24421974a91.26.1795803385345;
        Fri, 27 Nov 2026 10:16:25 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm39867121a91.13.2026.11.27.10.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:16:25 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	vireshk@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v4 3/4] ata: sata_dwc_460ex: add missing newlines to error messages
Date: Fri, 27 Nov 2026 12:16:18 -0600
Message-ID: <20261127181619.183139-4-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127181619.183139-1-artem122novak@gmail.com>
References: <20261127181619.183139-1-artem122novak@gmail.com>
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
 drivers/ata/sata_dwc_460ex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4ab378d2c26f..df711a802c53 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -497,7 +497,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 
 		qc = ata_qc_from_tag(ap, tag);
 		if (unlikely(!qc)) {
-			dev_err(ap->dev, "failed to get qc");
+			dev_err(ap->dev, "failed to get qc\n");
 			handled = 1;
 			goto DONE;
 		}
@@ -611,7 +611,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		tag_mask &= ~(1U << tag);
 		qc = ata_qc_from_tag(ap, tag);
 		if (unlikely(!qc)) {
-			dev_err(ap->dev, "failed to get qc");
+			dev_err(ap->dev, "failed to get qc\n");
 			handled = 1;
 			goto DONE;
 		}
@@ -706,7 +706,7 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap)
 	tag = ap->link.active_tag;
 	qc = ata_qc_from_tag(ap, tag);
 	if (!qc) {
-		dev_err(ap->dev, "failed to get qc");
+		dev_err(ap->dev, "failed to get qc\n");
 		return;
 	}
 
@@ -1187,7 +1187,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
 	if (err) {
-		dev_err(dev, "failed to activate host");
+		dev_err(dev, "failed to activate host\n");
 		goto error_out;
 	}
 
-- 
2.56.1

