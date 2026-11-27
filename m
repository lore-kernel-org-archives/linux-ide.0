Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803387;
	b=0nShT9COnvWUSLqYFa5VqFxd65vL6Sa0OXihjz/l6GLDZlfE6Aua19JI4bku51eT5oK8
	 KMibhzim+YcI05P0ma/GquxIIt3C1AEQQCfYNqtcbAqBNswhYICd/qU/pItg7mwAmdwYs
	 b8ohSXsXxv1yhsH846qniHSxzHi2LVjXuvIYFDYVmMAUBvxr/LSFm8uCCevwiEnzl1Ukq
	 FcO5P4fDB85dYQIik8PYCw8V8p/bth/CgyG+1mqO+o11bFrUgIM1cJZsf8q0fYd7OqqtF
	 BDWhtZKLNgD9Q/GduRJpmabm+B8pxpChS8BBaTvewXX20mHJUJTmWEHpHRSM8MjRUVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mz+Itla6D9aJ4LEfK+0eYjrF7t88lxIqTXb6+qpzWZI=;
	b=Fug0jf/h1zs2dufGHKChVZ9fFVn+8h5gZNsnlkUsGOhVtMbNkkMie7TVdgVbILyB76U6
	 geabASbXrBcVYkM0BM5T1pBXWEiJItR+df5Dj0em8cjjXAC4cbbCauP8E3uYryBF6qI7V
	 3PwQj+ejunwvlAoaBHxeV3pAwA1enkDzTd+gJMMMADmj/1OSB/kxFehXlKPReF30fhXT1
	 yxqHtOQ+UCZlbTHAutixUWdRlOlDttaNeNLL0q2z9uJpGH0XkSVcNNCawBQ1Qupwp9ktZ
	 rYJBnYCj1amlIa8lmYd7sfbnCnh+Pr+wMtg8+jRLzVhVX6a6oxW+bloUTGI3//ggoGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HtosqRNs;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B1606A33D
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C3B1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HtosqRNs
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so3499038a12.1
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795803386; x=1796408186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mz+Itla6D9aJ4LEfK+0eYjrF7t88lxIqTXb6+qpzWZI=;
        b=HtosqRNsbIzl2DkZ+uJhpkTEt4vU/840aWS05VouFYYlnAck/LeVeOAEagvhtIXJNZ
         NvlNWH2HslKtJPUCc5ItcJuPDT23SrAwyIT9Q31Q8/m0X9Tq0P3D3HmJf7P9WcrA31Wk
         Uj4DrkuDewnSJt+xPqL/qyxL+egAMewAxCAurz/pJKUaRiqVNV4/eLjXUyndwq+GPtET
         8d/jzQMRGG/ManIlCXx4q1V2xrq0Cux3kC10ONrg/d6mgyObfdjUBzh9LjuO15kFUtgV
         UrvqNA6SFr1A5wsgEaGZmGusEajxI/pVn+n5EGWw6qiUtfXNnbNMPJ5WZhdevczWLKlH
         hWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795803386; x=1796408186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mz+Itla6D9aJ4LEfK+0eYjrF7t88lxIqTXb6+qpzWZI=;
        b=xgu5RvZV9G5DypIMK7DLTr/419OWa+Jclel1uEY0gofwNxMPrHZbzxSVl+ojJKzF7t
         ua4Ssx03oe3zoXt6oSMJcpCRA8Xtc9DBjEB0gbzzuXXQ0Gy46JxnibENfOnN8WuJf0Sw
         tofJnrHlv+DVv6AGIonyY9SQ1K+RYO4UGYClptBXX4i9KjGTKdXVoCtnY5oE1FpR4XjO
         oql8xwLGL76xqqvhKwH/xjZtoHXZRwsmRtmQrg9FUnSH91DEOPqlmk4A7SFQwklWrOI6
         AE0G5Es5eSBpyVToSTi0lsN1oW664DvVLhm7P7D6yvh7nu3ZAnQax+YbPdfJZtejs9hp
         CSKA==
X-Gm-Message-State: APuU4Z8uImq9/sK6xVjWKlKHeEvOQifq/1Bn+KTWtQGSXvz+H9aMnkr6
	ac+vcbBFkc7fCfUiwIQ1JS3mYMcO8giw5Kh474oNPrQGyKCR+yqiSkLnnaNVbl/p
X-Gm-Gg: AZFdTZcoO3DIEXYkEgRpPWDoXQon4W7yXq7ayC1q9WgGnNlybEy1V4T4ky4omHw8qpl
	e8RCi5nCe5slOoaRIoox8RlTPF6A8Tq6Rms7Dr73z6yK4sn8/yAoTbn3ISGKLOOACu40MPTL5+Q
	lMHHe/2rumeyE5WGG+L6J1lha/p5iZA5Reqd6xr0rkRbYANZJhQueVROYjYXxCrsJfiWySjv5cB
	+OYUYyil3uuAxB8T9Hj0NyJLEL9sz2274bo2APzQfBpqtLIoeZz2HM+RPEVSFcXf22NrApcCn/6
	rbt1OtZ6kZzxeoYU3UvWbv4WI0S0cf4HPN6MfscDxUTmJwnA0AdM9Rc3Vl+jl9BXITK1BZjGj1W
	y15fDMWr4g77YdJd5nRN1jWCJ8ReQZv59+EdpcEaNdYIXAZnzwJ9CWojVeawLTJH4xGWnBzibxP
	9tnlG8wFS1NPmpLSOumjQ61uWd8sBa12ecsc+AFqnK5cKSAJHZHItiVE4E26CflQqaXbdCsnbbO
	VhhYUhWJ5amygTpus4h7Ewdtnk7a78v5FkvgeclpyLIcQ/7eQk8Du6fml6oIWkGsAqnJGNSyu5D
	gmi+gkBB6eTeW2movHoi3LYG597zZjhoNBZPgY/SMWJ2XMeh9g==
X-Received: by 2002:a17:90b:3810:b0:3b3:cb3b:1965 with SMTP id 98e67ed59e1d1-3b41c8fe1f8mr25142628a91.16.1795803386248;
        Fri, 27 Nov 2026 10:16:26 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm39867121a91.13.2026.11.27.10.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:16:25 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	vireshk@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v4 4/4] ata: sata_gemini: add missing newlines to error messages
Date: Fri, 27 Nov 2026 12:16:19 -0600
Message-ID: <20261127181619.183139-5-artem122novak@gmail.com>
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

Terminate the SATA clock lookup error messages with newlines
to keep kernel log messages properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/sata_gemini.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 9d87603ef531..b69db749b49d 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -227,12 +227,12 @@ static int gemini_sata_bridge_init(struct sata_gemini *sg)
 
 	sg->sata0_pclk = devm_clk_get(dev, "SATA0_PCLK");
 	if (IS_ERR(sg->sata0_pclk)) {
-		dev_err(dev, "no SATA0 PCLK");
+		dev_err(dev, "no SATA0 PCLK\n");
 		return -ENODEV;
 	}
 	sg->sata1_pclk = devm_clk_get(dev, "SATA1_PCLK");
 	if (IS_ERR(sg->sata1_pclk)) {
-		dev_err(dev, "no SATA1 PCLK");
+		dev_err(dev, "no SATA1 PCLK\n");
 		return -ENODEV;
 	}
 
-- 
2.56.1

