From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ata: highbank: Fix section mismatch
Date: Sat, 17 Nov 2012 15:54:38 +0400
Message-ID: <1353153278-23570-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:35430 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab2KQMBv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Nov 2012 07:01:51 -0500
Received: from smtp18.mail.ru (smtp18.mail.ru [94.100.176.155])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id 4D900D48559
	for <linux-ide@vger.kernel.org>; Sat, 17 Nov 2012 15:55:06 +0400 (MSK)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Alexander Shiyan <shc_work@mail.ru>

WARNING: drivers/built-in.o(.data+0x4f40): Section mismatch in reference from the variable ahci_highbank_driver to the function .init.text:ahci_highbank_probe()
The variable ahci_highbank_driver references
the function __init ahci_highbank_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/ata/sata_highbank.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 0d7c4c2..36a141a 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -260,7 +260,7 @@ static const struct of_device_id ahci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
 
-static int __init ahci_highbank_probe(struct platform_device *pdev)
+static int __devinit ahci_highbank_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-- 
1.7.8.6

