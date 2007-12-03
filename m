From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 15:40:33 -0500
Message-ID: <475469C1.2080700@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	<BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	<20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	<47543C58.4040106@rtr.ca>	<475447A0.2010101@rtr.ca>	<47544B2F.5080007@pobox.com>	<47544BAA.1020901@rtr.ca>	<BD261180E6D35F4D9D32F3E44FD3D9010ADF35A5@EMPBEDEX.empirix.com>	<47544DA9.3070702@rtr.ca>	<47544E74.3000608@rtr.ca> <20071203184204.1a2d7e35@the-village.bc.nu> <47545503.2070006@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3390 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbXLCUkf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 15:40:35 -0500
In-Reply-To: <47545503.2070006@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, Jeff Garzik <jgarzik@pobox.com>, hp@syntomax.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> Alan Cox wrote:
>>> Confirmed.  It writes "lgcy" + stuff into the 9th sector of the drive
>>> (for my "Legacy" drive).
>>
>> Thats quite nasty. Given that users putting volumes unpartitioned on
>> drives may see actual data corruption and loss perhaps we should
>> blacklist that controller variant with a large warning ?
> ..
> 
> Yeah, that's quite obnoxious of Highpoint to just arbitrarily overwrite 
> data.
> 
> Some warnings would probably be quite useful here.
> 
> We could log a WARNING the first few times (after boot)
> whenever we see software writing to that sector.
> Do this with a hack in mv_qc_prep or mv_qc_issue ?
> 
> Or even just fail any write to that sector, so that the error
> gets propagated all the way back to usermode where it might be visible?
> 
> Plus some big nasty "awareness" messages at boot regardless.
...

Something like this, perhaps.

Comments, suggestions ?

It might be a good idea to also change qc_prep() semantics
to allow the LLD to fail a request from there, rather than
having to defer it to qc_issue(), (as done in this hack).


--- old/drivers/ata/libata-core.c	2007-12-03 15:29:42.000000000 -0500
+++ linux/drivers/ata/libata-core.c	2007-12-03 15:21:15.000000000 -0500
@@ -7568,6 +7568,7 @@
 EXPORT_SYMBOL_GPL(sata_print_link_status);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
+EXPORT_SYMBOL_GPL(ata_tf_read_block);
 EXPORT_SYMBOL_GPL(ata_check_status);
 EXPORT_SYMBOL_GPL(ata_altstatus);
 EXPORT_SYMBOL_GPL(ata_exec_command);
--- old/drivers/ata/libata.h	2007-12-03 15:29:37.000000000 -0500
+++ linux/drivers/ata/libata.h	2007-12-03 15:21:23.000000000 -0500
@@ -64,7 +64,6 @@
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
 			   unsigned int tag);
-extern u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev);
 extern void ata_dev_disable(struct ata_device *dev);
 extern void ata_port_flush_task(struct ata_port *ap);
 extern unsigned ata_exec_internal(struct ata_device *dev,
--- old/drivers/ata/sata_mv.c	2007-12-03 15:29:43.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2007-12-03 15:33:17.000000000 -0500
@@ -308,6 +308,7 @@
 	MV_HP_GEN_II		= (1 << 7),	/* Generation II: 60xx */
 	MV_HP_GEN_IIE		= (1 << 8),	/* Generation IIE: 6042/7042 */
 	MV_HP_PCIE		= (1 << 9),	/* PCIe bus/regs: 7042 */
+	MV_HP_RESERVED_LBA8	= (1 << 10),
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
@@ -1280,19 +1281,38 @@
 {
 	struct ata_port *ap = qc->ap;
 	struct mv_port_priv *pp = ap->private_data;
+	struct mv_host_priv *hpriv = ap->host->private_data;
 	struct mv_crqb_iie *crqb;
-	struct ata_taskfile *tf;
+	struct ata_taskfile *tf = &qc->tf;
 	unsigned in_index;
 	u32 flags = 0;
 
-	if (qc->tf.protocol != ATA_PROT_DMA)
+	if (tf->protocol != ATA_PROT_DMA)
 		return;
 
 	/* Fill in Gen IIE command request block
 	 */
-	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
+	if (!(tf->flags & ATA_TFLAG_WRITE))
 		flags |= CRQB_FLAG_READ;
 
+	if (tf->flags & ATA_TFLAG_WRITE) {
+		if (hpriv->hp_flags & MV_HP_RESERVED_LBA8) {
+			u64 start = ata_tf_read_block(tf, qc->dev);
+			u32 nsect = tf->nsect;
+			if (tf->flags & ATA_TFLAG_LBA48)
+				nsect |= tf->hob_nsect;
+			if (!nsect)
+				nsect = 256; /* good enough for here */
+			if (start <= 8 && (start + nsect) >= 8) {
+				printk(KERN_WARNING "ata%u: sector 8 is "
+					"reserved by Highpoint BIOS\n",
+					ap->print_id);
+				qc->err_mask |= AC_ERR_INVALID;
+				return;
+			}
+		}
+	}
+
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 	flags |= qc->tag << CRQB_IOID_SHIFT;	/* "I/O Id" is -really-
@@ -1306,7 +1326,6 @@
 	crqb->addr_hi = cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
 	crqb->flags = cpu_to_le32(flags);
 
-	tf = &qc->tf;
 	crqb->ata_cmd[0] = cpu_to_le32(
 			(tf->command << 16) |
 			(tf->feature << 24)
@@ -1353,6 +1372,8 @@
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	u32 in_index;
 
+	if (qc->err_mask & AC_ERR_INVALID) /* from qc_prep */
+		return AC_ERR_INVALID;
 	if (qc->tf.protocol != ATA_PROT_DMA) {
 		/* We're about to send a non-EDMA capable command to the
 		 * port.  Turn off EDMA so there won't be problems accessing
@@ -2503,6 +2524,14 @@
 
 	case chip_7042:
 		hp_flags |= MV_HP_PCIE;
+		if (pdev->vendor == PCI_VENDOR_ID_TTI) {
+			if (pdev->device == 0x2300
+			 || pdev->device == 0x2310) {
+				hp_flags |= MV_HP_RESERVED_LBA8;
+				printk(KERN_WARNING "sata_mv:  RocketRAID BIOS "
+					"corrupts LBA 8 on connected drives\n");
+			}
+		}
 	case chip_6042:
 		hpriv->ops = &mv6xxx_ops;
 		hp_flags |= MV_HP_GEN_IIE;
--- old/include/linux/libata.h	2007-12-03 15:29:42.000000000 -0500
+++ linux/include/linux/libata.h	2007-12-03 15:21:38.000000000 -0500
@@ -840,6 +840,7 @@
 /*
  * Default driver ops implementations
  */
+extern u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev);
 extern void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
 extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
