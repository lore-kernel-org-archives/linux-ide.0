Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729681;
	b=TtvV15hIu7mA1NEDHL5Iu56PDtV/hbVpeh2AVqYGzVwHApTA1eIi/caiL0m9bvMklsNE
	 YnIEXhvmId+yj+h9kDynC0zYDyPe/ElISoigdzA0q/e55PkBdjB9P2MXsDgSDjThqS6Tz
	 DMBmRSIA2I2siVI9XGAxgXfXv0hvok6VP+38uKwfL9/+vH0kPNR6oppmyzLkNlAO8y7eH
	 liY5ZWoAvnwgHbaYEhLPYE79w7nsZPjd38wA8n390milr3zuAQsP8riDfcKv1yoz2cPfH
	 qcHNQzaCFejtc578v79eQcn9ZBWAEqXTaBdX57EGizCDH+n3f5d6vv/4G2k5utvqrzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=88wO5kQpybJ/beFK+Rs0eIReDQhcfH9A53/2Ga7sliE=;
	b=04drNqWy7ZpoOXLLwVmwL3NopYnP49MgAYK6oPhh1/12kwaE44JnhV/t6gf4MBqHT73y
	 wrbIPl+G5wu+vpXlXpE4d0bDnYge08sKldm4xSIzYT/Ba4SAkYuXf7CeJNgzRTgZ4EG7w
	 ODQNhy33E/WtqEXpZ9Hlhu6zQ6OUtdQuX081bU1B4q093Jtz4Yy6QmHD0zdH6M0fKuUVo
	 k8auFFJLSpbzNeJGh3fMB+FIS90t9ks1YH+CzrsjTEaugqFyGh45AQM/JAUg/Q2kLcjoZ
	 Ww6MO+Oi+Z74wEKrvLpJ3XoX5v0Id0/cJGFPgHVdtaiWQ9O7YLVC/Hxn0lJKwQtBn0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwUrkFTC;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8A606A32F
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AE8A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwUrkFTC
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so3246844a12.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729681; x=1796334481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=88wO5kQpybJ/beFK+Rs0eIReDQhcfH9A53/2Ga7sliE=;
        b=KwUrkFTCKPd6KLpLjFH+lWDV+IlcqS12aXb4Ysyvx1A6729PEeOx/zqr1XPGMzgkXW
         QoHutuAETVZa1JYymPzcPpLdaYZY14csGayQC3PR+7cKOoqBD6C0Ho+JXXp+HNV4p1E/
         JFyxIdWmwQBhyMPa/eBqmgm5fm6NF1FEO1kktYTUAS8OmMyFRqVNN5cRM3pioL8QKlg7
         l/t6q4bcOU1/yP280nrqKPANKbMmbcJZ4uSDqw2N+zcZQzj5g4vunhue6XcuaGbTj7xR
         mQJna0tckJdfFSusgs82ngaYuBvcQj9XCCtcFIR8ACID8/QevBeVOXS2VV7rGR+NMxGM
         ltFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729681; x=1796334481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88wO5kQpybJ/beFK+Rs0eIReDQhcfH9A53/2Ga7sliE=;
        b=Vw+w/GHc9jd1K/H9ckabnpTjt9O3LwyzsUkUxr9Uk3CEnHcv0Df3E2/1fh/+TDo3Vx
         sKVVs+WUpIy+uMJOZn/tkawzwKDLfZ1yxuNvS9DtfOA2vj5MYU5jDkAYSmbuFtZNp3jb
         TRzGwtMWMRbOisiuy8K9ygYmE8IRvaV1qTWD4OaDr249vR1YV6jHGxLekrwbV8M4i/Wj
         +AYZN/QoSETKyqbNLkC8wPjd3jsCuynjX+vi01k3TDBp0In6PjH8kHnny15fJsFLMEMw
         aFf0h4majwZ5b2b6qZWX0Z9pbDFaSAWUHrKw3S0OJTlHkk0x5sJSwBd2wMh9oZZu1LgH
         Uy9A==
X-Forwarded-Encrypted: i=1; AL+hErEltgh6V9APXQ7bvq3Ucz64HsRR2DL+z/c/EXMHcHC7No7EgY+15QOfneVEL4nlaVbqLyxwEq5Jz9U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GbtCafLNvM/J33NhQGJ7ZfwSvovmgMmM434fFi2YGS9Ltf1OY
	gQinscMY15CB/f2ylpoB2jiAdiqUOSyqABIrkzBmIusbfUDZCcPp4S7u
X-Gm-Gg: AZFdTZfYtG0cKemhwb70fGJJUTDCia1s+/u8rFb4hZZCKOVPJk+aqLb+Dw+n4PCeFG6
	w/lqoQHSf2ZXMhOHatdIXauETvA3+QnbLK4H1A+wFmy2cj9pZc12c/uo0bAyVBLcEhA7lWXt0OO
	w/wQ23WNRwYytAqTSIspPe+w3dXT//bZbQgaDSTjI5XoDEAnqC/Td8w2xBZk/DBe8yyzgm6azJi
	7VLd0BKjDG2+woV8Wx7S6kv7E1nrWLpjWsbrwA2Kfg8BjYnfA5wC6415ZgFO+WjiUCZTi7+HZjR
	TKE+gNJbOMcOAsKrBmYeVbGcDJjq1Hx+otG/+O7MdNPR0nlfc0UoU8OmIvZOtrTPDgSIuE/6mDm
	YYNcOEt3HF8ATJWz13zfvvCTovdiYXsbWfzG3JPkkvTdejmsyFybMvNICzsPa6Q1oWQ+Kd6BEAz
	2u8mw/NyHO0vIj9I4nswQOXN9d/2K5uR55E+emuQGPekCu64Pvj3n/7OgwoP96Ka/5vvnubPeDc
	sYli7+4VgCQNhNg8gaPkeAyJj9o/vJi2kVrNlvmj3ia6sTjFxB1Udy0khgl1gZ5S59huLuFFQJD
	JgUsQjFKmuXrWEMkuMQ6LtFWPiwz9IoJkPMAusOFkS9d7nHMiA==
X-Received: by 2002:a17:90b:3d4d:b0:3b3:b704:119c with SMTP id 98e67ed59e1d1-3b41c938935mr20334429a91.37.1795729680792;
        Thu, 26 Nov 2026 13:48:00 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm34636414a91.8.2026.11.26.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:47:59 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v3 0/4] ata: add missing newlines to error messages
Date: Thu, 26 Nov 2026 15:47:52 -0600
Message-ID: <20261126214756.39027-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
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

This series adds missing trailing newlines to error and warning messages
in four ATA drivers.

The changes are formatting-only and do not alter driver behaviour.

Changes in v3:
- Carry Damien's Reviewed-by tag on all four patches; it was
  inadvertently included only on the sata_dwc_460ex patch in v2.

Changes in v2:
- Fix an additional missing newline in sata_dwc_error_intr(), as pointed
  out by Damien Le Moal.
- Add Damien's Reviewed-by tag to the sata_dwc_460ex patch.

Artem Novak (4):
  ata: pata_arasan_cf: add missing newline to warning
  ata: pata_pxa: add missing newline to DMA warning
  ata: sata_dwc_460ex: add missing newlines to error messages
  ata: sata_gemini: add missing newlines to error messages

 drivers/ata/pata_arasan_cf.c |  2 +-
 drivers/ata/pata_pxa.c       |  2 +-
 drivers/ata/sata_dwc_460ex.c | 10 +++++-----
 drivers/ata/sata_gemini.c    |  4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.56.1

