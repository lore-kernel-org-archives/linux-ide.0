Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670127;
	b=DJcLagfr7twtTpP17OrinWOmg/gRIan3Rub0rs8qtCyIvIbmm12ngxPzwjr2k4P6PDcm
	 oCytnQkADTqtnzs4HUsEUb5bxE5VhCbNcH2pslr5pEnsgX5gpYBCQ7E4WqkzcZ8/+5DXG
	 E5sTJnWwky35MLsm6HPvXqHAnH/08n1sThN8iHdU1lVdPaFe3hu3xxmwiy//8rL5cHrRw
	 oqBB3YjoVD0b5ealc+t5h3a8T2PQYa60HXmfyIdN4704wnUGfpyP50vBrSDg3Sr3N1d8U
	 C5HdrgvaNp1KG13IcXkEFubRbbm+L7gGh8LyFioDeUu+DbANYmFNljrEWyNV6xfwiDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=x7dWTwMm4SzHnnHqQMC/uPsi8F2/ZPntO42FlxEQFuk=;
	b=ax89hYVUharKPmKEI8ErxsxSpr7B7/YymL5VkzlHX0TkQJWGuikI8CXqLjzb4Dj2hG0j
	 9oWh0d45q53ou2IAceODfhEc5Xyuj2/BuMsVSgBfvp4/dDqUo0g290esxoUwuhRRftyni
	 QQVjbEp3JCO6NbPNz7EGchcdX6xHEMvV4WXGCnXSZ/kFQpYFIssRY6+K0lduR/Tk36j39
	 u9jhL48/bXo6qgppNDEM2Aw+hFsFr+meMO84FTaoUIovjBKrt26emG5Jg9tx7OVuPM+9R
	 cwawuSGUwlmGNdzuIrRbNLArcit15CyyCAcAueUVsOKlvKRqMDgDpP4yo1TFRnof6Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iKbOWIiG;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF0606A31C
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 05:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AFF0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iKbOWIiG
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso3416950a12.3
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 21:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670126; x=1796274926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7dWTwMm4SzHnnHqQMC/uPsi8F2/ZPntO42FlxEQFuk=;
        b=iKbOWIiGHkqtA/5jKZhAMxeTxrmFx4BpZ1moKvCoQDRApIYarchwp5lVytCoTupgc2
         zENqTOk2aoJK0Suy2Rsr5Uc4eHztx+KtI7kYR2j91GEAstX1Erk3yC3iNWP6ahTBBQci
         ooVLRuEs7ra+r0IvrEB7btVukXZAjKKT3Fytzi/cM6OAMaBnPoXk+YcF4QZGkigqbknO
         W4/k4neFAwEeRorFy+Pz9VsJtUVPV6ygrjE3wYFHj1iYYmFUe1NlCm5TqF0ouoMcL+Wv
         OKBk7mltR+quXS4RYAdWKfH6RXVkMLnE9JAWjcGi6daraw14/7dng+nK8/B/ggQ95OMa
         GYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670126; x=1796274926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7dWTwMm4SzHnnHqQMC/uPsi8F2/ZPntO42FlxEQFuk=;
        b=cerml2dwrVFE22ObKw0ChT72plT1UGdkupHle8x+9zj+NqBectqska8RVqcBqMmF74
         Q9qKJLFHkE3pxb9crVCgCvbpoGdSkDtwdjkj/Eg1b+nCucqzjsrKOsgIaH+hIGkEk2+V
         7tQYLhpoup10rioFCIQV76//CyBsSnnQ3jrdKgOD8UiciufuMBi0QV5mDdEyAtkb+jnu
         txrWJjxO95bfFbd/z9SpuNG7WNeQ2mA30Ytp7ktqbHaeZGH/Bj185i4nelDC9qHGoy8v
         yHm4c0+iuknNaaFgRTed0ry442s6wGaisPMuVhTH4tGCl9M9GgOltKg7PhMXWuEZVwzk
         sVtg==
X-Gm-Message-State: APuU4Z/E/tGHWg6qEXwFmCwXUHoSzN3LKXT5QLOZW1BEKT5FL5RJaLf4
	EZEckjkg7XG9cpxHbQZFzGzX5bHridAIEUOhxqsfvgd5DHAYgV6UuQUwmRInQR5U
X-Gm-Gg: AZFdTZf0ICgkCDcxzZaZNVfe7Yj2+VniniS17f1zmpv/LS0rR5IlN9zNgJaWFqGzV6V
	H7FgNkL2CmDIE6z2RgEgaUHc1avNcz4kv56gT7vIdPqWxdyKNET6zKBZFe4GiXVWTZxO+6Gjk08
	RJIb4fiVX81BEdP42YZjUnxALVMY/DYyF7YlzQiAXo7qllyU+HPj1Zy1Rp44xFr24T3nZ2PClWR
	jxJz9Yly5ELaLNqtCCDMYOtRKX/DJVITuyfZi8WtKZHGRrfY6BHsiZC5LMksi7OCQCXu3JIQg8p
	TPTgOjq7mMa2BCzFu78u6dJ3HyajzKCx+n7ZlLThDefBV0oLwXB5yUYttRWXOVZ0M1XA5A3j6em
	kK00nAq6eRtVpdLhEP1mrC3ZfJ5GJDeY0YrSuLLV8PCVFZ/jwnme9iIyKSPlRs8O5YczRf3OPil
	2EjQoGDf2GMKoX0ubO5i8+B2GWJLRvnkLtKUL63B64P4htnEi371DcaIHSIDiuXAqckn0F4LIW3
	8hSMvuri2BnXANbXFetw8bj1xQDNmbbGyrilx/OXjUsQdPYal8OR9m3MDajL2p5MZCU4u6qDNOS
	FNz/s5MIWV3X/4TuT5EfrjbtKN9mVsXHfV21GNV2Gbl/nzRM6A==
X-Received: by 2002:a05:6a21:7704:b0:3eb:4b16:1afb with SMTP id adf61e73a8af0-4014e6566f5mr18994749637.56.1795670126494;
        Wed, 25 Nov 2026 21:15:26 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm10179820b3a.8.2026.11.25.21.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:15:26 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: vireshk@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linusw@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH 0/4] ata: add missing newlines to error messages
Date: Wed, 25 Nov 2026 23:15:19 -0600
Message-ID: <20261126051523.14431-1-artem122novak@gmail.com>
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

This series adds missing trailing newlines to error and warning messages in four ATA drivers.

The changes are only formatting changes and do not alter driver behaviour.

The affected drivers are:

- pata_arasan_cf

- pata_pxa

- sata_dwc_460ex

- sata_gemini

All four driver objects were successfully compiled with an ARM cross-compile configuration.

Artem Novak (4):
  ata: pata_arasan_cf: add missing newline to warning
  ata: pata_pxa: add missing newline to DMA warning
  ata: sata_dwc_460ex: add missing newlines to error messages
  ata: sata_gemini: add missing newlines to error messages

 drivers/ata/pata_arasan_cf.c | 2 +-
 drivers/ata/pata_pxa.c       | 2 +-
 drivers/ata/sata_dwc_460ex.c | 8 ++++----
 drivers/ata/sata_gemini.c    | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.56.1

