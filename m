Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729685;
	b=Q3zs1B9i54aptF84511XgFKoEz7Go/bEv0zDqsgDfO4k/vLkyr2m3i5QumGQJRceJCm5
	 UVxapJVd0YQbPwjSwe211eb1n/pzlpw89O6VQzyqmd97cNO3HQiYmb3n3DRTUummwP61x
	 gIsYTMrgazU61Jz/FgR4wp9LazZzVLoCUml2X8GWu3rWBYNSis3jli4BEklzKMJYyxq/r
	 lDyXzpQ5ttEbu7iKjIguQFoii1jbYu9xKdVYEKyFRjpDWDXRR2h1HUmbJoYkBdfHB0iau
	 ijVYebR4mvcUxXvGvUCLMp+zZUvkFQNFoGKNkBN3/6zQXz+x7/eIeaccMZ42xyVOFEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oIf7AWYdO1zS62mXGE9pCL6nWbiT96WGLtk/goDJuAQ=;
	b=xC2NdRsI5p85/lvkzPeixHEgp/4gtFxzMMjtpOjM8bLIb+n6QcgRujmgYhii81HLk9bl
	 bulsKAhHyLUTxj9sKX4r71CIzrjVQhkkhDjbiexa4YqQrjplgjF8ZHfd2wznofw4yIqoG
	 eCkTOglxuZ/9yG0Ep/jDYY8Ja4+uHtQsJ0K5qpEf8LAejV6dQZaGkTBXSkswquAdgMg0X
	 mpa/XN7N8a+reln4VIcAcTjwzikt/OUsElAQ5GyTD1BKkOI/SVaHJlzthNk6AlubNmc2x
	 ARWqGpkmUB0KWlSRuaiJ43fufWrBythE9yTyl5ruzv0nq/Bcl9qhXfEFWbgCF7E4pKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CH/Ch4LV";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAC606A339
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CAC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CH/Ch4LV
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f04fab527eso56424615ad.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729684; x=1796334484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIf7AWYdO1zS62mXGE9pCL6nWbiT96WGLtk/goDJuAQ=;
        b=CH/Ch4LVIkJ1qMZ1aGmp3NPvESW0Uzn/DY3d5YsRskDr/CfULJMiiIpeoVui+fG6nT
         FAF/XA/DhkpJfB4OUo7Z0NmtP2kWebOmvt1Y6vivKJPZw5A/fIS1RKbDOIajaJW/M6kk
         gSvt8ASrKTMqEUiPA1Er6xDU1Ox6X7UWEQV5bW1OdOqAV8g24jh2qftlY/6FOpeAJBf0
         HPYDIq3UdBw44zhfrdbziSsZOT3sOAnFgrzTYseN9Xl+JgJ4CQ8138ONgsQ6bErEp6nI
         Mt99E1ikg1dvszWQ9mYoIrDnr8SiOCCWsnR2ZNJArXgkVH2UGFmj/dpIiyBHtOGFbiZP
         ocCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729684; x=1796334484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oIf7AWYdO1zS62mXGE9pCL6nWbiT96WGLtk/goDJuAQ=;
        b=ZAl4AScwGQNP+/7k/E9EJlWjQo0v4bXJWs3Avpec3GUI8WdJHbtgEfIXJrBpzBf0ex
         6YfLmcH2EUAq5tdY+tq6z11/TwmmAPbn4KCn+F+VIi8G/XMJ1a5ZoRh4kT9jXqMXal7O
         oTBNjsznskotiFqxkfBjs79/sTqBQFiO57XHloO5Vs62OcUy6PaaY56iHqAXOXOu9qu8
         gJ4f5tPvclKDcQZ/msAF1xEJAuuDx0cFq7NtjvBdQycNMrITVvFDS+Ze+2LO8SyhRnp4
         DHFTYErToB6VB291X4ikM+BAllMB0B3SQlHC8ZliEYqfpewVl8lckYzRQmonUCqs/QAK
         QwVg==
X-Forwarded-Encrypted: i=1; AL+hErGL385jrEhMaXAPxH8OH9bdZE7dSW1PzCwFimGGEJ5ixbXklhLRqtYv9iUxKM7rWP2Rmn7Ivpf2XMY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GD5XgWlbiTbrkDLzLDyLUt0Nfh+XeTOz6vB+X+ZNrmpMBJ0YM
	aNhEO4hHjSruSkDxpk4qaq761v2EPOKIab5OK+0yWFJvQLq639lFTZll
X-Gm-Gg: AZFdTZcHNOx6wQcEpNoa+tnGfDaObtKWH28W2bZioKRTbSC1LtqEhd1/cvzFbJlfJJG
	DDM0tM2oNUFkDIQdk+NwKZ5dn2fc7gq052kt5jmoU/st2F48U3zK/hW2LzteQplOmv8KNdlgb4C
	SRUPSUg9HeIxBfiQRKB4TVFQTR4TiPuwgUYepPEnFYImyAOAIQMJu/IY4cAkY9MB1TKhq2S+YO1
	bFdKa3W0vDZGsAGI5g/YgIZcNlM9Sw2FbRyUfnJe4XIXmqQw97Hxa3WfOLyRvBSBAQw/o+3xeXs
	Tr3RLOEPViK8Boibv3heEDBXAn3KJZ2YgAUbZAGp+bDy2meKotcgjvynZjoPLYnPoE1ckHQPMIk
	xbmtwcM79u+VpR3eI9HjZjifhlgB0u2HdPoOjH9RFXTWpvXo2wgsD0Xrup/RjdbFesO9rMKp2+F
	vO/kBaJt06Ow8OgRNDa4RRDv7ar61aykt2InjECibmiB59pYVJuLeGOmCP8KdTVEVCishAzUNoL
	OeKwYUvwBN5VvOm4f+vuiE10wZJJjq9FEqincazHM22Jx62TCUquXJARAZpqf6kNttC/gJYhxF4
	xW8JZDLgPVVy7CBsGQ8p4bGrP1OWklRfHceeW/+67rDgG42veA==
X-Received: by 2002:a17:90b:2d06:b0:3b5:a3:4424 with SMTP id 98e67ed59e1d1-3b500a3461fmr5476821a91.38.1795729683673;
        Thu, 26 Nov 2026 13:48:03 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm34636414a91.8.2026.11.26.13.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:48:02 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v3 2/4] ata: pata_pxa: add missing newline to DMA warning
Date: Thu, 26 Nov 2026 15:47:54 -0600
Message-ID: <20261126214756.39027-3-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214756.39027-1-artem122novak@gmail.com>
References: <20261126214756.39027-1-artem122novak@gmail.com>
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

Terminate the DMA completion timeout warning with a newline to
keep kernel log messages properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index ed8c19db207c..46f93ad25a80 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -97,7 +97,7 @@ static void pxa_bmdma_stop(struct ata_queued_cmd *qc)
 	status = dmaengine_tx_status(pd->dma_chan, pd->dma_cookie, NULL);
 	if (status != DMA_ERROR && status != DMA_COMPLETE &&
 	    wait_for_completion_timeout(&pd->dma_done, HZ))
-		ata_dev_err(qc->dev, "Timeout waiting for DMA completion!");
+		ata_dev_err(qc->dev, "Timeout waiting for DMA completion!\n");
 
 	dmaengine_terminate_all(pd->dma_chan);
 }
-- 
2.56.1

