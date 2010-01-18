From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 19/64] pata_serverworks: fix PIO setup for the second channel
Date: Mon, 18 Jan 2010 18:16:38 +0100
Message-ID: <20100118171638.14623.85773.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754857Ab0ARRR6@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_serverworks: fix PIO setup for the second channel

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_serverworks.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ata/pata_serverworks.c
===================================================================
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -1,6 +1,7 @@
 /*
  * pata_serverworks.c 	- Serverworks PATA for new ATA layer
  *			  (C) 2005 Red Hat Inc
+ *			  (C) 2010 Bartlomiej Zolnierkiewicz
  *
  * based upon
  *
@@ -232,7 +233,7 @@ static void serverworks_set_piomode(stru
 	if (serverworks_is_csb(pdev)) {
 		pci_read_config_word(pdev, 0x4A, &csb5_pio);
 		csb5_pio &= ~(0x0F << devbits);
-		pci_write_config_byte(pdev, 0x4A, csb5_pio | (pio << devbits));
+		pci_write_config_word(pdev, 0x4A, csb5_pio | (pio << devbits));
 	}
 }
 
