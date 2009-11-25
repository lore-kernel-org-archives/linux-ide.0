From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 19/86] pata_cmd640: document known issues
Date: Wed, 25 Nov 2009 18:04:36 +0100
Message-ID: <20091125170436.5446.83994.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759207AbZKYRFc@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cmd640: document known issues

Document known issues with the driver to aid distribution makers,
users and developers in making informed decisions instead of wasting
their time needlessly.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/Kconfig |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -287,8 +287,11 @@ config PATA_CMD640_PCI
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the CMD640 PCI IDE
-	  interface chip. Only the primary channel is currently
-	  supported.
+	  interface chip.
+
+	  Known issues:
+	  - only the primary channel is currently supported
+	  - only the PCI chip interface is currently supported
 
 	  If unsure, say N.
 
