From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/14] libata: implement new reset mechanism
Date: Sun, 18 Dec 2005 22:38:33 +0900
Message-ID: <20051218133833.GC31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:4134 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932706AbVLRNij (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:38:39 -0500
Received: by zproxy.gmail.com with SMTP id 14so1714877nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:38:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Implement new reset mechanism.  This patch adds the following ata
operations.

int (*soft_reset) (struct ata_port *ap, unsigned int *classes);
int (*hard_reset) (struct ata_port *ap, unsigned int *classes);
void (*post_reset) (struct ata_port *ap, const unsigned int *classes);

In a reset trial, ->soft_reset and ->hard_reset may be called
multiple times before succeeding and post_reset is called only once
after reset finally succeeds.

A new function ata_reset() is added.  This function intelligently
drives reset process using above operations.  All resets must be
performed by calling ata_reset() with appropriate flags.  ata_reset()
prefers ->soft_reset but can fall back to ->hard_reset and knows how
to deal with reset methods which can't report signature.

ata_reset() does not modify any libata data structure, it just
performs reset using requested methods and report completion status
and classes to the caller, making it easily useable from EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-12-18 17:58:18.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-12-18 17:59:44.000000000 +0900
@@ -1424,7 +1424,24 @@ static int ata_bus_probe(struct ata_port
 {
 	unsigned int i, found = 0;
 
-	ap->ops->phy_reset(ap);
+	if (ap->ops->phy_reset)
+		ap->ops->phy_reset(ap);
+	else {
+		unsigned int classes[2];
+		int ret;
+
+		ata_port_probe(ap);
+
+		ret = ata_reset(ap, ATA_RESET_ANY|ATA_RESET_CLASSIFY, classes);
+		if (ret == 0) {
+			ap->device[0].class = classes[0];
+			ap->device[1].class = classes[1];
+		} else {
+			printk("ata%u: reset failed, disabling port\n", ap->id);
+			ata_port_disable(ap);
+		}
+	}
+
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		goto err_out;
 
@@ -2134,6 +2151,111 @@ err_out:
 	DPRINTK("EXIT\n");
 }
 
+/**
+ *	ata_reset - reset host port and associated ATA channel
+ *	@ap: port to reset
+ *	@flags: ATA_RESET_* flags
+ *	@r_classes: resulting classes of attached devices
+ *
+ *	This function tries to reset the given port.  Low-level
+ *	drivers may supply either one or both of hard and soft reset
+ *	methods, and the caller can tell ata_reset() which ones to use
+ *	via ATA_RESET_SOFT, HARD and ANY flags.  ata_reset() always
+ *	tries to use softreset if possible.
+ *
+ *	If ATA_RESET_CLASSIFY flag is given, ata_reset() will try
+ *	allowed reset methods until classification is done.
+ *
+ *	Reset methods may or may not classify attached devices.  For
+ *	example, it's not possible to obtain signature after hard
+ *	reset on some SATA controllers.  However, at least one reset
+ *	method should classify attached devices.
+ *
+ *	If a reset method doesn't support classification, it just
+ *	leaves @classes unmodified on return.  Also, it's allowed for
+ *	reset methods to classify only the first device.  If the first
+ *	one is classifed but the second isn't, the second device is
+ *	considered to be ATA_DEV_NONE.
+ *
+ *	This function returns 0 on success, -EINVAL if the ap doesn't
+ *	support specified reset methods, -ENODEV if ATA_RESET_CLASSIFY
+ *	is specified but classification fails, and any error code from
+ *	reset methods if reset fails.
+ */
+
+int ata_reset(struct ata_port *ap, unsigned int flags, unsigned int *r_classes)
+{
+	const unsigned int unknown[2] = { ATA_DEV_UNKNOWN, ATA_DEV_UNKNOWN };
+	unsigned int classes[2];
+	int ret = 0;
+
+	DPRINTK("ENTER\n");
+
+	if (ap->ops->soft_reset == NULL)
+		flags &= ~ATA_RESET_SOFT;
+	if (ap->ops->hard_reset == NULL)
+		flags &= ~ATA_RESET_HARD;
+
+	if (!(flags & (ATA_RESET_SOFT | ATA_RESET_HARD))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+ retry:
+	if (flags & ATA_RESET_SOFT) {
+		memcpy(classes, unknown, sizeof(classes));
+		ret = ap->ops->soft_reset(ap, classes);
+		if (ret == 0) {
+			if (!(flags & ATA_RESET_CLASSIFY) ||
+			    classes[0] != ATA_DEV_UNKNOWN)
+				goto success;
+			/* no signature on SRST, try HRST */
+			flags &= ~ATA_RESET_SOFT;
+			ret = -ENODEV;	/* no sigature */
+		}
+		/* SRST failed, try HRST */
+	}
+
+	if (flags & ATA_RESET_HARD) {
+		memcpy(classes, unknown, sizeof(classes));
+		ret = ap->ops->hard_reset(ap, classes);
+		if (ret == 0) {
+			if (!(flags & ATA_RESET_CLASSIFY) ||
+			    classes[0] != ATA_DEV_UNKNOWN)
+				goto success;
+			/* no signature on HRST, retry SRST */
+			flags &= ~ATA_RESET_HARD;
+			ret = -ENODEV;	/* no sigature */
+			goto retry;
+		}
+		/* HRST failed, give up */
+	}
+
+	goto out;
+
+ success:
+	if (classes[0] == ATA_DEV_UNKNOWN) {
+		/* classification not performed, use old values */
+		classes[0] = ap->device[0].class;
+		classes[1] = ap->device[1].class;
+	} else if (classes[1] == ATA_DEV_UNKNOWN) {
+		/* only dev0 is classifed, assume NONE for dev1 */
+		classes[1] = ATA_DEV_NONE;
+	}
+
+	if (ap->ops->post_reset)
+		ap->ops->post_reset(ap, classes);
+
+	if (r_classes) {
+		r_classes[0] = classes[0];
+		r_classes[1] = classes[1];
+	}
+
+ out:
+	DPRINTK("EXIT, ret=%d\n", ret);
+	return ret;
+}
+
 static void ata_pr_blacklisted(const struct ata_port *ap,
 			       const struct ata_device *dev)
 {
@@ -4985,6 +5107,7 @@ EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
+EXPORT_SYMBOL_GPL(ata_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-12-18 17:58:10.000000000 +0900
+++ work/include/linux/libata.h	2005-12-18 18:00:31.000000000 +0900
@@ -115,9 +115,9 @@ enum {
 	ATA_FLAG_PORT_DISABLED	= (1 << 2), /* port is disabled, ignore it */
 	ATA_FLAG_SATA		= (1 << 3),
 	ATA_FLAG_NO_LEGACY	= (1 << 4), /* no legacy mode check */
-	ATA_FLAG_SRST		= (1 << 5), /* use ATA SRST, not E.D.D. */
+	ATA_FLAG_SRST		= (1 << 5), /* (obsolete) use ATA SRST, not E.D.D. */
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
-	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
+	ATA_FLAG_SATA_RESET	= (1 << 7), /* (obsolete) use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
 					     * proper HSM is in place. */
@@ -170,6 +170,12 @@ enum {
 	/* Masks for port functions */
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
+
+	/* Flags for reset function */
+	ATA_RESET_SOFT		= (1 << 0),
+	ATA_RESET_HARD		= (1 << 1),
+	ATA_RESET_ANY		= ATA_RESET_SOFT | ATA_RESET_HARD,
+	ATA_RESET_CLASSIFY	= (1 << 2),
 };
 
 enum hsm_task_states {
@@ -373,7 +379,11 @@ struct ata_port_operations {
 	u8   (*check_altstatus)(struct ata_port *ap);
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
 
-	void (*phy_reset) (struct ata_port *ap);
+	void (*phy_reset) (struct ata_port *ap); /* obsolete */
+
+	int (*soft_reset) (struct ata_port *ap, unsigned int *classes);
+	int (*hard_reset) (struct ata_port *ap, unsigned int *classes);
+	void (*post_reset) (struct ata_port *ap, const unsigned int *classes);
 	void (*post_set_mode) (struct ata_port *ap);
 
 	int (*check_atapi_dma) (struct ata_queued_cmd *qc);
@@ -430,6 +440,7 @@ extern void ata_port_probe(struct ata_po
 extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
+extern int ata_reset(struct ata_port *ap, unsigned int flags, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
