From: Jeff Garzik <jgarzik@pobox.com>
Subject: [Fwd: [PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)]
Date: Wed, 23 Feb 2005 21:35:56 -0500
Message-ID: <421D3D8C.1090709@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010101020300000407030006"
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33669 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261760AbVBXCgW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 21:36:22 -0500
Received: from [69.134.152.124] (helo=[10.10.10.88])
	by parcelfarce.linux.theplanet.co.uk with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.33)
	id 1D48rV-0005av-8Y
	for linux-ide@vger.kernel.org; Thu, 24 Feb 2005 02:36:21 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010101020300000407030006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------010101020300000407030006
Content-Type: message/rfc822;
 name="[PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)"

Message-ID: <421D3D33.9060707@pobox.com>
Date: Wed, 23 Feb 2005 21:34:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Kuschak <bkuschak@yahoo.com>
CC: linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?=22=5C=22Rog=E9rio=5C=22?=
 =?ISO-8859-1?Q?_Brito=22?= <rbrito@ime.usp.br>
Subject: [PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
References: <20050224015859.55191.qmail@web40910.mail.yahoo.com>
In-Reply-To: <20050224015859.55191.qmail@web40910.mail.yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------090407040907030700050103"

This is a multi-part message in MIME format.
--------------090407040907030700050103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Does this patch do anything useful?

	Jeff




--------------090407040907030700050103
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_sil.c 1.44 vs edited =====
--- 1.44/drivers/scsi/sata_sil.c	2005-02-17 19:43:51 -05:00
+++ edited/drivers/scsi/sata_sil.c	2005-02-23 21:27:18 -05:00
@@ -65,6 +65,7 @@
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void sil_post_set_mode (struct ata_port *ap);
+static void sil_tf_load(struct ata_port *ap, struct ata_taskfile *tf);
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
@@ -130,7 +131,7 @@
 static struct ata_port_operations sil_ops = {
 	.port_disable		= ata_port_disable,
 	.dev_config		= sil_dev_config,
-	.tf_load		= ata_tf_load,
+	.tf_load		= sil_tf_load,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
@@ -197,6 +198,69 @@
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
+
+static void sil_irq_enable(struct ata_port *ap, int disable)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	u32 tmp, new;
+	u32 bit = 1 << (22 + ap->port_no);
+
+	tmp = readl(mmio + SIL_SYSCFG);
+	if (disable)
+		new = tmp | bit;
+	else
+		new = tmp & ~bit;
+	if (new != tmp)
+		writel(new, mmio + SIL_SYSCFG);
+}
+
+static void sil_tf_load(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+
+	if (tf->ctl != ap->last_ctl) {
+		sil_irq_enable(ap, tf->ctl & ATA_NIEN);
+		writeb(tf->ctl, (void __iomem *) ap->ioaddr.ctl_addr);
+		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
+	}
+
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		writeb(tf->hob_feature, (void __iomem *) ioaddr->feature_addr);
+		writeb(tf->hob_nsect, (void __iomem *) ioaddr->nsect_addr);
+		writeb(tf->hob_lbal, (void __iomem *) ioaddr->lbal_addr);
+		writeb(tf->hob_lbam, (void __iomem *) ioaddr->lbam_addr);
+		writeb(tf->hob_lbah, (void __iomem *) ioaddr->lbah_addr);
+		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->hob_feature,
+			tf->hob_nsect,
+			tf->hob_lbal,
+			tf->hob_lbam,
+			tf->hob_lbah);
+	}
+
+	if (is_addr) {
+		writeb(tf->feature, (void __iomem *) ioaddr->feature_addr);
+		writeb(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
+		writeb(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
+		writeb(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
+		writeb(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
+		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+			tf->feature,
+			tf->nsect,
+			tf->lbal,
+			tf->lbam,
+			tf->lbah);
+	}
+
+	if (tf->flags & ATA_TFLAG_DEVICE) {
+		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
+		VPRINTK("device 0x%X\n", tf->device);
+	}
+
+	ata_wait_idle(ap);
+}
 
 static void sil_post_set_mode (struct ata_port *ap)
 {

--------------090407040907030700050103--


--------------010101020300000407030006--
