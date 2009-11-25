From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 29/86] pata_cypress: document known issues
Date: Wed, 25 Nov 2009 18:05:46 +0100
Message-ID: <20091125170546.5446.7389.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:57397 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759271AbZKYRGY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:06:24 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cypress: document known issues

Document known issues with the driver to aid distribution makers,
users and developers in making informed decisions instead of wasting
their time needlessly.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -344,6 +344,9 @@ config PATA_CYPRESS
 	  This option enables support for the Cypress/Contaq CY82C693
 	  chipset found in some Alpha systems
 
+	  Known issues:
+	  - only the primary channel is currently supported
+
 	  If unsure, say N.
 
 config PATA_EFAR
