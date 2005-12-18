From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/14] sata_sil24: add hardreset
Date: Sun, 18 Dec 2005 22:44:35 +0900
Message-ID: <20051218134435.GH31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:20085 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965110AbVLRNol (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:44:41 -0500
Received: by zproxy.gmail.com with SMTP id 13so1084490nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:44:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Now that libata is smart enough to handle both soft and hard resets,
add hardreset method.  Note that sil24 hardreset doesn't supply
signature; still, the new reset mechanism can make good use of it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-12-18 18:35:13.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-12-18 18:35:35.000000000 +0900
@@ -250,6 +250,7 @@ static u32 sil24_scr_read(struct ata_por
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static int sil24_softreset(struct ata_port *ap, unsigned int *classes);
+static int sil24_hardreset(struct ata_port *ap, unsigned int *classes);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
@@ -307,6 +308,7 @@ static const struct ata_port_operations 
 	.tf_read		= sil24_tf_read,
 
 	.soft_reset		= sil24_softreset,
+	.hard_reset		= sil24_hardreset,
 	.post_reset		= ata_std_postreset,
 
 	.qc_prep		= sil24_qc_prep,
@@ -485,6 +487,14 @@ static int sil24_softreset(struct ata_po
 	return 0;
 }
 
+static int sil24_hardreset(struct ata_port *ap, unsigned int *classes)
+{
+	unsigned int dummy_classes[2];
+
+	/* sil24 doesn't report device signature after hard reset */
+	return ata_std_hardreset_sata(ap, dummy_classes);
+}
+
 static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
 				 struct sil24_sge *sge)
 {
