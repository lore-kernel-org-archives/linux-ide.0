From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] sis5513: add missing pci_enable_device() call
Date: Tue, 27 May 2008 22:15:24 +0200
Message-ID: <200805272215.24560.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:5569 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357AbYEZU2B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 May 2008 16:28:01 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1677724mue.1
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2008 13:28:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Riccardo Gori <goric@trivenet.it>

Cc: Riccardo Gori <goric@trivenet.it>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
thanks to Riccardo for an unintentional ;) inspiration

 drivers/ide/pci/sis5513.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -569,6 +569,11 @@ static int __devinit sis5513_init_one(st
 {
 	struct ide_port_info d = sis5513_chipset;
 	u8 udma_rates[] = { 0x00, 0x00, 0x07, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f };
+	int rc;
+
+	rc = pci_enable_device(dev);
+	if (rc)
+		return rc;
 
 	if (sis_find_family(dev) == 0)
 		return -ENOTSUPP;
