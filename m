Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587931;
	b=wr+2yTgk5KQlHhhbRcXlIzML6Bxl38MHk9MxbEtRkDx+7LwvPyq2tfwpRVLtrtRxLBGV
	 1k5toPq2q7Eguplh0AdxlWeV5Y9xYAJlleam8ulaDPjyXqSh/UZRR2mcokqvSXLwQDGl2
	 VeRbHDla9GdD1W5hpHogd8jQTZgX5hUKsUnN/uJYNb2CE9UVNSmm49a4z638hleRovV0b
	 tPNRwZLXxMV3M6RQQeaMTOut2BV2e9lM6BkXVBieWvIZzbDSokXXB5X+NZ+U4mb3qzN6e
	 1EZJUY8a6ZWce80vCmsPNU3Nyq43j8O/Qf6XZwiUui6001R3AD21lUGo1XaEUDyFJDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587931;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ElhyKJTPLC9sa0kKw8UjgPt6BJk/sHWMBZUKNWMIGmY=;
	b=KF/TOl63P/0iC4hIc/H1FMyOOKWImMmYSynaYBfO3KzhDY994kx21eISZFZ13bnFMMSh
	 ovp3jbvXWVQsUcVNw2WjK3nIUVZdkCjIECxb6hjKhAyvqbdpJBtVgCQj9HUBYyt3lWkec
	 aaBkTrNtWEZxjesGHPBJ5AZL6d+mX2U3FGa1dEsa8cBJhko/K6soAJrDbXrtlIBEToEv8
	 NikJZZXVsiACSCegvLERogRSMT0mOEYmfO2+P1EEiihbIl0BUeV8whuPJ5tLsQ4TLRX+g
	 G4NgWQEyHn5eqlzPIgCcaptHBCiM9xO7q4WI3B4Zv6mgInQrYrqSqCd4WOt6TS/6Jlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPzVMMHC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F04606A8BA;
	Fri, 13 Nov 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPzVMMHC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794587930;
	b=eCYk3kRts2hW0rqi5yY2hpCbcLTG5nvM096uMPAI9Ci3XgC0haaMYQ5eMK5R3Hi5xrX1
	 TnZA5uXxjrYC6v73dBryKGovSCAkj2QdVLOaLAZrAMTk77SIE9yF0YuUNz9kXT5m/czW9
	 +O7t2CWodgxLGBVxp2g8DGmvtrJY+pWFNu8iXAPiAGLZ0D86R0AqG1M9LJqZVm7GpvtKD
	 r0xxcR5FztZO3zZUOACcQXckCV8X0sm2exwCmLXpMaN8yX0yTxj6WHPbKdppJ+mntO7xW
	 ZEvOo1gQ7pVNbYghM7C6dCn5qsa7TvSaLWmuOvmkiqhQhszGl2mPLJ0SqtAzSh8EXcg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587930;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ElhyKJTPLC9sa0kKw8UjgPt6BJk/sHWMBZUKNWMIGmY=;
	b=u2vsrZeiTDfp4MBXxadgC9c6swTVf559ctO5UmpH6cepz/XxNKnnFP3kc6yYADt8hh7J
	 KN/gWe3KBvrFvQGRUVr4FPoqzbWyiTgDKSiV5Pn2Bi7BFCdwmykYzqa/KJMvQ/UcFFCu0
	 qK3g9Gr7j03WFE32gRgZX5wP25Q5M7nvgThCkmKmwf9reTYoZZiNWPGo8vJvZVWjq52z6
	 SKJ8mxSXCpqT3EbRBPXm6FJ2O7otGXJ7M6pJJW6qpUgyXzvDh2gf8NellZ4S9tQcNb8lV
	 JvCoeb3WEM25kNm1myaRhnFFbsuWlRJNjTkbqMkgHr24ewHxcOR0mkQMXfhydK9as8A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0D29F1F000C7;
	Fri, 13 Nov 2026 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587930;
	bh=ElhyKJTPLC9sa0kKw8UjgPt6BJk/sHWMBZUKNWMIGmY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cPzVMMHCyn+OFwhkw9aBWgxP3MJW3ucNQ66BKerP0uCRbp17X5SsigzIRb7P+o12E
	 0VfqfHb0et6Hy0XooG3qhN93pMse1dOxerVVBO4ObkRl31Oy5aYuTnw1dZyOeneYo/
	 Qe3/g1jTwEk+HPyDOGvyL43r8CmTbUiUplVI/goHU5uI8A5qBccbq+p12V0MRsPkE1
	 iWfjhONG45Uy6mDOfYkDaHagFH/p3YR/bCjwMVfplATrahGzzcJE3ENojwQMjsxPJh
	 O6rjTOI/4L2tPBW7o65813zDf+wAjBJEfYT0SQIY0tEHSkjXTTlDVVlvjUsUeW6gWJ
	 rt3r4wu9LB9hg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8CD6A4999A;
	Fri, 13 Nov 2026 16:38:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:38:49 +0000
Subject: [PATCH 3/9] dt-bindings: soc: rockchip: grf: Allow a clock for the
 RK3588 PHP GRF
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
Message-Id: <20261113-mmu600-php-v1-3-231196049a3b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587927; l=998;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=B5gD6Ma73MQyMzaxyEvJStUcX9v8sHv/gtVo98dAf/c=;
 b=YT0aXhYrbKWY8wlrkZK/hEcyepwr4yg+gW6WEGC5ZSfHukSI3V4Bwa9sgPmHU73BoKkP5Tvm5
 /1hLXK4TftNA5gYYm+6NtnDIiiU7hbtYOagZcGdymdVu2rJRlg28B67
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The RK3588 PHP GRF is clocked from pclk_php_root, which is gated when
no PHP peripheral holds it. Allow the clock, so the syscon regmap
enables it.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index e94c83d7c138..2525eb51f13b 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -321,8 +321,16 @@ allOf:
         - clocks
 
     else:
-      properties:
-        clocks: false
+      if:
+        not:
+          properties:
+            compatible:
+              contains:
+                const: rockchip,rk3588-php-grf
+
+      then:
+        properties:
+          clocks: false
 
 examples:
   - |

-- 
2.55.0


