From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] libata-zpodd: must use ata_tf_init()
Date: Sat, 29 Jun 2013 21:04:54 +0800
Message-ID: <51CEDB76.3080704@intel.com>
References: <201306232325.04732.sergei.shtylyov@cogentembedded.com> <51CA4C74.50400@intel.com> <51CACC16.9050005@cogentembedded.com> <51CB9227.30307@intel.com> <51CD863C.7000802@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:11415 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab3F2NGI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Jun 2013 09:06:08 -0400
In-Reply-To: <51CD863C.7000802@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org

On 06/28/2013 08:49 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 27-06-2013 5:15, Aaron Lu wrote:
> 
>>>>> There are  some SATA controllers which have both devices 0 and 1 but this module
> 
>>>> Do you mean a SATA port can connect to two SATA devices without PMP?
> 
>>>      No, I mean 2 SATA ports combined in one ATA channel as 2 devices.
>>> Look for SLAVE_POSS in drivers/ata/[s]ata*.c...
> 
>> Oh yes that happened when the SATA controller is in IDE programming
>> mode, not AHCI.
> 
>     AHCI is not the only mode for the SATA controllers.

Right.

> 
>> ZPODD is only supported for SATA controllers in AHCI programming mode,
> 
>     Hm, really? How about the true SATA controllers that don't use AHCI?

If they don't set ATA_FLAG_ACPI_SATA, no.

> 
>> the ACPI table will not support power off the port if the controller is
>> in IDE mode, so the device 1 case shouldn't happen in practice :-)
> 
>     Anyway, I need uniform setup for ata_exec_internal() call for my to 
> be posted cleanup patches.

No problem.

Thanks,
Aaron
