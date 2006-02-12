From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: add information message about PCS
Date: Sun, 12 Feb 2006 19:17:34 +0900
Message-ID: <20060212101734.GC20979@htj.dyndns.org>
References: <20060212100841.GB20979@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:26032 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932375AbWBLKRi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 05:17:38 -0500
Received: by pproxy.gmail.com with SMTP id n25so870529pyg
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 02:17:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20060212100841.GB20979@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: jfs@keytradebank.com, kmannth@gmail.com, 0602@eq.cz

So far, the incorrect PCS problem has only been reported on two ICH5
SATA setups and masked PCS was zero in both cases.  This patch makes
ata_piix print an information message about ignore_PCS option in such
cases.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, this patch makes ata_piix advertise about ignore_PCS option if
the PCS value seems suspicious on ICH5 sata.  IMHO, this can make
lives much easier for those who are trying to figure out this rather
obscure problem with small amount of added code.

 drivers/scsi/ata_piix.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: work1/drivers/scsi/ata_piix.c
===================================================================
--- work1.orig/drivers/scsi/ata_piix.c	2006-02-12 18:55:25.000000000 +0900
+++ work1/drivers/scsi/ata_piix.c	2006-02-12 18:55:41.000000000 +0900
@@ -101,6 +101,7 @@ enum {
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
 
+	PIIX_FLAG_FLAKY_PCS	= (1 << 26), /* PCS reportedly flaky */
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
 	PIIX_FLAG_COMBINED	= (1 << 29), /* combined mode possible */
@@ -274,7 +275,7 @@ static struct ata_port_info piix_port_in
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED |
-				  PIIX_FLAG_CHECKINTR,
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_FLAKY_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -439,6 +440,11 @@ static int piix_sata_probe (struct ata_p
 		return 1;
 	}
 
+	if (orig_mask == 0 && ap->flags & PIIX_FLAG_FLAKY_PCS)
+		printk(KERN_INFO "ata%u: PIIX PCS is 0x%x, consider using "
+		       "ignore_PCS option to force device probing\n",
+		       ap->id, pcs);
+
 	/* TODO: this is vaguely wrong for ICH6 combined mode,
 	 * where only two of the four SATA ports are mapped
 	 * onto a single ATA channel.  It is also vaguely inaccurate
