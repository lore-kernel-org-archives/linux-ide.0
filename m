From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 05/50] ide: call ide_pci_setup_ports() before do_ide_setup_pci_device()
Date: Sun, 06 Jul 2008 19:20:15 +0200
Message-ID: <48710232.1ade660a.3458.6271@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:41596 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbYGFReq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:34:46 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309132gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:34:43 -0700 (PDT)
Content-Disposition: inline; filename=ide-call-ide_pci_setup_ports-before-do_ide_setup_pci_device.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Call ide_pci_setup_ports() before do_ide_setup_pci_device()
  in ide_setup_pci_device[s]().

While at it:

* Remove stale FIXMEs.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -533,14 +533,16 @@ int ide_setup_pci_device(struct pci_dev 
 	if (ret < 0)
 		goto out;
 
+	ide_pci_setup_ports(dev, d, 0, &hw[0], &hws[0]);
+
 	ret = do_ide_setup_pci_device(dev, d, 1);
+	if (ret < 0)
+		goto out;
 
-	if (ret >= 0) {
-		/* FIXME: silent failure can happen */
-		ide_pci_setup_ports(dev, d, ret, &hw[0], &hws[0]);
+	/* fixup IRQ */
+	hw[1].irq = hw[0].irq = ret;
 
-		ret = ide_host_add(d, hws, NULL);
-	}
+	ret = ide_host_add(d, hws, NULL);
 out:
 	return ret;
 }
@@ -558,6 +560,8 @@ int ide_setup_pci_devices(struct pci_dev
 		if (ret < 0)
 			goto out;
 
+		ide_pci_setup_ports(pdev[i], d, 0, &hw[i*2], &hws[i*2]);
+
 		ret = do_ide_setup_pci_device(pdev[i], d, !i);
 
 		/*
@@ -567,8 +571,8 @@ int ide_setup_pci_devices(struct pci_dev
 		if (ret < 0)
 			goto out;
 
-		/* FIXME: silent failure can happen */
-		ide_pci_setup_ports(pdev[i], d, ret, &hw[i*2], &hws[i*2]);
+		/* fixup IRQ */
+		hw[i*2 + 1].irq = hw[i*2].irq = ret;
 	}
 
 	ret = ide_host_add(d, hws, NULL);

-- 

