From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 01/02] sata_mv: enable async_notify for 60x1 Rev.C0 and higher
Date: Wed, 18 Jun 2008 12:11:16 -0400
Message-ID: <485933A4.3010409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1525 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbYFRQLS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 12:11:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

The early chipsets cannot safely handle Async Notification (AN),
but 6041/6081 chip revision "C0" (and newer) can handle it.

So allow AN for "C0" and higher.

This enables use of hotplug on PMP ports for the 6041/6081 PCI Rev.9 chips.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-30 19:36:52.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-06-17 17:45:00.000000000 -0400
@@ -1322,6 +1322,9 @@
 		goto out_port_free_dma_mem;
 	memset(pp->crpb, 0, MV_CRPB_Q_SZ);
 
+	/* 6041/6081 Rev. "C0" (and newer) are okay with async notify */
+	if (hpriv->hp_flags & MV_HP_ERRATA_60X1C0)
+		ap->flags |= ATA_FLAG_AN;
 	/*
 	 * For GEN_I, there's no NCQ, so we only allocate a single sg_tbl.
 	 * For later hardware, we need one unique sg_tbl per NCQ tag.
