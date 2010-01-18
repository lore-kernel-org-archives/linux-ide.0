From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 38/64] serverworks: add missing pci_dev_put() call
Date: Mon, 18 Jan 2010 18:19:30 +0100
Message-ID: <20100118171930.14623.11967.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755241Ab0ARRUr@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] serverworks: add missing pci_dev_put() call

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/serverworks.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/serverworks.c
===================================================================
--- a/drivers/ide/serverworks.c
+++ b/drivers/ide/serverworks.c
@@ -178,6 +178,7 @@ static int init_chipset_svwks(struct pci
 					"enabled.\n", pci_name(dev));
 			reg |=  0x00004000; /* enable UDMA/33 support */
 			pci_write_config_dword(isa_dev, 0x64, reg);
+			pci_dev_put(isa_dev);
 		}
 	}
 
