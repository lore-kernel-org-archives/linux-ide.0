Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587930;
	b=cEDAxnggyg3BZRWkL+cj6v+uUFdxl7qLvcBOkqtGA0bZqsqxIbpQTa0jU+Orn+mkdiY4
	 AJrYyW7OL1MxiAvvE/ncb/NZxqy4fAODSTMd1bigNNTCqIW1q/YIiAfyiMcnssA9gFBbL
	 2zFkDIAoHgGmFU9bYDOW02Ij6zpIT0FD8U0vE5glvkHuWSy45w5LAY8uLicKL/Cr7ltaT
	 Itr4xzCuQJY8XbF1Yl5Goa+dVHyXw926zKo2P38O8m1Z1utiSLIL6XfvCSjOov/e8kLrN
	 +mdSOriH/fYkcx35rRLA+lDIEdQ34z+mFYRWgWzKYV4Hq1WTc5AwhwRMVFOLONEm2UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587930;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sMSQ+avg+iqG/IQkttcCunKx1tc/rZHgiCheJcioyCQ=;
	b=iUzZRSs6mVJwp/Zd0ztQrEe8NitHAB0Uf61lQJMvVEPETMiIGC8oJr2Jx+UFI8CSjhtk
	 QFgQvkvNxDejSY6iliczeYlH/ynjLR/5um/S39fM+TuxeAuVvaoa/JukVrXTSgavdkSeE
	 i+/hICUKiUgUHTdhfkGEjK9Z+EgvA+fO7SbiRvG9SmKJW5N/YHSxPgWyn/TyS405K1ZK5
	 oLWMeH3k88HMWPfX0r3l8piXAKE1WSRA1NsZgLFlMXnPOjt+UCK3ELqWUPURPSKAUPVWc
	 gCFkdkd0xoHDQN37oWS/52UBGs5bMaRHAeeHL0WHJC5TtTbdCOggsqZC5SUJmaAMrsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkXsh9bZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A43606A33E;
	Fri, 13 Nov 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkXsh9bZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794587930;
	b=BXFvbf5uDGqNmWTVEps7Z8GHnyTRgnWtRh9DLhvT+VrYC9jasEPWOsSaul2Jh1l3ftOV
	 YuFPypGtMNQxpJRiKbSO2gAmYgpHEGaghj7ZYQB1J1I9IvyNFI9wE8uLTWptCG7OVbQ+O
	 myMDKe9E+7L6RSZtekKmrmRAhCr5Np7lEi/9o47AKAsxIDIteljFDDV36ACEQm06NYAZ4
	 aZlaNhxDP8aRtd52gqcLsk6F9zUp2oxskU/QKmRsmi3pmfATNaJxZW/+bKNqPVZr0GXpy
	 CwNICwJ/UDSLMYXuVXk8Mvr8FMVMmjA+f2Ahpwlq7I8v48e5OEsU5qsJwc3FMPrZcnA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587930;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sMSQ+avg+iqG/IQkttcCunKx1tc/rZHgiCheJcioyCQ=;
	b=DMNN18EFcn1Sj3ORchYzYT6+l8L9ZPSfHyk/MUJ4hlAHyNkHa7cR56WPbfTN7VduqZk8
	 qOX7rScliWOEpFCxpcy8GXUNCvGbdplxHQzhZXHTEAS6//rAPxV01XrE6mcPx2x1jsCA/
	 xvEqveKSVew4hDAKFZ0yfrOPLi59wnyiek+nS0twM7DDbeRscch9vWwxEYOnJ9Q9tB68L
	 AZwjWpIzNlHjYNrlfRTSRUgl8bnFrDoxaInY4HmfhV5PEADHIMvBg5CcNIg3tXFG8ufcS
	 f34WKNbKGE9l+Ya6fgyIy6bl5FvmEezrsRgpYX62uKFh4pxqUAKt+NVu4+maD9vxLhg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E5F781F000C6;
	Fri, 13 Nov 2026 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587930;
	bh=sMSQ+avg+iqG/IQkttcCunKx1tc/rZHgiCheJcioyCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EkXsh9bZDseRe9miJMAbztnsJErnPjuvTS7FVcixPr8rygs6RuTFAvP2yuddFdpFF
	 Qfd3fXmcIUz+h0e0aZMfIpxtUiWaS0x+F313bW8X2Fn+KAxE6Bs9StExEMorzKGeDo
	 IcsIW4IlNQ5NatojYDWa40/614WkiWvwruFTkKDKH9D/Weflt8PKNYXcqjLsmq4R1U
	 FMPtZxTSg8O6AqCbcunnnlmoN8g9P0YR34RcA6I5UGP7IVI7JQH6l+L91Bx3jugrpl
	 a1kisrweRNM5cwwi0ByfLU0jayJv+zKN3LbsRdgebqhXAY3d2w+uXZUJb9URKgximy
	 eJVMSDtULXgVw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 72D1E49996;
	Fri, 13 Nov 2026 16:38:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:38:48 +0000
Subject: [PATCH 2/9] dt-bindings: ata: rockchip,dwc-ahci: Allow iommus
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
Message-Id: <20261113-mmu600-php-v1-2-231196049a3b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587927; l=768;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=isSOzqim4au9wHe7ayRhl/SLN2i9x9Bd32HMuVeTIQM=;
 b=f6Y3AcMeSBLf/zykfhiJs5LybaevPurozLoFXlFNqhejoU33A3G1MjYQNWi1Mb5O1U8Ymvg19
 B/YuuGiVKViCq0yib6lm2auaQC3rhJ4p7/Hv04UMNTk54hvSQsIEhip
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The RK3588 SATA controllers are behind the PHP SMMU. Allow iommus, as
snps,dwc-ahci does.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
index b5ecaabfe2e2..e33e8b5591ee 100644
--- a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
@@ -34,6 +34,9 @@ properties:
           - rockchip,rk3588-dwc-ahci
       - const: snps,dwc-ahci
 
+  iommus:
+    maxItems: 1
+
   ports-implemented:
     const: 1
 

-- 
2.55.0


