Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670130;
	b=lqdXNh3rXMsBEjLqHxU5HjxjLD0IdRV5E4evcUMQCG+M/6FEJxlOpieZZhH3mHBOiUC8
	 7BQBIBy7KXo0WUff/7QE+UA+apzz5ro1v1frpUn4HXkpKjZwcZsLAHlcJ5ML1f4vlBvx4
	 IZ11pxQ3OWuPYUMqOkBQlM3Jz57gD0GJMB9KbrMl7CiOJipQZ7iLjkOMyhLoDxiNYYU7T
	 BfMdrf/F6otigkNpaq332OZpEJPims4dYRuiOaMnYoqClYS4XuqL5TYhPVAVTJxMJ/721
	 y1ds+i+tCqhmcRLYnKpxh2VLuHIJxWTnryvRLW8tRdDqwcMwGU/q9bdMexaA6ED8XOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aBxl91IFHxSp98BX9SH0COzdVVb1RDUdXups0y1oPJc=;
	b=eGk+//fmIdwFxD5eaoLDH1FARcDPthyadiPlWfrCrOS4ei0j/1UkCHYIYCo5omJI5ZSi
	 /jbAsPmA1TjpudWo1GcynPOFLzH7CvADjVYZPSGe73OBtu502HMLjsmXVJyvCy2Hbciq/
	 FVbsvzaXEZWEJM7ICz9EuGGQoT5/x987NEB7zi7yvRubH7A92URrnjHf65dtrtUb/j8/q
	 nwCBI29vdpF+N2eofB2KgAGWEqjdsbWNq4RIMB3riUyaV5G6WgtictWtbOMTwEzuklOV0
	 ISss4K6hnnjdp+tXUg1J9Z6AbUyNrOpVuClbGXBLLfDtL/eQaM47DYXvRSdTJVg/pBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rqh43eIt;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BFB606A680
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 05:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94BFB606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rqh43eIt
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso2678221b3a.3
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 21:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670130; x=1796274930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBxl91IFHxSp98BX9SH0COzdVVb1RDUdXups0y1oPJc=;
        b=rqh43eItLw2VvBUu8/ab2PM+vFYDTvks8O7GhSnvGrrkV0IwT+OBLvnt2+k5oM7AkH
         4EGMrSiOPtUmOsnmsFdVGXAp17J8K5Erz1xWdGyCX5wSSVu2TpDMlrqNx8nw2XYPE44H
         QYUmvs0mZGiZAZyR/dEzR7ZnVgVDEEj2groWruErQaHCXSun8lchlU0NOYeZf+ne5sVx
         exZIDgeRSlZg84S8pNMldg7c/GuwFsYotHQFMK1FSfkMU7trke11p9A/4EYE0coAqkDr
         WgaieWFnAE19Mh8Y1X744Qs7YEN3Wqo2GT9Noudp/kjpFDCajHJeM4chrqSpK9McxuKE
         8/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670130; x=1796274930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBxl91IFHxSp98BX9SH0COzdVVb1RDUdXups0y1oPJc=;
        b=X18Vqif+pEkOP3Kzq3FmIzjipLkvh44F83+y9K20DqjP1frIo4UPMEaz/NEtWz3UFI
         8CvR1m7sJ0rflUJJCZWeScDUj58GoLfsh/iDyMP02/zHOnoD6oNhQaXHgjFuFPX2lOc6
         r14PWmRbcX7my2WOB+FyT+CKHox9rDBX2MMqSM2V8j0BOA0Oylr6/UIREQRTJeUzVxBd
         pdMR2lyy4ipzljcXGxZ/oTp+dJamzlKKZiyUpJMbT2xLFCYkVuO8bpfjzWkwHk0271sI
         mXWR3XgqmzLifPmiPIRrY/MtFNitS2W/BuLuDWlyyQQAcyA8ZwylF2WucOsIVJ/+aB5t
         iU0A==
X-Gm-Message-State: APuU4Z/mFr7YH6mx/d3gYeicoQFj/e4yx3hSqsUkrpeYGmwoHKLQz0YE
	kjRlL7+ZfdMBXYeoVFcsDAKnSit1H8mQ5eyMlbVH/Gw42v6R81+NUbEK
X-Gm-Gg: AZFdTZe7+eiOllISOhWsZuZZEinZG1TSOE+B1QfrR24ILfj9n+uJwSxe0lRtypS/jb2
	40vIEwzZjJDNk86cYiXUHYkUtQlG3+eQucDnSpNh8tCWnNhDIzRPWfUdDQZGEguKjOgTcAkr4W/
	FxyZrWn7kORVFHID1XYagrBjwuN0HMFT47e1+qEs+U/fIUsaWfla2O/csWEF8Q+P4d+dBET7Btk
	3hazJp/Uph8LAtheMwxxUONy08Rlz9ZVWvcVfcGEmcBa8jJLDGDmQDWdMJLiqYCrgerRN/wPtal
	Rgpr7tNy1c4vKtlzHlcBA+Olwj0SRRLrFICrkRx+GsK6/8hCPWeP4gYXyV6LTYW6GFbfmtYz27k
	xlJhw9rSV7VYwhBIYAvi4V8Hn+5D4yMEm//Zdf1tCifUsO/U6blY4o2PvIaUdN77+3/EqzKx7Ct
	FZVw6cs728J6ByvCBPvhGqVhL0B4RjYJyzrMG1b+INAtYjyjYFadOiThTv9Rx+38GBgSX4traJ/
	n4vfFKn7xNLgDtAGyQxtwrD00Y337rQiO0Rpq0T5mA9phlngCU9HCi7Q6he2hJxZfzDq0RZAdPT
	MKZlry3ta+zsNRNZhsbllsU85AqntWQ+7A+dW/+v9nRbXGF5Aw==
X-Received: by 2002:a05:6a21:6e82:b0:3f9:c2af:37d9 with SMTP id adf61e73a8af0-4014e06373dmr20130506637.56.1795670129999;
        Wed, 25 Nov 2026 21:15:29 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm10179820b3a.8.2026.11.25.21.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:15:29 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: vireshk@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linusw@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH 4/4] ata: sata_gemini: add missing newlines to error messages
Date: Wed, 25 Nov 2026 23:15:23 -0600
Message-ID: <20261126051523.14431-5-artem122novak@gmail.com>
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

Terminate the SATA clock lookup error messages with newlines
to keep kernel log messages properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
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

