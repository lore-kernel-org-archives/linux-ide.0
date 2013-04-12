From: Marc C <marc.ceeeee@gmail.com>
Subject: [RFC PATCH] AHCI: Workaround for ATAPI on buggy AHCI controller
Date: Fri, 12 Apr 2013 12:34:24 -0700
Message-ID: <CAO1A-8A0c=5GnH4wLYBz+N1tHLUO3CeuOSq_7S+ZxscNqt5Hnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:54683 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3DLTeZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Apr 2013 15:34:25 -0400
Received: by mail-vc0-f177.google.com with SMTP id hr11so2474856vcb.22
        for <linux-ide@vger.kernel.org>; Fri, 12 Apr 2013 12:34:24 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

Hello Jeff,

I'm working with a proprietary but AHCI-compatible SATA controller that uses
the libata driver. Early versions of this controller have issues with processing
non-data ATAPI commands. A workaround was identified which requires some
register pokes in the command completion path of the driver. I don't expect to
push this patch upstream (yet). However, I would like to get some feedback
regarding the workaround, and check if the placement of the code is "acceptable"
or if there would be a better place to put it.

The workaround itself is rather simple: toggle the START bit immediately after a
non-data ATAPI command completes. The ST bit toggle would be performed within
atomic context in the AHCI port interrupt ISR.

Signed-off-by: Marc C <marc.ceeeee@gmail.com>
---
 linux/drivers/ata/libahci.c     |   26 ++++++++++++++++++++++++++
 linux/drivers/ata/libata-core.c |    6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/linux/drivers/ata/libahci.c b/linux/drivers/ata/libahci.c
index f9eaa82..20b3a9a 100644
--- a/linux/drivers/ata/libahci.c
+++ b/linux/drivers/ata/libahci.c
@@ -2215,6 +2215,32 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
 }
 EXPORT_SYMBOL_GPL(ahci_set_em_messages);

+void ahci_apply_atapi_workaround(struct ata_queued_cmd *qc)
+{
+    if (!(qc->flags & ATA_QCFLAG_DMAMAP)) {
+        /*
+         * Non-data ATAPI commands need to kick the DMA engine
+         */
+        struct ata_port *ap = qc->ap;
+        void __iomem *port_mmio = ahci_port_base(ap);
+        u32 tmp = readl(port_mmio + PORT_CMD);
+
+        /* check if the HBA is idle */
+        if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) != 0) {
+            /* setting HBA to idle */
+            tmp &= ~PORT_CMD_START;
+            writel(tmp, port_mmio + PORT_CMD);
+
+            /* wait for engine to stop */
+            do {
+                tmp = readl(port_mmio + PORT_CMD);
+            } while (tmp & PORT_CMD_LIST_ON);
+        }
+        ahci_start_engine(ap);
+    }
+}
+EXPORT_SYMBOL_GPL(ahci_apply_atapi_workaround);
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Common AHCI SATA low-level routines");
 MODULE_LICENSE("GPL");
diff --git a/linux/drivers/ata/libata-core.c b/linux/drivers/ata/libata-core.c
index 4e73e1b..383de21 100644
--- a/linux/drivers/ata/libata-core.c
+++ b/linux/drivers/ata/libata-core.c
@@ -4827,6 +4827,12 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 {
     struct ata_port *ap = qc->ap;

+    if (ata_is_atapi(qc->tf.protocol)) {
+        void ahci_apply_atapi_workaround(struct ata_queued_cmd *qc);
+        ahci_apply_atapi_workaround(qc);
+    }
+
     /* XXX: New EH and old EH use different mechanisms to
      * synchronize EH with regular execution path.
      *
--
1.7.9.5




--
Regards,
Marc
marc.ceeeee@gmail.com
