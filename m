From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/10] ide: remove unused ->next field from ide_pci_device_t
Date: Tue, 11 Sep 2007 23:38:58 +0200
Message-ID: <200709112338.58397.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:27488 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036AbXIKVkW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:22 -0400
Received: by ug-out-1314.google.com with SMTP id z38so138060ugc
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    1 -
 1 file changed, 1 deletion(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1283,7 +1283,6 @@ typedef struct ide_pci_device_s {
 	void			(*fixup)(ide_hwif_t *);
 	ide_pci_enablebit_t	enablebits[2];
 	unsigned int		extra;
-	struct ide_pci_device_s	*next;
 	u32			host_flags;
 	u8			pio_mask;
 	u8			swdma_mask;
