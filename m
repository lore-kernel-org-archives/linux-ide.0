Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794729594;
	b=fEwTROGWNnF6veAI/NGJkPv8Vst0yT3g7GYZxUT/6MMyqBNOqusobl+KitOTYnVSpIrz
	 M8vZkKAG0hyIxE/06P2V+94p7e2aVb4xEJzsFL02ekNxeeGQbO9IX6YbkP7Girv7dxd51
	 1g9X7cVyEhMSBR3oSI4WZ4IoXtKYOydlgpLv6KAFKyU6o+8rmktwIMMCLEcZ4v+qNrbUg
	 LLUoICQqnfa9V2lnJZsr1s1tO3jfSnEUPk0Awv/MuAyG7Kpqqo0E8FxMFl3Rb8jXrOYtx
	 toSWcBhji5pSDKirMwJoLqo7kTdqvBYLZtwqNEm5w/qD7OVcrqT2p12AmSJ88InVjiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794729594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uTDHqE1Lg6G8+bxeAtYf/i35aEgyOGsm68xtWenUwWc=;
	b=rBQHnGPEQFbS3/u33L7IaQPb5PhFHEBBPxgTgqH9+jSv7rskGkJ4k8OWRe2ZJsgiYqyt
	 48lEWpuaZ9F92q6YOiGet/he+yHoQ3w9eTJbqnUc4TEE2bxZ/3jaLT820epmulQubjjJx
	 iQclhiBTZXXBEi4Je9ll/fa0Hzawj9r9LWr0v/UdX9kVtGsK76nzW4cakj1kYXCUi90wi
	 T74B0kguIXjEEeldYSOUaF7emdLjkWxbaK84UeJA97/g5nhcyt6PxwYAI9MT+dGNz4IOD
	 G4AdlM3kdiZYHqC8DVLfmz3+PCKkw2R0YwPukGOmrCg0mE0uvFbYzURVT1Af5wtgncg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3ZsFgXj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA413606A327
	for <linux-ide@vger.kernel.org>; Sun, 15 Nov 2026 07:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA413606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3ZsFgXj
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ae3b5b1027so1304401fa.2
        for <linux-ide@vger.kernel.org>; Sat, 14 Nov 2026 23:59:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794729592; cv=none;
        d=google.com; s=arc-20260327;
        b=e2nSrpkaInI5MVXR/801bVRaUqJi67t/KXqNNdduitSntPIqeVWUxfH/IFCZTlsM4M
         J/cNd7aP3QIAV+Gz4Nxe7aSFFrWzoRcT/S6lBDOI6CugTEy/aA5Oy6a0eTNZ8Jy+yX3d
         QUBZdfjLP6HciY3kPVBL4Qoe9XT3XjAQNpeSB2xGOGMKwTOF80ocu3zSV1Os3og8h+Zv
         pXOf7nxL1+zxrOsRW4k+34QVrN2dfLUxFCviY0X84tIQHZune00zq5U3xMD+C1vbIkHU
         zBijmdntAntWd7d6/XXC+JmU9gn8B4Rfum6JLCCwt9h90Jixp+0Odm6Yg23KGUyg5Ud7
         /wvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uTDHqE1Lg6G8+bxeAtYf/i35aEgyOGsm68xtWenUwWc=;
        fh=VQuEjdpbfI5I2VHMy+0LhYw2dbrVhkadbaDc3lSWYjM=;
        b=l2fIw5apVZ6WdEOeO7PD4mXB2SqXm64508bgqNgfALg4gxJiQc+rA97VqY7idD12JT
         AgCjPcvk7RknpBBzZ914QY+wtI6n9CRPOgJR9Q18+NMSEnzT3CrqUuCUCWd1+mDM3y5f
         QH6noM1tOxcpSwLvYtNmwhrPhA9vPYEeCiNfg3WDi9nHDHjKFq9wLhHznuR6kYi3u+W1
         jNtCrNchbyZMMWv2YRiiAbw2QGzqzbkYAVO04r5xdYz+ibln3TIPdVXnFoHQOXnhP5nr
         IWhTuImBsqzZMdHk5bWqtDr9oPTLDeECYfv7oUQ9qJNq4pqyLsmOkzQniuJjtCMp6Ozq
         tESA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794729592; x=1795334392; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTDHqE1Lg6G8+bxeAtYf/i35aEgyOGsm68xtWenUwWc=;
        b=l3ZsFgXjqQaUHCu/uCWOhjK/dyHAiUzR+hi2m0HmL1j93hV0uGsEBJsWQGdli/PgCR
         1rv+SVpAaBEzQxHWhcuUuCGzyvRzqYMqQ4/ncvBK6a/61yfT8HUkAn/6C+u4ZI3w16yp
         oz8palOkMILd5b6Frdbg+kf6ZE5X2l1gv3fbLAwhEIGbfhpEriGaTI9QbMcUl49HiYsP
         iGpPErs1fUrEv6pRfU2xuOmqNlWQNUCZ5TKgNZmVETnIYRCcL/kCGBw0oxsmKB7XzLhM
         u7aznga62Ev9fV6nD8R32SRlqRLoIf0DA5HM+QGFAJZXEwYaGbIo0FFbRo6/ysveACVY
         MjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794729592; x=1795334392;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uTDHqE1Lg6G8+bxeAtYf/i35aEgyOGsm68xtWenUwWc=;
        b=waNQjZ1Zn9DkomQwBV2bU+1R9/MoYGHCyS6bfcrlfoNJ5C7F85XPeJwakSsOmiG9dV
         HG0c4L97SmF8e3orDZYDkATDrQ4K2wIG/sP22lWce/NPTYcyMc6ipUaovib1py/f5mTS
         d9bxaME8kb+gozwhvUAR3oy67GtEsnq291mSO9RjZhSs1wvI35CqoURjgcuwRfbo3EXA
         ax1pp0DHrh3XK56Mr48Mk85ms/93pQqQ8q4uG7fZZW+Q84RgCcjp5Vw+1CovuTEvO3pU
         5yFSqUA/E9KsIIQ3sWIxbTAnbcyPX0yg8coIRpAkZ8h/Z+ckgD97RiV7PRR0z03l3F1x
         TqZg==
X-Forwarded-Encrypted: i=1; AL+hErGjT/ZFNeL4Odzm58vNvFjyBwejMBsFsY1d5rHemFw//pgeGc6cRynH4/2sBmwU/yxD3FKpyybA5jg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vpqiRTkaXOrwYyLZvRArXfFcPvyxf469CnpjY3CU3osCWWnnr
	RjjhlvgPZpquTwuKMfGNdDIMW8Yc4Y5gCCtzwkytbxSHGVAFKLvUQw9XlaegRJJ7LcnML5C1ojA
	e2wtwj/0O7sxXLU+3oF2XocKzEYsApxsjRPISblo=
X-Gm-Gg: AYBFou21AosjCJFrUvru9YiGC4xaBFGYgPY1Bt5ANDno5LN4z+HshF34zynqBAtNkes
	zbX4RhP16bmLY6chepTvUhQcZrAwPLwoAC+4NJsGowaZOFXeztnTWa/PHNgpMi3dbEsKGRQemPD
	D855F60/7UDFIEKODdZ6LwR3VkbfsLhw9LqWER9TG/4Bs5m/m4m2C5SY3UAsoalMEbnLILCwnoA
	663lGVq/T3ZbHERnJdZ5jD+jxsT+WDePtQg8U5SV/r3b6NHkjAor9x13O6A9ZO2VMDO4VAuYueA
	dv7cSgCG2FSQtY//5DOK51dADy6eTCGhZuPKT1CHZtc6po3Kc3e2lTcp9ovBHWQ1OcFlRBBeZAh
	8AxrtoMwTUEvDwJWVH9G0mWYscFELN1Yr5FpB+yIqIYx4/L1mlTk73knhGe2PIRDtqsRLQS8=
X-Received: by 2002:a05:6512:6c5:b0:5bf:ce24:38c8 with SMTP id
 2adb3069b0e04-5c1709fc01bmr2810875e87.4.1794729591806; Sat, 14 Nov 2026
 23:59:51 -0800 (PST)
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
 <20261113-mmu600-php-v1-9-231196049a3b@gmail.com> <sashiko-outbox-214777@kernel.org>
In-Reply-To: <sashiko-outbox-214777@kernel.org>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Sat, 14 Nov 2026 23:59:40 -0800
X-Gm-Features: AclHuK-JybsEZ6nSpOrtN4adzzDq3bM7zDeeZmmerdCe2Ul1Cz2qTLFRAuITT4w
Message-ID: <CAEy9hNVh_DL57=pa4_cEMCVC4j_mLhWCVsfRdqZ1=Pu_QHJakw@mail.gmail.com>
Subject: Re: [PATCH 9/9] arm64: dts: rockchip: Enable the RK3588 PHP SMMU
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, dlemoal@kernel.org, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Does enabling mmu600_php break deep system suspend and resume while
> arm_smmu_driver lacks .driver.pm sleep callbacks?

Yes. That is why the cover letter asks to hold this patch until [1],
which adds the sleep ops, is merged. With [1], deep suspend passed 3/3.
v2 will repeat the dependency.

[1] https://lore.kernel.org/r/20260929034510.2023173-1-praan@google.com
