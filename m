From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 13/17] ide: mark const init data with __initconst instead of __initdata
Date: Thu, 29 Mar 2012 23:12:30 +0200
Message-ID: <1333055554-31300-13-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120329211131.GA31250@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33793 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933860Ab2C2VM5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Mar 2012 17:12:57 -0400
In-Reply-To: <20120329211131.GA31250@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: kernel@pengutronix.de, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

As long as there is no other non-const variable marked __initdata in th=
e
same compilation unit it doesn't hurt. If there were one however
compilation would fail with

	error: $variablename causes a section type conflict

because a section containing const variables is marked read only and so
cannot contain non-const variables.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
---
 drivers/ide/ali14xx.c   |    4 ++--
 drivers/ide/cmd640.c    |    2 +-
 drivers/ide/dtc2278.c   |    2 +-
 drivers/ide/ht6560b.c   |    2 +-
 drivers/ide/icside.c    |    2 +-
 drivers/ide/qd65xx.c    |    2 +-
 drivers/ide/tx4938ide.c |    2 +-
 drivers/ide/tx4939ide.c |    2 +-
 drivers/ide/umc8672.c   |    2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ide/ali14xx.c b/drivers/ide/ali14xx.c
index d3be99f..8f3570e 100644
--- a/drivers/ide/ali14xx.c
+++ b/drivers/ide/ali14xx.c
@@ -52,13 +52,13 @@
=20
 /* port addresses for auto-detection */
 #define ALI_NUM_PORTS 4
-static const int ports[ALI_NUM_PORTS] __initdata =3D
+static const int ports[ALI_NUM_PORTS] __initconst =3D
 	{ 0x074, 0x0f4, 0x034, 0x0e4 };
=20
 /* register initialization data */
 typedef struct { u8 reg, data; } RegInitializer;
=20
-static const RegInitializer initData[] __initdata =3D {
+static const RegInitializer initData[] __initconst =3D {
 	{0x01, 0x0f}, {0x02, 0x00}, {0x03, 0x00}, {0x04, 0x00},
 	{0x05, 0x00}, {0x06, 0x00}, {0x07, 0x2b}, {0x0a, 0x0f},
 	{0x25, 0x00}, {0x26, 0x00}, {0x27, 0x00}, {0x28, 0x00},
diff --git a/drivers/ide/cmd640.c b/drivers/ide/cmd640.c
index 1471730..70f0a27 100644
--- a/drivers/ide/cmd640.c
+++ b/drivers/ide/cmd640.c
@@ -685,7 +685,7 @@ static int pci_conf2(void)
 	return 0;
 }
=20
-static const struct ide_port_info cmd640_port_info __initdata =3D {
+static const struct ide_port_info cmd640_port_info __initconst =3D {
 	.chipset		=3D ide_cmd640,
 	.host_flags		=3D IDE_HFLAG_SERIALIZE |
 				  IDE_HFLAG_NO_DMA |
diff --git a/drivers/ide/dtc2278.c b/drivers/ide/dtc2278.c
index 46af474..8722df3 100644
--- a/drivers/ide/dtc2278.c
+++ b/drivers/ide/dtc2278.c
@@ -91,7 +91,7 @@ static const struct ide_port_ops dtc2278_port_ops =3D=
 {
 	.set_pio_mode		=3D dtc2278_set_pio_mode,
 };
=20
-static const struct ide_port_info dtc2278_port_info __initdata =3D {
+static const struct ide_port_info dtc2278_port_info __initconst =3D {
 	.name			=3D DRV_NAME,
 	.chipset		=3D ide_dtc2278,
 	.port_ops		=3D &dtc2278_port_ops,
diff --git a/drivers/ide/ht6560b.c b/drivers/ide/ht6560b.c
index 986f251..1e0fd3a 100644
--- a/drivers/ide/ht6560b.c
+++ b/drivers/ide/ht6560b.c
@@ -341,7 +341,7 @@ static const struct ide_port_ops ht6560b_port_ops =3D=
 {
 	.set_pio_mode		=3D ht6560b_set_pio_mode,
 };
=20
-static const struct ide_port_info ht6560b_port_info __initdata =3D {
+static const struct ide_port_info ht6560b_port_info __initconst =3D {
 	.name			=3D DRV_NAME,
 	.chipset		=3D ide_ht6560b,
 	.tp_ops 		=3D &ht6560b_tp_ops,
diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
index 8716066..7e9e1c1 100644
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -453,7 +453,7 @@ err_free:
 	return ret;
 }
=20
-static const struct ide_port_info icside_v6_port_info __initdata =3D {
+static const struct ide_port_info icside_v6_port_info __initconst =3D =
{
 	.init_dma		=3D icside_dma_off_init,
 	.port_ops		=3D &icside_v6_no_dma_port_ops,
 	.dma_ops		=3D &icside_v6_dma_ops,
diff --git a/drivers/ide/qd65xx.c b/drivers/ide/qd65xx.c
index e03f4f1..a6fb6a8 100644
--- a/drivers/ide/qd65xx.c
+++ b/drivers/ide/qd65xx.c
@@ -335,7 +335,7 @@ static const struct ide_port_ops qd6580_port_ops =3D=
 {
 	.set_pio_mode		=3D qd6580_set_pio_mode,
 };
=20
-static const struct ide_port_info qd65xx_port_info __initdata =3D {
+static const struct ide_port_info qd65xx_port_info __initconst =3D {
 	.name			=3D DRV_NAME,
 	.tp_ops 		=3D &qd65xx_tp_ops,
 	.chipset		=3D ide_qd65xx,
diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index 7002765..91d49dd 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -117,7 +117,7 @@ static const struct ide_port_ops tx4938ide_port_ops=
 =3D {
 	.set_pio_mode		=3D tx4938ide_set_pio_mode,
 };
=20
-static const struct ide_port_info tx4938ide_port_info __initdata =3D {
+static const struct ide_port_info tx4938ide_port_info __initconst =3D =
{
 	.port_ops		=3D &tx4938ide_port_ops,
 #ifdef __BIG_ENDIAN
 	.tp_ops			=3D &tx4938ide_tp_ops,
diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index 71c2319..c0ab800 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -522,7 +522,7 @@ static const struct ide_dma_ops tx4939ide_dma_ops =3D=
 {
 	.dma_sff_read_status	=3D tx4939ide_dma_sff_read_status,
 };
=20
-static const struct ide_port_info tx4939ide_port_info __initdata =3D {
+static const struct ide_port_info tx4939ide_port_info __initconst =3D =
{
 	.init_hwif		=3D tx4939ide_init_hwif,
 	.init_dma		=3D tx4939ide_init_dma,
 	.port_ops		=3D &tx4939ide_port_ops,
diff --git a/drivers/ide/umc8672.c b/drivers/ide/umc8672.c
index 5cfb781..3aa0fea 100644
--- a/drivers/ide/umc8672.c
+++ b/drivers/ide/umc8672.c
@@ -128,7 +128,7 @@ static const struct ide_port_ops umc8672_port_ops =3D=
 {
 	.set_pio_mode		=3D umc_set_pio_mode,
 };
=20
-static const struct ide_port_info umc8672_port_info __initdata =3D {
+static const struct ide_port_info umc8672_port_info __initconst =3D {
 	.name			=3D DRV_NAME,
 	.chipset		=3D ide_umc8672,
 	.port_ops		=3D &umc8672_port_ops,
--=20
1.7.9.1

