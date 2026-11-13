Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587931;
	b=0Q3RXN+WvE36OvWN2Qt1hXUUjZMa4hx5A+cjVOIw/3kDqmztXaai4XghboBa70unXBZ/
	 B7gyCfRPO8+rpPZdpMz29fVWVHDpNlw6gXX1UgpMxnL/w8xglW76HYViNodEEAPk/5aRV
	 eSy4A/wgfecalZM8Qty9LYciUHt/w5BVv8k8fPfBphYCfwM6aYUPaF9B7Gxqyen99ugrJ
	 BYBPB1PY0VzWBZSo4JOvgBnJtuRlfGmCqmRNd94yNPqQ4m5yEDbFVJupz6oL0abm6gtkC
	 QGJ8VRerkzp35Vhne2i7T54I3aTWAnPQHTb6m2iVhmM7CIZihAVNwOb1WZUDMU8yZDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587931;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ovNdFvN4j5VHctDx3kFirGTCyVStcoGTaw81WNU+GIg=;
	b=BsLQ1McpZlGqlo1fsP0Rt7rNkvY5bW7oIaeBr/enHL14j0OpWNLWVgLdmyLbVKI95HDF
	 2+sRi6yZGBpY5VHu6Q9JJrvx6AvQEIHxzkfUmqPwegqI6oRgWOJYsU5ylL7S9K/OTF7LR
	 ByLTHDZo8SrlleVW9CakT0nIgwBus8jGf3fqMxeqXwmMK18Z7HV8JWGIVuxohpO6MLsLk
	 +UgWGq46dhlcyByBS56bBJJIGDJ8TyiTp7Q9WcHZl480OhGDmc7FpCOjBrsaiiG15fFDW
	 NYjGTSROCOLycqhx96K89BbyNQFwglQWysbkSAMp/yDSNoY2bJKoFZCiTdVahsPfBQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AebHUpoo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB560A2636;
	Fri, 13 Nov 2026 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AebHUpoo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794587931;
	b=0RqqBh9FdbZHQbwk5q3Ko02PBehpVj4erQw+z9su5R41j+FMYWiPPDBWK+w+JtPPLl5q
	 CgITaI0TIzLl3xhoY3+sMsLnB6HABXrxnS735k3VC8j/uhoZEPfXdXe0ZIjFPocqF9XP5
	 dHsT1RAduosqkZdAq2M8qLktQZOV8Iqlp0JMQqOByRaQZ7T20JV5EiJf4GrkBE2xCRB/Y
	 KvTXtMpl90U1Um5q+S4lR/jTJhbJofHXKsQs/8nP2M01yYiaZfPasImIyEGkFY7g3zG7/
	 SqlCeUfxEAnOQwrvnAs3gaYDOJaJBAzTeVTqd9pVziDvhOofn5jDlq1gLfa9xygB5nw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587931;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ovNdFvN4j5VHctDx3kFirGTCyVStcoGTaw81WNU+GIg=;
	b=pIMZ450Q8G3PA2z1NcI4tVLXUgasoODFRlIb1Us493aFdfH80A2i9azg1mcxOU9K7e8o
	 CAGJs1pdiSi0Mv9bXUlGmufiCJD/G/frVEX4T513AVz+2vBLPCYmloaJJNU32H/LqLtxZ
	 2Ct4+FjnvS/nU3oZR9N1lq+1t1PEAFhJZVYnm/83jE/BM3SpolQ7JAhhYCCtYpNwpH1Fu
	 k14R6LrZiOU2Y7OYA1J/H1dUlE+TKW9QY2RqiajJDBBBMif4VXfvATIGhAFjFngZYHbfb
	 3x5Hses3u1xs15ObB1ePAI3U8IRqbmLdkqfSj5VYNsPi2KSpYRBU+bfWL+UZGYRRr7w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5E8031F000CE;
	Fri, 13 Nov 2026 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587931;
	bh=ovNdFvN4j5VHctDx3kFirGTCyVStcoGTaw81WNU+GIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AebHUpoooTPyzyHgqOlj0RVrQyeurOXkECAd4cT0KthQPRs/F7OR+bUZJJdugAI58
	 NflURMv+7gnWf7pU9BfjijmEy/TySlFEoThxZeK9SUB2I+T+DN0vPt0GNzRaF9WpLM
	 2UOYGrreQsYsrstGDY3pOipoCTmt16qneA7TY9GewfUq59c+YidtgOEZ22M0r2DSgF
	 gXKOmyJQkpdidaJn8yhGzIRMFRubJ80HHpUU6L+rkoCj1HiZgCiR9jO4VgnMuw3HaI
	 S8cUl0YURvZDtJMUGGKXAWyziVSyMXmSvFugSCVT70a1iZgUxANxzGywr0I9peb57u
	 nlpZCH7qe1EbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EACE2499AA;
	Fri, 13 Nov 2026 16:38:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:38:53 +0000
Subject: [PATCH 7/9] arm64: dts: rockchip: Add the clock and reset of the
 RK3588 PHP SMMU
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
Message-Id: <20261113-mmu600-php-v1-7-231196049a3b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587927; l=879;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=xABvrdkxSQnkm1+qfE0iALRBlyW42bCwAyaR90qxPhg=;
 b=xE5R4KcJTdTxZjvybb4lSfLzdvrVQIfHptR+aNxsE46yMNImwKhfOcGx3b+mmYtyw2cwWdFjG
 zQ5Cmhor3HVAPuiOA1+su84pTXGffMRbobChWmNaS3cbBZ6ZE0rcxbx
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Describe ACLK_MMU_PHP, so the SMMU keeps its clock while its masters
are idle, and SRST_A_MMU_PHP, as for the PCIe SMMU.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 8807ce6193bf..3bf8d0e4ff33 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -570,6 +570,8 @@ mmu600_php: iommu@fcb00000 {
 			     <GIC_SPI 386 IRQ_TYPE_EDGE_RISING 0>,
 			     <GIC_SPI 379 IRQ_TYPE_EDGE_RISING 0>;
 		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+		clocks = <&cru ACLK_MMU_PHP>;
+		resets = <&cru SRST_A_MMU_PHP>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};

-- 
2.55.0


