Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729479;
	b=uOsiXPhng/1QBlLnGzuPo5Ki6/iOSuqSFhelHWjohk4Rcz351GsI5mocH3Q7c3/0RpVJ
	 Tjxpv847GXMgAs17TjgDDwHtR0TJd4qA6Se95EUdra0VcJMidyufv7AxhFU97bhGpdK/E
	 AdHMUDjxsyyzRXJTgj4RpERJmDbcJH736fwQDrUNvQCONjidS/PQm29v0SI9yqoQed6qd
	 ob0RYkXfYZRrwOZdTdU7eDytCcRudTpcLvxH3mCHMArZo9O8qhbKQKBTVlj8gQb32xQ39
	 L7LEezKS+I72U3IcXGj6UXTsJzjQfbrZoKFTwc6q1bVte4JZYOz2fBOle4+i7YoJQ2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Kn6BBQ3QBW0mVYg9ROb+cNf6wk2lxnrC4mh+Wfh8lGs=;
	b=puSo3Upek8GZQYuPKV08iu7+W+CLEQWow5OkuHAu/bpLkHMYbYlojNDJNC2fV0+WPBXU
	 2F6UfPAd5UqH/5v5hrfcYVjpjYTY8XwDEhG/eGfIhu8ZmBnSHRVQY36nXyLDeBZuU+o3O
	 8A49p4IXwe9c3xrvpsamM6Hi4tOQkgj9sSAMwlwHDB8rC/8NAQN/V33bsg2mGykl49hhd
	 +ihte/WE8L0vy8h1OTf43xKsIQa38RlfPY/xxHjENvG9o7vrHqzmWeRWb6DM20xW/H+zm
	 Ry8E5EX7S/xZElWv9FLdP2WPLQwPw8L155KQB1CeJ004ut+lQfsEc8TvhljIZNa6CmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTOf7+TH;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D817606A32A
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D817606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTOf7+TH
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cddc597d062so4444681a12.3
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729479; x=1796334279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kn6BBQ3QBW0mVYg9ROb+cNf6wk2lxnrC4mh+Wfh8lGs=;
        b=hTOf7+THA88UEDhELgxphRrr3O9AbAZs0UQvGdb58DVTpvrclUfbp+BKc39/oqmCl/
         XccliWyVihCD4pzMKCUjU39uZCQ78S1YYgb3VhHr8w9oqWjY/a7vMgFKy3tHA6Qfh0+S
         LEuCM7flsEoupWKoYVIj+E9nFk+u7zKtOCJDdrFcto4xn994dUhJ7jJCE++UDtT68iD3
         jDWVMFRMyNAmFQiEVAbJaooyHnnH+A2S/Yrzz/CatL6yX4C2uSbtd137zGf+wHDmaNik
         pRfnclfLk2h6xO4QJgxoJ2oAVrioctKpWxfNIe9WteD3dGlnlph8u6H+EByOmqlHQsV2
         ct6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729479; x=1796334279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kn6BBQ3QBW0mVYg9ROb+cNf6wk2lxnrC4mh+Wfh8lGs=;
        b=u5zYxmGnnlbtEaS5SSzPaKFQFyV6OeGfQNYNpmMCdxkuDYenYGLjHh9icMVkzbFIYC
         UWrKPHsLPDH3IIrC+NEdxeEGFrqPvm/9qj8c84XvDNYCHjnUJTg2fEBLCAKIrOfxXHo9
         Ob0+IDMLsKdZh8tC/72zfsn2I35vx+JH+BZr7cSuHacbjABnCQnrQSghrDzawJS5cwJJ
         gT0ub3/VWIeEbyn1XNTL6VM+crpD51TdC8AB07vUc1WW+zTTfS/W//kfv2Oc0z27PDOm
         yK1ee8jKDZ4CKgndhzdW9cjLTwc1S4m8VYAagbgrmki7sM0MGNezl6v7oeIbTC7sE7ax
         Dm0Q==
X-Forwarded-Encrypted: i=1; AL+hErFWeTTCA4iN+RzZSV5yplaGwtDiWsagULAZCNHBwWcY2GD8UtPxvYx4m+3EF+1gf6WBDKudZn9a/xU=@vger.kernel.org
X-Gm-Message-State: APuU4Z81RSAhWoQiGEK39zSLkOqOD/YTMgPBS3F61Ody/+NdJL4s4LQr
	wtN1y1EZsKm0uTHjipLyow43Oux7ZOog3m+kK4GkhiWiALOtmh1YEGix
X-Gm-Gg: AZFdTZfusjxW51MM++upinBL2oUkvSXQHnM5QLGLuQ7a6KoHI+9Qem+mQgg50Qdf7I4
	YMgXaFgvgohUOk4T8daYwtyCoAAsXg0twzWBo4+/9a8RYVhuElkBMoI9M5IAfK58vpFxXePT+Fk
	ngRpqG3lWc9Ngki4lY+cdgG3ISe8OCH5VDTEoW5v9O3sVm2B+2z9Ihnjy5jr4G5J5F8EQUVLihH
	Y3j0HHCkF2bp+Wcc0U6ePnwB3aBEDnB7ZKQ0uIdXJWeK0ne6RWHls4W71Y/s9TkjnDX9yRblKYq
	m17qxmKKPzGtbg/5aIM6mSji2yGsjoytvlY5eKhM0N1fRzbac5KnFZf0K6Yx1SU65MOpoxXkrN5
	JPkiivP8r7L3YgS3Jfz1OOWJKy7SP3xjObwRdzM2tEwYncihD0gFVaNyG5nLgZwtXkiOdfKx2XE
	5VukwYBu91J1nViYwLvMnlY+xmX81avNOwQzXVeiuwIAaKVeSYz2Vtt0YTIgSOygYlllO44NsXZ
	jr07f819XAhkRtSk1mEFWjADRJrKtDgQQRwo/tESg7gwRIlptnuMQRJHD+7aiMRfismOfn0OLfI
	px/j2R9vvlWCKSDw+kS1y89OcYNrkWSN9KEyv6Emmccv22u/uw==
X-Received: by 2002:a17:90b:1dcd:b0:3b0:9e2c:9b57 with SMTP id 98e67ed59e1d1-3b41c7c7a57mr22714647a91.4.1795729479015;
        Thu, 26 Nov 2026 13:44:39 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm36176538a91.3.2026.11.26.13.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:44:38 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v2 2/4] ata: pata_pxa: add missing newline to DMA warning
Date: Thu, 26 Nov 2026 15:44:31 -0600
Message-ID: <20261126214433.38317-3-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214433.38317-1-artem122novak@gmail.com>
References: <20261126214433.38317-1-artem122novak@gmail.com>
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

