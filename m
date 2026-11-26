Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729477;
	b=jnA2zjm/dY6rkxliq9UwuRAHKvPUEeng2xRoi2XGC+5934XwdLeFk3smd6uwk8em2GxB
	 qLo0vfTJlvX+LE0QwgAjDm1OfkH3X/5r8nr2cV8SBBgXImgUHI0iRH8+K808jSO9lAhsq
	 ojqAJ2MoHpuFJpmBwPLUh3whQB2Em4V0SV/2D0dKpo/eufAYWDh0vsNxBYI1h2FOI7Rke
	 Eyty+vU3NLxD3ZMw8AmNs3hhH2IKMA6fezFe4PF6fBbY4vPpIs8sEneA+BM2hJqJMVjuV
	 Y+R0rt+adVII7Eaf1R5Zmc3uQGV0HzcqQFA/60K7nmau8+oiNu6yfOfdBbr+k9uTgjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OoXG3LYwaAjDPYu54stPd/H0Rb7wdL1aptwzNRaRwSQ=;
	b=wQAc1IbvfptLFZocF6lAfKxYdkQ/DRsQFQV6yZtdj2WhU8gIcT1JoxEr5plyBgNLb9dP
	 8CV7hZQZL11+u+xUIQMtyuZXOVe3YcIrTP4r7riupCZJukbvZS15wH5EKd7vt6M8JCNDr
	 iCx5pwyZWId+bnu+bp6vNT2t7siWfnzWtot1B9uqz8OBXvidtls6SatFSyue2wwSlqgSa
	 is5AorR7O3fNVKsgzrmYpne2RFU6wR3IHhBZiPFwouQiX6OZcjGA2qQ0cSMC34iKiFbgc
	 X2reDKq568jlvBl8v6Cawz731NnxtZlxpW7tCIqhHJWqIGw6utEExdAEiqWHD8lkHhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fEQSc3RZ;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45E606A31C
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F45E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fEQSc3RZ
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso6599085a91.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729476; x=1796334276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OoXG3LYwaAjDPYu54stPd/H0Rb7wdL1aptwzNRaRwSQ=;
        b=fEQSc3RZSnuYQIs0UZirSTJrYgwbqOblwQiNXCLSO9R6BVV4x3qrtXKumdGstl3Jit
         3v5TWPWu37E1ydD5i8AQbAPsfF1CB7fUbqDTDL1qARxSnsYv1ZfSB1aXNLIwJ9YIUX/L
         V/8XUm4ATd/9CIPy5iGkbCv/5C33ukxh2YBMHetDBsLLBq8bPDXDy4NJvZW/iXN/U2pU
         IF4ztzz5id3wATDrkIcJi+KrjtEK18i6aTSCSViy3Hj2B3IMAwzSsp/X2yiwrW+c537x
         iAzHb6ExCtNFpE3G5MIz0M2xUb3vo8MjcC/AdFp62YygnftKWyeg6+MoU2keEThiLwy1
         3shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729476; x=1796334276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OoXG3LYwaAjDPYu54stPd/H0Rb7wdL1aptwzNRaRwSQ=;
        b=Ti/fs+4X8xYiEoa1A7zdXhQLkb6b3u7TpZepQxd51b5n/R4Dj6uu7kcmVyiQBM0ySV
         /gNoNhIAZ0Sqs6/WqVb1n3ZU3swM1EhOE1ahiLyGLu3cE/Rv8PFAUNnMGxomzG39TR3o
         iSAo5iFSa6n8PtIxjTNv4SmzaZN/DMfUCtndKDJf9woCWuGlupjzCTJy4vYyuG4TaQBo
         wrYLbqJwp9Ya7GJPZTthGiwirarEJl3n9RiT4NoQcIMkuyAQbZJavf9r0OP6haBMIveF
         AeMm9ubTuZI5Y2rEz27OfmecenY8NHfCJSNbCGtGsNIcPQ52quGrzdjaIAMyi0/jB6FV
         NmKQ==
X-Forwarded-Encrypted: i=1; AL+hErHkNYi3WPuyJJVAIAPb0PtEedJuinxx7b5xw2n6uKCDpDNnLLbSFF0zRbRRsY28JU+EIoQ1ySb29as=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vODGDLQeLHEX662h0G5J7GeXoZd14Omss1iI/qaRFGKVA2HVl
	p/RWBusStI5UkdoK4d9KrXUwQY5mCK0MGpBcP8r3TRSgBCnZMh4o/UWC
X-Gm-Gg: AZFdTZfzl2UdxbI1yB5st8H+Q2ds30J4DmDkGSE/cUeVGkcpGMk+ONNFz5pdQ1aF6ue
	uKsEe7dTxA511cyakIU4wp+R64nHquuBO93Ym5JnrJMTEBIHzoTuAiGQogRT+zJbH2Y40/D/Fxg
	kDdRXPleN1p1E+oeZdFTWqjm0G361v6QWBiGAxV/r4BFr4UsZpzl3RJmAjRqQriEwnHQ+pPT8x9
	H/jUSwEwcv5MCC6F2aqX0NaIZfe2e4QxYJh892Su6Ofes8xxfZzP8dgE5QGiyBn4le1KKmU1cpG
	vJukxqA6KZFue40cGsZllZr0u5Fy1jCc1dORe7lAJXt4xWW0b7BITnQY4gR3AvE87LdZfvoNXYa
	AQmDSCa/vpCjN3BKjpHu2ZF1TWM5krAT61lizbSgILCWv1P7X3ZqQpcPcPTuSQAYLKq1urqi0j8
	oUo+lPrrEyarclyn9GO9pmyTaL6Nt/gYPRTRsiKIab1kzpmlhIecP2FGztyiNKDMyseiMqJYxwJ
	LseQzvWMUHEy8dcpfGLu8zaSKSSzHd5RqV5UAsbxAqCtM/9rTlFo0ZS1rNls+Jy8x+eWbMlSyyl
	JqsvsACxlb9ASIYENKT/k/QfLN4o2XSTzx+GUnVUJHDWqJ5k4jkSZs3jL1cgQssBCor8KgQ=
X-Received: by 2002:a17:90b:5887:b0:3ae:3e9b:5265 with SMTP id 98e67ed59e1d1-3b41c93c24emr13850192a91.26.1795729475941;
        Thu, 26 Nov 2026 13:44:35 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm36176538a91.3.2026.11.26.13.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:44:35 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v2 0/4] ata: add missing newlines to error messages
Date: Thu, 26 Nov 2026 15:44:29 -0600
Message-ID: <20261126214433.38317-1-artem122novak@gmail.com>
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

