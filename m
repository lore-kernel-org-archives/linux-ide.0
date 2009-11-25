From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 62/86] pata_pdc202xx_old: document known issues
Date: Wed, 25 Nov 2009 18:09:48 +0100
Message-ID: <20091125170948.5446.32754.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934828AbZKYRSA@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_pdc202xx_old: document known issues

Document known issues with the driver to aid distribution makers,
users and developers in making informed decisions instead of wasting
their time needlessly.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -583,6 +583,10 @@ config PATA_PDC_OLD
 	  This option enables support for the Promise 20246, 20262, 20263,
 	  20265 and 20267 adapters.
 
+	  Known issues:
+	  - UDMA transfers fail mysteriously on some chipsets
+	  - ATAPI DMA is unsupported currently
+
 	  If unsure, say N.
 
 config PATA_QDI
