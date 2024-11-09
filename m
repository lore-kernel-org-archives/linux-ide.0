Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C6335C7;
	Sat,  9 Nov 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731145614; cv=none; b=e0PmP2g6NpGy2bWFdZw99WrBlslpqzTRlLNED7nui+5uubGzf6ySk6xoWgtIVgCiw2R91GzD4VLJU6ShEX/gPk71g9Ch21HZTODiMCOTHVbhxj8GbFvktQdGOSFJJxJORdPw82e2h/5XaLVSqJXhGFfp09PsjpsaS3yK/wLFvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731145614; c=relaxed/simple;
	bh=SpU7iGl59vK+c0XBjQ8IrxfQzZ2xsluU/D9OU9ogGiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGF2h8HT1E7CJGyajzJgLHGMK9v+gptZYNnJdNIpBQUYkK/oirLcPYq3TIaxKl3JllIsIYIKUOxoau+5y/RHcxAFITkU7y43cBIOImGcAa5VZvYIN5oqMpjY59lL4Zl1NGmH2Fgbm3wK5lUwNmGaeSIV0x06frNTLfw0EkJ7WZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=W3biGNog; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="W3biGNog"
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout4.routing.net (Postfix) with ESMTP id 76D5E100941;
	Sat,  9 Nov 2024 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1731145603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ekv8+GjqNv+Xg5rGbFE8IYBvUPz9b5og8Y0KA1yyQ+0=;
	b=W3biGNogm3aojbL/nk+Ur8qPuqlet+nybLy9JOpicoYqP38zbP7pIjKE+rX0617etp5t+0
	23VIK/9CHcbiLP4DjPFmwIFd3M0lcLB5JyX6KCk9q9Iadn7qKVLbzXhfnQJavMwBnAag5h
	0+fes4Q1xTFoxOAEbq9u8cZsUUmcnhs=
Received: from frank-u24.. (fttx-pool-157.180.226.68.bambit.de [157.180.226.68])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id AD46340044;
	Sat,  9 Nov 2024 09:46:42 +0000 (UTC)
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
Subject: [PATCH v1 2/3] arm64: dts: marvell: drop additional phy-names for sata
Date: Sat,  9 Nov 2024 10:46:20 +0100
Message-ID: <20241109094623.37518-3-linux@fw-web.de>
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
X-Mail-ID: 47633f1f-8324-4bc6-82ae-a21587be3939

From: Frank Wunderlich <frank-w@public-files.de>

Commit facbe7092f8a ("arm64: dts: marvell: Drop undocumented SATA phy names")
drops some phy-names from devicetrees but misses some. Drop them too.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
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

