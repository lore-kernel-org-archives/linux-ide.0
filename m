Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795683337;
	b=LAfZjBF34VZY6o9mzcGN4Tp8kjjd85ORUc5UmF5Mow3PrLXhMYcjcYB0RbEpEZan6niL
	 v1seJhfOEZ+pjD712YSH/hY6LnyHtfACeQXbg+1sSp5huArhIX2AUuZv0GyBxeuriM2Cf
	 sX8EL1Jz0+tbu5oSMTAJTtP3kP41ZN34Kq0lRWwBSLEzQS/tpVg+qDv6iJvgcOueEdccA
	 dmJLj2mrHxk/6qC4RInaZKdaCB9D44V/Wf/n1xjiBXYHGKQy7ghsdSoOJRsEtJdkh6K+V
	 eWP9SsbysxsBRuyRSekhy+HrwzFp+GxRxmxEmO31P7iWfTPF8pVX2Whovw2DBehodAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=QKThXZIRAMEkOiH8X0ve/DDQDh2imYfE9WZ4cHyq7O4=;
	b=1Q273HcFSQ4vEkEX5SXLfMl/yQQ0+sSPbQ+5+rxUVrGw+OXgiNqpp+qWr+a4dkwilzeU
	 bF+O/Rr1A9ajcYMjEUZvLEEFEqLOuTjpvHTDxFXTrHHNicze8LOJQ3rRhL4xXB63vpIng
	 qphBJILdrI1C0b8ETouGUCgLIYNn4uAygJbx64GpyZKyYfvYLH3fD/L2kNo3wKOx5PLO1
	 04EIjCOtwRhq8tHYcPvwxKMRjGEBCUL9Qw11DjUmz2bLXu23yEtqvfQ+6GP7c3NEhLMvJ
	 Jm1w4GkvXJky/EHZn3K7ZRffBsCTtt4rEGviRO3XgfS5saBX/5X1OQdvIpg7xGPE+yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rfMg87DP;
	arc=fail smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3265606A339
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 08:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3265606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rfMg87DP
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ae10409ceaso6540591fa.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 00:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795683335; cv=none;
        d=google.com; s=arc-20260327;
        b=BH2rVyRwloXM1hbNf9KW3FtRjMjtvUDO1wWD3K8vxHP2BDGIxoYyPDpKm1bQcu352u
         HuaRs/TMObkGAmq5Qap0p0R4J4EfhJi15XH3+lqjckZsVqEafv+1KmOQN0ZBS1dAfOmL
         dqD15alpkwevyZJpLxwOeNg67/z9hN/zQSiWYtRgcEdrhDNvs23IhbLfHC11M9YGm9ls
         azNfGblnyKs9Qgys4fFZBu3zEvIHytcLbznRCMHbj2a92kBk+82KiUXGL7YRanNEWxCL
         Bi6tqdZmSv3fi8D1fNTxsCWfc7dHUNwvfGFHMx6RLqEaZl5kZVNBN3VSCTwfc/8rBnPR
         fPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QKThXZIRAMEkOiH8X0ve/DDQDh2imYfE9WZ4cHyq7O4=;
        fh=Ceh/0I8yW/SYlZBhnATovxaLkqDxDoCE5ZkwgVHODoA=;
        b=ac1XemCEGykyRDP2zZVaSGNRX9rRbwLZ7Qy4vRZWWwbAbEwEQgkyGZEyV9CVkKzOc8
         CcGT8eVNrfvWUz1zOknGHkm9hnwGO3O7EdbZnVjVXofS0Eplv+RijXR7LDImKNmRbPw9
         fYVIqVoTIQyd6R6eFp6bBk9CksOwXN+HA4i3Zs2k6UMSru3X3vRWEXFe9wei0RjTzHaT
         1porMm+Z954HNCstMbJGIEYw20Z36mLJSDh7RmHjlBO8cm5nSmXxhhQw/yk7ZfXio7sI
         ipLFxvPNirSczD2TjNOe+vQ010ygGvApWkjZL+ou4x7Jc+KIkpkIWopqRaibt+oSgUdL
         mCZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795683335; x=1796288135; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKThXZIRAMEkOiH8X0ve/DDQDh2imYfE9WZ4cHyq7O4=;
        b=rfMg87DPvIeaAt7WefjGyrL7uSD0uquLqmcawwAuuF0LDc6gm3phN9FgQ1hfcvNK4P
         vZUlpOYWEPZRvkrmo+Mh5OCC14KnFgEHDnbHYBX4t18bjdh2rj5ugU6P0+GkO8jWovOn
         RMvM770R8L//+znfMXxpcv0SQZZi9vdNe75S8ImFMsKJ3Q1QjbmRT2JJOl8FScurQcSB
         0tqg3bunvtmzuZ2dkoxsxh5Ib9cTPnZ3eF/Om7ll6kPxuzPcCWzJbprFtufbqrH4s7/U
         t9YQ1tkr9xcfscV4PTDAcngJBXvdMP87j158ZHdpSixSopf2JQM3kDHgOT41E84eKBAk
         k6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795683335; x=1796288135;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QKThXZIRAMEkOiH8X0ve/DDQDh2imYfE9WZ4cHyq7O4=;
        b=a5TtsVx7LOkX8Ln8lk4K1lCVpRWibi7x+igQ30+uiBN5HmL57uK93kRg/qZkAl4cW/
         mLYv6GeEdTSOTQSJmO2BKN9oWYamT/1hko1UjhhQp7/hQ13Rkb4fxAuF4sFmB4CDlx7w
         VKj42tvk+nwM5GA5Wh7xgOgjaEDTEu2ZpW4cafwrsoF4cQSk+WxHfPP5WwwYXW8LC2EU
         ccgvoj5jw/NjSOdql+qgBzLvE+/A6o+RELOrLFyBqT9FzPQn5BQVGHwyujEHBIobIv8a
         hprl6lg6ZqUZPi3s+68uR2XuzQ6BF2jC0RIq0sDpy5DgKRqlYVHRlLOvoGSR5zm92bBC
         81Tg==
X-Forwarded-Encrypted: i=1; AL+hErEWuK5rjYXp+ZyovGsSkgN78u+TtcuzxS1N/eXkYp+aftXBOTNnSh7z1BpAwu1ZvLTnKzLe/EyrZWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+n10D+kxqfJy7MDOphTWv6Vi9C5tDKWTqB5kSEXxAKvEcngL4O
	zK4cIriPWBk8uwpgD9/6bQ/ntA54PnUAGwxzQ3V/9WMQytEoOko93JQNNscrN/o+bhi4GfuTIZt
	aLcr6hoNy6EcVn+AyERbYsmKHPN270/8=
X-Gm-Gg: AZFdTZct6Xuvq4EEFmFfvmEZSRoG0GykGD8Fb57Yj86H9anNXoT6fWA1JcwKRzJKWQN
	0G86D9X/yRdtEdvGhHblLZ2on/iSL5WMnPIKRl8tjyXH+9cbCDOY5mFsx3rNPfVuaBrn2uysUU9
	yyeYuKVFK7F/aT3cVeg/wzLs2yEvLeYDnUtrsoDycPkOPVat4xPM6pihWY8EWWNtylU4Bwd/N7l
	gY4dVfQDjzhBxmanLzGgqb0tc5yH7XwlyyffrKjD097Ne4WocjWSbwpFVvor+KUT6uWJghgHZD9
	edJvsjtb5FuTzlTGDtKkVInYhe/Q/gER7ts+dqOQtKvR/FmE3X9mbDQZN9MzCBUD7N2O1JgSV4Y
	c5R7h9ug+2SxOrvNJ6Ukq5sNsudDOPky87q7ze+ir48N24n0CUF196vUQ5VOszB8NnquAEGY=
X-Received: by 2002:a05:6512:1151:b0:5c0:62:7fc3 with SMTP id
 2adb3069b0e04-5c1bc7ceb5fmr8223250e87.5.1795683334857; Thu, 26 Nov 2026
 00:55:34 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
 <20261113-mmu600-php-v1-1-231196049a3b@gmail.com> <20261123-quirky-scallop-of-beauty-c662b7@quoll>
In-Reply-To: <20261123-quirky-scallop-of-beauty-c662b7@quoll>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 26 Nov 2026 00:55:22 -0800
X-Gm-Features: Aa3M54pFlibDAmDC24529Pztyl31CflHnU5Me60OGDKTLA2a_3s21NJ2pQ1ALv8
Message-ID: <CAEy9hNX-TiThoXZ9+Q7j=bB7PpNBr7Wjz8_sH7C081HXka4xHA@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: net: rockchip-dwmac: Allow iommus
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wu <david.wu@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-ide@vger.kernel.org, Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Shawn Lin <shawn.lin@rock-chips.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Sorry, I missed the report. v2 allows iommus only on the RK3588
compatibles and drops the nested ifs in 3/9. It follows once the
arm-smmu-v3 clocks/resets binding it needs is settled.
