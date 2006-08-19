From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/20] libata: kill ata_host_stop()
Date: Sat, 19 Aug 2006 17:59:30 +0900
Message-ID: <11559779703875-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:37636 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750896AbWHSI7h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:37 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465939pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:36 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

As all the current LLDs are PCI, ata_pci_host_stop() should be used,
which BTW is effectively identical to ata_host_stop().  Convert all
LLDs to use ata_pci_host_stop() and kill ata_host_stop().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c    |    2 +-
 drivers/ata/libata-core.c |    7 -------
 drivers/ata/sata_mv.c     |    2 +-
 drivers/ata/sata_sis.c    |    2 +-
 drivers/ata/sata_uli.c    |    2 +-
 drivers/ata/sata_via.c    |    2 +-
 include/linux/libata.h    |    1 -
 7 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a44c431..0cb48a4 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -934,7 +934,7 @@ static void piix_host_stop(struct ata_ho
 {
 	struct piix_host_priv *hpriv = host->private_data;
 
-	ata_host_stop(host);
+	ata_pci_host_stop(host);
 
 	kfree(hpriv);
 }
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1c93154..e8bbbaa 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5207,12 +5207,6 @@ void ata_port_stop (struct ata_port *ap)
 	ata_pad_free(ap, dev);
 }
 
-void ata_host_stop (struct ata_host *host)
-{
-	if (host->mmio_base)
-		iounmap(host->mmio_base);
-}
-
 /**
  *	ata_dev_init - Initialize an ata_device structure
  *	@dev: Device structure to initialize
@@ -6056,7 +6050,6 @@ EXPORT_SYMBOL_GPL(ata_altstatus);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
-EXPORT_SYMBOL_GPL(ata_host_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_mmio_data_xfer);
 EXPORT_SYMBOL_GPL(ata_pio_data_xfer);
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 34f1939..92ee209 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -828,7 +828,7 @@ static void mv_host_stop(struct ata_host
 		pci_intx(pdev, 0);
 	}
 	kfree(hpriv);
-	ata_host_stop(host);
+	ata_pci_host_stop(host);
 }
 
 static inline void mv_priv_free(struct mv_port_priv *pp, struct device *dev)
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 9b17375..167f9b6 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -123,7 +123,7 @@ static const struct ata_port_operations 
 	.scr_write		= sis_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= ata_pci_host_stop,
 };
 
 static struct ata_port_info sis_port_info = {
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 8fc6e80..227f983 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -123,7 +123,7 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= ata_pci_host_stop,
 };
 
 static struct ata_port_info uli_port_info = {
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index cd77f03..f9ec293 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -138,7 +138,7 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= ata_pci_host_stop,
 };
 
 static struct ata_port_info svia_port_info = {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 563885c..8fd8851 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -741,7 +741,6 @@ extern u8 ata_altstatus(struct ata_port 
 extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
-extern void ata_host_stop (struct ata_host *host);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_mmio_data_xfer(struct ata_device *adev, unsigned char *buf,
 			       unsigned int buflen, int write_data);
-- 
1.4.1.1


