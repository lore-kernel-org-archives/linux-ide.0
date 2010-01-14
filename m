From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide/ide-cs: fix order of releasing resources
Date: Thu, 14 Jan 2010 16:50:17 +0100
Message-ID: <201001141650.17348.bzolnier@gmail.com>
References: <1263324894-28117-1-git-send-email-w.sang@pengutronix.de> <20100114.015938.224705378.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:42661 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253Ab0ANRCX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 12:02:23 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so43871ewy.28
        for <linux-ide@vger.kernel.org>; Thu, 14 Jan 2010 09:02:20 -0800 (PST)
In-Reply-To: <20100114.015938.224705378.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: w.sang@pengutronix.de, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux@dominikbrodowski.net

On Thursday 14 January 2010 10:59:38 am David Miller wrote:
> From: Wolfram Sang <w.sang@pengutronix.de>
> Date: Tue, 12 Jan 2010 20:34:54 +0100
> 
> > ide_detach() called first ide_release() and then release_region(). This
> > produced the following warnings:
> > 
> >   Trying to free nonexistent resource <000000000000c10e-000000000000c10e>
> >   Trying to free nonexistent resource <000000000000c100-000000000000c107>
> > 
> > This is true, because the callchain inside ide_release() is:
> > 
> >   ide_release -> pcmcia_disable_device -> pcmcia_release_io
> > 
> > So, the whole io-block is already gone for release_region(). To fix
> > this, just swap the order of releasing (and remove the now obsolete
> > shadowing).
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> Applied, thanks a lot!

Port resources should not be freed before ide_host_remove() call in
ide_release() returns as port and/or devices may still be in use.

FWIW the following modified version of the patch is now in my atang tree:

From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] ide/ide-cs: fix order of releasing resources

ide_detach() called first ide_release() and then release_region(). This
produced the following warnings:

  Trying to free nonexistent resource <000000000000c10e-000000000000c10e>
  Trying to free nonexistent resource <000000000000c100-000000000000c107>

This is true, because the callchain inside ide_release() is:

  ide_release -> pcmcia_disable_device -> pcmcia_release_io

So, the whole io-block is already gone for release_region(). To fix
this, just swap the order of releasing (and remove the now obsolete
shadowing).

bzolnier:
- release resources in ide_release() to fix ordering of events
- remove stale FIXME note while at it

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cs.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-cs.c
===================================================================
--- a/drivers/ide/ide-cs.c
+++ b/drivers/ide/ide-cs.c
@@ -131,19 +131,11 @@ static int ide_probe(struct pcmcia_devic
 static void ide_detach(struct pcmcia_device *link)
 {
     ide_info_t *info = link->priv;
-    ide_hwif_t *hwif = info->host->ports[0];
-    unsigned long data_addr, ctl_addr;
 
     DEBUG(0, "ide_detach(0x%p)\n", link);
 
-    data_addr = hwif->io_ports.data_addr;
-    ctl_addr  = hwif->io_ports.ctl_addr;
-
     ide_release(link);
 
-    release_region(ctl_addr, 1);
-    release_region(data_addr, 8);
-
     kfree(info);
 } /* ide_detach */
 
@@ -365,12 +357,19 @@ static void ide_release(struct pcmcia_de
 
     DEBUG(0, "ide_release(0x%p)\n", link);
 
-    if (info->ndev)
-	/* FIXME: if this fails we need to queue the cleanup somehow
-	   -- need to investigate the required PCMCIA magic */
+    if (info->ndev) {
+	ide_hwif_t *hwif = host->ports[0];
+	unsigned long data_addr, ctl_addr;
+
+	data_addr = hwif->io_ports.data_addr;
+	ctl_addr = hwif->io_ports.ctl_addr;
+
 	ide_host_remove(host);
+	info->ndev = 0;
 
-    info->ndev = 0;
+	release_region(ctl_addr, 1);
+	release_region(data_addr, 8);
+    }
 
     pcmcia_disable_device(link);
 } /* ide_release */
