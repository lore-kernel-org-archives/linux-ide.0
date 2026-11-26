Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670128;
	b=et0TP+tSJn4f8skj8094hqU7V2ziOKY4XMxZR0H06FcQAfPCA0tBTryaZkKH3vMQ9YWH
	 8BbwR/J4YD3Zaz654l3b5JIEp9T+mb+n26113sibveWlw38QKOLozTchXpjLdL1rLMFNl
	 v+aFWpQ27r2LtDBWqqfUrD+yiYYHpHT9gw9vtEH1IrdEBNJgUIBjQmv5iQxnFSlkpB4KL
	 LzV4HNLCGIBUzCxM3DGXDmlwlq6xl8Sj2kYmHkiTYJdT3kmB+IByRcC3qTn6fe2cKEd88
	 529l7w/30xBrmHz1uunvcACFZpCo7zRVIrafVOhcCE2ynYKsu18tL/RZSOPQpcmp+rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qsM5RJY4ssSc6XEZK9/kRUVmdgCpjgjWKidI/l+cEZA=;
	b=kewmnoxpxw8j+ZizthqavHwZUPVj1getC9HrU6umqmb2YWGkwaxyT6pM9EMzY1Owo/Dj
	 I3zpPVM7dz99UdOrmWYSc8l5WXs2TorLg3vnCuMYPzKOC4OuC6/H9g2FMESyW5KpamGfo
	 4UNsGR0ZChGKQC1S5dVGBM4gHFfGJ9JaTUPBiNLVvrfpvPYhxWFOqQOVIWW9vatx0rhvU
	 xMw4QGCfN9nO/Ng3hc7E6jE74IvhZvAEMR7GxZZRImQoWVLGr6DV0Wm+vM50zSsDIrtxR
	 x520HoG6Cah/7ITeGi2ZdbUIErzzECyDjbsbtRgxqEB+Wgk99B72RAHy8/kt0LWUYNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=anPSe+SS;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF17606A32A
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 05:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBF17606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=anPSe+SS
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso2722992b3a.3
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 21:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670127; x=1796274927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qsM5RJY4ssSc6XEZK9/kRUVmdgCpjgjWKidI/l+cEZA=;
        b=anPSe+SSJbPa+iVGCzFWsJegDk9HcIXXjcbEXj3+ReLi4sWHyF7gmMhyyfJvyTL1nO
         q4W35BEAX7OXUCoP3eMRthxOGqHfuX+Wt/GTFG7WtTtrk98EMEDfXporL7Ow/a+xMq6O
         ptcJOsVfb7FTIfyuCo8tWbjXoSrEg3t8FdXqxY4N8MuZia96ESLYJJ4pStjOTvMvtr0Q
         zxqYgKNbZt2PaeXehBjM04kMZH1TA6cyThvTE5zXj5k0xW/uiu3m2QKFOJHApWl83H52
         bbCHVGiDW3P9RCaS7fm4/usI5PM5FprWUyEGcZi97CTml3AuG2pmV6V7xrZ9zyFmgsG2
         X/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670127; x=1796274927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qsM5RJY4ssSc6XEZK9/kRUVmdgCpjgjWKidI/l+cEZA=;
        b=SaoAzxzRnS6tiPt1/I4umswS6MqJaMQP9v1SnVvmxQTcYJ0xR6NmWQ62A0OfK6Bd0S
         4m9VZwGLrZM/LRtXNWmRZk9LJxAISDrR4e2TjgyICObEZkVmJkNX+wPQaO728EkQH7Q2
         9G8RPftW04iD6dpF7kY6N4pyq67RWPEepfQte4qGDBTExOqgzyPE9Gng4fqemJCC0EL5
         xDD2hjiRlyWfVZsczLX7cjRf0GnBGht0RQP2+7LaEtkryReD9TE4Ub3eBf4BptRPCHUJ
         IpKoMwYbekIqcHH+BxoXPcrSWNN6TpVR08VkAFQSrCm0Az8l90zmLBNxwG4jEOrgoQ03
         XvUQ==
X-Gm-Message-State: APuU4Z8rHTe8LhN4PbrtZJICEcN0i6YCz9luIpu49HGAqODFSpdpd3KK
	SlhnzxLK9Eo71A89Q8ap4c0DCVTu0Ub7u+9b32Y+CighDWSJ3mERN8lQ
X-Gm-Gg: AZFdTZdf4mCpSdfW7D3SorZ1cUf/BYMAbXYfVy9hQgOAZG6zgjpuZR2BUKnVbotLZgT
	4pB/xTMVOXOezSY61NeDbYwVj6oqcX5dBAKySk3K/6qzDvYDE8Zz/9tp1p8XHfF6LFtGy2yl/ZA
	uYjNmBmgdKkieuOUiQIUb+gNJs4TfvxqzdTp31wnrael91DoL6cq36b0X0U0KLZtG0t0r1/H1fE
	B1t0ocJL9d4qja/TuN+nTyrCZOmss7SqpxlHzEEGho2AFIjeXn6zX6c//s3lLHRA/wWDiX79huk
	rbrlj0xHfx6yRpDzyx/2CpyGm3Glwz0cumFcEFc/amaENRqOccP6jJtZuPmf5FqDH3KZd/OO+7/
	JcyhhnJqsxMevJpR2jy6S4xNjyt5F9gG5xDJbPLxpr9S0HxJtUBkp0cg4CQq9CiyrcVBbzJXmLH
	w75PbZxzURzJpFOFapM8OrILW759TkWHMLUWRxNXbYHbj4iALCKFzuKd1eJTs3La5NgtOo6fTy6
	Vmis/PqP8+sAY8biReToIyLecqD9R7eHPu34Jn+UdD4tOvpmZdgbmmB8sGs2GfW9KQBUvqKUx0Z
	7sPD8eMzwGVTBWKmRc6Mj8QeNe/UjSrDrXAt9+znSzyxPEkg4Q==
X-Received: by 2002:a05:6a21:4eb2:b0:3e8:b7fd:6280 with SMTP id adf61e73a8af0-4014d85fbbbmr22187564637.27.1795670127244;
        Wed, 25 Nov 2026 21:15:27 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm10179820b3a.8.2026.11.25.21.15.26
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
Subject: [PATCH 1/4] ata: pata_arasan_cf: add missing newline to warning
Date: Wed, 25 Nov 2026 23:15:20 -0600
Message-ID: <20261126051523.14431-2-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126051523.14431-1-artem122novak@gmail.com>
References: <20261126051523.14431-1-artem122novak@gmail.com>
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
---
 drivers/ata/pata_arasan_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 12f1324461d1..0b3e4e63b66d 100644
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

