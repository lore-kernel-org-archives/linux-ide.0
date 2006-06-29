From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 4/9] libata-core.c conversion
Date: Thu, 29 Jun 2006 19:07:27 +0200
Message-ID: <20060629170727.GB20246@gollum.tnic>
References: <20060629161001.GE23122@zmei.tnic> <44A40502.3040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp108.plus.mail.re2.yahoo.com ([206.190.53.33]:3512 "HELO
	smtp108.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751013AbWF2RHa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 13:07:30 -0400
Content-Disposition: inline
In-Reply-To: <44A40502.3040509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Fri, Jun 30, 2006 at 01:51:14AM +0900, Tejun Heo wrote:
> Borislav Petkov wrote:
> >@@ -1341,20 +1341,18 @@ int ata_dev_configure(struct ata_device 
> > 	unsigned int xfer_mask;
> > 	int i, rc;
> > 
> >-	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
> >-		ata_dev_printk(dev, KERN_INFO,
> >+	if (!ata_dev_enabled(dev)) {
> >+		ata_dev_printk(dev, ATA_MSG_INFO,
> > 			       "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
> > 			       __FUNCTION__, ap->id, dev->devno);
> > 		return 0;
> 
> ATA_MSG_TRACE.
yep.

<snip>
> >@@ -1399,8 +1396,8 @@ int ata_dev_configure(struct ata_device 
> > 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
> > 
> > 			/* print device info to dmesg */
> >-			if (ata_msg_info(ap))
> >-				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
> >+			if (print_info)
> >+				ata_dev_printk(dev, ATA_MSG_DRV, "ATA-%d, "
> > 					"max %s, %Lu sectors: %s %s\n",
> > 					ata_id_major_version(id),
> > 					ata_mode_string(xfer_mask),
> 
> Hmmm.. not INFO?
yep, INFO.

<snip>
> >@@ -3456,7 +3466,8 @@ static int ata_sg_setup(struct ata_queue
> > 	struct scatterlist *lsg = &sg[qc->n_elem - 1];
> > 	int n_elem, pre_n_elem, dir, trim_sg = 0;
> > 
> >-	VPRINTK("ENTER, ata%u\n", ap->id);
> >+	ata_port_printk(ap, ATA_MSG_SG, "%s: ENTER, ata%u\n", 
> >+			__FUNCTION__, ap->id);
> 
> TRACE???  Not sure.
although, this is SG-specific (ata_sg_setup) , so which one?
> > 	WARN_ON(!(qc->flags & ATA_QCFLAG_SG));
> > 
> > 	/* we must lengthen transfers to end on a 32-bit boundary */
> >@@ -3681,7 +3695,9 @@ static void ata_pio_sector(struct ata_qu
> > 	page = nth_page(page, (offset >> PAGE_SHIFT));
> > 	offset %= PAGE_SIZE;
> > 
> >-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : 
> >"read");
> >+	ata_port_printk(ap, ATA_MSG_CMD, "%s: data %s\n", 
> >+			__FUNCTION__,
> >+			qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
> 
> Yeap, this is CMD.  :-)
Yei!

<snip>
> >@@ -5241,7 +5272,7 @@ static void ata_host_init(struct ata_por
> > 	/* turn on all debugging levels */
> > 	ap->msg_enable = 0x00FF;
> > #elif defined(ATA_DEBUG)
> >-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | 
> >ATA_MSG_WARN | ATA_MSG_ERR;
> >+	ap->msg_enable = ATA_MSG_VDEBUG | ATA_MSG_INFO | ATA_MSG_DRV | 
> >ATA_MSG_WARN | ATA_MSG_ERR;
> 
> I think it should be ATA_MSG_DEBUG | ATA_MSG_DRV | ATA_MSG_INFO | 
> ATA_MSG_WARN | ATA_MSG_ERR.
> 
> > #else
> > 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
> 
> ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_WARN | ATA_MSG_ERR
This is the default level, are you sure INFO belongs here since it is for
EH/feats etc?

Regards,
    Boris.

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

