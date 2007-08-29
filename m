From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/10] scc_pata: remove ->init_setup
Date: Wed, 29 Aug 2007 23:24:07 +0200
Message-ID: <200708292324.07903.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:44326 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542AbXH2VZW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 17:25:22 -0400
Received: by nf-out-0910.google.com with SMTP id g13so293495nfb
        for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:25:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/scc_pata.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -698,7 +698,6 @@ static void __devinit init_hwif_scc(ide_
 #define DECLARE_SCC_DEV(name_str)			\
   {							\
       .name		= name_str,			\
-      .init_setup	= init_setup_scc,		\
       .init_iops	= init_iops_scc,		\
       .init_hwif	= init_hwif_scc,		\
       .host_flags	= IDE_HFLAG_SINGLE |		\
@@ -722,7 +721,8 @@ static ide_pci_device_t scc_chipsets[] _
 static int __devinit scc_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	ide_pci_device_t *d = &scc_chipsets[id->driver_data];
-	return d->init_setup(dev, d);
+
+	return init_setup_scc(dev, d);
 }
 
 /**
