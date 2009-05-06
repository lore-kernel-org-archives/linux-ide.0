From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Subject: [PATCH] libata: Add multi-count transfer debugging
Date: Wed, 06 May 2009 15:45:18 +0200
Message-ID: <4A01946E.1020300@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:48108 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753059AbZEFNpU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 May 2009 09:45:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Ward Vandewege <ward@gnu.org>

On my Asus M2A-VM (SB600) board, the SATA disks use multi-count
transfers only with some BIOS variants.
Dumping the relevant config words helps debugging a lot.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

--- a/drivers/ata/libata-core.c	2009-05-06 14:24:32.000000000 +0200
+++ b/drivers/ata/libata-core.c	2009-05-06 15:27:06.000000000 +0200
@@ -2390,11 +2390,11 @@
 	/* print device capabilities */
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG,
-			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
-			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
+			       "%s: cfg 47:%04x 49:%04x 59:%04x 82:%04x 83:%04x"
+			       " 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
 			       __func__,
-			       id[49], id[82], id[83], id[84],
-			       id[85], id[86], id[87], id[88]);
+			       id[47], id[49], id[59], id[82], id[83],
+			       id[84], id[85], id[86], id[87], id[88]);
 
 	/* initialize to-be-configured parameters */
 	dev->flags &= ~ATA_DFLAG_CFG_MASK;


