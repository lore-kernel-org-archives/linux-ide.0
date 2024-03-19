Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656257B3EB
	for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839616; cv=none; b=eiwBEprG4/i+MoKEDl0bbGl8iVPVjnoaysGMlO68ooRVyMKbOe7niUZw1K3VIFVjvyggakkt6KX/UA9e6bE7W+zDnJzj1YzfAT7rOlUtfQy5z1BFlwphtXABTYo5+WnHMr3WwjJhuIuEG0OfWSzqgovmlXoNKxO9QcUbR35yVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839616; c=relaxed/simple;
	bh=TLXx0nQNa/Rp2Km6zWi3UKcI70bXyhB1ZGBgHF3rOFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cB8Yb7zA7Dq06qxiUGhK+TYasdG8U0xFOqIr22HCR8mpGuA8jSHXN9qNBxg0oq6KKcJEmphdvxuC5r24+JGFGPmlHINuy3yL2BZG5NU9yOXVFTvM9CHEbzlam4cYrSpecmtNObswZ+S5J6xUIoSKfe7CUMhvW8U6zIjicbB+gAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbUtCZnX; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbUtCZnX"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c390030af2so762374b6e.3
        for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710839614; x=1711444414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3z3iI93qBagbVpFS+nQVWFhk8lqhYuUQU2GvQfQzsY=;
        b=SbUtCZnXs7g71R2yp6VZPiTCWGM96jq2Bacq5P1xSL9QfwYUlMDhoeVzpUsWLktV1V
         2QX95DrW1akMn+cgCDHjIEvmQqyzXI05aHv+VMPftqCAAU9wLE9NoTzsTOMSYap+XRpg
         P+qEWcHNtJWfl0Ibrih0ArFqLHhjZ/oue1Rh098cxl3G4xZdFQM8vBZwBzfmqf46M0WW
         UG85UpBBVIkNh/d7KJM+7KytuA7F0GUE+TaVTcMqQnWu4vSHf7Aa0Bio2TwXknaMn+i6
         LOTixpZicLhD/Pz13Vwg7LTGcSeoUmCjGO4nyu98/5DCnskEMLq63GxQzIH4LIQM/eDh
         Wutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710839614; x=1711444414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3z3iI93qBagbVpFS+nQVWFhk8lqhYuUQU2GvQfQzsY=;
        b=wswqwpa1ZyqReL4hgnh8dv0AjvItekgMYABW4HntFI1Kcfe2k30UMPCdEfC8QpOR3m
         d3+SnsMBLUs3aw1sTwmyHUJ5lQ1vBIWlR/LQTn1cmtNjJaRoHnu+qhnRaBW1egw1N0wX
         49Ao9fFbXAxIE2AiaGlrLyPI139V/mc9VVIT0JEmJmeDwC0JRkVr9XKAQLwb3/h+1Olt
         /JqsHrpB47tg17FO8gOZ5WO6T0+r7hMMKwCJT5ckgPiPjroSN6wiqXYqs2gzwGNd7YsA
         wl7/+Y6F30X+QpqbbxgGAhfVYoWwqfunH46qOMie+Y82I94PmPNf5/LrTq+9zpvoct1L
         xz8w==
X-Forwarded-Encrypted: i=1; AJvYcCUC3kI92QzUJZNJQw/tVAiR+XJKSWCPQQOFj4RL55DH6nFsbn+GifEvunzaBYq7K/gQ4fa74SV5XujVpCQJCLyGnQNa1q0SAVdW
X-Gm-Message-State: AOJu0Yx4jZz+mDxUuPs8G7ka6/WLUxHQVROCaOJqknOhpqtQ/yKHBYvT
	v2hMK2ehW8DNWt53DoozK7xPnJ7/SDdrLRrZG69C1ngSj3mCiLyW
X-Google-Smtp-Source: AGHT+IFWUO99QG4N35i4F4iRHRX32TN/GbHlVYqkvCUriM1KqUequ2Os989M/bm2yAV1nX6Hape8Jg==
X-Received: by 2002:a05:6808:1485:b0:3c3:7752:897c with SMTP id e5-20020a056808148500b003c37752897cmr2452355oiw.11.1710839614386;
        Tue, 19 Mar 2024 02:13:34 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id y31-20020a056a00181f00b006e61b0a4b17sm9267418pfa.185.2024.03.19.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:13:34 -0700 (PDT)
From: Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw,
	Chloe_Chen@asmedia.com.tw,
	conikost@gentoo.org,
	cryptearth@googlemail.com,
	temnota.am@gmail.com,
	hdegoede@redhat.com,
	jnyb.de@gmail.com
Subject: Re: ASMedia PMP inquiry
Date: Tue, 19 Mar 2024 17:13:22 +0800
Message-Id: <20240319091322.10909-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---

On 3/18/24 19:32, Niklas Cassel wrote:
> A user plugging in an external PMP (so not a PMP embedded on the PCIe card).
> We need to be able to read the PMP device and vendor ID, in order to apply
> the correct PMP quirks, see sata_pmp_quirks(). So trying to hide which PMP
> that is connected is bad, not only because it violates the specs, but also
> because it stops us from providing the proper quirks for the connected PMP.
> 
> Could you please tell us how we can communicate with the PMPs directly?
> (Regardless if they are external PMPs or PMPs embedded on the PCIe card.)
> 
Hello Niklas,

Unfortunately, our design does not provide interface to communicate with
the PMPs directly.
When ASM1064 plugging in an external PMP, we will hide the PMP and map to 
the virtual port to run.

Thanks.
Chloe

> 
> Kind regards,
> Niklas
