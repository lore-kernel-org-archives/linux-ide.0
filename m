From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Subject: [PATCH 1/2] ide-generic: add some notes to clarify probing PCI
 devices
Date: Tue, 21 Feb 2017 11:22:37 -0300
Message-ID: <20170221142237.GB11234@giustizia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm14-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.164]:44221 "EHLO
        nm14-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753372AbdBUOWX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Feb 2017 09:22:23 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Miller <davem@davemloft.net>, petkovbb@gmail.com

Some inline comments were added in ide-generic, to make clear to
developers the way probe_mask is managed when PCI IDE devices are
present.

A not-so-deep analysis of the code could make it is buggy, as it seems
that if a device is detected, the probing procedure is avoided,
suggesting some kind of reversed logic.

Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
---
 drivers/ide/ide-generic.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
index 54d7c4685d23aa5e62ce606e7b994a57bb54b08a..ee11edcdba3170c077381d603918498d79ffa3bb 100644
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -96,6 +96,33 @@ static int __init ide_generic_init(void)
 		printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" "
 		     "module parameter for probing all legacy ISA IDE ports\n");
 
+		/* Here the logic seems reversed, but it's not. *primary would
+		 * be 1 if there is a device at 0x1f0 and *secondary would be 1
+		 * if a device is detected at 0x170.
+		 *
+		 * However, the main intention here is to not allow PCI IDE devices
+		 * using ide-generic unless the user chooses so, as this driver is
+		 * designed to support ISA IDE devices mainly.
+		 *
+		 * In this case, users are strongly encouraged to use the designated
+		 * PCI IDE driver, and not isa-generic.
+		 *
+		 * Pure ISA IDE devices OTOH will use ide-generic. In this case, *primary
+		 * and *secondary will return from ide_generic_check_pci_legacy_iobases()
+		 * with zero (because they are not PCI...), and probe_mask will be set
+		 * accordingly (to 0x01, 0x02 or 0x03, depending on which io ports are
+		 * present).
+		 *
+		 * Users would even use ide-generic with such PCI IDE devices, choosing a
+		 * nonzero value for probe_mask when initializing ide-generic. Using
+		 * probe_mask=0x03 is sufficient to make it detect common IDE interfaces
+		 * (with primary at 0x1f0 and secondary at 0x170), but in the more
+		 * general case, one should set probe_mask to 0x3f to check all possible
+		 * io addresses. In this case, it is up to the user the task of checking
+		 * for eventual conflicts between ide-generic and any other driver and
+		 * manage those conflicts properly.
+		 */
+
 		if (primary == 0)
 			probe_mask |= 0x1;
 
-- 
2.8.2

