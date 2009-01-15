From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] pata_via.c: Support VX855 and future chips whose
 IDE controller use 0x0571.
Date: Thu, 15 Jan 2009 22:27:32 +0900
Message-ID: <496F39C4.8050603@kernel.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087EC568@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37296 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756943AbZAON1h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jan 2009 08:27:37 -0500
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087EC568@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: linux-ide@vger.kernel.org, HaraldWelte@viatech.com, BruceChang@via.com.tw

JosephChan@via.com.tw wrote:
>>> +	if (ap->port_no == 0 && pdev->device == 0xC409) {
>>> +		pci_read_config_dword(pdev, 0x52, &ata66);
>>> +		return (ata66 & 0x10)  ? ATA_CBL_PATA80 : 
>> ATA_CBL_PATA40;
>>> +	} else if (ap->port_no == 1 && pdev->device == 0xC409) {
>>> +		DPRINTK("C409 only has one pata channel\n");
>>> +		return ATA_CBL_PATA_UNK;
>>> +	}
>> Eh.. can you add 0xC409 entry like other controllers and put 
>> necessary restrictions there?
>>
> 
> It's a pity that we don't have corresponding registers for
> identifying the single port controller. So, we just can do this by
> checking the device ID at present.

I feel a bit confused so please correct me if I'm babbling.  Can't you
add { PCI_VDEVICE(VIA, 0xC409), FLAGS_OR_IDENTIFIER } to pci_device_id
table and use different port_info on it?  If that's too different from
how other devices are beign identified, you can just add the
corresponding logic to init_one() and use, say, via_single_port_info
there instead of doing it deep in the reset sequence.

>>>  static void via_tf_load(struct ata_port *ap, const struct 
>>> ata_taskfile *tf)  {
>>> -	struct ata_taskfile tmp_tf;
>>> +	struct ata_ioports *ioaddr = &ap->ioaddr;
>>>  
>>> -	if (ap->ctl != ap->last_ctl && !(tf->flags & 
>> ATA_TFLAG_DEVICE)) {
>>> -		tmp_tf = *tf;
>>> -		tmp_tf.flags |= ATA_TFLAG_DEVICE;
>>> -		tf = &tmp_tf;
>>> +	if (tf->ctl != ap->last_ctl) {
>>> +		iowrite8(tf->ctl, ioaddr->ctl_addr);
>>> +		iowrite8(tf->device, ioaddr->device_addr);
>>>  	}
>>> +
>>>  	ata_sff_tf_load(ap, tf);
>> Can you please explain why this change is necessary?  And if 
>> it's necessary, please put it in a separate patch.
>>
> 
> Yes,  I will separate it.

Thanks.

-- 
tejun
