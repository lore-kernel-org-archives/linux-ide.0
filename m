Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDC284B41;
	Wed, 30 Jul 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873521; cv=none; b=Zuu6uaN0JQo0zij9Br9mf1JdyZHbstiTkQWsVw09lIbFL0xb8MyWoB8lW/c9u3tiOzugNUvQi0WdZ3Zo88JRx007+jFtWirEetrCZDDk58uSOLlAUw/kbB7jyJ5XPdmPE/EJM2WhCNWcsIY64Sn9yLJQCnpm/w9pj22tsT2YaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873521; c=relaxed/simple;
	bh=ZfP+G/ZvV75Byc+EUdeEQxcNfw6I2EE/Dec9sK0mFxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ISqdKA9oBAjGrl6ed2oOSXCBdUsoiwL7jQexs9Ku3zLN849aHsTls8I5e1ebB1VNFB9ERIHfqal2TzHWn8a90DYg5XwJsJyv8WOYlbElafR5B+EtvKs84Eho74XXGPrZQt8mJUfE67arrfxdA1i5sfcmFC93w3uS5P1b0AnMikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4qVj7LW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4qVj7LW"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b790dbb112so1057839f8f.3;
        Wed, 30 Jul 2025 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753873517; x=1754478317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54AIPyJy1uCtqZ7NGhSPeutHe5R23DZ/fm+drMb1lCs=;
        b=a4qVj7LWRC3+KqatnGRnGBamFVYM+huh8P6AXRpv1kRT2q+qx2Q2mMKicKML4gpYQH
         XJQ84sAnte8JvNSi+xhJaGayEWHXy2V3l1DMjyDs9OWBLD8ZQ/lS+osvDJqyItnxZcyj
         h6f3V2vTRFd2ZVLzSEziQspvA4QDqoGKurYBEg7pyw68RiAi2jotWviWh2JxxTonfcYr
         HLOhPpTQWf65qfdMy0U1U+ofyKdcuLta3auTr2gehcRfVC7dtQat+U8nH39sNmENVhSx
         FpXl3ju1qIgbtZdcVOuDRRpBqgY1IddH0IQr7b51IgijWRkyKoLUjndrTj+NlaWK5lyM
         LqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753873517; x=1754478317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54AIPyJy1uCtqZ7NGhSPeutHe5R23DZ/fm+drMb1lCs=;
        b=f/T60UGAourk1jEb+UF5S+DgN5FfmfefGMTWtN56ikpM2kLjYA54uVoFsOh1hlx+uS
         8eY3MLkY/XhUGa1c/mWNepDALwKAReDMqvkzb6lfNAFC5VOQjj8EFXXm0/UsHcyR0eHK
         f/V+OJA3qRc1n6Z+gingDnbz/yfXa5Kovdd1RVzcTNfNzEUAaC+h35ueewy6PxERIey8
         /O86/wwYmQJR5kaer/WsQ4a5G8kbxbksNVe5qYuN8ie9VSJEmd+tI28swTv3vMNawn1S
         CBoLVXM62zUIVdFl8lucDYuG9hbNYKzBbNe9UvStKSNEgbp8HeXU8qoe718++B+sjcEj
         pYRw==
X-Forwarded-Encrypted: i=1; AJvYcCXCP4B6DkHVNNRJ0qu36TwXmwXNHxdbLIS9aMSNTFYTbcwDmNNPbB9Cj5422EsoqVtUPZ+1kuw60kEohVR1@vger.kernel.org, AJvYcCXSHSdVEd03FUH1fqfdwNJmqoBLdyhQKaad+ueSFH5UQ78cqmBh5d9rRWns7yhyjgxhDFVcKZTOQLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoqpquVGCPpR7uI93VE7sL28cs8+Bewi6P7jkW7g/MA2AMMzvz
	xRQzmXi1t86RY3rg++7sMDYsLbCzIXJ8WlDRPUaSEZjnAbF0Bi8f1n65
X-Gm-Gg: ASbGnctcC99KzLWcf5zGTv2Li34GwD7POl0jQB9jf/nQdUzRRb0LUP7z2GFTarnbpG6
	ZcqLYuvmvuyRR1fkC705/uLsEGl6EIAdis0i5TkmR69CwbaDhAJD0WLGr6VPpTqDg0TCSe+kMKY
	zpPvQdnG2KYNnEa0dPdrVKb2BgxZayTSlqTeOPjqgZa2D/llcSRRi3MZx0bQ3ktGZ07/gkNoitl
	ijwSyAm/1qcXUAbU1Uciqhj9bcIxR0znfb12imxvVXrSt0Wn2fXLHwuN6i5DqrkJiuqxgbXztTp
	vYDauLi6cS858zAf6Pyp6Ja0yqhROFaxCg7SF1wDyS3mY3pATN1k6J6wzCiX669SSUoG/iRaTXL
	gSk4yKC35YTk4HvwTYf3dWFi87qQWGEU=
X-Google-Smtp-Source: AGHT+IHNkjb7RgoRXtTFkL5ICG4Uho4Y4jKD4r50o8pxtcFYUvIysyolnX0sizkUEgmucDNp8pv8Sw==
X-Received: by 2002:adf:a297:0:b0:3b7:970d:a565 with SMTP id ffacd0b85a97d-3b7970da81bmr918250f8f.46.1753873516536;
        Wed, 30 Jul 2025 04:05:16 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778f104ffsm14990170f8f.66.2025.07.30.04.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:05:16 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ata: pata_macio: Remove space before newline
Date: Wed, 30 Jul 2025 12:04:42 +0100
Message-ID: <20250730110442.2059004-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space before a newline in a dev_dbg message.
Remove the space.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/ata/pata_macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index f7a933eefe05..9eefdc5df5df 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -758,7 +758,7 @@ static void pata_macio_irq_clear(struct ata_port *ap)
 
 static void pata_macio_reset_hw(struct pata_macio_priv *priv, int resume)
 {
-	dev_dbg(priv->dev, "Enabling & resetting... \n");
+	dev_dbg(priv->dev, "Enabling & resetting...\n");
 
 	if (priv->mediabay)
 		return;
-- 
2.50.0

