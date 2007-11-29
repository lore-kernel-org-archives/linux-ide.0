From: Tom Evans <tom@23palmer.net>
Subject: Re: SATA PMP support in 2.6.24-rc3?
Date: Wed, 28 Nov 2007 22:17:50 -0500
Message-ID: <474E2F5E.1010509@23palmer.net>
References: <39B20DF628532344BC7A2692CB6AEE070201BD83@orsmsx420.amr.corp.intel.com> <474CC423.70705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:21406 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757700AbXK2DRz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 22:17:55 -0500
In-Reply-To: <474CC423.70705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org


I'm also seeing this with 2.6.23-rc3 on my Alpha system - sata_sil24 and 
a SiliconImage PMP.

...tom

Tejun Heo wrote:
> Gaston, Jason D wrote:
>   
>> Does 2.6.24-rc3 support SATA port multipliers?
>>
>> I am getting "ata6.03: COMRESET failed (errno=-5)" error messages with a
>> SiliconImage PMP connected to an Intel ICH9 SATA controller in AHCI
>> mode.  
>>     
>
> Yeah, it should work.
>
>   
>> Dmesg output attached.
>>     
>
> Eeek.. Can you please tell me more about the configuration?  Which
> devices are connected to which downstream port, etc...
>
> Thanks.
>
>   
