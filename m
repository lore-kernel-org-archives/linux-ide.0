Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3913C9A9;
	Sat,  9 Nov 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731145986; cv=none; b=pqkAjB6qoglEHzv0r2b5MJdo/x0KIFUFmFZxJyfc9QnTdk4tHKOQgtO2Yql8EbJU7HubCeBP/P5Ob4UDTzjb4WxzIBi0MHqThSxhMuBEU4ehHAifUB0Svbh6uUHBz1jXpXC4qs39OQ2Hv9tZ2uXGoLC0WImz0MFO4BkmzO4pqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731145986; c=relaxed/simple;
	bh=uetHf+iaauHsvvFyqaeBI8Pvow7MD+zXLMtwQwX88T8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ak+WD8hXaE8mE2jnurPBt2Wzd4vfgNymmQK5ETnmrXA8VP8eYcufqicXqBkegFtELQa6SCVzRTEH/pSW0sR7vNTd0fSLD5BmFcracqsZaS/RZjm35DIbPvaAOFaj0vDxkTy49bjWQifGdsFz1YwpRcab9a+NNT6NycBFv3dfB2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=AtfRjeoB; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="AtfRjeoB"
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout2.routing.net (Postfix) with ESMTP id CD35F5FBA0;
	Sat,  9 Nov 2024 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1731145600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dsnVBnJzrSx3yR3uTwKq3fiPk27Oe3tF24NPbK3S3f0=;
	b=AtfRjeoBXaxX0QVh6lNi7ebs5xVtIpkYALRoS7d9z2A4l0leJ+/RAQ5xT/2G5TjgtT9Var
	867U9y7JVUkUdm2TCe3S4PDV8IbbSqt/VgCg8QvpSyHgP3y8pBuZiz7NZVhlZXPjfjjXyX
	jm52nxek12xq5YkfaIVno+MkOVAWiYI=
Received: from frank-u24.. (fttx-pool-157.180.226.68.bambit.de [157.180.226.68])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id AE44840044;
	Sat,  9 Nov 2024 09:46:38 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/3] fix some binding check errors for marvell
Date: Sat,  9 Nov 2024 10:46:18 +0100
Message-ID: <20241109094623.37518-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 15871758-9287-4eb9-b486-392be61ec69a

From: Frank Wunderlich <frank-w@public-files.de>

Thies series fixes some Errors reported by dtbs_check. First part is taken
from my old series [1] where i converted sata-platform txt binding to yaml
because it wasn't picked up.

[1] https://lore.kernel.org/linux-arm-kernel/20220311210357.222830-1-linux@fw-web.de/

Frank Wunderlich (3):
  arm64: dts: marvell: Fix anyOf conditional failed
  arm64: dts: marvell: drop additional phy-names for sata
  dt-bindings: ata: ahci-platform: add missing iommus property

 Documentation/devicetree/bindings/ata/ahci-platform.yaml   | 3 +++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts             | 1 +
 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts       | 2 ++
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 1 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts             | 5 +++--
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi         | 3 +--
 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts    | 2 ++
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi              | 2 ++
 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts               | 1 +
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi                 | 1 +
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi                 | 1 +
 11 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.43.0

