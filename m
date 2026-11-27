Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804955;
	b=rKcvEd1832y8csgGP8Tg2ulT3p0CCu2qqgiNW+JYlB/sBD+iukut5UnKyBfrPTbjISck
	 9dzsfnqU1vMnyYrlZ8f+y2re/c1aGNoHvSdKU9OGXAQYwrHid2lBS4dqJgwrZ2yIvu7Zv
	 qOzbQurF8p8soxjQxppfmiQXPFPQUfbbgLYINh0kOwnQX2FFuRcVODIzY2m7r3QIiq11Q
	 Q+mRoJG5f4xSc1dYB2f41/bzK28rLcgoshP76yNAQOtRRVrKsxaMJl3quEUrrW+3TZSaD
	 Frf70KTlDl+BkZ/eJdTWyx2vuCaOLUt2rcX7krmLaAhOPhuGQghm/PNENEFHIrxkobQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mz+Itla6D9aJ4LEfK+0eYjrF7t88lxIqTXb6+qpzWZI=;
	b=CsAcJGy89COE+Dtx0ekjQvfCe9J7faZoawbQfwSfA3gtCVf5VMHMlNQ87GS+SqnWkAWN
	 41xXRJ1ZsJVZ7Z2JeqosPKu3gr+o2MtEXs/5zLgYGN9p7ZNk+4Y73IlDCWNG5244BM+mt
	 7UJadf4vGWc/urQOJ7j32d6W/gv5Vc64zWwBQGNuWyjGTY7CBxZhTgzyRFneRguWoYIKp
	 mOIqzH1b7+rmrksSxjwZwxxVgr4Z6/wNjvgGx5jbMJhhGaxf+YGwGyMiAEXuLURBaq1kw
	 dZP2hmMkJOUNnSYt9+BbEhmo3nZWLqYY/44FO5yW36KS2MzKD8TAL/AgKHRbhnG+x/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="a8LS7/jr";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1AA606A6AB
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B1AA606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a8LS7/jr
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b532dfb874so737809a91.3
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795804955; x=1796409755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mz+Itla6D9aJ4LEfK+0eYjrF7t88lxIqTXb6+qpzWZI=;
        b=a8LS7/jrC8OakwEkuivUxroAjF4H4gY4gX6cWu8fMCGkxfFRs+UrZ51doqLICEdh/Y
         bd6UMbb0T1AU8w56hW4+KE37WsRuLnljwg4Sc5RDSNxSfAJqPXAcOG014uFR+Tc40RYt
         iE+SFsc9KTu0O4p35wLt5V99yxIMv9js/u4xDaidKe8le+6itp1LqjUOcq3Oo22O8rrV
         1/AuKEvXfEup4hjbbsdUXkI64zz3OUH5yfRf9D4nI5mc1W8zKf9zgu8kW2ig/PlHaXxw
         0A/KSjF9p5cJGckzjRyMHv9N4YJDmbLgUNfVWkDngJEbvLNJ1YuVGkxNtpLK6nINZDPn
         nqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804955; x=1796409755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mz+Itla6D9aJ4LEfK+0eYjrF7t88lxIqTXb6+qpzWZI=;
        b=MLjHHPi+TkdZyK42w/Db9TryZV7tkjBDsApOkXMePvFhLjGHloTABFKNJ5Ok3sZGTd
         qMpcwgJXc92dbgTuFbYs8wKTkVVO/1otomhQORAZuz6b+6HejlEgLVxyDx0KjpArGOP7
         Zc4k8sSCaUbYUWfSGCzE/U4so7mZMLYlGu0p7WdfECzZF+bN4qU5Lrhqjq8oNhu9W75F
         QZ2gudpxV6jpp2g2xgINY8n6rrgBryRG9zSjsmwIpNvEQKCbPi7FZy/hwzAzQTKRgOHk
         6Zm4iY8twPJrWrV2jqvITWwjndoWl2XQNV/X3HjxBdTh14u+UapAfYMERj2TUA5txmJI
         o9Mw==
X-Forwarded-Encrypted: i=1; AL+hErHVNFdt8EJ7Zt2V+wJOKhV3vesgaU4cLrK6Qmr9WldkAedu+HPD0169dx/eKlkW2ECaYCOslQ1j3e4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+p2DSDBFsugWX4Pe61FOfmXPJrbSH1b331YCsCBdlkg/dx7eS0
	MDuLkUuDjFNzAvi1lBZ8urW12R686wFyUiuodnxgUubkBGXvyWZA8ulq
X-Gm-Gg: AZFdTZftOjCI6sg8C/bhU4wwOK15uPuz5Vq+AUniJB3QtErc4DCQ3nIx3uA9HKPmr9I
	MzHF3kAXgytSYXaP0M+1m9IWb2Shs3YSgdRQNsgOigkZ1j0dDY6TfUdOm54nPcu070H/QnJ17fi
	Xt7jw3lFCt/Lteb/bOOxGYsObAuJHecq9HYyN4CyuMz6253EFTjfjDGTJwK6ddKRQC5isVIkvnb
	BLmHZKwj8AsSQj8t0YsucgIeSlgiLuhiYxiG7aWDT6K+3U+HTskVm8aNaRAggYU1GcI/mat2NOd
	BuarJ40VOeivQ2xAm/Yitz13pad/027nIBrSJ2Sa+Cqh4R0owjdVZY3t4/EfK7/z405P9Qc4IzH
	GZaxz9I0/kLWF3entOCKbVIABF9PWKDqNKKlX5o+Bp9BEVBFxxUQ6dOfUSUuUrVarCzwtFoLQTv
	Wk+a34tNqztn0Vs0RtxBF5x32QnHAtDWQejEoxdvLnjjHb+V1INhVx6TwUUkaTbMKO7EyLAfsNW
	oo5AKyLDATg24DsaRNXMtoDw9Qjq1B/xC1g5dzYr6df+1e5RUxouf03K3tttJPVf/kXYscnCSXA
	V/Cv7ZsWtjjzbf4rDSxqaW2ZgIX0ScENzNfUBQH8M7J/yELAPA==
X-Received: by 2002:a17:90b:4483:b0:3b0:9deb:d991 with SMTP id 98e67ed59e1d1-3b41c92cbb8mr25063012a91.35.1795804954700;
        Fri, 27 Nov 2026 10:42:34 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4dfbe54a2sm19149071a91.17.2026.11.27.10.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:42:34 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: artem122novak@gmail.com
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	linusw@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vireshk@kernel.org
Subject: [PATCH v5 4/4] ata: sata_gemini: add missing newlines to error messages
Date: Fri, 27 Nov 2026 12:42:28 -0600
Message-ID: <20261127184228.185827-5-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127184228.185827-1-artem122novak@gmail.com>
References: <20261127181619.183139-1-artem122novak@gmail.com>
 <20261127184228.185827-1-artem122novak@gmail.com>
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

Terminate the SATA clock lookup error messages with newlines
to keep kernel log messages properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/sata_gemini.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 9d87603ef531..b69db749b49d 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -227,12 +227,12 @@ static int gemini_sata_bridge_init(struct sata_gemini *sg)
 
 	sg->sata0_pclk = devm_clk_get(dev, "SATA0_PCLK");
 	if (IS_ERR(sg->sata0_pclk)) {
-		dev_err(dev, "no SATA0 PCLK");
+		dev_err(dev, "no SATA0 PCLK\n");
 		return -ENODEV;
 	}
 	sg->sata1_pclk = devm_clk_get(dev, "SATA1_PCLK");
 	if (IS_ERR(sg->sata1_pclk)) {
-		dev_err(dev, "no SATA1 PCLK");
+		dev_err(dev, "no SATA1 PCLK\n");
 		return -ENODEV;
 	}
 
-- 
2.56.1

