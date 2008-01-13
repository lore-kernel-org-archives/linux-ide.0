From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] sata_sil24: freeze on non-dev errors reported
 via CERR
Date: Sun, 13 Jan 2008 14:04:16 +0900
Message-ID: <47899BD0.4030204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:38586 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbYAMFEX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 00:04:23 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1380281rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 21:04:22 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Andrew Ryder <tireman@shaw.ca>

CERR reports errors detected during executing a command.  This doesn't
mean the error is tied to the command and can be recovered by just
issuing it again.  Many of the errors are fatal port-wide connditions
including HSM violation, host bus error and ATA bus error and require
freezing and port reset.

The freezing part wasn't implemented previously.  This used to be okay
because port resets were scheduled anyway and EH eventually resets and
recovers the port.  With PMP support added, this is no longer true.
The error condition and recover actions are attributed to the fan-out
port and the host port condition isn't properly recovered leading to
EH failures.

This patch makes CERR errors which require resets to freeze the port.
This will force host port reset and proper recovery.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Andrew Ryder <tireman@shaw.ca>
---
 drivers/ata/sata_sil24.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index b4c674d..d84561d 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1094,10 +1094,13 @@ static void sil24_error_intr(struct ata_port *ap)
 		if (ci && ci->desc) {
 			err_mask |= ci->err_mask;
 			action |= ci->action;
+			if (action & ATA_EH_RESET_MASK)
+				freeze = 1;
 			ata_ehi_push_desc(ehi, "%s", ci->desc);
 		} else {
 			err_mask |= AC_ERR_OTHER;
 			action |= ATA_EH_SOFTRESET;
+			freeze = 1;
 			ata_ehi_push_desc(ehi, "unknown command error %d",
 					  cerr);
 		}
