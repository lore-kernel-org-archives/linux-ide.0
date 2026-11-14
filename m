Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674385;
	b=bWz958IS6gFxXud2pqb0HhVTFm74XY1FCDM+G/q4x0mKdmQjwiJoUf8n3NQ2xXp+c4Gu
	 a4N30+0LSGhF9gy7YFwhTeV8GuZTYeLW19Ws0/UNoHufWV1IVvuhbPoPTgDoeV6sgRBuN
	 mbaFi0hPpH3rrjxKlhNOD69JnoJWNClosyg5aYwJfMNHYlvGBrdll27j4TbNeoeOUFVFZ
	 i6ybwWPbgVCuaD9LJefFyY/vYdFdyg4uN4QjlY1keRozftckQeleqbj473Tg4qwCTFbWb
	 txRLXw/NYXIaaDQlqsC1crDOrRl0eCSb6ZBMAoReLy4WpRmorBXaTsFURO0rFkaJdYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K3AcZ1sPTwV30Y79eO26Dn+oM0LZFpx1y8em5Z20wiE=;
	b=N8hiwlCixOE3u3N58OZ7IDYkMvARUGHa3rK+c9PqCQN6FeFPQgYYSYP/NQhPBLppErul
	 NZJ1JGeiKBoM21IFZCh1QplLJK0hOfeGVCvz0GzRFbwUxNQs6Q1EF4S31D5z9Tu9lEx/S
	 xK4ZAqAW5WxtmzT9TIvI4lu7STbyWxUj4jBtBqvuQ6DBM5H5HjobzCgPuU0Tim9h2XRED
	 7Rv9V1Q/DxRHhdaE+oDXo8oyK36Bl3T1nb1V9OGYgkZlEO8bkebD6AYhTdeEZ4HfE8IHb
	 PrJbkUl2iN5c+V5wWPDsA9p47Tkt/XfzLtI/zRMj2td0WUfZhE1XjA4Tbt0+9vd4Z4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6BOE1ZM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF6606A323;
	Sat, 14 Nov 2026 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6BOE1ZM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027A91F000C4;
	Sat, 14 Nov 2026 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674385;
	bh=K3AcZ1sPTwV30Y79eO26Dn+oM0LZFpx1y8em5Z20wiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h6BOE1ZM0fvFu6SDzi5cHGuv6BAlicg62rrPVKy4lxY3rytgQ1/PK2WwRYAdPpi1g
	 G+0fqAh1Cxojd6eG3UF/KQVtKz+E0jci7aJklB9yaDX3cI7Fuhnhwn3nUHBMrocsGe
	 Csf49sUd5LcRW4caSFXLwpu17ZoJFSDXm8/iLg2NjOQsXawpXR+I74y56aI9KKCCaY
	 0KwG532OGdh9XnlBNLT2b5mnASCoL+l9g9n18vfFvTjXaPITxbworsN1BTL1BCL9PO
	 jYLD41vfFzte8QT0i5ahdHX5vn1dIrmZCAeZDx+dSIDs3+XgoK5ugBSYHGJYU/W9G/
	 ftEt1V5Wk8ltg==
Message-ID: <sashiko-outbox-214777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] arm64: dts: rockchip: Enable the RK3588 PHP SMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261113-mmu600-php-v1-9-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
 <20261113-mmu600-php-v1-9-231196049a3b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:39:44 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] arm64: dts: rockchip: mmu600_php enabled without arm-smmu-v3
  sleep PM support
--

commit 3839dbc025f5f6bf3346a2b85f6dda76ed471a93
Author: Arun Iyengar <aiyengar1990@gmail.com>

arm64: dts: rockchip: Enable the RK3588 PHP SMMU

This commit enables the mmu600_php IOMMU node on RK3588 SoCs by removing
its disabled status.

Link: https://lore.kernel.org/r/20260929034510.2023173-1-praan@google.com [=
1]

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk3588-base.dtsi
> index 2b6e14e7e1a3c..ed54d888caba2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> @@ -576,7 +576,6 @@ mmu600_php: iommu@fcb00000 {
>  		clocks =3D <&cru ACLK_MMU_PHP>;
>  		resets =3D <&cru SRST_A_MMU_PHP>;
>  		#iommu-cells =3D <1>;
> -		status =3D "disabled";
>  	};

[Severity: High]
Does enabling mmu600_php break deep system suspend and resume while
arm_smmu_driver lacks .driver.pm sleep callbacks?

When PD_PHP is powered off during deep suspend, mmu600_php loses its
register state and resumes from reset in bypass mode with its command
queue disabled, while attached PHP masters (such as PCIe, SATA, GMAC, and
USB) remain bound to translated IOMMU DMA domains.  On resume, DMA from
those devices uses virtual IOVAs directly as physical addresses on the
bus, corrupting memory, and subsequent command queue operations stall
until CMD_SYNC times out.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mmu600-php=
-v1-0-231196049a3b@gmail.com?part=3D9
