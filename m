From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-sff: tf_load
Date: Mon, 19 Nov 2007 14:34:56 +0000
Message-ID: <20071119143456.380042a1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33660 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752829AbXKSOgu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 09:36:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Jeff said he preferred that the SFF tf_load followed the spec and we
documented that anyone who needed different overrode it, rather than it
using the ->check_status methods. No driver relies on the current behaviour.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/libata-sff.c linux-2.6.24-rc2-mm1/drivers/ata/libata-sff.c
--- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/libata-sff.c	2007-11-16 17:55:11.000000000 +0000
+++ linux-2.6.24-rc2-mm1/drivers/ata/libata-sff.c	2007-11-16 18:11:51.000000000 +0000
@@ -147,7 +147,9 @@
  *	@tf: ATA taskfile register set for storing input
  *
  *	Reads ATA taskfile registers for currently-selected device
- *	into @tf.
+ *	into @tf. Assumes the device has a fully SFF compliant task file
+ *	layout and behaviour. If you device does not (eg has a different
+ *	status method) then you will need to provide a replacement tf_read
  *
  *	LOCKING:
  *	Inherited from caller.
@@ -156,7 +158,7 @@
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	tf->command = ata_chk_status(ap);
+	tf->command = ata_check_status(ap);
 	tf->feature = ioread8(ioaddr->error_addr);
 	tf->nsect = ioread8(ioaddr->nsect_addr);
 	tf->lbal = ioread8(ioaddr->lbal_addr);
