Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587931;
	b=ynBX/0Gr/VkzXuRDrzhlF1/TgqaswMoPxrhIrgqIhHyq60blIwu9gJA4piGpKHoieAYk
	 xYoLz3SZTnMc1kS+YkwYUnanZ8j4B9RKiDaQnPT4a0AnjT6jNrGpVZAoZFXBKznGlJpU1
	 mlcUWDYmY/TVWyosy/SlYenCXeH7lKUaX3mdah/fDpiHEEJ1Is5m5ty5KChDGjCw9CKDm
	 OKnRs+RCpFhC6KQ+CsdcIzPALS0U9sXXdyr2n5fV6rJPGFzlDYlVFLVjueSb6RxjaWfQk
	 nBV66JjXc98+aN+iY7ehIQZ2OuTVuv6TxGre+MO41J63TZkvohURruEkq2cAy2uCz0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587931;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qZp0DD2KBXte+j7jcpltjfJG89AIh2m/LcHGQ9zJReg=;
	b=iPpOQnnudQNL48eQUJTmmo7ybeKt/EgLJ1mthsYE+2ckam7aIapnVpvg/6LJxqvLNAXZ
	 UQsjKYIb08/pln4RLhjBfG2ON7Y5SyQtIpY3pfCOY9DS3/LFkTPpCWhj//uKS40hpDGxP
	 sLmA4mXA0jgR60Us87mV8PpeWhZEqdEsO9K4HF08PVsTBC1A7UlIzVacwlqb1tlzXoETU
	 RCdgL2hFHPElslWgPlPztymGEBtA6WcnGZkyDvnWehGVKqWpeFEopRbGi/VWRoYvjDjR4
	 OdzKDALsOd1lrzehUcITplH9Zw6sAhCQ6gNi9zsFZkNfssW1yto7BDwvDu2JZ1qkxaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vixxz0Jn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C085606A8BE;
	Fri, 13 Nov 2026 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vixxz0Jn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794587930;
	b=tJ0pH8DQ5EMPK7096sISRqCoqQ4uT44CpXXi9W35Xi9QvYrs3Uf8Ct89a/wkQf77UQp+
	 5JM4K+ApfyRohOhGVBmIh0D+KD/XglxmlkLf7rdOjTpG9rw5MrdDMtRNNgQrOHQHBnGdk
	 EEFzXwxYBJz13Hgs+Dk08fJ4iNeBRai/SMgECQPucnkxWy6gmhPmwgtJLP0g3LihiJp0u
	 /3FDP/73Q429i6MoL0x0h47aMXN7F1VYYUm7dKbxDT+RcIImABnA6PlH9fuFcTeMjYuRt
	 ZhePgo7/qWKizyYqA2UcHfTT1He07GjgftQ0iqapWvtnyz0FFtnyk4CcFHrzPUa/SmA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587930;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qZp0DD2KBXte+j7jcpltjfJG89AIh2m/LcHGQ9zJReg=;
	b=aYzDKL4wGSg2zk9y2iRMfy/QgTur9KEC6rZonrFYnKw8sOWPvtX+MXZVVb9VI4av6Ld9
	 la700QXQVASiNIN2eD1NZVf7fQekLE1f4jz+cTEW1AoqJXUocJTmYK6Hvjms2UhZ7hZk4
	 Di7zXItLO6lNo2BjaGpmH/ij5QtlN6lIzPbp2moP6Ut27t632GU9y2mRywu2hB+0syyXa
	 zaGCdqgzP5rw0kWc81/izvd7TbGa2+nDDdhOhUkreWHOhHcMzUAnZ+bs2ZhVxNKtrU8Em
	 GAHfoNTIAVVSCtIw9+JaBgq1bTQ5p002ZQuPE9EafTFs68daZIthH8TFbAin3m7MYbA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 052141F000C5;
	Fri, 13 Nov 2026 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587930;
	bh=qZp0DD2KBXte+j7jcpltjfJG89AIh2m/LcHGQ9zJReg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Vixxz0Jn+vo6Eh95k42RiilxmrcEq6xusz2YQjDtA7bvtnw6lmnQmCyrx4O4VK3sU
	 t43nE2FM0wjIUQSHV05KP79EmynCkDbgCK60pv27JLvfXc/eeTenLfXcrU/X3FqeEz
	 Ilk+NidMvoBf9PXzwpvHabLPtRmWndlTFmBQD4DEOnhRuRjD1GPSIETIa1DUdrqaUo
	 4iduwe3lySX3yDAeH1pb1xCwcmn76GMLjjHQdh3ZFnj5Azcb0XRDV0zdDfard4MITp
	 KkHfLPdUknMD0zoKo0E2z0swfdUulLbnKBv+3fBbDDQJxOm0JWlWi8YA7HrJYpfS+0
	 5FcXafczfoLbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BE731499A2;
	Fri, 13 Nov 2026 16:38:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:38:51 +0000
Subject: [PATCH 5/9] arm64: dts: rockchip: Add the PHP GRF clock on RK3588
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-mmu600-php-v1-5-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
In-Reply-To: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587927; l=874;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=kP/SM+y2vUxtKYfqhUjNYHPB7Pw9gQeqdsuzeyx9mdI=;
 b=+IIxzB+4idJmJ+rG+mFd0cbUWQf03L8gHnWxfJK04I1uiUPqNXUDcCLSOZvJmSZzyLeYJ6//t
 mrPxUsyexlEAi6WZD+LL42kYToUu+Enigmf7VBBOD8YlnxJZong8Ky7
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Once the PHP peripherals suspend, pclk_php_root is gated and a PHP GRF
access hangs; the syscore resume op of the next patch hung deep suspend
this way. Add the clock, so the syscon regmap enables it.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index d0f364547ae5..8807ce6193bf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -619,6 +619,7 @@ usb_grf: syscon@fd5ac000 {
 	php_grf: syscon@fd5b0000 {
 		compatible = "rockchip,rk3588-php-grf", "syscon";
 		reg = <0x0 0xfd5b0000 0x0 0x1000>;
+		clocks = <&cru PCLK_PHP_ROOT>;
 	};
 
 	csidphy0_grf: syscon@fd5b4000 {

-- 
2.55.0


