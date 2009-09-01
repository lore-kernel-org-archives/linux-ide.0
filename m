From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching
 support
Date: Tue, 01 Sep 2009 21:28:55 +0900
Message-ID: <4A9D1387.6040709@kernel.org>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60754 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754448AbZIAMaM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Sep 2009 08:30:12 -0400
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Shane.

Huang, Shane wrote:
>> You can do
>>
>> 	pmp = fbs >> PORT_FBS_DWE_OFFSET;
>> 	if (pmp < ap->nr_pmp_links && 
>> ata_link_online(&ap->pmp_link[pmp])) {
>> 		link = &ap->pmp_link[pmp];
>> 		pp->fbs_need_dec = true;
>> 	}
> 
> PORT_FBS_SDE also need check, because(ahci v1.2  3.3.16):
> Device With Error (DWE): Set by hardware to the value of the
> Port Multiplier port number of the device that experienced a fatal
> error condition. This field is only valid when PxFBS.SDE = '1'.
> 
> So I'll update the code into:
> 	u32 fbs = readl(port_mmio + PORT_FBS);
> 	int pmp = fbs >> PORT_FBS_DWE_OFFSET;
> 
> 	if ((fbs & PORT_FBS_SDE) && (pmp < ap->nr_pmp_links) &&
> 	    ata_link_online(&ap->pmp_link[pmp])) {
> 		link = &ap->pmp_link[pmp];
> 		fbs_need_dec = true;
> 	}

Yeap, I missed the condition while trying to point out that the loop
wasn't necessary there.  Sorry.  :-P

>>>  	if (irq_stat & PORT_IRQ_IF_ERR) {
>>> -		host_ehi->err_mask |= AC_ERR_ATA_BUS;
>>> -		host_ehi->action |= ATA_EH_RESET;
>>> +		if (pp->fbs_need_dec)
>>> +			active_ehi->err_mask |= AC_ERR_DEV;
>>> +		else {
>>> +			host_ehi->err_mask |= AC_ERR_ATA_BUS;
>>> +			host_ehi->action |= ATA_EH_RESET;
>>> +		}
>>> +
>> Are you sure IF_ERR is device specific and doesn't require host link
>> reset?
> 
> Because I referred to the AHCI spec v1.2  9.3.6:
> An interface fatal error may be localized to a particular device or may
> be fatal to the entire port.....If the error is fatal to the entire
> port, then
> PxFBS.SDE shall be cleared to '0' by the hardware. Software should
> follow either the device specific or non-device specific error procedure
> depending on whether PxFBS.SDE is set to '1'.

Ah hah... thanks for the explanation.

>>> -	mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma,
>>> -				  GFP_KERNEL);
>>> +	/* check FBS capability */
>>> +	if ((hpriv->cap & HOST_CAP_FBS) && sata_pmp_supported(ap)) {
>>> +		void __iomem *port_mmio = ahci_port_base(ap);
>>> +		u32 cmd = readl(port_mmio + PORT_CMD);
>>> +		if (cmd & PORT_CMD_FBSCP)
>>> +			pp->fbs_supported = true;
>> Maybe whine a bit if CAP indicates FBS but PORT_CMD doesn't?
> 
> Sure, updated as below:
> 	if (cmd & PORT_CMD_FBSCP)
> 		pp->fbs_supported = true;
> 	else
> 		WARN_ON(1);

WARN_ON() would be a tad bit too scary.  Given that on certain
hardwares it would always trigger.  A dev_printk() would be better.

> OK, thanks for your nice suggestions, I'll have to submit v3 later...

Nice work!  Thanks a lot for doing it.

-- 
tejun
