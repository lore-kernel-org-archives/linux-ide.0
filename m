From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v7 4/7] ata: ahci_platform: add a generic AHCI compatible
Date: Mon, 23 Jun 2014 15:39:40 +0200
Message-ID: <1403530783-17180-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The ahci_platform driver is a generic driver using the libahci_platform
functions. Add a generic compatible to avoid having an endless list of
compatibles with no differences for the same driver.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 drivers/ata/ahci_platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index ebe505c17763..a30cecd68609 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -78,6 +78,8 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_s=
uspend,
 			 ahci_platform_resume);
=20
 static const struct of_device_id ahci_of_match[] =3D {
+	{ .compatible =3D "generic-ahci", },
+	/* Keep the following compatibles for device tree compatibility */
 	{ .compatible =3D "snps,spear-ahci", },
 	{ .compatible =3D "snps,exynos5440-ahci", },
 	{ .compatible =3D "ibm,476gtr-ahci", },
--=20
1.9.1
