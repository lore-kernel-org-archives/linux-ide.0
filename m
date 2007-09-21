From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Subject: Re: [patch 05/25] ata: add the SW NCQ support to sata_nv for MCP51/MCP55/MCP61
Date: Fri, 21 Sep 2007 10:04:23 +0200
Message-ID: <46F37B07.1020006@dunaweb.hu>
References: <200708102059.l7AKxYVQ008581@imap1.linux-foundation.org> <46F2F6E5.3010406@garzik.org> <46F35C7F.20400@dunaweb.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080703060303060501060503"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linux.dunaweb.hu ([62.77.196.1]:39413 "EHLO linux.dunaweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbXIUIEq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Sep 2007 04:04:46 -0400
In-Reply-To: <46F35C7F.20400@dunaweb.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, kluo@nvidia.com, pchen@nvidia.com, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080703060303060501060503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Zoltan Boszormenyi =EDrta:
> I will test the code without this locking. Can you give me a better ide=
a
> besides beating both my disks with separate requests? Say, bonnie++
> and simultaneous hdparm -tT on both?

I tested the driver without locking with the above test, it survived nice=
ly.
Patch is attached which deletes locking, enables swncq by default and
a correction to my previous readability cleanup.

Best regards,
Zolt=E1n B=F6sz=F6rm=E9nyi


--------------080703060303060501060503
Content-Type: text/x-patch;
 name="sata_nv.c-nolock-swncq-enabled-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_nv.c-nolock-swncq-enabled-cleanup.patch"

--- linux-2.6.23-rc3-mm1/drivers/ata/sata_nv.c.committed	2007-09-21 08:32:04.000000000 +0200
+++ linux-2.6.23-rc3-mm1/drivers/ata/sata_nv.c	2007-09-21 09:27:49.000000000 +0200
@@ -279,7 +279,6 @@
 
 	unsigned int	last_issue_tag;
 
-	spinlock_t	lock;
 	/* fifo circular queue to store deferral command */
 	struct defer_queue defer_queue;
 
@@ -637,7 +636,7 @@
 MODULE_VERSION(DRV_VERSION);
 
 static int adma_enabled = 1;
-static int swncq_enabled;
+static int swncq_enabled = 1;
 
 static void nv_adma_register_mode(struct ata_port *ap)
 {
@@ -1965,7 +1964,6 @@
 	pp->sactive_block = ap->ioaddr.scr_addr + 4 * SCR_ACTIVE;
 	pp->irq_block = mmio + NV_INT_STATUS_MCP55 + ap->port_no * 2;
 	pp->tag_block = mmio + NV_NCQ_REG_MCP55 + ap->port_no * 2;
-	spin_lock_init(&pp->lock);
 
 	return 0;
 }
@@ -2051,18 +2049,15 @@
 {
 	struct ata_port *ap = qc->ap;
 	struct nv_swncq_port_priv *pp = ap->private_data;
-	unsigned long flags;
 
 	if (qc->tf.protocol != ATA_PROT_NCQ)
 		return ata_qc_issue_prot(qc);
 
 	DPRINTK("Enter\n");
-	spin_lock_irqsave(&pp->lock, flags);
 	if (!pp->qc_active)
 		nv_swncq_issue_atacmd(ap, qc);
 	else
 		nv_swncq_qc_to_dq(ap, qc);	/* add qc to defer queue */
-	spin_unlock_irqrestore(&pp->lock, flags);
 	return 0;
 }
 
@@ -2265,7 +2260,6 @@
 		return;
 	}
 
-	spin_lock(&pp->lock);
 	if (fis & NV_SWNCQ_IRQ_BACKOUT) {
 		/* If the IRQ is backout, driver must issue
 		 * the new command again some time later.
@@ -2290,8 +2284,7 @@
 		 */
 		pp->dhfis_bits |= (0x1 << pp->last_issue_tag);
 		pp->ncq_flags |= ncq_saw_d2h;
-		if ((pp->ncq_flags & ncq_saw_sdb) ||
-		    (pp->ncq_flags & ncq_saw_backout)) {
+		if (pp->ncq_flags & (ncq_saw_sdb | ncq_saw_backout)) {
 			ata_ehi_push_desc(ehi, "illegal fis transaction");
 			ehi->err_mask |= AC_ERR_HSM;
 			ehi->action |= ATA_EH_HARDRESET;
@@ -2302,7 +2295,7 @@
 		    !(pp->ncq_flags & ncq_saw_dmas)) {
 			ata_stat = ap->ops->check_status(ap);
 			if (ata_stat & ATA_BUSY)
-				goto irq_exit;
+				return;
 
 			if (pp->defer_queue.defer_bits) {
 				DPRINTK("send next command\n");
@@ -2321,13 +2314,11 @@
 		rc = nv_swncq_dmafis(ap);
 	}
 
-irq_exit:
-	spin_unlock(&pp->lock);
 	return;
+
 irq_error:
 	ata_ehi_push_desc(ehi, "fis:0x%x", fis);
 	ata_port_freeze(ap);
-	spin_unlock(&pp->lock);
 	return;
 }
 


--------------080703060303060501060503--
