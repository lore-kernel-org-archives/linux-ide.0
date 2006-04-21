From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/14] ahci: convert to new EH
Date: Fri, 21 Apr 2006 10:20:10 +0900
Message-ID: <4448334A.4030204@gmail.com>
References: <114476330353-git-send-email-htejun@gmail.com> <1145525177.3417.65.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:64064 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932098AbWDUBUD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Apr 2006 21:20:03 -0400
Received: by nz-out-0102.google.com with SMTP id n1so342553nzf
        for <linux-ide@vger.kernel.org>; Thu, 20 Apr 2006 18:20:02 -0700 (PDT)
In-Reply-To: <1145525177.3417.65.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Tue, 2006-04-11 at 22:48 +0900, Tejun Heo wrote:
>> Convert AHCI to new EH.  Unfortunately, ICH7 AHCI reacts badly if IRQ
>> mask is diddled during operation.  So, freezing is implemented by
>> unconditionally clearing interrupt conditions while frozen.
> 
>>  
>> -static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
>> +static inline void ahci_host_intr(struct ata_port *ap)
>>  {
>> +	struct ahci_port_priv *pp = ap->private_data;
>>  	void __iomem *mmio = ap->host_set->mmio_base;
>>  	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
>> -	u32 status, serr, ci;
>> -
>> -	serr = readl(port_mmio + PORT_SCR_ERR);
>> -	writel(serr, port_mmio + PORT_SCR_ERR);
>> +	u32 status, serror, ci;
>> +	unsigned int eh_flags;
>>  
>>  	status = readl(port_mmio + PORT_IRQ_STAT);
>>  	writel(status, port_mmio + PORT_IRQ_STAT);
>>  
>> -	ci = readl(port_mmio + PORT_CMD_ISSUE);
>> -	if (likely((ci & 0x1) == 0)) {
>> -		if (qc) {
>> -			WARN_ON(qc->err_mask);
>> -			ata_qc_complete(qc);
>> -			qc = NULL;
>> -		}
>> +	/* AHCI gets unhappy if IRQ mask is diddled with while the
>> +	 * port is active, so we cannot disable IRQ when freezing.
>> +	 * Clear IRQ conditions and hope screaming IRQs don't happen.
>> +	 */
>> +	if (ap->flags & ATA_FLAG_FROZEN) {
>> +		/* some AHCI errors hang the controller until SError
>> +		 * is cleared.  Store and clear it.
>> +		 */
>> +		serror = scr_read(ap, SCR_ERROR);
>> +		scr_write(ap, SCR_ERROR, serror);
>> +		pp->eh_irq_stat |= status;
>> +		pp->eh_serror |= serror;
>> +		return;
>>  	}
>>  
>> -	if (status & PORT_IRQ_FATAL) {
>> -		unsigned int err_mask;
>> -		if (status & PORT_IRQ_TF_ERR)
>> -			err_mask = AC_ERR_DEV;
>> -		else if (status & PORT_IRQ_IF_ERR)
>> -			err_mask = AC_ERR_ATA_BUS;
>> -		else
>> -			err_mask = AC_ERR_HOST_BUS;
>> -
>> -		/* command processing has stopped due to error; restart */
>> -		ahci_restart_port(ap, status);
>> -
>> -		if (qc) {
>> -			qc->err_mask |= err_mask;
>> -			ata_qc_complete(qc);
>> +	if (!(status & PORT_IRQ_ERROR)) {
>> +		struct ata_queued_cmd *qc;
>> +
>> +		if ((qc = ata_qc_from_tag(ap, ap->active_tag))) {
>> +			ci = readl(port_mmio + PORT_CMD_ISSUE);
>> +			if ((ci & 0x1) == 0) {
>> +				ata_qc_complete(qc);
>> +				return;
>> +			}
>>  		}
>> +
>> +		if (ata_ratelimit())
>> +			printk(KERN_INFO "ata%u: spurious interrupt "
>> +			       "(irq_stat 0x%x active_tag %d)\n",
>> +			       ap->id, status, ap->active_tag);
>> +
>> +		return;
>>  	}
>>  
>> -	return 1;
>> +	/* Something weird is going on.  Hand over to EH. */
>> +	serror = scr_read(ap, SCR_ERROR);
>> +	scr_write(ap, SCR_ERROR, serror);
>> +
>> +	pp->eh_irq_stat = status;
>> +	pp->eh_serror = serror;
>> +
>> +	eh_flags = ATA_EH_ABORT;
>> +	if (status & PORT_IRQ_FREEZE)
>> +		eh_flags |= ATA_EH_FREEZE;
>> +
>> +	ata_eh_schedule_port(ap, eh_flags);
>>  }
>>  
> 
> Anther problem with this patch is that interrupts happened
> when port is in ATA_FLAG_FROZEN state are recorded in pp->eh_irq_stat.
> So a later user-initiated warm-unplug operation might trigger EH
> to handle the error conditions previously recorded in pp->eh_irq_stat.
> 

Yeap, correct again.  The problem is fixed in my repository but saving
stuff to pp and analyze later idea didn't work very well for PM support
(sil24 can push multiple commands to multiple devices and multiple of
them can fail) so I'm stripping that out and pushing it to interrupt
handler.

Thanks for experimenting with this.  Oh.. and one more thing.  Have you
noticed that the first hotplug fails to attach the SCSI device?  This is
because setting SCS_HOTPLUG_PLUG is moved to the end of
ata_eh_scsi_hotplug() from ata_eh_hotplug() by quilt (I changed
ata_eh_hotplug() and while pushing, 'patch' resolved it by moving the
call...).

-- 
tejun
