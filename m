From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Don't powerdown Compaq Triflex IDE device on suspend
Date: Wed, 12 Oct 2011 16:31:51 +0200
Message-ID: <201110121631.52099.bzolnier@gmail.com>
References: <alpine.DEB.2.00.1105152228530.12411@artax.karlin.mff.cuni.cz> <201110111856.05491.bzolnier@gmail.com> <20111011.150225.289373201920187790.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47912 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab1JLOij (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 10:38:39 -0400
Received: by eye27 with SMTP id 27so809970eye.19
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2011 07:38:38 -0700 (PDT)
In-Reply-To: <20111011.150225.289373201920187790.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: mikulas@artax.karlin.mff.cuni.cz, jgarzik@pobox.com, linux-ide@vger.kernel.org

David Miller wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Tue, 11 Oct 2011 18:56:05 +0200
> 
> > Mikulas Patocka wrote:
> > 
> >> Don't powerdown Compaq Triflex IDE device on suspend
> >> 
> >> This fixes APM suspend on Compaq Armada 7400.
> >> APM BIOS doesn't suspend if IDE is powered down when suspending.
> >> The Triflex controller is found only on old Compaq boards,
> >> so this patch will hopefully have no side effects.
> >> 
> >> This patch fixes a suspend regression introduced in 
> >> feb22b7f8e62b1b987a3a1dbad95af767a1df832
> >> 
> >> Signed-off-by: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
> > 
> > Reviewed-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > 
> > This patch is still valid for 3.1.  Dave, ping?
> 
> Feedback was given on this patch, and changes were requested.  The patch
> was never fixed up and resubmitted by the author:
> 
> 	http://patchwork.ozlabs.org/patch/95665/

Here is updated patch:

From:	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: [PATCH] IDE: Don't powerdown Compaq Triflex IDE device on suspend

Don't powerdown Compaq Triflex IDE device on suspend

This fixes APM suspend on Compaq Armada 7400.
APM BIOS doesn't suspend if IDE is powered down when suspending.
The Triflex controller is found only on old Compaq boards,
so this patch will hopefully have no side effects.

This patch fixes a suspend regression introduced in 
feb22b7f8e62b1b987a3a1dbad95af767a1df832 ("ide: add proper PCI PM
support (v2)").

Signed-off-by: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
[bart: add commit's summary in parens]
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/triflex.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Index: linux-2.6.39-rc7-fast/drivers/ide/triflex.c
===================================================================
--- linux-2.6.39-rc7-fast.orig/drivers/ide/triflex.c	2011-05-09 21:05:37.000000000 +0200
+++ linux-2.6.39-rc7-fast/drivers/ide/triflex.c	2011-05-15 14:06:14.000000000 +0200
@@ -113,12 +113,26 @@ static const struct pci_device_id trifle
 };
 MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
 
+#ifdef CONFIG_PM
+static int triflex_ide_pci_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	/*
+	 * We must not disable or powerdown the device.
+	 * APM bios refuses to suspend if IDE is not accessible.
+	 */
+	pci_save_state(dev);
+	return 0;
+}
+#else
+#define triflex_ide_pci_suspend NULL
+#endif
+
 static struct pci_driver triflex_pci_driver = {
 	.name		= "TRIFLEX_IDE",
 	.id_table	= triflex_pci_tbl,
 	.probe		= triflex_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
+	.suspend	= triflex_ide_pci_suspend,
 	.resume		= ide_pci_resume,
 };
 

