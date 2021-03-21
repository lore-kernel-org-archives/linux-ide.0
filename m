Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F7AC433E4
	for <linux-ide@archiver.kernel.org>; Sun, 21 Mar 2021 19:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E536361946
	for <linux-ide@archiver.kernel.org>; Sun, 21 Mar 2021 19:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhCUT4L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 21 Mar 2021 15:56:11 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38036 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhCUTze (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 21 Mar 2021 15:55:34 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A1CBC92009C; Sun, 21 Mar 2021 20:55:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9CEF192009B;
        Sun, 21 Mar 2021 20:55:32 +0100 (CET)
Date:   Sun, 21 Mar 2021 20:55:32 +0100 (CET)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] pata_legacy: Add `probe_mask' parameter like with
 ide-generic
In-Reply-To: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2103211800110.21463@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Carry the `probe_mask' parameter over from ide-generic to pata_legacy so 
that there is a way to prevent random poking at ISA port I/O locations 
in attempt to discover adapter option cards with libata like with the 
old IDE driver.  By default all enabled locations are tried, however it 
may interfere with a different kind of hardware responding there.

For example with a plain (E)ISA system the driver tries all the six 
possible locations:

scsi host0: pata_legacy
ata1: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
ata1.00: ATA-4: ST310211A, 3.54, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA
ata1.00: configured for PIO
scsi 0:0:0:0: Direct-Access     ATA      ST310211A        3.54 PQ: 0 ANSI: 5
scsi 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 19541088 512-byte logical blocks: (10.0 GB/9.32 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
scsi host1: pata_legacy
ata2: PATA max PIO4 cmd 0x170 ctl 0x376 irq 15
scsi host1: pata_legacy
ata3: PATA max PIO4 cmd 0x1e8 ctl 0x3ee irq 11
scsi host1: pata_legacy
ata4: PATA max PIO4 cmd 0x168 ctl 0x36e irq 10
scsi host1: pata_legacy
ata5: PATA max PIO4 cmd 0x1e0 ctl 0x3e6 irq 8
scsi host1: pata_legacy
ata6: PATA max PIO4 cmd 0x160 ctl 0x366 irq 12

however giving the kernel "pata_legacy.probe_mask=21" makes it try every 
other location only:

scsi host0: pata_legacy
ata1: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
ata1.00: ATA-4: ST310211A, 3.54, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA
ata1.00: configured for PIO
scsi 0:0:0:0: Direct-Access     ATA      ST310211A        3.54 PQ: 0 ANSI: 5
scsi 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 19541088 512-byte logical blocks: (10.0 GB/9.32 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
scsi host1: pata_legacy
ata2: PATA max PIO4 cmd 0x1e8 ctl 0x3ee irq 11
scsi host1: pata_legacy
ata3: PATA max PIO4 cmd 0x1e0 ctl 0x3e6 irq 8

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 Documentation/admin-guide/kernel-parameters.txt |   11 +++++++++++
 drivers/ata/pata_legacy.c                       |    6 ++++++
 2 files changed, 17 insertions(+)

linux-pata-legacy-probe-mask.diff
Index: linux-dolch/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-dolch.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-dolch/Documentation/admin-guide/kernel-parameters.txt
@@ -3627,6 +3627,17 @@
 			Set to non-zero to probe tertiary and further ISA
 			port ranges on PCI systems.  Disabled by default.
 
+	pata_legacy.probe_mask=	[HW,LIBATA]
+			Format: <int>
+			Probe mask for legacy ISA PATA ports.  Depending on
+			platform configuration and the use of other driver
+			options up to 6 legacy ports are supported: 0x1f0,
+			0x170, 0x1e8, 0x168, 0x1e0, 0x160, however probing
+			of individual ports can be disabled by setting the
+			corresponding bits in the mask to 1.  Bit 0 is for
+			the first port in the list above (0x1f0), and so on.
+			By default all supported ports are probed.
+
 	pata_legacy.qdi=	[HW,LIBATA]
 			Format: <int>
 			Set to non-zero to probe QDI controllers.  By default
Index: linux-dolch/drivers/ata/pata_legacy.c
===================================================================
--- linux-dolch.orig/drivers/ata/pata_legacy.c
+++ linux-dolch/drivers/ata/pata_legacy.c
@@ -71,6 +71,10 @@ module_param(probe_all, int, 0);
 MODULE_PARM_DESC(probe_all,
 		 "Set to probe tertiary+ ISA port ranges even if PCI");
 
+static int probe_mask = ~0;
+module_param(probe_mask, int, 0);
+MODULE_PARM_DESC(probe_mask, "Probe mask for legacy ISA PATA ports");
+
 static int autospeed;
 module_param(autospeed, int, 0);
 MODULE_PARM_DESC(autospeed, "Chip present that snoops speed changes");
@@ -199,6 +203,8 @@ static int legacy_probe_add(unsigned lon
 			free = lp;
 		/* Matching port, or the correct slot for ordering */
 		if (lp->port == port || legacy_port[i] == port) {
+			if (!(probe_mask & 1 << i))
+				return -1;
 			free = lp;
 			break;
 		}
