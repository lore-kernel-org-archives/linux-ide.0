Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DA155342;
	Thu, 24 Apr 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520772; cv=pass; b=fJKlrKpLa6inaFGubCb8rshG/Cgagu9Et3JmpD6Aw8WDiMQAzGs2jICWg6MXHXvuk6f+AOiHRVYKyAFJYfV29TIbYY4Vcxl+383hiRiX77V3/t7nVW7cKjKuFQKtTuQTzhgP/2vC/d6W6qoFktqfFLZsYzNOd/jVOKxSzb9wzls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520772; c=relaxed/simple;
	bh=PMDn+0W79TXm1iF2Bo6a1Wf6lm/iCXOFkNwYtUERB3w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZvPoCLoR3H/yFp+10TWEqI5dYhj/Ecv+Cybebjt6rV6kxLvvSKU6nLcw5Ge/YVxDI70vw7zCQsRcjx9a4ncR6R+WmdJvXt/zB86sv6BqVRw++jPaR4CE/SupBvIE+6ZaUetgfOQ7Ze9aGY1H5eJGwrWR7HHsEBnFG9XYnNW578g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=AvPhEc7k; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="AvPhEc7k"
ARC-Seal: i=1; a=rsa-sha256; t=1745520751; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nj0gHv9l+M8l+v+HmXeshUTdo1OdA7CMnRQy54oxYs8WP/6cFvf2K5sDgdqnDKHn3+LvQHZRS5SxAmR5ho1QTNP6I+POHrXSxlBSTfKRGZVsC7pGQZ8Of1YZUY1pbWgRFAfDF/osjlw+R9hHqmGRL5Nh40KVL+KdGgB264fxqAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745520751; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5xbRlmm2bg6X6lzMBn4zN/H76kLu4hf67UQ/35KC2So=; 
	b=MLsWHL9WC67oOHJu5wW/CMK6rOFCACQsG40HRV5cQoWYkB2u72jKyfPZF1iYz44hRf3lzrufiNHBBtZmbMRzjQOm0GRLWKbs+GTx2Vr2DeLga8rWNVYGnq0qJo1toosEjA12mLMrkfcguPMjVwOygom5kMMjOuC1Df3hkKCC7po=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745520751;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=5xbRlmm2bg6X6lzMBn4zN/H76kLu4hf67UQ/35KC2So=;
	b=AvPhEc7kVOXGVuSOHUoz4AK4k4vbRTiT6gmVRMq+MbhWMdLT80f2wr5DrS3RSATa
	JdetpN8KgmYtg2LHGpALTEHvgYQTvj4u3OgwUCLGoRICJziKAIYAnJur/bKRdN2DGO2
	AL2iEUsSqL+sYfmyvhp4OYr4mExw72TZwECPZpwc=
Received: by mx.zohomail.com with SMTPS id 1745520750292268.9096442049322;
	Thu, 24 Apr 2025 11:52:30 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/2] RK3576 SATA Enablement
Date: Thu, 24 Apr 2025 20:52:21 +0200
Message-Id: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGWICmgC/yXMQQ7CIBCF4auQWTsGKGDsVUwXgKNOTFsdsDFpe
 neJXX4vef8KhYSpQK9WEFq48Dw1mIOC/IjTnZCvzWC19dpZh/Ls/ClgiTViMtoma8idY4D2eAn
 d+PuvXYbdQu9Pi9Z9hBQLYZ7HkWuvlnA0HiV3MGzbD5zvrIGKAAAA
X-Change-ID: 20250424-rk3576-sata-b102b21e49a6
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

This is a tiny series to enable SATA on RK3576. It consists of a patch
to add the compatible to the bindings, and a second patch to add the
nodes to the SoC .dtsi.

I've only been able to test sata0 on my board (Sige5), but the
successful test gave me confidence that downstream's "dma-coherent"
property here is appropriate and true.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (2):
      dt-bindings: ata: rockchip-dwc-ahci: add RK3576 compatible
      arm64: dts: rockchip: add SATA nodes to RK3576

 .../devicetree/bindings/ata/rockchip,dwc-ahci.yaml |  3 +++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 30 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)
---
base-commit: f34da179a4517854b2ffbe4bce8c3405bd9be04e
change-id: 20250424-rk3576-sata-b102b21e49a6

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

