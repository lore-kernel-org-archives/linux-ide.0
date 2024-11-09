Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296014659B;
	Sat,  9 Nov 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731146365; cv=none; b=ThAIUeYQz1OpjDmIyOCSuz/C3i0vEKxgsOaPHAv0hK+Y3ConF9zYDqIi2pgbpYJvDJ2nsfYb6I2afztsu7jpYy0/XWHPY/eqv1tnhJzD9D6XjbL0/209N2JuNSrxWEJZQ71eqvSXWigp+FwgPnGXREO1ESlD6YNA9w5cMVQd+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731146365; c=relaxed/simple;
	bh=QM0rGeZev1aY6mPVHfhyo8r33NONqCG6KY1uIw6qRAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSA8kKvRraZ25FMVkY69ICkQzbfOplKr/8AFq1UEXCV1zjh3OpmtzT0s3DTdUtb0i6NI7pCtyddOog6vi4rUGNGxQ7tBHYKyDOB8R6tVwEfllcPnOQP0XmkF++C/MRdyCta41+pnRN+LPumPS+w67oqSt+lHBKf6aPsxqaHdKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=mZ0LCmRH; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="mZ0LCmRH"
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout3.routing.net (Postfix) with ESMTP id BC475605E7;
	Sat,  9 Nov 2024 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1731145602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZsa5iU2jR0G/7DFqX6cnFKBTeZjUb4uJ5OsX1Hv+wQ=;
	b=mZ0LCmRH1j/J0MjkR/OUeUHZYNigTLlz9cOOuA+B1MjNQHGV+P48NJQ92pwpXf2qDidGkG
	M/noflYlBTbEdiB67auhfrNMy3q6sC+icPPnJ8tIiu2TAD++XoeC7KghfCQ2hsP1tvgSl7
	TMiH4MnUcHVkA99hPbyvBUDz3Mot4jE=
Received: from frank-u24.. (fttx-pool-157.180.226.68.bambit.de [157.180.226.68])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id F10EC40229;
	Sat,  9 Nov 2024 09:46:41 +0000 (UTC)
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
Subject: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional failed
Date: Sat,  9 Nov 2024 10:46:19 +0100
Message-ID: <20241109094623.37518-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241109094623.37518-1-linux@fw-web.de>
References: <20241109094623.37518-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 71dd898d-dffd-468d-bd7c-742f3ca40e43

From: Frank Wunderlich <frank-w@public-files.de>

after converting the ahci-platform binding to yaml the following files
reporting "'anyOf' conditional failed" on

sata@540000: sata-port@0

armada-7040-db.dts
armada-8040-clearfog-gt-8k.dts
armada-8040-mcbin.dts
armada-8040-mcbin-singleshot.dts
cn9130-db.dts
cn9130-db-B.dts
cn9131-db.dts
cn9131-db-B.dts
cn9132-db.dts
cn9132-db-B.dts

the following files reporting 'anyOf' conditional failed on

sata@540000: sata-port@1

cn9132-db.dts
cn9132-db-B.dts
cn9130-crb-B.dts

'phys' is a required property
'target-supply' is a required property
From schema: Documentation/devicetree/bindings/ata/ahci-platform.yaml

This is caused by defining sata-ports incomplete in armada-cp11x.dtsi
and overriding only a subset of ports with the needed
phys/target-supply property.

Fix this by disabling the node-templates and enabling the needed nodes.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v7:
- rebase on mvebu/dt64
- drop fixes tag
i only try to fix binding-check errors.
as i cannot test it on hardware, please verify my changes are correct

there are still some there, but they should be fixed by someone having the hardware.

v5: add fixes-tag

the dtsi uses a macro for the node-label defined in armada-common.dtsi

CP11X_LABEL(sata0): sata@540000 {

so i hope i catched all right nodes to be enabled...
have enabled all cpX_sata0 sata-portY childs
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts             | 1 +
 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts       | 2 ++
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 1 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts             | 3 +++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi         | 1 +
 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts    | 2 ++
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi              | 2 ++
 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts               | 1 +
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi                 | 1 +
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi                 | 1 +
 10 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 1e0ab35cc686..2b5e45d2c5a6 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -214,6 +214,7 @@ &cp0_sata0 {
 
 	sata-port@1 {
 		phys = <&cp0_comphy3 1>;
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
index 7af949092b91..6bdc4f1e6939 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
@@ -433,11 +433,13 @@ &cp0_sata0 {
 	/* 7 + 12 SATA connector (J24) */
 	sata-port@0 {
 		phys = <&cp0_comphy2 0>;
+		status = "okay";
 	};
 
 	/* M.2-2250 B-key (J39) */
 	sata-port@1 {
 		phys = <&cp0_comphy3 1>;
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 7005a32a6e1e..225a54ab688d 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -475,6 +475,7 @@ &cp1_sata0 {
 
 	sata-port@1 {
 		phys = <&cp1_comphy0 1>;
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 2ec19d364e62..fe5d6cb9d692 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -145,9 +145,12 @@ &cp0_sata0 {
 
 	sata-port@0 {
 		phys = <&cp0_comphy1 0>;
+		status = "okay";
 	};
+
 	sata-port@1 {
 		phys = <&cp0_comphy3 1>;
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index e88ff5b179c8..5043cf2eb33e 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -245,6 +245,7 @@ &cp0_sata0 {
 	/* CPM Lane 5 - U29 */
 	sata-port@1 {
 		phys = <&cp0_comphy5 1>;
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
index 3e5e0651ce68..9c25a88581e4 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
@@ -408,10 +408,12 @@ &cp0_sata0 {
 
 	sata-port@0 {
 		phys = <&cp0_comphy2 0>;
+		status = "okay";
 	};
 
 	sata-port@1 {
 		phys = <&cp0_comphy5 1>;
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 7e595ac80043..161beec0b6b0 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -347,10 +347,12 @@ CP11X_LABEL(sata0): sata@540000 {
 
 			sata-port@0 {
 				reg = <0>;
+				status = "disabled";
 			};
 
 			sata-port@1 {
 				reg = <1>;
+				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts b/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
index 0904cb0309ae..34194745f79e 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
@@ -28,6 +28,7 @@ sata-port@0 {
 		status = "okay";
 		/* Generic PHY, providing serdes lanes */
 		phys = <&cp0_comphy2 0>;
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
index ad7360c83048..626042fce7e2 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
@@ -127,6 +127,7 @@ &cp1_sata0 {
 	sata-port@1 {
 		/* Generic PHY, providing serdes lanes */
 		phys = <&cp1_comphy5 1>;
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/cn9132-db.dtsi b/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
index e753cfdac697..f91fc69905b8 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
@@ -175,6 +175,7 @@ &cp2_sata0 {
 	sata-port@0 {
 		/* Generic PHY, providing serdes lanes */
 		phys = <&cp2_comphy2 0>;
+		status = "okay";
 	};
 };
 
-- 
2.43.0

