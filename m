From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v4 7/7] ARM: berlin: enable the eSATA interface on the BG2Q DMP
Date: Tue, 20 May 2014 11:04:35 +0200
Message-ID: <1400576675-25265-8-git-send-email-antoine.tenart@free-electrons.com>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58355 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750699AbaETJEn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2014 05:04:43 -0400
In-Reply-To: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

The BG2Q has an AHCI SATA controller with an eSATA interface. Enable it=
=2E
Only enable the first port, the BG2Q DMP does not support the second on=
e.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot=
/dts/berlin2q-marvell-dmp.dts
index 2da9c41e29d8..899b4e04fe12 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -26,3 +26,11 @@
 &uart0 {
 	status =3D "okay";
 };
+
+&sata0 {
+	status =3D "okay";
+};
+
+&sata_phy {
+	status =3D "okay";
+};
--=20
1.9.1

