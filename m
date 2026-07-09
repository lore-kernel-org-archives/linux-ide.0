Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E28F35674A
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564326; cv=none; b=Di95/K0zJaLun4ziD413RkhufY2TJjOAYqyeI0l4fX6UgpmHPY1W6tQXGZOV2wOAEN2WLb3Nf36F8yseoXUtosLJqmYI3SnuZstS1FYS8AYW88d5prTLEm08baWdc/qP4Y4SdiiBfO8Yx19ZJRaAaOkyePxJtLO5/1S4q/EH6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564326; c=relaxed/simple;
	bh=N5ypJRr+B4PLFY0uTdy/nYMiu3cORVTUEBd2Eh9uOXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6lv0eO+C/B+3iRicXOMExuqR7sbredlVJnxCKDt3LAl7v5/swwB5MFe8sQm3i2CDWiqmHSuiyXbSl4aDausi5wd0o09usrML0g2yvdQIM68pCsjQFNmFcJGsn4XAczxwvG2CIY1qtOZhrmlEJOqs7dOeiBtCiQ41VLwbrC5rvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0xgS5cF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0xgS5cF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-846970f0acaso414322b3a.3
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 19:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783564325; x=1784169125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EkdpAtMgxU4TYg95cadNbgkx4tHxAGnlxHVTCHLzsy4=;
        b=D0xgS5cF6sGHVlax4abphNZI77o8QECUON6j8QlY5CHkPK+odrRjZSMcaX+dKXYOVj
         lXISy5R+NDXxcqUHDwVa7R57vtOEDhHXePgabx4t+bGkUJ0kmsBLGo+S1jWSyDKLqzGU
         RpGNwouEtk+AdcN8MyfoFXbrqUzmrnQrV0kiJfm9yqFLVpq/LK0A3dacgG5ZszwJMwLD
         VYbsYdpuGKuRNBXgmdkvGSq1OYpaMVVqjTRPGtP6mig3bwT8eI/RJH8AOO6sIdhYvY5U
         6KTi1eT5wKDTrl4zqhXnswYYWoXQzqma5tD4vhtgpuwhcgP9XWrWPTDir5U3+a3Drg3m
         Oxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783564325; x=1784169125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EkdpAtMgxU4TYg95cadNbgkx4tHxAGnlxHVTCHLzsy4=;
        b=KVpN2CJsVso1Sa1XL+TyJrG5B0hqTTgCiDuTxALM434gb1SYBfWz2eUOQkn5VDv/6A
         h5TegnjuF/dqokuJuVrEItZYPlyw2vCX+Tptl3n3KIEa3GV0h502+lMl7TkwYoJXBZhy
         2UF7LnmB+hU1W8uPqf09qf1LLLrpm+MCdE2m7SqaEqpgf4r5RIDZ4YV4nTH6FCxnEpYH
         3y9PD32JaC1xuBxD4Idy+ThGXO3J0Y4XP/RXh9/gevTv1rzawd6Wo576SXjKu/VdgR86
         p3JtgaOsABG1HvCV6hgdgNUmzNs3rhn4YxcsC5RL89eFKSHK16+pe1VY2AQSNnipeTdh
         X7VQ==
X-Gm-Message-State: AOJu0Yy6KTwTO4jk11krflvQ15GjiFzo6VfdfQ1EyndtkKWJWejeX2RT
	SEFXMKqXURu6fL/xoXsgVsmqb2JVFLRfijrNQliMtFHbCryqCMkyZq1r7K7f6A==
X-Gm-Gg: AfdE7cl+XqNE9VSe9hu5T+fJ0YYkxCoEB95rAUgfJY8O9nEai6rnk7kHM/saOrkbci0
	qyEooeXvvb2/+n6JhZ3e+IhAQH535i6vquhGTuunEk+QnQeNb6IcKUHDoJSaddCxq8pmQcZfVt9
	OK6l2ZLFJDSm1T0T5ZQOk7hgAUGjJ3/P7fXJKCjhPBkbSnoZnpqS2X/8Nfo1Kr2K0erggB69j7k
	G79Hx/hTFS9n1xrwMYi1MSvWVpW3R42naXsvnuHOleRkqLwnA3KAZyF7JrK6lyRI7n9kNPw3b+D
	x6+RshyV9xtQskGcDE6lZL35W8/nzrCqYl3EJ+2VSdZHlDEbCXIowCC2VHjFpGk6R33K7hEFQu5
	o8hzWAch09Q+ReJuJG5ONRBTeSPhB4YlKcxPwMvmx1T1hME5sg+N9DK+NuQrnVgO4onpqA0Pl5D
	3MSu49gJwyJYLVsJCx+8V1I7WdnP+t3NZg/8MIbk+qTHMsZRC83i56cAu8MLc5my2zZnlkdFQlc
	9s0dMbZ36PdzrRXP2YfUWsFHAbJBNBTOnasxPs70sGft83GvngkrxZ6xaP+/IXLFw==
X-Received: by 2002:a05:6a00:8f0b:b0:847:968c:a0f1 with SMTP id d2e1a72fcca58-84842fd40fcmr4991124b3a.43.1783564324890;
        Wed, 08 Jul 2026 19:32:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm7935954b3a.14.2026.07.08.19.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:32:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 0/5] ata: sata_dwc_460ex: cleanups and interrupt ordering fix
Date: Wed,  8 Jul 2026 19:31:57 -0700
Message-ID: <20260709023202.2132165-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various issues flagged by Sashiko against the original submission of this driver.

v3: Shrink series to Fixes on the initial commit.
v2: sashiko fixes.

Rosen Penev (5):
  ata: sata_dwc_460ex: use platform_get_irq()
  ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is
    registered
  ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending
    interrupts
  ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion
    bit-scanning
  ata: sata_dwc_460ex: disable SATA interrupts on device removal

 drivers/ata/sata_dwc_460ex.c | 46 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

-- 
2.55.0

