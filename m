From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH 1/3] ide: allow to wrap interrupt handler
Date: Tue, 3 Feb 2009 11:46:59 +0100
Message-ID: <200902031146.59602.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:62343 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbZBCKrG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Feb 2009 05:47:06 -0500
Received: from ebg226.internetdsl.tpnet.pl (HELO staszek-desktop.local) (stf_xl@wp.pl@[83.14.136.226])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 3 Feb 2009 11:46:59 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>
Cc: linux-arm-kernel@lists.arm.linux.org.uk

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

---
 drivers/ide/ide-io.c    |    2 ++
 drivers/ide/ide-probe.c |    6 +++++-
 include/linux/ide.h     |    1 +
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 9ee51ad..086bea2 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1163,6 +1163,8 @@ out_early:
 	return irq_ret;
 }
 
+EXPORT_SYMBOL_GPL(ide_intr);
+
 /**
  *	ide_do_drive_cmd	-	issue IDE special command
  *	@drive: device to issue command
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index ce0818a..821563d 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -951,6 +951,7 @@ static int init_irq (ide_hwif_t *hwif)
 {
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	int sa = 0;
+	irq_handler_t irq_handler;
 
 	mutex_lock(&ide_cfg_mtx);
 	spin_lock_init(&hwif->lock);
@@ -969,7 +970,10 @@ static int init_irq (ide_hwif_t *hwif)
 	if (io_ports->ctl_addr)
 		hwif->tp_ops->set_irq(hwif, 1);
 
-	if (request_irq(hwif->irq, &ide_intr, sa, hwif->name, hwif))
+	irq_handler = hwif->host->irq_handler;
+	if (!irq_handler)
+		irq_handler = &ide_intr;
+	if (request_irq(hwif->irq, irq_handler, sa, hwif->name, hwif))
 		goto out_up;
 
 	if (!hwif->rqsize) {
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 194da5a..bfae29f 100644
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
-- 
1.5.2.5
