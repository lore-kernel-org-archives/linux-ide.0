From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata-zpodd: must use ata_tf_init()
Date: Fri, 28 Jun 2013 16:49:00 +0400
Message-ID: <51CD863C.7000802@cogentembedded.com>
References: <201306232325.04732.sergei.shtylyov@cogentembedded.com> <51CA4C74.50400@intel.com> <51CACC16.9050005@cogentembedded.com> <51CB9227.30307@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:42202 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab3F1MtB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jun 2013 08:49:01 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so2120913lab.33
        for <linux-ide@vger.kernel.org>; Fri, 28 Jun 2013 05:48:59 -0700 (PDT)
In-Reply-To: <51CB9227.30307@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org

Hello.

On 27-06-2013 5:15, Aaron Lu wrote:

>>>> There are  some SATA controllers which have both devices 0 and 1 but this module

>>> Do you mean a SATA port can connect to two SATA devices without PMP?

>>      No, I mean 2 SATA ports combined in one ATA channel as 2 devices.
>> Look for SLAVE_POSS in drivers/ata/[s]ata*.c...

> Oh yes that happened when the SATA controller is in IDE programming
> mode, not AHCI.

    AHCI is not the only mode for the SATA controllers.

> ZPODD is only supported for SATA controllers in AHCI programming mode,

    Hm, really? How about the true SATA controllers that don't use AHCI?

> the ACPI table will not support power off the port if the controller is
> in IDE mode, so the device 1 case shouldn't happen in practice :-)

    Anyway, I need uniform setup for ata_exec_internal() call for my to 
be posted cleanup patches.

> Thanks,
> Aaron

WBR, Sergei

