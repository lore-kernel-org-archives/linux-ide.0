From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ide: icside: remove incorrect initconst annotation
Date: Mon,  8 Feb 2016 15:31:45 +0100
Message-ID: <1454941909-2778808-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The icside_probe function can be called for hotplugged devices, so
its reference to the __initconst icside_v6_port_info variable
may be invalid, as Kbuild points out:

WARNING: drivers/ide/icside.o(.text+0x338): Section mismatch in reference from the function icside_probe()
 to the (unknown reference) .init.rodata:(unknown)

Interestingly, this problem only shows up with clang but not
with gcc, which optimizes out the __initconst variable.

This removes the incorrect annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ide/icside.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
index 9f0a48e39b8a..80e933b296f6 100644
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -451,7 +451,7 @@ err_free:
 	return ret;
 }
 
-static const struct ide_port_info icside_v6_port_info __initconst = {
+static const struct ide_port_info icside_v6_port_info = {
 	.init_dma		= icside_dma_off_init,
 	.port_ops		= &icside_v6_no_dma_port_ops,
 	.host_flags		= IDE_HFLAG_SERIALIZE | IDE_HFLAG_MMIO,
-- 
2.7.0
