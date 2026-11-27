Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803384;
	b=IzWK8LubGJ64+3CzuKc/+YhZ94YQAHtMQerPAyA8e4QEHM/5xRK9TnPuKanD3OhUOATX
	 TewzKIeL7GjROqDoNKnAnf3Yyl6avrl6fLonrb1yy/9ykaNeijD6fwqHVDRB2tQH7aUl4
	 eGdStg7ZG0ET0EyD5ou/6dgMjq4fjO5TmA9yj0OHvSoJrEKaIxiHDcToti2A2xuzixr1j
	 Vvspc1vXKsxEnmuBLe5ELFPyekjUoq+UVN2RS9iNoy59j7k205uKa7MRaAlPLYY0v0MnP
	 iFDvXn932e8WtZbmLT4mcRhd9MWTqMuqY/h+M4wk/bSrlQKO4Qe/0LtHjR/faCDD2YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vWsF7/sGRnQcNHhIssCpGPPEwDUF/AFXvsQJ0lFQQ60=;
	b=v/jZRPaxq1A1ARPx1FkRGV2ym1A1bT9rzPv+BD/ieV53IA34btiOFib+GQ6WOUO0vLnn
	 2wKPNpTx/Fqt9iZfNriQXQ/VOITRjCLjYwcbxBYSbCd126j1MRXIAU22YSCdKICYHq2Q8
	 rgi9ayLVVehlaJohmWM642Pkw0Cl/ypNqPMgVIFwv6YfAyj0frFrpWMddmyqD/QGCG+Yh
	 UH1w06WUrTkjT8ls9HGwaSHTW78vnaVav9KlLzU0pgi1sApxSrUNYyRZFnUCtKV9j5D0E
	 A421GgPfoXGZzObzWb8VXPJuXDTPFDRWFSSB8iTZ7X9wYhM6QskE3zrlv08zWbFLHKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHi2q+uV;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F9606A327
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B4F9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHi2q+uV
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso3545848a91.0
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795803384; x=1796408184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vWsF7/sGRnQcNHhIssCpGPPEwDUF/AFXvsQJ0lFQQ60=;
        b=UHi2q+uV1ffsrnuLijpKghhT6ycHqr+TW0AKd+E3pY8Dqhxb4VvLl9SXLLLk1bdCZZ
         VYXZa3EDnOEL46nQCnG6bTuXsP4vt34Nuyjv73sFKroTVet0kO3GLXHExMGU507D0pdK
         7s8VCpts7qlxv4wxPabGXy2ZaSdCF8p+qxTi3u4Lh1B8QXElGAcAE9AykCM9LrLq9DYO
         JJPjbUqy7CSS4KXugJ6c/E/IvAvG/TrOYeK0QKNPCLVPtkhldMzxaw9ASIuJgurQIg0e
         02+YDt3+6+tFYTj9YZXP/pDhmrPkLCXZSmxc2K2QO/A5Khxs5Si0KuptV1LjP5O57G0P
         G0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795803384; x=1796408184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vWsF7/sGRnQcNHhIssCpGPPEwDUF/AFXvsQJ0lFQQ60=;
        b=FVMeO/LcNKkqhUl+eJ7qXXa7J0GCFbyHgW8CvMedIRz7QsMb3TO7xlBeOcaFReLsUi
         +ecyems7jKZxi7qgUWTROM+fCW/YdZ9/zv/27Gfb9SIujqkQpBPFlkg2I+riNMzPtE44
         ICM6bJ2sFjQm79pDPSunRBtZLNsdn0BRB8eMf5ICdYfTSU+FurRnldPd8A1u6Ce1CHIY
         rVHNnvTtBuHvCKzm2DWrcREGu8/nMOzM754MOhGg4Grxn6ii3y/c47kD72LHnDwN0grV
         KCnVaU3uCvnxoPV0Bvy1pZRV2uhZrQQCcSqDBCKGrdjj2TEwOCb0vued+JsYu4FOWf/9
         Zfow==
X-Gm-Message-State: APuU4Z+fX/juNqs1A5fYshiROsgqmcoybyciIN8ZpMP/4NPPFyD2MV9A
	b41DpccvCrE0EbbbMKrUaaxKh2f8lkJ8phc9rJupQMrEWVTyaMcKcaF1DNq7C0FYLKE=
X-Gm-Gg: AZFdTZfFHjRR5aOs/YLKR0bHsEKUpkV5/zgbQxp5ryToiIEWHSEafxl/UqmJ0vyNBZ4
	A2In1reQJSTa8+p5DINmqY8c3I3VQqdDJYskIRU2dclx4Ha9YAGdqRUAJLJCogeJxLRZORnL9FZ
	j+YSpj1N472HbOvVHwebm3xAGsr1w7xhGIyNMiP/5hkFfQ4MBlT6GYcGK0bLHVdSHo1TULyUu9b
	hayIX7ZPYOOcziLXo8Ks4avV8Cg6kVHkPyY8ChiFlItBrfiYUuef2yXwP6LlLVbEQSpaqXkdzM5
	x07Fi4qV19n4ik5qf5Wt4MJ1WJYKiynT/o+BDdNXsNprNHSS+CkCoSsmeOEuU8AizotSNVy4QZN
	x88G6lVSTVXqb0RPlEo9u3F//XXlwhVG9OIOaljP9y5hVILnrSovVw5n+noNX0RO34pTIVdT1p8
	XTgqN7/NC/mN4/q8hHwbfBEESmMYbQYBXN2aFNIr40kgqdVSou/SZ0FMevdPqIII1JIFmUc/twc
	yQiAU2yeSak737IOZbMB3bAA/G/uos1xF1Dwc94RF8ViPDdTpyzouM3SUl2s8WBYq23dngzGX6B
	i0b0qPW8aGyQLkGkQv5QjezUqkxlpaKjVKCDbj/DRG1m3u01Lt0=
X-Received: by 2002:a17:90b:578b:b0:3b5:a3:4433 with SMTP id 98e67ed59e1d1-3b500a3463bmr9398644a91.34.1795803383604;
        Fri, 27 Nov 2026 10:16:23 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm39867121a91.13.2026.11.27.10.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:16:23 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	vireshk@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v4 1/4] ata: pata_arasan_cf: add missing newline to warning
Date: Fri, 27 Nov 2026 12:16:16 -0600
Message-ID: <20261127181619.183139-2-artem122novak@gmail.com>
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

Terminate the clock-rate failure warning with a newline so that
subsequent kernel messages are properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_arasan_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 5e02d227ddda..61977f0ed84c 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -318,7 +318,7 @@ static int cf_init(struct arasan_cf_dev *acdev)
 
 	ret = clk_set_rate(acdev->clk, 166000000);
 	if (ret) {
-		dev_warn(acdev->host->dev, "clock set rate failed");
+		dev_warn(acdev->host->dev, "clock set rate failed\n");
 		clk_disable_unprepare(acdev->clk);
 		return ret;
 	}
-- 
2.56.1

