Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4338DC0;
	Fri,  3 Jan 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735901049; cv=none; b=JuSiuCpjFCbFF9jmKLcKQyWqjojOjzPw5v5F1eqGiZcVrT/J0yBcyMEjAQZ+ZXwt9W9E6yQgLuPWhl1Kj+Lin04OcAOM31Qlm6+yIQ5zMx81b6Ze77l+QUPbEq7IIR6YdxrT8takatdAosZqZfiUl0GIv/4pwPXIg0e9HTWtX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735901049; c=relaxed/simple;
	bh=JlflqWKvyH51UJRKDs1nUNKMa3mkP3Du27RHeSn5F3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUoQyYi0f3Jcs8nHHle4n3nQVI9GpMq5kfqnkNfoBLKNGRg+7rSk87/fehWNn5/lOPHhkbcx3V9xIgCe3wZ/Qors2+mZj9S++88zPY+PZHeqHLtP2P+mg+2+4p/is80YeQfSiMK0Ol0L/2irPqqAcjcIAcSJhpdeXCFwmOlDV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=kIhfbjzP; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="kIhfbjzP"
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout2.routing.net (Postfix) with ESMTP id 731A15FC3D;
	Fri,  3 Jan 2025 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1735900651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z4idm+cfyn4XfuyNKu3rWDxtNAPG7GEtO7g+GVHM2dA=;
	b=kIhfbjzPN6xzaPFWJZwuwxbh0Vlzk72f1/Vjax9XTYpLy065IptH35c3KMEhra9ezp1duT
	kkHYT/gPnWJpvFZVUQaUFB8+DjjQjW9QMBV5BwJOlO4Tm2OJO8iYetOSmhbADFNjgZaxAS
	ZZT/HYKevK3myGsCsv8abop0Pxf8nMo=
Received: from frank-u24.. (fttx-pool-80.245.72.216.bambit.de [80.245.72.216])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 5385C8020A;
	Fri,  3 Jan 2025 10:37:30 +0000 (UTC)
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
Subject: [PATCH v2 0/2] fix some binding check errors for marvell
Date: Fri,  3 Jan 2025 11:37:20 +0100
Message-ID: <20250103103724.6223-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 729bca03-721c-4cdc-b611-1a6a3a5f3403

From: Frank Wunderlich <frank-w@public-files.de>

Thies series fixes some Errors reported by dtbs_check. First part is taken
from my old series [1] where i converted sata-platform txt binding to yaml
because it wasn't picked up.

[1] https://lore.kernel.org/linux-arm-kernel/20220311210357.222830-1-linux@fw-web.de/

I only try to fix the binding errors, i do not have any marvell board, so
cannot verify that my changes are correct. From my PoV peripheral
controllers should be disabled in the SoC DT and enabled in board DT.

Frank Wunderlich (2):
  arm64: dts: marvell: only enable complete sata nodes
  arm64: dts: marvell: drop additional phy-names for sata

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
 10 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.43.0

