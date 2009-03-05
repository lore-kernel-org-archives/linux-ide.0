From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ide: allow to wrap interrupt handler
Date: Thu, 5 Mar 2009 14:48:15 +0100
Message-ID: <200903051448.16002.bzolnier@gmail.com>
References: <200902031146.59602.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:49675 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbZCEOty (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 09:49:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so390290fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2009 06:49:51 -0800 (PST)
In-Reply-To: <200902031146.59602.stf_xl@wp.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

On Tuesday 03 February 2009, Stanislaw Gruszka wrote:
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

BTW Please remember to check patches with scripts/checkpatch.pl:

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#22: FILE: drivers/ide/ide-io.c:1166:
+EXPORT_SYMBOL_GPL(ide_intr);

[2/3 also has a few "WARNING: line over 80 characters" ones...]

Thus the applied version looks a bit different:

From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH 1/3] ide: allow to wrap interrupt handler

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>
[bart: minor checkpatch.pl / CodingStyle fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c    |    1 +
 drivers/ide/ide-probe.c |    7 ++++++-
 include/linux/ide.h     |    1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1162,6 +1162,7 @@ out_early:
 
 	return irq_ret;
 }
+EXPORT_SYMBOL_GPL(ide_intr);
 
 /**
  *	ide_do_drive_cmd	-	issue IDE special command
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -950,6 +950,7 @@ static int ide_port_setup_devices(ide_hw
 static int init_irq (ide_hwif_t *hwif)
 {
 	struct ide_io_ports *io_ports = &hwif->io_ports;
+	irq_handler_t irq_handler;
 	int sa = 0;
 
 	mutex_lock(&ide_cfg_mtx);
@@ -959,6 +960,10 @@ static int init_irq (ide_hwif_t *hwif)
 	hwif->timer.function = &ide_timer_expiry;
 	hwif->timer.data = (unsigned long)hwif;
 
+	irq_handler = hwif->host->irq_handler;
+	if (irq_handler == NULL)
+		irq_handler = ide_intr;
+
 #if defined(__mc68000__)
 	sa = IRQF_SHARED;
 #endif /* __mc68000__ */
@@ -969,7 +974,7 @@ static int init_irq (ide_hwif_t *hwif)
 	if (io_ports->ctl_addr)
 		hwif->tp_ops->set_irq(hwif, 1);
 
-	if (request_irq(hwif->irq, &ide_intr, sa, hwif->name, hwif))
+	if (request_irq(hwif->irq, irq_handler, sa, hwif->name, hwif))
 		goto out_up;
 
 	if (!hwif->rqsize) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -866,6 +866,7 @@ struct ide_host {
 	unsigned int	n_ports;
 	struct device	*dev[2];
 	unsigned int	(*init_chipset)(struct pci_dev *);
+	irq_handler_t	irq_handler;
 	unsigned long	host_flags;
 	void		*host_priv;
 	ide_hwif_t	*cur_port;	/* for hosts requiring serialization */
