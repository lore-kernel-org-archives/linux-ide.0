Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804951;
	b=hgNo7uWgJyYF96pQFXptrpBGoUZm+i1Nd6TYb3vpKG7zQSCliDCLqslidGDNFs8koaix
	 ZIC6ehUJiQV+E+axMI2XrB+X0qzFZ4JferxYt6r1EEdq42e08ZfCuYaFMJn3QKvxUbvZa
	 FHquZ09v8H1k22ZuCfIh439kMyLWXB2TXjSpTrqivBekirtsgVpYT9F5aqtpNzDUhDf0h
	 EZM8UYLQvKsL94u8FKlParU0gwICTujWHafQTAisQW1lLlWiyHvVQY2s4t9ND+KBpeE07
	 RwGIqxAGStquZhyYc2T84QKu8r8oaRg+VLdhM6fO9XuoZ0Xx7n7fipJteYJvDVvxVig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gjZ1e898XhWXCBqSM6QfJZ0rrSlqOu1Q/txUinvl18o=;
	b=4W+k1DIr3ITRGYH2a/nehRHbAQlnA6uRvwN5iFYP13ZquSzBdVnrBNeqcUtpu6XYz7gV
	 /X7viVG/idYbln27TqKhjJqhQdpSueDI/Qni65d4F3ACJj8xYdvaj0QFZVhwE1CoZNvtB
	 /tVQdrr00iSaikcMzTv3cF5AI/wiKeJfU1VKlbPn8+KOLuONsCUtgW4RgyENZ2BHqceTQ
	 OI1KhaXc73wugLBy96utB5StvqPILT37kBwAKrikR8bfBnVV01J+rPHiPulERgwJtGjdM
	 4kRXR1WB+bFBAOUOFG8RGkY7bBMavfVIXTcjnkLvS1LWsNnNbVZSKe7hNrQ9wTYbIjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ndeu8bMI;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA8606A331
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BCA8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ndeu8bMI
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb2893531bso4418872a12.1
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795804951; x=1796409751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjZ1e898XhWXCBqSM6QfJZ0rrSlqOu1Q/txUinvl18o=;
        b=ndeu8bMIlo8ph9k4IZSIGAiPigffhdj5Jmt47H8gHWJ6e9U6tnylNbxHjMU1fE/7b0
         ASnFvYNAAECXOasS2Af4SNRtui0jXCgvmiZBwouX+28v5ToVC2Tc4dwDf6wb8bpvB/Go
         +iJ7HLf6WWxopmu3uRChSmU5nhRjuIrWaTw6ycNtwyZaPVFuap3LCJVrpy6nst4P5s4b
         J4TPIeVV3GyDceaJrQmc9Azhv0XnJV7LbNiFqYo6BRZVmpKmITPCygKHbzYRR4x2OQ8u
         2BYVMhXRplEVT5zvFho/AuL1kx0//nvAXSaYCiAI5FfIvzK4zkVgvnKZnQj9C714SFWV
         4muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804951; x=1796409751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjZ1e898XhWXCBqSM6QfJZ0rrSlqOu1Q/txUinvl18o=;
        b=c3moo3D0tER4n4wVtC1g47dzhP9yjquabYqmO6hRvIN6n/AWvby1u0Dxihgmeq0xyH
         1iWpeGhbYg6uCljelnh0G27LOGDZ7TAYXCnoapKRz/odL7dm0Pz2pzKBNf6wZ1mJLEPm
         T1gKRZ2pIwjqWPfcZzw3AHDKvFHUz+pzqeqRgtCuyusVNx9uSMQfDxB6hIukUVSGRRBv
         Rs31nwi+3IFtv9D1eVTIDPFYAvnLrY0PjfIFj66F+okZHcqqasgHozulxYBfukCE5gs7
         LFTYb0OQWRnPFQY36EGZ79fmtR9yZYDsJFJYe9bDjR/v1dE9W7YIBH99t9oDuMkzpukK
         fz/A==
X-Forwarded-Encrypted: i=1; AL+hErFUqd6oGiAYkIoDqMrMJt+jpdif3802pU6cdcar3ypVCuJype5NvzoS0UGOaba3sNVetAxcXsZ2AK8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NQ4n6ylLA/VLZiY3O/EfbpLRoQ5UGSIieGRLC6YNjZuNrOkhT
	jDhP7rOMI0LCXtUKOGnXhsNOkUAr/PknexGrNJvz42TuQJfI0MDbC0eG
X-Gm-Gg: AZFdTZf2Mxn3wXxMAJNMbJuBjkMvkTEX1+5GPwdEtSN8tEXvhVJ4NNJVIozt4LTW6Bm
	52AI4TzRTgswhXM83XS5dxGGiKrij3vNFjhBZfaBDWbaosnYm0WEkRdDWCvxSq0sJWWZ18NFEeF
	AIX/WbhVsGlWivHqJi0QV+NtrRx2oLL9Uvf/NSAZW4pIQ/Oix7FEuIslSmeB3byvVBmbFz3Gqd4
	RIs3NcQ5bVSCscyDohzom/cmeOtVaYL+uPCw9plJzI1tXrwHPirwEaijxlyaZYAZ7vi356LA42/
	sOfAGQN7NGpUyIYVSHUWBTtF9J8w5+kwkesnQYAMJpX710ZEVg4KY8efSWKVPi6SsOXDYS3e+QB
	8nBhxAq7XLTVPS5cF94d5a2UmiYSuqsfvNcmQoB/2Ji/9ghe7o50qdIYpB+/X/19Tg+y3oAgWEj
	hmdzb0LH5gXsknCi5D2XSI8eNbkt7FMXXjbPX00/1wtujOM5+jblIvoU0vxIDA5VRpugfbuEGqb
	I+tjpEcheGIxJ//dXewYKyVo+kAF6RjDVo0ybwCfqZHCEIqc9G9kTay6Ux3bXtPEsZ5bEAtCX0J
	CjZUNzeZa8Fr0dlMsohIcAN8norqFtTFWqDhDFdLysW17i0Ung==
X-Received: by 2002:a17:90a:e705:b0:3ad:aa1a:312e with SMTP id 98e67ed59e1d1-3b41c7e127cmr25168456a91.3.1795804950922;
        Fri, 27 Nov 2026 10:42:30 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4dfbe54a2sm19149071a91.17.2026.11.27.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:42:30 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: artem122novak@gmail.com
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	linusw@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vireshk@kernel.org
Subject: [PATCH v5 0/4] ata: add missing newlines to error and warning messages
Date: Fri, 27 Nov 2026 12:42:24 -0600
Message-ID: <20261127184228.185827-1-artem122novak@gmail.com>
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

This series adds missing trailing newlines to error and warning messages
in four ATA drivers.

The changes are formatting-only and do not alter driver behaviour.

Changes in v5:
- Restore the sata_dwc_error_intr() newline that was accidentally
  dropped in v4. This change was already included in v2 and reviewed
  by Damien Le Moal.

Changes in v4:
- Rebase on libata for-next (3391ac405dca).
- Resolve the pata_pxa conflict while preserving the updated DMA
  timeout condition from the new base.

Changes in v3:
- Carry Damien's Reviewed-by tag on all four patches.

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

