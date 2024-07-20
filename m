Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23912C53D;
	Sat, 20 Jul 2024 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721509084; cv=none; b=stb54oj1zin55oHLUZ/RFxyRj8IVOnOc7F0M0yziy/jGoH1yU+NdAaUy2IDULg9oC+qjgPcn5U9AwrqgdetLBSVFN+I3w617W6w2xE9v2BlvusqxpjSe0uSUuPQLdP/GjSR3WshRIpX7xmPjOnUDO9PXDQjb+SeBG1ZNCb0H5UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721509084; c=relaxed/simple;
	bh=VZ5MeoNk9IkJ0VOIjaZuN+/zcboTsoiAjIO5pQRW+VU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u0WqUADA5J2XRzxigPE+SB5G2Pknugo1BEAcrwBcg+JTa/xpAvCN+ph2goN6WGo7D8rO5QxuB0e89dRii0EZYuVMAjyqSMMTo5hv36BqjA5bmgHo9+nfH1gd3+KPulLksWUjDjsh2xOFn6teD8Mx+ucDEL47i4zhWKMYZky5fUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVH9D-0005tv-2L; Sat, 20 Jul 2024 22:57:43 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sebastian.reichel@collabora.com,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u.kleine-koenig@baylibre.com
Subject: [PATCH] dt-bindings: ata: rockchip-dwc-ahci: add missing power-domains
Date: Sat, 20 Jul 2024 22:57:05 +0200
Message-Id: <20240720205705.776384-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip variant of the dwc-ahci controller does have and need power-
domains to work, though the binding does not mention them, making dtccheck
quite unhappy:

  DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dtb
/home/devel/hstuebner/00_git-repos/linux-rockchip/_build-arm64/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dtb: sata@fc800000: Unevaluated properties are not allowed ('power-domains' was unexpected)
        from schema $id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#

Fix that by adding the missing power-domain property to the binding.

Fixes: 85b0e13b19c2 ("dt-bindings: ata: dwc-ahci: add Rockchip RK3588")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
index b5e5767d86988..13eaa8d9a16e5 100644
--- a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
@@ -35,6 +35,9 @@ properties:
   ports-implemented:
     const: 1
 
+  power-domains:
+    maxItems: 1
+
   sata-port@0:
     $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
 
-- 
2.39.2

