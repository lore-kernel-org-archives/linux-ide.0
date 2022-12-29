Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BEFC4167B
	for <linux-ide@archiver.kernel.org>; Thu, 29 Dec 2022 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiL2RAc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 29 Dec 2022 12:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiL2RAX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Dec 2022 12:00:23 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99A10B78
        for <linux-ide@vger.kernel.org>; Thu, 29 Dec 2022 09:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672333222; x=1703869222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iAp2Ea+KW/L1J0nxWnzcy6lcGq+hi0WMJZGC4TQQidE=;
  b=bl7S3Wl77jG3FmqZdsidms8C39HRYnSIbpc2RrIc8hROw+E5g2Vxf71M
   CoIgKbl6diAIYFUQShrEOWt2r2mlQBE5VWpu/A7Kaw5n1hzyeOk+CJ0BZ
   C8eKaCmVnD/Svte0zy/M1qUx5FfOWNELSpQfJTTPM7DD2Ax/Nn8aK2/3U
   oKuwn2eIvNxI6NqSqTaern5IblD7FoZzhz09pF/KBYEKVu1BGjatByY/V
   DDzrBDTlMmsvllL4TeLuefWpHd7l04zZySpY1NQNSAUr978tTb9XRcyrL
   olEXgpbFNU9JOMfNup60MSgV3zhMx6TvXHStKX9HVfQa8xCk0JQq6M4/U
   A==;
X-IronPort-AV: E=Sophos;i="5.96,284,1665417600"; 
   d="scan'208";a="323990987"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 01:00:22 +0800
IronPort-SDR: Ex8CABQE0shStLl5dNnVlKrcm2EWmY7iEBgHjDKMC/jwlHUXjvGq+ilrP3q9fmXpZBcAg4/AQh
 ATYiMArc9lKEbHy/Myl5NaL6w1ZZogOSPl0ELluCV5xuL5Il7xeJ1516ya83kd72DEi96aSR7Q
 +ArK2dxi9b8Zc9inM5Lppj5L86tOwdfgsfNDnLXm5lDuV1jE/GcVRNEGF94qfwUswrSEwuPmE0
 ke7LKc0scC+bORd+hOHQvNDLGoTp2AjDA94/c5teJi3GThiRur/KP11jRAp9QzYrUhJB6XSpQ5
 bA4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Dec 2022 08:18:26 -0800
IronPort-SDR: yjMl6AbyTogYm0vpotyiBiwRbncX3lWs1IQuWwhk5qJkmzcMlGaWxjiBHK8o7gNw1v1Ucd57fN
 0XB5tx1ooHfraxNnPvhJAxR/UE6Xxa4LIy1TN3rqC2EO+byxjD9P1QJuLDNxvYCh2Ov4Wyt3A8
 TrX/YqeI4ZiXHP8w3iyIXLW9eM8fSjDXGdWEM1hFgNVG8pXR1YKT8RwhlMLLjYdNnPVNjCodOq
 6gK3hJIDpXlgwts2hOwWDzDHR1nsO2xHKhQINeuP/1GtXpVo4cVJHrktybFBBV5Ia7ex7CU1LE
 jME=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Dec 2022 09:00:22 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH v2 4/7] ata: libata: respect successfully completed commands during errors
Date:   Thu, 29 Dec 2022 18:00:00 +0100
Message-Id: <20221229170005.49118-5-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229170005.49118-1-niklas.cassel@wdc.com>
References: <20221229170005.49118-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In AHCI specification 1.3.1:
"5.5.3 Processing Completed Commands"

"For each port that has an interrupt pending:

1. Software determines the cause of the interrupt by reading the PxIS
   register. It is possible for multiple bits to be set.
2. Software clears appropriate bits in the PxIS register corresponding
   to the cause of the interrupt.
3. Software clears the interrupt bit in IS.IPS corresponding to the port.
4. If executing non-queued commands, software reads the PxCI register,
   and compares the current value to the list of commands previously
   issued by software that are still outstanding. If executing native
   queued commands, software reads the PxSACT register and compares the
   current value to the list of commands previously issued by software.
   Software completes with success any outstanding command whose
   corresponding bit has been cleared in the respective register. PxCI
   and PxSACT are volatile registers; software should only use their
   values to determine commands that have completed, not to determine
   which commands have previously been issued.
5. If there were errors, noted in the PxIS register, software performs
   error recovery actions (see section 6.2.2)."

The documentation for the PxSACT shadow register in AHCI:
"The device clears bits in this field by sending a Set Device Bits FIS
to the host. The HBA clears bits in this field that are set to ‘1’ in
the SActive field of the Set Device Bits FIS. The HBA only clears bits
that correspond to native queued commands that have completed
successfully."

Additionally, in SATA specification 3.5a:
"11.15 FPDMA QUEUED command protocol"

"DFPDMAQ11: ERROR
Halt command processing and transmit Set Device Bits FIS to host
with the ERR bit in Status field set to one, Interrupt bit set to one,
ATA error code set to one in the ERROR field, bits in ACT field cleared
to zero for any outstanding queued commands, and bits set to one
for any successfully completed queued commands that completion
notification not yet delivered."

I.e. even when the HBA triggers an error interrupt, the HBA will still
clear successfully completed commands in PxSACT. Commands that did not
complete successfully will still have its bit set in PxSACT.
(Which means the command that caused the NCQ error and queued commands
that had not yet finished at the time when the NCQ error occurred.)

Additionally, for a HBA that does not have the libata flag
AHCI_HFLAG_MULTI_MSI set, all ap->locks will point to host->lock, which
means that IRQs will be disabled for one port while another port's IRQ
handler is running. The HBA will still receive FISes from the device,
even if IRQs on the HBA itself are disabled. What can thus e.g. receive
a FIS that completes several commands successfully, followed by a FIS
that does (or does not) complete additional commands with the error bit
set, to indicate that at least one command was aborted.

Therefore, modify ahci_handle_port_interrupt() using the new helper
ahci_qc_complete() to complete the commands that have already been
signaled as successfully through a regular completion SDB FIS, as not
doing so would simply cause successfully completed commands to be
retried for no good reason.

Co-developed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libahci.c | 73 +++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e5d67eb46f3c..8f216de76648 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1849,18 +1849,47 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 		ata_port_abort(ap);
 }
 
-static void ahci_handle_port_interrupt(struct ata_port *ap,
-				       void __iomem *port_mmio, u32 status)
+static void ahci_qc_complete(struct ata_port *ap, void __iomem *port_mmio)
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	struct ahci_port_priv *pp = ap->private_data;
-	struct ahci_host_priv *hpriv = ap->host->private_data;
-	int resetting = !!(ap->pflags & ATA_PFLAG_RESETTING);
 	u32 qc_active = 0;
 	int rc;
 
+	/*
+	 * pp->active_link is not reliable once FBS is enabled, both
+	 * PORT_SCR_ACT and PORT_CMD_ISSUE should be checked because
+	 * NCQ and non-NCQ commands may be in flight at the same time.
+	 */
+	if (pp->fbs_enabled) {
+		if (ap->qc_active) {
+			qc_active = readl(port_mmio + PORT_SCR_ACT);
+			qc_active |= readl(port_mmio + PORT_CMD_ISSUE);
+		}
+	} else {
+		/* pp->active_link is valid iff any command is in flight */
+		if (ap->qc_active && pp->active_link->sactive)
+			qc_active = readl(port_mmio + PORT_SCR_ACT);
+		else
+			qc_active = readl(port_mmio + PORT_CMD_ISSUE);
+	}
+
+	rc = ata_qc_complete_multiple(ap, qc_active);
+	if (unlikely(rc < 0 && !(ap->pflags & ATA_PFLAG_RESETTING))) {
+		ehi->err_mask |= AC_ERR_HSM;
+		ehi->action |= ATA_EH_RESET;
+		ata_port_freeze(ap);
+	}
+}
+
+static void ahci_handle_port_interrupt(struct ata_port *ap,
+				       void __iomem *port_mmio, u32 status)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+
 	/* ignore BAD_PMP while resetting */
-	if (unlikely(resetting))
+	if (unlikely(ap->pflags & ATA_PFLAG_RESETTING))
 		status &= ~PORT_IRQ_BAD_PMP;
 
 	if (sata_lpm_ignore_phy_events(&ap->link)) {
@@ -1869,6 +1898,12 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 	}
 
 	if (unlikely(status & PORT_IRQ_ERROR)) {
+		/*
+		 * Before getting the error notification, we may have
+		 * received SDB FISes notifying successful completions.
+		 * Handle these first and then handle the error.
+		 */
+		ahci_qc_complete(ap, port_mmio);
 		ahci_error_intr(ap, status);
 		return;
 	}
@@ -1905,32 +1940,8 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 		}
 	}
 
-	/* pp->active_link is not reliable once FBS is enabled, both
-	 * PORT_SCR_ACT and PORT_CMD_ISSUE should be checked because
-	 * NCQ and non-NCQ commands may be in flight at the same time.
-	 */
-	if (pp->fbs_enabled) {
-		if (ap->qc_active) {
-			qc_active = readl(port_mmio + PORT_SCR_ACT);
-			qc_active |= readl(port_mmio + PORT_CMD_ISSUE);
-		}
-	} else {
-		/* pp->active_link is valid iff any command is in flight */
-		if (ap->qc_active && pp->active_link->sactive)
-			qc_active = readl(port_mmio + PORT_SCR_ACT);
-		else
-			qc_active = readl(port_mmio + PORT_CMD_ISSUE);
-	}
-
-
-	rc = ata_qc_complete_multiple(ap, qc_active);
-
-	/* while resetting, invalid completions are expected */
-	if (unlikely(rc < 0 && !resetting)) {
-		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_RESET;
-		ata_port_freeze(ap);
-	}
+	/* Handle completed commands */
+	ahci_qc_complete(ap, port_mmio);
 }
 
 static void ahci_port_intr(struct ata_port *ap)
-- 
2.38.1

