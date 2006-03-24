From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: kill E.D.D.
Date: Sat, 25 Mar 2006 01:33:34 +0900
Message-ID: <20060324163334.GC5288@htj.dyndns.org>
References: <20060324034556.GF25706@htj.dyndns.org> <44240337.8030509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:62696 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932456AbWCXQdl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 11:33:41 -0500
Received: by zproxy.gmail.com with SMTP id o37so868623nzf
        for <linux-ide@vger.kernel.org>; Fri, 24 Mar 2006 08:33:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44240337.8030509@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

E.D.D. has no user in-tree and mostly useless.  Kill it.  For possible
out-of-tree users, add a nice warning message and error handling if
LLDD doesn't report any useable reset mechanism (and thus tries to use
E.D.D.).

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

I left BUS_EDD constant alone as I have no idea know how those BUS_*
constants are used.  Tested on sata_sil, sata_promise, ata_piix and
ahci.

 drivers/scsi/libata-core.c |   98 +++++----------------------------------------
 include/linux/libata.h     |    1
 2 files changed, 13 insertions(+), 86 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index eda4c0c..516b1a6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1081,9 +1081,8 @@ unsigned int ata_pio_need_iordy(const st
  *
  *	Read ID data from the specified device.  ATA_CMD_ID_ATA is
  *	performed on ATA devices and ATA_CMD_ID_ATAPI on ATAPI
- *	devices.  This function also takes care of EDD signature
- *	misreporting (to be removed once EDD support is gone) and
- *	issues ATA_CMD_INIT_DEV_PARAMS for pre-ATA4 drives.
+ *	devices.  This function also issues ATA_CMD_INIT_DEV_PARAMS
+ *	for pre-ATA4 drives.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -1095,7 +1094,6 @@ static int ata_dev_read_id(struct ata_po
 			   unsigned int *p_class, int post_reset, u16 **p_id)
 {
 	unsigned int class = *p_class;
-	unsigned int using_edd;
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
 	u16 *id;
@@ -1104,12 +1102,6 @@ static int ata_dev_read_id(struct ata_po
 
 	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
 
-	if (ap->ops->probe_reset ||
-	    ap->flags & (ATA_FLAG_SRST | ATA_FLAG_SATA_RESET))
-		using_edd = 0;
-	else
-		using_edd = 1;
-
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
 
 	id = kmalloc(sizeof(id[0]) * ATA_ID_WORDS, GFP_KERNEL);
@@ -1139,32 +1131,9 @@ static int ata_dev_read_id(struct ata_po
 
 	err_mask = ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
-
 	if (err_mask) {
 		rc = -EIO;
 		reason = "I/O error";
-
-		if (err_mask & ~AC_ERR_DEV)
-			goto err_out;
-
-		/*
-		 * arg!  EDD works for all test cases, but seems to return
-		 * the ATA signature for some ATAPI devices.  Until the
-		 * reason for this is found and fixed, we fix up the mess
-		 * here.  If IDENTIFY DEVICE returns command aborted
-		 * (as ATAPI devices do), then we issue an
-		 * IDENTIFY PACKET DEVICE.
-		 *
-		 * ATA software reset (SRST, the default) does not appear
-		 * to have this problem.
-		 */
-		if ((using_edd) && (class == ATA_DEV_ATA)) {
-			u8 err = tf.feature;
-			if (err & ATA_ABORTED) {
-				class = ATA_DEV_ATAPI;
-				goto retry;
-			}
-		}
 		goto err_out;
 	}
 
@@ -2005,45 +1974,6 @@ static void ata_bus_post_reset(struct at
 		ap->ops->dev_select(ap, 0);
 }
 
-/**
- *	ata_bus_edd - Issue EXECUTE DEVICE DIAGNOSTIC command.
- *	@ap: Port to reset and probe
- *
- *	Use the EXECUTE DEVICE DIAGNOSTIC command to reset and
- *	probe the bus.  Not often used these days.
- *
- *	LOCKING:
- *	PCI/etc. bus probe sem.
- *	Obtains host_set lock.
- *
- */
-
-static unsigned int ata_bus_edd(struct ata_port *ap)
-{
-	struct ata_taskfile tf;
-	unsigned long flags;
-
-	/* set up execute-device-diag (bus reset) taskfile */
-	/* also, take interrupts to a known state (disabled) */
-	DPRINTK("execute-device-diag\n");
-	ata_tf_init(ap, &tf, 0);
-	tf.ctl |= ATA_NIEN;
-	tf.command = ATA_CMD_EDD;
-	tf.protocol = ATA_PROT_NODATA;
-
-	/* do bus reset */
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ata_tf_to_host(ap, &tf);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	/* spec says at least 2ms.  but who knows with those
-	 * crazy ATAPI devices...
-	 */
-	msleep(150);
-
-	return ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
-}
-
 static unsigned int ata_bus_softreset(struct ata_port *ap,
 				      unsigned int devmask)
 {
@@ -2115,7 +2045,7 @@ void ata_bus_reset(struct ata_port *ap)
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	u8 err;
-	unsigned int dev0, dev1 = 0, rc = 0, devmask = 0;
+	unsigned int dev0, dev1 = 0, devmask = 0;
 
 	DPRINTK("ENTER, host %u, port %u\n", ap->id, ap->port_no);
 
@@ -2138,18 +2068,8 @@ void ata_bus_reset(struct ata_port *ap)
 
 	/* issue bus reset */
 	if (ap->flags & ATA_FLAG_SRST)
-		rc = ata_bus_softreset(ap, devmask);
-	else if ((ap->flags & ATA_FLAG_SATA_RESET) == 0) {
-		/* set up device control */
-		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-		else
-			outb(ap->ctl, ioaddr->ctl_addr);
-		rc = ata_bus_edd(ap);
-	}
-
-	if (rc)
-		goto err_out;
+		if (ata_bus_softreset(ap, devmask))
+			goto err_out;
 
 	/*
 	 * determine by signature whether we have ATA or ATAPI devices
@@ -4535,6 +4455,14 @@ static struct ata_port * ata_host_add(co
 	int rc;
 
 	DPRINTK("ENTER\n");
+
+	if (!ent->port_ops->probe_reset &&
+	    !(ent->host_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
+		printk(KERN_ERR "ata%u: no reset mechanism available\n",
+		       port_no);
+		return NULL;
+	}
+
 	host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
 	if (!host)
 		return NULL;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0471922..9fcc061 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -161,7 +161,6 @@ enum {
 	ATA_QCFLAG_EH_SCHEDULED = (1 << 5), /* EH scheduled */
 
 	/* various lengths of time */
-	ATA_TMOUT_EDD		= 5 * HZ,	/* heuristic */
 	ATA_TMOUT_PIO		= 30 * HZ,
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
