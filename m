Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803385;
	b=Rt5Ht8yIpGaZXRU3Q4jrZy1ucoIGGugs0hCVdxk7YrGO7YrrWnSsMxJeC3POiGNr3iH+
	 x586i/OiyxxmJO5iYmfIwLEL7I80QXYDpXCiiVohiwl4g89y1AHWbFe8oMDNAiCZhWxmD
	 EN5II/Ayvb/cL6ASw+LZx9U8WRY1Zwk7CyHLanZtcPg54lO8m5EA9lfctx9NY9vidMn6J
	 0F70KoFy/AxTSkugwWxiqK/W5NRItSoRZCV3JeYBsvGAdJGGk60zgHF7pvCFVt2P4i8JE
	 sVzB/GymQc04u5qQ97HFPXCACI+q+wY/ap6fYy+YQzfD9ypOMLtiAgaz+zJSUE6IwkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kgvT+dOepkzuZa55RwDoKTHZPik5/QAGfaPisL9xZDE=;
	b=yoJL/JSFi6dGFHp6/aUP9EW2eEPYptDQv2UbTxUDzlsrWynX+YKLZ4tONIv0erZpSJm0
	 bh/oOPdzL8/MU3eosmwh4CggzhgF3xUs5fnpLc9ZQdxClTtNZeaa7aWY+GacP0xAr3Cf8
	 05ZYzjdD1QzIPQCedPOVsWc1/EdClOC+oFn0RMA7kL7USLhiFWxk5/8CYsStHTVM1eJ1c
	 qWeVkzF5OJDaiHWG7gozTsmQekdSPwB1RfRFSAlZbT0Y7KWOLUtgPOoDm6HRwtvLscYjk
	 HBFh70SqVq0hWmsR2Ki11u0HbCNtIR0S4rsgwsBC9i9Xj3XaSmMO/5lgXdKBEput/+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGIgtLFT;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E92606A331
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E92606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGIgtLFT
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso4839700a91.0
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795803384; x=1796408184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kgvT+dOepkzuZa55RwDoKTHZPik5/QAGfaPisL9xZDE=;
        b=zGIgtLFTLFb3bTCFHJdpdNrD/XVvbrHgVs/HhfHelDm2b8fAROsInkQRxlQD8MHHeg
         JePSYdenhOc0rbReGyuZkV3VfxYwdQXwiQXtjMbW5oVxVXzTfOqmQ542ES2WK4cX4Igs
         1BRSbdehNdIQneTwnH5AmiA0opBv9KAmpn6U8lJCaz6kcs3x/nETnCzjZtbeINoLv4PL
         d7NQ4KrQOxPQYfuwsY/2i7zv3gLd3wgk766j32BRaPdS+rM1f4BRV5nY9HNWlJub6Q3X
         hT+ce93f9umv4NWy4XMEgJ39Z5gdQIQjY6UHbEM9y5sLS9i2ivKywOiw075DCQ+O8WC8
         gS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795803384; x=1796408184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kgvT+dOepkzuZa55RwDoKTHZPik5/QAGfaPisL9xZDE=;
        b=bZhTc9xx+ti5jhXxlDLgos9qbt3eXi0o3asB48EhnzpBNFIlOv7rdmsLb3poVsmduv
         CjqIMm32LGRHE1xkKzfv52aeK+KqubElIfexXOEHfrUVJ9bdVcKd2uDlvtQecq3jz6G8
         LURUqJty7eYRhgt3ho4j11uTLsEOONQsh2n9rlnWdPtJSSd27FPtUk9A56H6ujQCAJLU
         DtbFjmL6PiVaT7NbiJDiPxXhfEw5nFdswIjpUbKC/Wlty0fqfZbfUitMKomwrDbd6O8W
         62ttNU3wtqAl0KPVPvU5VRIKe1H7CooQOqg7Pv2JWQyA/rDe6VSuMTrVLmtDbeaRuHk1
         ksmg==
X-Gm-Message-State: APuU4Z+ZwIcsEZss+KwYcfwNvKnuIQ8sZJW87lWffKrWVEZ52fFn/MDw
	ym1Q9ViN5epeKoWYO92aukfMmBj8zRLytogQFAXH34bPp0gH6VtiBqlkUvyHJVqv
X-Gm-Gg: AZFdTZcbIEM2Rci5xfftn3KmW9vIL+tUrTdEHpuVxiYJ1aWLkss/Kh5NF0vnnM7t5Zk
	eTrHZrs/pYZqKvDRHgR78YkQeR6jKo6gmFZ2J80ZNXdyN1BINOhG2MJVNaEhTSyZzZGdl62KFM0
	51xJXiYAZJgJcLe6WCJxrOBR9+JtgPuwRjSv7vsgojmj6JWiFI/aFJgiawPF7XRgN+vmrmvNeSB
	nAy7S5vcXxGlnXlFn78RaClLjroEg+mNR2ZNnH5ZwTmdazK4eq9/pbEUZHCm3J2Op1nDljPvJzg
	DZPiI73J+3k8g4D81mTdlgHYl3EMw/8umnPEksVbQ/meujVfK25FZboBT467vnRVzikgqlGfGtE
	qBITFQoLr7x5uGOO/gR7m0VvCc0/udcUGpAvyC35Ir93UN6hkAa1rCEVnMMkrvSYpYq92XtjUdk
	yo+DkrMFz8Pm/Gj8Lo7BsL86wJ23omB2P1wv0aXccxnmYo2yM/rm1L7eASLWQ6Y4jqni6D9LT5g
	Lrn0XZZLph0JjdQbwEy7g+ld2Y2+mAsLZtjWNn4IRtQ8+SUz2RtSMust/JgihCf28J4SSHOb9ee
	1PuL7vnDPme/EUOExD7xWwBT305MaDpOjf+Dcq+cu+OnZ/ncPmPCOEueW+QJFXmUAs8W1UY=
X-Received: by 2002:a17:90b:35c2:b0:3b3:cf61:dc65 with SMTP id 98e67ed59e1d1-3b41c8debf5mr23812581a91.23.1795803384480;
        Fri, 27 Nov 2026 10:16:24 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm39867121a91.13.2026.11.27.10.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:16:24 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	vireshk@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v4 2/4] ata: pata_pxa: add missing newline to DMA warning
Date: Fri, 27 Nov 2026 12:16:17 -0600
Message-ID: <20261127181619.183139-3-artem122novak@gmail.com>
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

Terminate the DMA completion timeout warning with a newline to
keep kernel log messages properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 2312c42def22..2e73726410b9 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -96,7 +96,7 @@ static void pxa_bmdma_stop(struct ata_queued_cmd *qc)
 	status = dmaengine_tx_status(pd->dma_chan, pd->dma_cookie, NULL);
 	if (status != DMA_ERROR && status != DMA_COMPLETE &&
 	    !wait_for_completion_timeout(&pd->dma_done, HZ))
-		ata_dev_err(qc->dev, "Timeout waiting for DMA completion!");
+		ata_dev_err(qc->dev, "Timeout waiting for DMA completion!\n");
 
 	dmaengine_terminate_all(pd->dma_chan);
 }
-- 
2.56.1

