From: Dan Williams <dan.j.williams@gmail.com>
Subject: [RFC][PATCH] Necessary evil to get sata_vsc to initialize with Intel iq3124h
Date: Tue, 13 Dec 2005 12:00:57 -0700
Message-ID: <e9c3a7c20512131100v3def8760o2017d3da1a7e5b3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:15042 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932460AbVLMTC2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Dec 2005 14:02:28 -0500
Received: by zproxy.gmail.com with SMTP id 34so1804153nzf
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2005 11:02:27 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeremy@sgi.com

The following patch works around "irq nobody cared" problems
encountered while using sata_vsc with the Intel iq3124h.  It seems the
unexpected interrupts are only generated at initialization time, but
more testing is required.  Patch is against 2.6.14.3

Dan

diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index cf94e01..7dcc486 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -81,6 +81,19 @@
 /* Port stride */
 #define VSC_SATA_PORT_OFFSET           0x200

+/* Error interrupt status bit offsets */
+#define VSC_SATA_INT_ERROR_E_OFFSET    2
+#define VSC_SATA_INT_ERROR_P_OFFSET    4
+#define VSC_SATA_INT_ERROR_T_OFFSET    5
+#define VSC_SATA_INT_ERROR_M_OFFSET    1
+#define is_vsc_sata_int_err(port_idx, int_status) \
+        (int_status & ((1 << (VSC_SATA_INT_ERROR_E_OFFSET + (8 *
port_idx))) | \
+                       (1 << (VSC_SATA_INT_ERROR_P_OFFSET + (8 *
port_idx))) | \
+                       (1 << (VSC_SATA_INT_ERROR_T_OFFSET + (8 *
port_idx))) | \
+                       (1 << (VSC_SATA_INT_ERROR_M_OFFSET + (8 *
port_idx)))   \
+                      )\
+        )
+

  static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
@@ -193,13 +206,28 @@ static irqreturn_t vsc_sata_interrupt (i
                        struct ata_port *ap;

                        ap = host_set->ports[i];
+
+                       if (is_vsc_sata_int_err(i, int_status)) {
+                               u32 err_status;
+                               printk(KERN_DEBUG "%s: ignoring
interrupt(s)\n", __FUNCTION__);
+                               err_status = ap ?
vsc_sata_scr_read(ap, SCR_ERROR) : 0;
+                               vsc_sata_scr_write(ap, SCR_ERROR, err_status);
+                               handled++;
+                       }
+
                        if (ap && !(ap->flags &
                                    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
                                struct ata_queued_cmd *qc;

                                qc = ata_qc_from_tag(ap, ap->active_tag);
-                               if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+                               if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
                                        handled += ata_host_intr(ap, qc);
+                               } else {
+                                       printk(KERN_DEBUG "%s:
ignoring interrupt(s)\n", __FUNCTION__);
+                                       ata_chk_status(ap);
+                                       handled++;
+                               }
+
                        }
                }
        }
