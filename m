Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8828F948;
	Thu, 24 Apr 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520776; cv=pass; b=dROdGmfyDONqdY0Xoe0VCKpHurskNJfyFiofGrDBPVEm0WpgsKgLH3J8Iy7RFzUUb/gKz3hAKUzPyohj1CaUWgKW0UOlhZZl7zBj76Eq1LK7ZT3IIqVt4WvXs7k3fS34Mkyx1KlWEth3jtDGBaRLVCsRZqfSBPF0zoZDcuAhsr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520776; c=relaxed/simple;
	bh=6Zc78zHIMKK8i7thc6IFhgarhhDCdigbEYX1I5OKnl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPvFD6+GWlTu0ODZvWSY4/EfN9CYvW7M/6MH3QxCNesqsike+Mzu3cqTIOFkbQ9ht3UWPlZYN2TCRQyvKGXp5tNm+gFd8ZpZH7JZYs0KjEdv6eRx7BPuMDmM96C9ATJyCvF5BBPYXknldbd9sROvXyDx02ZMlvqExVg/VmVXrAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=PrHLdNKR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PrHLdNKR"
ARC-Seal: i=1; a=rsa-sha256; t=1745520755; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NCamvSjAd1TPlup5KpNJxV8L6yt2XPpYm5bOijTs3biV1cZ5KQ5X8gKkBZkEZmiT7Mzbvp3Kx99eawUPTeSH7ySrWkULwNtcTVPlA6ZLibQ4/xFF+oPtL13/l4mvB5fUNO21+1IFYHlKb+OtfMVDN05CUCX61MKVpXkqBP5SIAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745520755; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nSm85WrOXXd0xYU8c9OOo0pnjRflgeYS11s36aD5s1U=; 
	b=SP6u549Lk0DjrwCyDxdRdS9/fq3dcb2jM53xq5Ww0HB0ACnjwJwG5X/frK8EkoRUTbSY1K9MdrwHTntLPh6sJtrzb0kVFb4biT66vkg01ozAEGOgq+kkKNjVaEe+etb9oftG202XdsbJ07l7bIdTXElzmbPqUxEJkMKgGrDT2IE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745520755;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=nSm85WrOXXd0xYU8c9OOo0pnjRflgeYS11s36aD5s1U=;
	b=PrHLdNKRkF34UzA3HCrdw+tWQGyujwnbX2l+zKOurm+FTHamBoK7V/xKh95oUDwq
	PWCqW++EPaXaSFsDhGoibTNJmezCPWlF9wfyVElc3U+o5PdPBUSlXiQe4iDLNrUUDSj
	3aFmKHDoTBMxtteG1sCw2E1KczTDxEU42V8N7DZY=
Received: by mx.zohomail.com with SMTPS id 1745520753589285.7033388625773;
	Thu, 24 Apr 2025 11:52:33 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 24 Apr 2025 20:52:22 +0200
Subject: [PATCH 1/2] dt-bindings: ata: rockchip-dwc-ahci: add RK3576
 compatible
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-rk3576-sata-v1-1-23ee89c939fe@collabora.com>
References: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
In-Reply-To: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The Rockchip RK3576 has two SATA controllers. They work the same as the
RK3568 SATA controllers, having the same number of clocks and ports.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
index 13eaa8d9a16e5a4bd43b3e184f9277494acf27a1..b5ecaabfe2e2537afe6093558fb0ab975dcf6058 100644
--- a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
@@ -20,6 +20,7 @@ select:
       contains:
         enum:
           - rockchip,rk3568-dwc-ahci
+          - rockchip,rk3576-dwc-ahci
           - rockchip,rk3588-dwc-ahci
   required:
     - compatible
@@ -29,6 +30,7 @@ properties:
     items:
       - enum:
           - rockchip,rk3568-dwc-ahci
+          - rockchip,rk3576-dwc-ahci
           - rockchip,rk3588-dwc-ahci
       - const: snps,dwc-ahci
 
@@ -83,6 +85,7 @@ allOf:
           contains:
             enum:
               - rockchip,rk3568-dwc-ahci
+              - rockchip,rk3576-dwc-ahci
     then:
       properties:
         clocks:

-- 
2.49.0

