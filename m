From: Holger Hasselmann <hhasselm@web.de>
Subject: Re: Gigabyte GA-MA69VM-S2 can't do 64bit DMA
Date: Wed, 16 Sep 2009 11:19:46 +0200
Message-ID: <4AB0ADB2.8090009@web.de>
References: <4AAE8252.8000206@web.de> <4AAFE66D.8050807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:38217 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758249AbZIPJTp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Sep 2009 05:19:45 -0400
In-Reply-To: <4AAFE66D.8050807@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Shane.Huang@amd.com

Tejun Heo schrieb:
> Holger Hasselmann wrote:
>   
>> Hello Tejun,
>>
>> I want let you know, that the following laptop would need to be included
>> in the list of the 32bit DMA boards.
>>
>> First I have used the snapshot 2.6.31-git and was not able to boot until
>> I reversed the patch 58a09b38cfcd700b796ea07ae3d2e0efbb28b561.
>>
>> I have tried it with the snapshot 2.6.31-git2 and was not able to boot.
>>
>> I have checked the latest bios (1.10c) for this laptop and it did not
>> worked.
>>
>> I will attache the dmidecoder output (don't know if this helps).
>>     
>
> Can you please verify the attached patch fixes the problem?  This should
> apply cleanly to 2.6.31.
>
> Thanks.
>
>   
I have tried the attached patch on a clean 2.6.31 source and it is working.

dmesg is showing the following:

libata version 3.00 loaded.
ahci 0000:00:12.0: version 3.0
ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: ASUS M2A-VM: BIOS too old, forcing 32bit DMA, update BIOS
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pmp pio slum part

Will try it later on the latest git, I think the dmesg should identify 
the Board correct then and.

Thanks,
Holger

