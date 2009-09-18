From: Tejun Heo <htejun@gmail.com>
Subject: Re: Gigabyte GA-MA69VM-S2 can't do 64bit DMA
Date: Fri, 18 Sep 2009 17:09:19 +0900
Message-ID: <4AB3402F.5010609@gmail.com>
References: <4AAE8252.8000206@web.de> <4AAFE66D.8050807@gmail.com> <4AB0ADB2.8090009@web.de> <4AB0C2AD.6020503@gmail.com> <4AB2B463.4010408@web.de> <4AB2D7A1.8060909@gmail.com> <C8E4BD7D001E44499280E0884BD9DB30010861B7@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:40590 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbZIRIIl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Sep 2009 04:08:41 -0400
Received: by yxe37 with SMTP id 37so668019yxe.33
        for <linux-ide@vger.kernel.org>; Fri, 18 Sep 2009 01:08:44 -0700 (PDT)
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB30010861B7@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Holger Hasselmann <hhasselm@web.de>, linux-ide@vger.kernel.org

Huang, Shane wrote:
> Hi Tejun, 
> 
>> -----Original Message-----
>> From: Tejun Heo [mailto:htejun@gmail.com] 
>>> ahci 0000:00:12.0: version 3.0_
>>> ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
>>> ahci 0000:00:12.0: Fujitsu-Siemens AMILO Pa 2510: this 
>> board can't do 64bit
>>> DMA, forcing 32bit
>>> ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
>>> ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 
>> 0xf impl SATA mode
>>> ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pmp pio slum part
>>> It's correct now.
>> Cool, patch posted with the id string shortened.
> 
> Just some small questions about this topic:
> 
> What is the actual impact of 64-bit DMA not being available?

If IO happens to memory above 4G it will either be bounced (ie. DMA
will be performed to a bounce buffer < 4G which is copied from / to
the original buffer or more likely iommu will kick in.

> How important is it to have this enabled?
>
> In other words, will the performance be improved significantly
> after it is enabled? Do you have any experimental data for it? :-)

There probably won't be any noticeable performance regression if iommu
is working properly and no, I don't have any concrete numbers.

Thanks..

-- 
tejun
