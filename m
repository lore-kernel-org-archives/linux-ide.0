Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729686;
	b=EeUfTbNKLowPBP7j4wcTTT21tTyVB5rlY+0GWVCQJlt+nW/AQxs+8orKtzknW0qyiZth
	 /oYh9GvnaCWgntn04LcY4KqlebeQnmOcSGCWZX/xuacB2Ghy80tz4PFB7CQI7osqnIsB4
	 zZeoF/3vPuAJOwKoXJxqt0PoXR0MNiYDCvJOHOBKkECCLOhYuf380yZZB3Zx8Y8mUwPT5
	 C86Deu5dGgOYIaMrQVsbNLWewSsPhkaTfMcw6RUYLMUar9zpcPDuV/zljnIajXxanq11K
	 iTqPEPKJfBbpwWnqeVZLWMEP8XkeYFIvOlGYtzarKsv3F0UH9Z3DfOaa7eHuvvVVdXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mz+Itla6D9aJ4LEfK+0eYjrF7t88lxIqTXb6+qpzWZI=;
	b=I+bXi2j2vvTMSZEFerZaTfrWbu8spP+qf1j6VVAIqHRUO7bNpMButWHcaO3q1F+ppuva
	 5z86dJEMvpQOlsAJCJ9s3RqDm5yzRkw3x/XCowNerqactySFzHXxYmNs5jIYH+R8GbRfI
	 GTOxRpPu12jdA/I44DOJ/N7oPMWof1uUeO1i9cwj9Wd6XSMkTa39m/9xoL4NnlfD60Ncy
	 1WBz8g5HDxtksS0FQZH2BWXaxgs/nkbYU0EVc6cV7xFfg4eezOm7BcE//TtGFjafLWAuh
	 1Q/+PcIkYeyPE9TcBuuyAIAZzW1s3yHNh0pQe+39iT30NfVfW1VRNxNL5w7jMOVqYnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUbvXPpQ;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CACF606A684
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CACF606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUbvXPpQ
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b532dfb874so79980a91.3
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729686; x=1796334486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mz+Itla6D9aJ4LEfK+0eYjrF7t88lxIqTXb6+qpzWZI=;
        b=nUbvXPpQgySjxVjRz48Vov14b1bptslVjT+ROckJphZd6z2JWiCb6+dq402cm8/Y+p
         ldQKEa09j6sRxikDWcAgrUwZnpKFeTPtQ74zobflWaaU36PG+ver9lwpHjHmeKkf1h9B
         YMg/v7WJBXyDvf8eEdwoO+ZE2/ussRT3AkgxeW6/326QU+V5dMPZm5o4th4ahTX+ljIZ
         jaF91TpmwE65oRTeHneoyw25xZ5EuRTLoVeZRyEmqbAVidUAXlXy3tPQY7J78PfIcpWI
         rbWW/x4Z/91LAEoLLCDQFwPayJcahd4yMYL75ImZFXPywc+nuxpKjrbsPpxwIN4/chBK
         YMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729686; x=1796334486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mz+Itla6D9aJ4LEfK+0eYjrF7t88lxIqTXb6+qpzWZI=;
        b=s5iigrhV4xA9XcWRXRuUzH7I1hOBl02KueuycuQp+kOebNYp0du5MFcforFg7dGpIk
         OQ0WuCtapoJJ47OuL/SUM18Ye78pacvK5ekAV2NJH3ypUqvsNq+sQqbS0mn+fkkUgRpT
         ljlrY9jmQDXOcvEM4/w7GzhFsBEamaBfWfFcNWZv6kQO2ztyFjFiZdO6oYUBjZR8qh1Q
         SN5g4FLveTxvMZzzB06yIljhJKdBdamPBLWHX5fDG7+LDzUwGQWrzIN/xHvJPFCC8zYz
         NhfS+ceNpUnVkuivRrGiqA90n8chzYHyhUc+4l5qI8YRY3tc9dTGhTho+IOMtHAGkPHJ
         q7AA==
X-Forwarded-Encrypted: i=1; AL+hErHv3+wqzCO/RLodh5XjtNufbImfyIE1IJMnKwhVcLjpEFNvHoEGbYkpdoNMvW9cwseWNS+XBG/B3Nk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uFvoWhc0VqNVVy/6bplkmvs3qbioXdZ42Lg5d/+kjDTkYwSYw
	x3VGWRLYpfrAREEd04fSoBEM7/QyeMttu7VyqeUENhMVqbvHLakyYKZ3
X-Gm-Gg: AZFdTZdYLmMs8CQOgUUNXHr+iLG5ytcvebuaM7wyIn0y3nUyC0NVx2uDsi1E7PlKIAO
	bKvKZKrWaKrxK3csHbKJSo2SXsKNh8gk1XYHFQjzKznJgaqjaShfGhkqcuL1CF4pAKEPXqb7Dya
	C/ka6Vujs1wC+8jvREwda88AX7FUtUW+QwbevCDiRN41AjPzfYhOovZHCt/C7SOGJ6uyeC0p2l3
	wz1BcM5WE+5L+63xs4WUxLpYhbm/MKmHW0PQ/P09mw8CvcuPm48jxwJcM5qQUfKzNKeY6YdBf7l
	Mv4EOheJSjhvDIR2oB+HqkQ1SZf0zbc1QDiKZivrHsXOiwkAassUS3DhH7LtFsJsVoR0bQtsHaW
	mxLDWEncwVF5YI5VoUvuhDKUjk+1YHOXm+pfWz1RxK17aNvhdmWucv7nfv49yvAWanUIkV/mOoP
	s0LH+FdVIvy47dOrxLU8FdE9wG0qSTlteucpeJhg0wr9WR7QgD/D5DN0jMIoxH5UhILgZwsi3lz
	BRSCLUlcCpmJU86X+MmGGlwAIvM6quco5Oisky5edm0Tcp8yWwcFJPmAptV74SC4faeaYH2xvBb
	TG/vXU2t46s7qJN6j3KqC/29q36GOVFXDNoE5I1MFzscf/2fdw==
X-Received: by 2002:a17:90b:2f8f:b0:3ac:9f24:44be with SMTP id 98e67ed59e1d1-3b41c92a3dbmr22744671a91.29.1795729685759;
        Thu, 26 Nov 2026 13:48:05 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm34636414a91.8.2026.11.26.13.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:48:05 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v3 4/4] ata: sata_gemini: add missing newlines to error messages
Date: Thu, 26 Nov 2026 15:47:56 -0600
Message-ID: <20261126214756.39027-5-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214756.39027-1-artem122novak@gmail.com>
References: <20261126214756.39027-1-artem122novak@gmail.com>
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

