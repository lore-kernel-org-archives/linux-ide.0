Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670129;
	b=SDz/5fBHRlDP82u3L8Kv4kB5O/6Ms1l5bTol/KLPMAfQzHJluzO7yl7lffKb9x5egoN+
	 EFm6H25Gx13TcBNKsApJW15clURoJl0BevkzsBEaF2Nik2qXAQXJNW0QIiFpf2C21Lv3D
	 9CEo+uzAWdQyZebjlTt39sehxjVM6ct2U5Cbs0Ze5ZhNjuL4ldkS9x2pyEvNZ0VoZn9P4
	 gHZh5mEoAgs60UtHpxO8gGJ1NSpRUdshQg3wRdwTq0DDuqZqLldDM6gX3u3FMNtYI3NbQ
	 katXgqgScWHIYWpFpE959vXNoiDDt0rs+VYxW4eHDZd3GVgDxcr2gg5clzL5ZLDKSRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Kn6BBQ3QBW0mVYg9ROb+cNf6wk2lxnrC4mh+Wfh8lGs=;
	b=ioRpHplZlsW2eYFJ4hPwpXcQWgZg5FB+uNqHS9j7TZJthcLQ9wOPF1rSQoMmMk9dRHD5
	 +G3duYU3B+U8U1IJRK2R0qzwcP6N3TafiVuekj9Iiamy0Eev+iOKTu0oXTm0IzDFYGeHl
	 /RQHtfb36m3bg5MCong23CAdLV1NKIrJ9Sq6ZW+Q4bmigO0F/eLq2eHjaotNu5huDTBn0
	 oENeLsfYhnEQsawLYoLrhANk2HNlNer8fYmXlBkQ8FHfW2BewCavI177DCpDygSL+5KY/
	 y4KHwujZs2xcGJn3ihc6T7+TvYd1jyGzWJjc5hG7tyJ9cbqow8SXbh5fa2POzsbmzEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OFFMM25o;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DA606A336
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 05:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B03DA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OFFMM25o
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8c5ebbc5150so4618359b3a.3
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 21:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670128; x=1796274928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kn6BBQ3QBW0mVYg9ROb+cNf6wk2lxnrC4mh+Wfh8lGs=;
        b=OFFMM25oHOgjPekKQ+WlRC2bWBuoEayX3eMalu7axlD9sTETbyW6ASQlUYKanwkSlx
         fI+ZiKf6LB51zonEyR/iHy7eaprCJDgCL19mLPhTzZKCdhQ2m8D+uV8JB5t9UMwxaRdJ
         +KJ+TE8HwaYsOBl+GhDmUEbzjrLK8SmkHR650h7MpiMkQfP4tWjVvNpUyaMKs29R4cXk
         U0/AsqgiG8y+MuOTdu3o7NKchnjnJUQW+r5Iy3pOeZid3Qg1vl9EZgSJHN7vueSRQQ4O
         WnsGGBqYxzkQk4467sPUc2GxvY7yV62t2UJOb3VZhv3xtMryysYw1U0B/U9apIPCZqci
         pCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670128; x=1796274928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kn6BBQ3QBW0mVYg9ROb+cNf6wk2lxnrC4mh+Wfh8lGs=;
        b=gSzG62fDn0L4ICLjR5EvBn2x4CUrgUtpIgWMd3UDu61zoS0NCVvHB655gy7Dm5qbXh
         I0NVZNKhdb0gE3EbxWySXV+INj2qkSG97lK+xRyA+gmrMR1RRqWITFXJ5p7PeV2qRtiz
         NuTeSNc1FE/LeMhQP8F5EGrhGsCHKGsO7nYnKO0eeu3SzYFBqzCXM7I5nsJjxASeti2j
         GW68VNaCDtI11kCaYC8e9yiH1/yBl6UmP9sjO+L6304bBkPYT4qOgQV9iZgNZTAbFIFU
         feCF3AO3gSMiuGehK1mh2TkuKNXd3HYzLYMtQAJzHfH67yz2YFXU838HCUHnbZz+SCnK
         QmWw==
X-Gm-Message-State: APuU4Z9G/p5YbAsT1f4l7mnxNrYtfpm0UTyKVYvyahivNSY0GoCzBLk3
	M8QbeAhcbhr3VG7qPacQ4f8wG6qJxDJwX+ylbmSy3JISJwKvsByf/hsvTk5GY9J/
X-Gm-Gg: AZFdTZfurulXSBCtAoaSw16dqVYk4q0F5PIh9TYcUMsw6vK1iFZZ8HWWf7ZNckVbKYX
	WOlWCL7RcOI9Ln6UXLtjw/CrORCBd+oQ5XPhtxNBta0pdT+VEhmfGRMlNwGnFc9cBV0XQO/+B+4
	PTYX1VyqQjymKluBS1SIpLNrIH/taCSlLPcTFBjoqd8s0SEUs9Uo6C3Jse6J4Wg4WyokbNVcsDC
	VsM7KPrZ9qGaQuISXWD7zc2t55xpKzB2OfvcRj2ZAUYl3ueACzmND8gUvU6S0uTvx38/keyRxb4
	mQ5UMqf4CjntJLlytcW9qde31gu5obgGz8r/1DDXb+f+gjdBCMu4BMxeHmHJ7k7Z9Ac9gWqQhse
	Qcqwoa/wb58L5OYf8974/b5no6Ja36FsVKSkPpH4p2fu7isfHlwIaBSgyAhaPwln0YFHinqFFhn
	fI+GmCooxlgAnNVSWknN4ryTomosd4hCrPjI/ELBZM0vfKKTc9X2Z+dMxZRvAbBoPLeXsY4NTSj
	kQip1fmMXODGKpO20YbgjF6LiKgYEkE7yui5wt6AQ+h8tmsgTq8Fy8D0ey1H/juHcwDlUCYhvfI
	Lslc/wgzVy+DVDS7Qt+edmHrPsSnd86YFNoxicFsM23bq/7fZg==
X-Received: by 2002:a05:6300:614a:b0:3fb:5869:81f3 with SMTP id adf61e73a8af0-4014ca44550mr21042470637.25.1795670127999;
        Wed, 25 Nov 2026 21:15:27 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm10179820b3a.8.2026.11.25.21.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:15:27 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: vireshk@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linusw@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH 2/4] ata: pata_pxa: add missing newline to DMA warning
Date: Wed, 25 Nov 2026 23:15:21 -0600
Message-ID: <20261126051523.14431-3-artem122novak@gmail.com>
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

Terminate the DMA completion timeout warning with a newline to
keep kernel log messages properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/ata/pata_pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index ed8c19db207c..46f93ad25a80 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -97,7 +97,7 @@ static void pxa_bmdma_stop(struct ata_queued_cmd *qc)
 	status = dmaengine_tx_status(pd->dma_chan, pd->dma_cookie, NULL);
 	if (status != DMA_ERROR && status != DMA_COMPLETE &&
 	    wait_for_completion_timeout(&pd->dma_done, HZ))
-		ata_dev_err(qc->dev, "Timeout waiting for DMA completion!");
+		ata_dev_err(qc->dev, "Timeout waiting for DMA completion!\n");
 
 	dmaengine_terminate_all(pd->dma_chan);
 }
-- 
2.56.1

