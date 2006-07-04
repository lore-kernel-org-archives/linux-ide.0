From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 21/24] ata_jmicro: Fix an escapee
Date: Tue, 4 Jul 2006 18:15:15 +0000 (UTC)
Message-ID: <11520361254139-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxo
 rguk.ukuu.org.uk> <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036122125!
 0-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361243147-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56206 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932314AbWGDSPD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:15:03 -0400
Date: Maw, 04 Gor 2006 19:01:45 +0100
In-Reply-To: <11520361243147-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

From: Alan Cox <alan@redhat.com>

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/ata_jmicron.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

4131a25c5ff7e00d9bd6f7e98c1c91b53e0346dc
diff --git a/drivers/scsi/ata_jmicron.c b/drivers/scsi/ata_jmicron.c
index b3136c8..f141ee7 100644
--- a/drivers/scsi/ata_jmicron.c
+++ b/drivers/scsi/ata_jmicron.c
@@ -19,7 +19,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"ata_jmicron"
-#define DRV_VERSION	"0.1"
+#define DRV_VERSION	"0.1.1"
 
 typedef enum {
 	PORT_PATA0 = 0,
@@ -259,7 +259,7 @@ module_init(jmicron_init);
 module_exit(jmicron_exit);
 
 MODULE_AUTHOR("Alan Cox");
-MODULE_DESCRIPTION("SCSI low-level driver for Netcell PATA RAID");
+MODULE_DESCRIPTION("SCSI low-level driver for Jmicron PATA ports");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, jmicron_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
-- 
1.2.GIT

