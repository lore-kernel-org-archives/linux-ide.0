Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587929;
	b=F7qA9NNeYPyiVTscZ05LROROzBnVd6NNPgdaT+4/IDXYhKiQlIhAXHMYacAqiKiZ/3fP
	 e9RFeVvzV7bow5ggea9oJgvIRwGfFNGdly9dcjyc55qXsIIp/sK1kwcz7xHSeICh6+SKb
	 5Mob+F5FvPx+jeeOXmLDNKZeTQXM6hTB6bg7kNg0cyHA6Hd5/l7Mx0jX+ltUWHUbYLtdJ
	 Bc68Taobu1JISZZmC0IP9FBkSfdfGo8mhlwVSLIjPbSErQN0rgN1G1R33x57MfipCFE/n
	 k76xUEW5x89HHy1m4KGL6/Z59OS7w6U9PfaAeczPMqJ55n6+bCyOlF8LWy8XyzY1b4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587929;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JZStwf7aG1NbM+HrgEyjyJ62lg+knGiytYOfDD7OyMo=;
	b=b/SK7CtzaiBZn3cA8sHrQ/Y4vAkrGh5wwNlwq1uEX64h/XleYrhfZ0LGXbJlcbTv/M/v
	 +2ME3NwjLNFWZfvQhNzWTrtJgzgImpaCNkeV+Xoj27dKSqt+pFlBno2vXF47e8oKXzUqM
	 JbGac/bHIoKymGuYsFYdrdOaomEUJRi/SjjZSwy+dIVhu3O55BiV+M+KU3rxUO2jr3iLb
	 KOUNW38c55bL2kYt1IS6DK/kCq1ptgb3jxND+oyIEhopjux9ri393ekZAz8zdofP+6BND
	 Zq3qWzvgCrpBDD7tfotojoZmbL4EVOwNv5XTIimS1yZsB3a3CFYyZqvkpCVXlLBHWPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeVlXPLZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1299606A323;
	Fri, 13 Nov 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeVlXPLZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794587929;
	b=tanR+BbgVToHeO9s9KF9j3cnQqBLg38aMiJXub/5Y6fps8/vr/WBOKwKDu3Lq8PCu3bz
	 dKukgsVyOyYgIpoXdFhq7IhnJDzPNpymb7eEn/FyOa+PmiESgOVlR5BptoTc3i8FOraeg
	 gz2sj6J7tXhe1AK171Uw7Ev3qC49HNLzJWZTv69G9PLMqAyk7j/IgmJqybm/k4ZHGNsLG
	 WFKy8cMEh7QqwLubjd2VN3d1reGStJmNDkODXT8OjncdHC1SZCLspE9/PWHE/JGurKskP
	 O2ahMdeWYOFXPTjF3717wpNzZNkIlHH9CUAxtACDSXwxEm8XtHL+4H+0wzSOQYNStNA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587929;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JZStwf7aG1NbM+HrgEyjyJ62lg+knGiytYOfDD7OyMo=;
	b=vH6x26k39ST6okgKU1Tn84TuA1bfpnw54dOoCurjA/pJeV47nM02RqEd9Nhc5KzKtyHt
	 ya9MpIAyV3MUXydeeNN6WHHdCg1bh/a/EcQu9W7HQZM1Hh+ZOdOVoyaobI64r9yAairww
	 eIq08UYS2lcf9Bs0U6ZcQ6R0wmCHCJCtbkbN1rDZjb1naVcP+8+Y6pMW6fIieWZs4kVKR
	 6vbTEb6idesWPHtRTzCBwhBiV8Cr8T7CQ3UqWcvxEOFcyRxWxcGz84459PwaS1xF/Cy9U
	 iyX7E7HBhDtKdBrObVG7jkDNkGpwmQ84G4otBEhWwNr9QASbH4jTf2kAJGbA+fWN0JA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D2BEB1F000C5;
	Fri, 13 Nov 2026 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587929;
	bh=JZStwf7aG1NbM+HrgEyjyJ62lg+knGiytYOfDD7OyMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TeVlXPLZGjke2P8Cg1gZz64jMIlrRgPn51XsWkZOC4v1rwIXARSEZtq+6AQ7d45Yx
	 EeRf8Srm9lYDsg2NS10NEXP4ZXSbGKExykmnvIveZ6q7DSXUr+1OINZz/hgLlWtMR1
	 93aDyRieHAHaB+yUP73bIZA1JqsYoOcWNOvYOAHAusZ2kM7EJ7hEOs4Vdn+FAIW0/Q
	 mmbIm4c1g5LPVizWEBujefyccMQIs1YV7aQYv8/3Dde2peRbL2yoLiHoW1OpwcZ8Ky
	 uSBxMa0TvQv2VwXDqIxchMqbt/yeNAX4FWoI9iRwmtKWn7adMDrfMmwyRTDVRga6+6
	 eMf54ouERlJPA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5E0294996B;
	Fri, 13 Nov 2026 16:38:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:38:47 +0000
Subject: [PATCH 1/9] dt-bindings: net: rockchip-dwmac: Allow iommus
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
Message-Id: <20261113-mmu600-php-v1-1-231196049a3b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587927; l=734;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=ioPYyqo2UgJ2ImvljVKX2vvvxEITz7+0OthqGBYY87E=;
 b=TA96yDOhwfB8bSu2g3uSq0VJeMWZ4VGI4GS22AkEHZlXTpubu6CU3Xq/uEqBfGYxrW7+Dh0xL
 Xqpelmu6JKPA8iGBmfb5Pao2lpIX4MnM3rKZ/0Hs6wU3xQ7pR0o0w29
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The RK3588 GMACs are behind the PHP SMMU. Allow iommus.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index e8dda1961ab3..2a0cd56fb4fe 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -87,6 +87,9 @@ properties:
 
   dma-coherent: true
 
+  iommus:
+    maxItems: 1
+
   clock_in_out:
     description:
       For RGMII, it must be "input", means main clock(125MHz)

-- 
2.55.0


