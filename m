From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ide: palm_bk3710: add __initdata to palm_bk3710_port_info
Date: Fri, 30 Dec 2016 14:50:02 +0530
Message-ID: <1483089602-6016-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, davem@davemloft.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-ide@vger.kernel.org

The object palm_bk3710_port_info of type ide_port_info is never
referenced anywhere after initialization by palm_bk3710_probe. It is
also passed as a parameter to ide_host_add which is called from the init
function but this call doesn't store the object reference anywhere, and
it only dereferences the values of the fields. Therefore add __initdata
to its declaration.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---

Compiled, but not tested

 drivers/ide/palm_bk3710.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
index 46427ea..157f2d1 100644
--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -300,7 +300,7 @@ static int palm_bk3710_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
 	.cable_detect		= palm_bk3710_cable_detect,
 };
 
-static struct ide_port_info palm_bk3710_port_info = {
+static struct ide_port_info palm_bk3710_port_info __initdata = {
 	.init_dma		= palm_bk3710_init_dma,
 	.port_ops		= &palm_bk3710_ports_ops,
 	.dma_ops		= &sff_dma_ops,
-- 
1.9.1
