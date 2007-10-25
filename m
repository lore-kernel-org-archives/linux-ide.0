From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide: fix drive_is_ready() for non-PCI hosts and CONFIG_IDEPCI_SHARE_IRQ=y
Date: Fri, 26 Oct 2007 01:36:37 +0200
Message-ID: <200710260136.37333.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:2002 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758897AbXJYXdn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 19:33:43 -0400
Received: by nf-out-0910.google.com with SMTP id g13so631759nfb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 16:33:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Need to check if the host is a PCI one before reading IDE_ALTSTATUS_REG.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -455,7 +455,7 @@ int drive_is_ready (ide_drive_t *drive)
 	 * an interrupt with another pci card/device.  We make no assumptions
 	 * about possible isa-pnp and pci-pnp issues yet.
 	 */
-	if (IDE_CONTROL_REG)
+	if (hwif->pci_dev && IDE_CONTROL_REG)
 		stat = hwif->INB(IDE_ALTSTATUS_REG);
 	else
 #endif /* CONFIG_IDEPCI_SHARE_IRQ */
