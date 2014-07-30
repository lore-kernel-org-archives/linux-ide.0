From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v13 5/8] ata: ahci_platform: add a generic AHCI compatible
Date: Wed, 30 Jul 2014 19:04:59 +0200
Message-ID: <1406739902-26311-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1406739902-26311-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406739902-26311-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The ahci_platform driver is a generic driver using the libahci_platform
functions. Add a generic compatible to avoid having an endless list of
compatibles with no differences for the same driver.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 drivers/ata/ahci_platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index fb3eca5cd66c..f61ddb9146d6 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -76,6 +76,8 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_s=
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
