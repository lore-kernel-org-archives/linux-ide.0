From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 26/47] ata: remove bf54x driver
Date: Wed, 14 Mar 2018 16:35:39 +0100
Message-ID: <20180314153603.3127932-27-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The blackfin architecture is getting removed, so this driver
is obsolete as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/Kconfig      |    9 -
 drivers/ata/Makefile     |    1 -
 drivers/ata/pata_bf54x.c | 1703 ----------------------------------------------
 3 files changed, 1713 deletions(-)
 delete mode 100644 drivers/ata/pata_bf54x.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a7120d621154..4582fa27cf37 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -549,15 +549,6 @@ config PATA_ATP867X
 
 	  If unsure, say N.
 
-config PATA_BF54X
-	tristate "Blackfin 54x ATAPI support"
-	depends on BF542 || BF548 || BF549
-	help
-	  This option enables support for the built-in ATAPI controller on
-	  Blackfin 54x family chips.
-
-	  If unsure, say N.
-
 config PATA_BK3710
 	tristate "Palmchip BK3710 PATA support"
 	depends on ARCH_DAVINCI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index f1f5a3fbc777..6dae8c985e8e 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_PATA_AMD)		+= pata_amd.o
 obj-$(CONFIG_PATA_ARTOP)	+= pata_artop.o
 obj-$(CONFIG_PATA_ATIIXP)	+= pata_atiixp.o
 obj-$(CONFIG_PATA_ATP867X)	+= pata_atp867x.o
-obj-$(CONFIG_PATA_BF54X)	+= pata_bf54x.o
 obj-$(CONFIG_PATA_BK3710)	+= pata_bk3710.o
 obj-$(CONFIG_PATA_CMD64X)	+= pata_cmd64x.o
 obj-$(CONFIG_PATA_CS5520)	+= pata_cs5520.o
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
deleted file mode 100644
index 0e55a8da2748..000000000000
-- 
2.9.0
