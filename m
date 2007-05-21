From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Kiss post_set_mode goodbye
Date: Mon, 21 May 2007 15:20:33 +0100
Message-ID: <20070521152033.40eadbdf@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44019 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755817AbXEUOQ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 10:16:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

As of the -mm tree we don't have post_set_mode users any more.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/include/linux/libata.h linux-2.6.22-rc1-mm1/include/linux/libata.h
--- linux.vanilla-2.6.22-rc1-mm1/include/linux/libata.h	2007-05-18 16:22:56.000000000 +0100
+++ linux-2.6.22-rc1-mm1/include/linux/libata.h	2007-05-18 16:38:16.000000000 +0100
@@ -575,8 +575,6 @@
 	void (*phy_reset) (struct ata_port *ap); /* obsolete */
 	int  (*set_mode) (struct ata_port *ap, struct ata_device **r_failed_dev);
 
-	void (*post_set_mode) (struct ata_port *ap);
-
 	int (*cable_detect) (struct ata_port *ap);
 
 	int  (*check_atapi_dma) (struct ata_queued_cmd *qc);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/drivers/ata/libata-core.c linux-2.6.22-rc1-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.22-rc1-mm1/drivers/ata/libata-core.c	2007-05-18 16:22:53.000000000 +0100
+++ linux-2.6.22-rc1-mm1/drivers/ata/libata-core.c	2007-05-18 16:40:23.000000000 +0100
@@ -2892,9 +2902,6 @@
 	if (used_dma && (ap->host->flags & ATA_HOST_SIMPLEX))
 		ap->host->simplex_claimed = ap;
 
-	/* step5: chip specific finalisation */
-	if (ap->ops->post_set_mode)
-		ap->ops->post_set_mode(ap);
  out:
 	if (rc)
 		*r_failed_dev = dev;
