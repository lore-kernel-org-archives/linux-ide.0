From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2.6.21-rc1 1/2] sata_vsc: factor the error and normal intr
	paths into separate routines
Date: Wed, 21 Feb 2007 10:56:46 -0700
Message-ID: <20070221175646.21231.90731.stgit@dwillia2-linux.ch.intel.com>
References: <20070221175354.21231.15372.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47437 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422744AbXBUR4s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Feb 2007 12:56:48 -0500
In-Reply-To: <20070221175354.21231.15372.stgit@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com

Separate sata_vsc interrupt handling into a normal (per-port) path and an
error path with the addition of vsc_port_intr and vsc_error_intr
respectively.  The error path handles interrupt based
hotplug events which requires the definition of vsc_freeze and vsc_thaw.

Note: vsc_port_intr has a workaround for unexpected interrupts that occur
during polled commands.

Changes in take2:
* removed definition of invalid fis bit
* let standard ata-error-handling handle the serror register
* clear all unhandled interrupts

Cc: Jeremy Higdon <jeremy@sgi.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/ata/sata_vsc.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 2fd037b..6a0c9cf 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -203,6 +203,36 @@ static void vsc_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
         }
 }
 
+static inline void vsc_error_intr(u8 port_status, struct ata_port *ap)
+{
+	if (port_status & (VSC_SATA_INT_PHY_CHANGE | VSC_SATA_INT_ERROR_M))
+		ata_port_freeze(ap);
+	else
+		ata_port_abort(ap);
+}
+
+static void vsc_port_intr(u8 port_status, struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc;
+	int handled = 0;
+
+	if (unlikely(port_status & VSC_SATA_INT_ERROR)) {
+		vsc_error_intr(port_status, ap);
+		return;
+	}
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (qc && likely(!(qc->tf.flags & ATA_TFLAG_POLLING)))
+		handled = ata_host_intr(ap, qc);
+
+	/* We received an interrupt during a polled command,
+	 * or some other spurious condition.  Interrupt reporting
+	 * with this hardware is fairly reliable so it is safe to
+	 * simply clear the interrupt
+	 */
+	if (unlikely(!handled))
+		ata_chk_status(ap);
+}
 
 /*
  * vsc_sata_interrupt
