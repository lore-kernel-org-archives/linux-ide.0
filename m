Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50861DDC37
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851052; cv=none; b=OdIRV7RDJmtON4woPDw+fNRRA/znDEfgaGm9VMtvQR7b90cUpEOlXQ2ARVC+VIGrOhffHVb2eKpIpO34nVLJNjRDr0f+m/XozrEAd9FRrDQBnG/IcwyX6qEAtzTxUUprZr7q+ccK/+V+/4t4LkSMtObe6lCrAL/h3Z6GsJbK3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851052; c=relaxed/simple;
	bh=b2VhNvXrHCrhosk8OuiXbSxaibv0yuL8K3YtVNw9Aqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KGaHFp1icuhP8QUijuS/2Ea+oDn3F+MAE1DHQSpmE5hgiocfO2fhPYc/GTKUOd5y49bo5+DeniRwbV26pu43ZxJtY04oCG72lefqFAe2uo3EAgILFZcCjhXOHKGUv8IygW0ZYwPnGeRBI+DEhs3gdRuzoiS/0bSlKr/2klu7XzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ3A1TzL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ3A1TzL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c979d03538so16670725ad.1
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782851050; x=1783455850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cC8fzwBv6xibExzUk8Zd1lAmfRWnIh89Kfn8/etfuyA=;
        b=lZ3A1TzLbuEsW297Dm6Gi4l9D2grANowNSNqJF2wTUB+DHE20m7a5zuIcnJQ2vGZo2
         TtufMqvm1zzD7HrJmcki4ZMnOMdNBQfXm7dwLev3VGLS4tyVuXchEi4EMQ3KgbF6pLT2
         m/fQCGiDPGO18FHX32e4oqCIfz4Fmv4yJ7Dw7C4T4ie86a7GHaCgoVNfvmFHCmfs04mN
         LTkmYYzCssTCJAAm6baER7lnRIT/SQlAwzXEbBm2Hpr121Qy7xIPJpPv9Ri9gz7XRZQC
         wE9iwBFWuwuJ+gaPe02VISfXjAgq3gCY8+wO0QRViVpdq4p9hVYnDYFx9KmWu83N0Gla
         6U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851050; x=1783455850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cC8fzwBv6xibExzUk8Zd1lAmfRWnIh89Kfn8/etfuyA=;
        b=LpOUeBCV9HTpsTlSoQ8JawhNkHfh/p7INwHJpf+yx0vS4dQIbzF6YprAolZ18I4/9T
         ltvWE8KfdCkswxTtcUQaPAJo0mUDafTtfQaPRkys2LM738kRvKWKFeElzIFoPVagquNq
         x1IFJCtX41v6FQ13Q0FffTOzhdFqb35QOFIB5bfPESXu5i9mbdIbz57BADRSsJtfwqIG
         dcSb1LRschzW8+YqM73Ah/qz0/Q5VUwJpOsmhRS7hl8uXZPoBalIAiipeCVAh/uvqCGC
         3bNwcCn5C8eEyff1aL3TZ5YmRUFCX2oIevqS4m5HPdT8O5NZTbg/BEb0yBM96Q++VC6B
         6ZmQ==
X-Gm-Message-State: AOJu0YxFFz/CtO8gO9HgK9pzCHYJRVNdo1/5oauyW7KJ0ZnPn9qkoiuX
	x2hkh3etZEvteQ2XyDMHH5wnckYmdW1aoPMnXZLFmKFKXGx243xdc31bwt2f2mEW
X-Gm-Gg: AfdE7ckkQPXu0pI3Amk6oEtfeFHUlkuAjIjNMv0HLJmSHC4161wVV70Rp7af7itX/Kb
	Bw0g9d9M1HtyqEX5L5dBzGlco3ZuZ/r7q0vIngX7m4geRBzWQ6bUV5wRGAKtSG1Z0MHZpm1eTF6
	CFNHii0vmV8msrnODdDzNeHl8SzbdAWjjlGdCKRaFvKH5AmdKvegDEZdDm4dXvWICyHxObrRACZ
	DM7k7l/YlcVvtSV4O5Wr0XqY2ZbUK0YLUkRF0vizqwXPfDyELVlwi2zdX1vcczEKStMsqND35ut
	SQgJ4lnA5x4PmfDsBkz+n2+V7HB9jlZ61WCUuKJoEl+fHSxo6X91cAL+KrZBI5aw2k4k5b9g3f7
	merykxVL/H6RENiCtnAxZc5uEaxOQgM8y+o4jFCKEQmWuKD+93M6jiLPaZ2K2PZ6U41nn6NedtI
	Glx97urj+l2EWoT+nPeOVAgi63ep/+hRqr3V7lGH1g/0yJOBkV2O3FUQHOMjAsdmtd+jJS7OG+S
	x8R+LKpEinsfSlBU/2t
X-Received: by 2002:a17:903:291:b0:2c9:e846:a57e with SMTP id d9443c01a7336-2ca2d3dfbb1mr38161815ad.0.1782851049994;
        Tue, 30 Jun 2026 13:24:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca3828c2e8sm20520525ad.43.2026.06.30.13.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:24:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/5] ata: sata_dwc_460ex: cleanups and interrupt ordering fix
Date: Tue, 30 Jun 2026 13:24:02 -0700
Message-ID: <20260630202407.233964-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series modernizes the sata_dwc_460ex driver by replacing legacy OF
APIs with their modern device-property and platform-device counterparts,
converting old DMA resource teardown to devm-managed cleanup, fixing a
latent interrupt-ordering bug, and dropping a redundant stack copy of
port_info.

Patch 4 fixes a real issue: sata_dwc_enable_interrupts() was called
before the IRQ handler was registered, so a probe failure or an
asserted interrupt could trigger an unhandled irq storm.

Rosen Penev (5):
  ata: sata_dwc_460ex: use device_property_present()
  ata: sata_dwc_460ex: use platform_get_irq()
  ata: sata_dwc_460ex: use devm for old DMA resource lifetime management
  ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is
    registered
  ata: sata_dwc_460ex: drop redundant struct copy of port_info

 drivers/ata/sata_dwc_460ex.c | 66 +++++++++++++++---------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

-- 
2.55.0

