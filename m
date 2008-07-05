From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [regression] Re: 2.6.26-rc6: pcmcia stopped working
Date: Sat, 5 Jul 2008 14:48:40 +0200
Message-ID: <200807051448.40466.bzolnier@gmail.com>
References: <20080622224022.GA2066@elf.ucw.cz> <20080625220946.GA1587@elf.ucw.cz> <20080625221529.GA1600@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:52769 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbYGEMvH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jul 2008 08:51:07 -0400
Received: by mu-out-0910.google.com with SMTP id w8so446449mue.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2008 05:51:04 -0700 (PDT)
In-Reply-To: <20080625221529.GA1600@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org, Greg KH <greg@kroah.com>


Hi,

On Thursday 26 June 2008, Pavel Machek wrote:
> Hi!
> 
> > > Hmm, hitting sysrq-w produces no blocked task until I eject pcmcia
> > > card. Backtrace there is:
> > > 
> > > Greg, I believe some traces lead to sysfs, can you help here?
> > 
> > ide_unregister() does not complete :-(.
> > 
> >         device_unregister(&hwif->gendev);
> > +       printk("ide_unregister: waiting for rel_comp\n");
> >         wait_for_completion(&hwif->gendev_rel_comp);
> > 
> > ...that wait_for_completion never returns.

[...]

Thanks for narrowing it down to wait_for_completion() call,
it was an useful hint.

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix hwif->gendev refcounting

class->dev_release is called by device_release() iff dev->release
is not present so ide_port_class_release() is never called and the
last hwif->gendev reference is not dropped.

Fix it by removing ide_port_class_release() and get_device() call
from ide_register_port() (device_create_drvdata() takes a hwif->gendev
reference anyway).

This patch fixes hang on wait_for_completion(&hwif->gendev_rel_comp)
in ide_unregister() reported by Pavel Machek.

Cc: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    2 --
 drivers/ide/ide.c       |    8 --------
 2 files changed, 10 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -646,8 +646,6 @@ static int ide_register_port(ide_hwif_t 
 		goto out;
 	}
 
-	get_device(&hwif->gendev);
-
 	hwif->portdev = device_create_drvdata(ide_port_class, &hwif->gendev,
 					      MKDEV(0, 0), hwif, hwif->name);
 	if (IS_ERR(hwif->portdev)) {
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1094,13 +1094,6 @@ struct bus_type ide_bus_type = {
 
 EXPORT_SYMBOL_GPL(ide_bus_type);
 
-static void ide_port_class_release(struct device *portdev)
-{
-	ide_hwif_t *hwif = dev_get_drvdata(portdev);
-
-	put_device(&hwif->gendev);
-}
-
 int ide_vlb_clk;
 EXPORT_SYMBOL_GPL(ide_vlb_clk);
 
@@ -1305,7 +1298,6 @@ static int __init ide_init(void)
 		ret = PTR_ERR(ide_port_class);
 		goto out_port_class;
 	}
-	ide_port_class->dev_release = ide_port_class_release;
 
 	init_ide_data();
 
