From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] libata-zpodd: must use ata_tf_init()
Date: Thu, 27 Jun 2013 09:15:19 +0800
Message-ID: <51CB9227.30307@intel.com>
References: <201306232325.04732.sergei.shtylyov@cogentembedded.com> <51CA4C74.50400@intel.com> <51CACC16.9050005@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2138 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab3F0BOo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Jun 2013 21:14:44 -0400
In-Reply-To: <51CACC16.9050005@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org

On 06/26/2013 07:10 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 26-06-2013 6:05, Aaron Lu wrote:
> 
>>> There are  some SATA controllers which have both devices 0 and 1 but this module
> 
>> Do you mean a SATA port can connect to two SATA devices without PMP?
> 
>     No, I mean 2 SATA ports combined in one ATA channel as 2 devices. 
> Look for SLAVE_POSS in drivers/ata/[s]ata*.c...

Oh yes that happened when the SATA controller is in IDE programming
mode, not AHCI.

ZPODD is only supported for SATA controllers in AHCI programming mode,
the ACPI table will not support power off the port if the controller is
in IDE mode, so the device 1 case shouldn't happen in practice :-)

Thanks,
Aaron
