Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022B3FE375
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805083; cv=none; b=WfE+uBkMHEAsPDvBSRS649SVNk5W6dfc6uKdQxGlOspg5N63S2ntlWzDdaqcAjGOtL55zewLjF8oFf32K3GC80dhcKWHD5jcq4VX4P9Pvgy6jda7Lur7JQK+dzgupang7nyRyiop/z7zjaxOcpoBvCBLNBR3wvBgqoWeyjT6cQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805083; c=relaxed/simple;
	bh=Ix8wMTvjRj2V15S2wbpbWWczlxynGaC6L6zz/D+au5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBg7Cjc8I4n1twxdvBYKthpj+4V4bHTKMSqcyAjXQ5dUUWl9/qI3H4mjQKteTZSjua2KVXpDlzd9kqFW2LoPuTxuZy1YIWQy4Ub2bVqTTEa0cQjq2w7a89kiYjzWVoW4Sd0gpRiAYO7ZFHUCdw0YlsXDQFhs0f/DYs91RR5jSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fu5Uc+v2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fu5Uc+v2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4905e190c71so26175145e9.3
        for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779805080; x=1780409880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKGgUH1fX9QGB4ANVtGN3iVgHTq5bfM46OO8lv6SkzA=;
        b=fu5Uc+v2AOxDgfKI1J60U3K/p/cSPgpf/KyLWMQjpjovTgpWH5A0gcZQVFB//ufh+1
         Gho+YDQlWLqrVjwQOXKZJODzS+rn2WDCGblRrMZ+FZKvxA5xSq4d5EsIjKkfUvq3r8O9
         zjjnxLKdAqCQyXHDm8vn4BEV8pJzKuHSrpfGje60gjl14OIGi42G2ndlmzMLCw4kUWOA
         9huKQlpKvMKUagHeljLws3VbgVnC2RM/Ap1vK0oclRHhLDSk0bhLkZX+BS4fwHC2YRiw
         z7Opk0Zd9vzUuFHixAYiGIfrdFHmLPjPxVtnziBazoHkJXRVVWeflY3gw46oGpZFoWcH
         SGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805080; x=1780409880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKGgUH1fX9QGB4ANVtGN3iVgHTq5bfM46OO8lv6SkzA=;
        b=PeGMvsSJkm58QTaZDF2KyprMz9aze8Xk2lzog6u9+OtJLPtEWbxhcsTAdMVPw4PB53
         owaCXEet1YTVUIbbW+5fz26T+GaRM77qLv5efWqZoPRKUYdleVVlhwofj1vx0PObVyiT
         VA6OYSCaFdlYbRhKOlZLwH5TO1vRPzczFOUGzFYp9qyJE6kymEjJ53JL0XqOhAttYwyG
         CsFdV0b3+BJjyTFHBzox+gIiQm2g2UjbBrKI5/oR7rUW3IyK2W27xVy243ZCGBPn4nqx
         zQymcN6SLx7VyuKjBOCCU6p/zVmWzf8s3dQFFW7qKTSY/HMw17SmgJeyS9+8vNHnntiw
         I2zw==
X-Gm-Message-State: AOJu0YyDyE7K95Reodt96b42yTzputI4lnkMteyoCFTfxV6HLqwlxZbR
	mkXvsii/H2ky1JcuU4836g0gfw7RK4pAE7X7MZo5UIKauX+JxNdo8ebZhix0tlzLBmyjZovbfS4
	6F1239rY=
X-Gm-Gg: Acq92OEVnFK1MEC9PKKVq9e7Xn6Ja583jEAV4pIhi4ZAz+txNj3KGDq+BUBuTQWYl4S
	LDeVCiMUpnoa+N1qeCjDxRZJszk24ka55HWdAkVJ/9nwmbiTbezV0T4YMT3Rd3+WsTAbWv7k3n8
	/7VBNFXNrxxpNqKe3oF/kT4NtkXMZQiA1YsjaUjd0o5/qHFfRZN/HfOX86FPwMDh5f9qy5klFn8
	fBXzbOmWzaEvSlH9TxksTzLHRpnbPss5qHXeYNWIgXxCJ2/eSQjxMlc/dbEO3Ki0tc7Gm8CPVbY
	gjDoER9XH7YHPEdZ78MazspCvpai1mzTtLPHMuLpM/B+aBP/jnpmsHyn1Nk7P/pcsU9iGrLQKcb
	SJAq26S11VKME57urh4A2xP5JNAhRhbfQOXiXuhKqEQ0u9dNodpFeMamzSBSlOVQSGMNgcVo7XN
	0l/3W2CtcJeTRNFYYlJQPeBtjICgYX8usUvnNCQjMx7r2orXzJk5ihyyq2u+tHQy9tmMhotnA+H
	jtioPBeuo/Cw/pcuiCBnYNTAw==
X-Received: by 2002:a05:600c:45d2:b0:490:6237:521d with SMTP id 5b1f17b1804b1-490623753admr156647735e9.13.1779805078453;
        Tue, 26 May 2026 07:17:58 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49044775266sm110761365e9.33.2026.05.26.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:17:58 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v1 1/8] ata: pata_budda: Use named initializer for zorro_device_id
Date: Tue, 26 May 2026 16:17:27 +0200
Message-ID:  <a20f52aeee9dfcacfaea43ff280fa1867878cbbe.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Ix8wMTvjRj2V15S2wbpbWWczlxynGaC6L6zz/D+au5c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFat4RsEUJs+JP0DdUtGO65bC9TW+TPwCfDBUt sqTR8XPzt2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWreAAKCRCPgPtYfRL+ Tq4NB/9LKL4P0fU7zq69zjKPXadEJbooMHKv4U0LmaNdculFVwVabt8d8w/eqfDxh0BTGkj6+mj rtEGQtd0ApMuqmujeug2au73Dj6Fbbc67P5DdIduNpVw9WugHne8/P8PFzhLqxw6z8P68S+ulIu EddgRkD6XHblmHbUvvoPZn+hVYE4HjiShEps34/3uuwnWaok5Q7ijUXK1dcKq77CzKQfMlxaP5r astqTQrhQIxuA4gMp9NgoY1e9YmbwiznIU7sWgE+vmD77ynaZKcnziO3ZfJMJDUDMhi6Xqtkygo 4idZaG8w2AK10QwAA7lBSc92/69CdBf2z19hS6Crn2NWTCjX
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Using named initializers is more explicit and thus easier to parse for a
human.

It's also more robust to changes in the struct definition. This robustness
is relevant for a planned change to struct zorro_device_id that replaces
.driver_data by an anonymous union.

This change doesn't introduce changes to the compiled zorro_device_id
array.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/ata/pata_buddha.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
index c36ee991d5e5..3b1f0ee2f875 100644
--- a/drivers/ata/pata_buddha.c
+++ b/drivers/ata/pata_buddha.c
@@ -253,9 +253,9 @@ static void pata_buddha_remove(struct zorro_dev *z)
 }
 
 static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
-	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, BOARD_BUDDHA},
-	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, BOARD_CATWEASEL},
-	{ 0 }
+	{ .id = ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, .driver_data = BOARD_BUDDHA },
+	{ .id = ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, .driver_data = BOARD_CATWEASEL },
+	{ }
 };
 MODULE_DEVICE_TABLE(zorro, pata_buddha_zorro_tbl);
 
@@ -282,7 +282,7 @@ static int __init pata_buddha_late_init(void)
 	/* Manually bind to all X-Surf boards */
 	while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {
 		static struct zorro_device_id xsurf_ent = {
-			ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, BOARD_XSURF
+			.id = ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, .driver_data = BOARD_XSURF
 		};
 
 		pata_buddha_probe(z, &xsurf_ent);
-- 
2.47.3

