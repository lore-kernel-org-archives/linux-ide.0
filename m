Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5203187FE0;
	Fri,  3 Jan 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735901068; cv=none; b=tGIV7DqIuDIoDTAxrVwaj6BhB/13T7ovFiRyDUJDdZC2FTAoK2B/0fm5XSwLEjYLya3gjtpXzO2cNRP5/olezTiTznihQWXLAuaE0jEsbn5pRMRO60kd/1l3TYgiebdbcmjNuA87uMYc7hYVQU4ESlih+yYl/5quPpuL+uv5DVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735901068; c=relaxed/simple;
	bh=YHMNti+didoHgK68FhrbDg3mJKgl9PHm8/CyISacV2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7McMu7LBpQRiL3pUWbpUNxojlQA/HXezCL3/G84S5BmMP/RQNYNEj0MVxPKbZPv1BWrJjglcmEK6SJKwe7NuOpAWotvLhDwAYnhYVRZfVSkfuJTbjnoEvpDM96WRpFOzmQhNeW7iZZBWGkfVCPH7kZRwyydT3yNYhJxBNWuaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=eHzB+yui; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="eHzB+yui"
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout3.routing.net (Postfix) with ESMTP id 51691605A2;
	Fri,  3 Jan 2025 10:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1735900653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2iahX1buMzs5p03vC9Zh7kp9EyqKjlKiO/Ae93S060=;
	b=eHzB+yuiY9jr3y6dXPaAaDCDMM+2kVQQKJY44VZzx154UmOM6eQKF1ebC/7PntzMAvSL+8
	pG68WgWOMQWMPlPzEPz59OxrOxp6vfQJS5Yn294w7EnWxnFj6Wt6hh3ZZnDAEE98P4mNTj
	oSOnBuxOjVz84X3q7Ev6eu2gmmrnaRE=
Received: from frank-u24.. (fttx-pool-80.245.72.216.bambit.de [80.245.72.216])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 6474A8020A;
	Fri,  3 Jan 2025 10:37:32 +0000 (UTC)
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
Subject: [PATCH v2 2/2] arm64: dts: marvell: drop additional phy-names for sata
Date: Fri,  3 Jan 2025 11:37:22 +0100
Message-ID: <20250103103724.6223-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250103103724.6223-1-linux@fw-web.de>
References: <20250103103724.6223-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 36ba5333-1016-4fad-b8ef-f646e7a56354

From: Frank Wunderlich <frank-w@public-files.de>

Commit facbe7092f8a ("arm64: dts: marvell: Drop undocumented SATA phy names")
drops some phy-names from devicetrees but misses some. Drop them too.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 2 --
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index fe5d6cb9d692..9d45e881a97d 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -307,11 +307,9 @@ &cp1_sata0 {
 
 	sata-port@0 {
 		phys = <&cp1_comphy1 0>;
-		phy-names = "cp1-sata0-0-phy";
 	};
 	sata-port@1 {
 		phys = <&cp1_comphy3 1>;
-		phy-names = "cp1-sata0-1-phy";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index 5043cf2eb33e..0d4a5fd9503f 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -345,13 +345,11 @@ &cp1_sata0 {
 	/* CPS Lane 1 - U32 */
 	sata-port@0 {
 		phys = <&cp1_comphy1 0>;
-		phy-names = "cp1-sata0-0-phy";
 	};
 
 	/* CPS Lane 3 - U31 */
 	sata-port@1 {
 		phys = <&cp1_comphy3 1>;
-		phy-names = "cp1-sata0-1-phy";
 	};
 };
 
-- 
2.43.0

