From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fix class handling in ata_bus_probe()
Date: Mon, 13 Mar 2006 03:34:00 +0900
Message-ID: <44146998.6070203@gmail.com>
References: <44144172.9040304@garzik.org> <20060312165701.GA9051@htj.dyndns.org> <44146758.6090006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.201]:4703 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751582AbWCLSeQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 13:34:16 -0500
Received: by xproxy.gmail.com with SMTP id i30so209489wxd
        for <linux-ide@vger.kernel.org>; Sun, 12 Mar 2006 10:34:15 -0800 (PST)
In-Reply-To: <44146758.6090006@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> ata_bus_probe() didn't set classes[] properly for port disabled case
>> of ->phy_reset() compatibility path.  This patch moves classes[]
>> initialization and normalization out of ->probe_reset block such that
>> it applies to both ->probe_reset and ->phy_reset paths.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>> Jeff, the sata_nv case is similar bug as what Jiri reported, except
>> that this one is affecting ->phy_reset path.
>>
>> This patch should fix sata_nv.  For sata_mv, I have no idea at all.
> 
> 
> 
> Yep, that solves that bug.  I spotted another minor one:
> 
>> libata version 1.20 loaded.
>> sata_nv 0000:00:07.0: version 0.8
>> ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
>> GSI 18 sharing vector 0xC1 and IRQ 18
>> ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LSA0] -> GSI 23 (level, 
>> high) -> IRQ 193
>> PCI: Setting latency timer of device 0000:00:07.0 to 64
>> ata1: SATA max UDMA/133 cmd 0x28D0 ctl 0x28FA bmdma 0x28B0 irq 193
>> ata2: SATA max UDMA/133 cmd 0x28D8 ctl 0x28FE bmdma 0x28B8 irq 193
>> ata1: SATA link up 1.5 Gbps (SStatus 113)
>> ata1: dev 0 cfg 49:2f00 82:3469 83:7f61 84:4003 85:3469 86:3e41 
>> 87:4003 88:407f
>> ata1: dev 0 ATA-6, max UDMA/133, 488281250 sectors: LBA48
>> nv_sata: Primary device added
>> nv_sata: Primary device removed
>> nv_sata: Secondary device added
>> nv_sata: Secondary device removed
>> ata1: dev 0 cfg 49:2f00 82:3469 83:7f61 84:4003 85:3469 86:3e41 
>> 87:4003 88:407f
>> ata1: dev 0 configured for UDMA/133
> 
> 
> The dev 0 id words are printed twice, but should not be.  Or, the second 
> one should only be printed if something relevant changed.
> 

The duplicated messages are KERN_DEBUG messages which usually won't show 
up on the console. Still, yeah, annonying. I'll send a patch which 
changes the code such that the message isn't printed the second time 
(during revalidation) tomorrow. I gotta sleep now.

Good night.

-- 
tejun
