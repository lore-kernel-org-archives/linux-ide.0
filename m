From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] 2.6.21 fix lba48 bug in libata fill_result_tf()
Date: Mon, 02 Apr 2007 16:20:35 -0400
Message-ID: <46116593.6050609@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:1840 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965827AbXDBUUh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Apr 2007 16:20:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Ric Wheeler <ric@emc.com>

Tejun,

Current 2.6.21 libata does the following:

void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
{
        struct ata_ioports *ioaddr = &ap->ioaddr;

        tf->command = ata_check_status(ap);
	...
        if (tf->flags & ATA_TFLAG_LBA48) {
                iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
                tf->hob_feature = ioread8(ioaddr->error_addr);
                ...
        }
}
...
static void fill_result_tf(struct ata_queued_cmd *qc)
{
        struct ata_port *ap = qc->ap;

        ap->ops->tf_read(ap, &qc->result_tf);
        qc->result_tf.flags = qc->tf.flags;
}

Based on this, those last two statements fill_result_tf()
appear to me to be in the wrong order, in that the tf->flags
are uninitialized at the point where tf_read() is invoked.
So for lba48 commands, tf_read() won't be reading back the
full lba48 register contents..

Correct?

This patch corrects fill_result_tf() so that the flags
get copied to result_tf before they are used by tf_read().

Signed-off-by:  Mark Lord <mlord@pobox.com>
---
--- linux/drivers/ata/libata-core.c.orig	2007-03-21 12:46:06.000000000 -0400
+++ linux/drivers/ata/libata-core.c	2007-04-02 16:16:28.000000000 -0400
@@ -4763,8 +4763,8 @@
 {
 	struct ata_port *ap = qc->ap;
 
-	ap->ops->tf_read(ap, &qc->result_tf);
 	qc->result_tf.flags = qc->tf.flags;
+	ap->ops->tf_read(ap, &qc->result_tf);
 }
 
 /**
