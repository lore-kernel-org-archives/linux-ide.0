From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] libata: implement to get tf's from _GTF and execute
 them
Date: Wed, 09 Aug 2006 16:29:19 +0400
Message-ID: <44D9D51F.9040309@ru.mvista.com>
References: <1153899372.4957.61.camel@forrest26.sh.intel.com> <20060808121902.2771f60b.rdunlap@xenotime.net> <44D90B2E.1050708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:29152 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1750705AbWHIM2O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 08:28:14 -0400
In-Reply-To: <44D90B2E.1050708@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: rdunlap@xenotime.net, forrest.zhao@intel.com, htejun@gmail.com, linux-ide@vger.kernel.org

Hello.

Jeff Garzik wrote:

>>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>>> index 386e5f2..cd4cf97 100644
>>> --- a/drivers/scsi/libata-core.c
>>> +++ b/drivers/scsi/libata-core.c
>>> @@ -91,6 +91,10 @@ static int ata_probe_timeout = ATA_TMOUT
>>>  module_param(ata_probe_timeout, int, 0444);
>>>  MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout 
>>> (seconds)");

>>> +int noacpi = 0;

>> Drop the "= 0".  It will be init. to 0 anyway.
>> (Yes, I know my patch had that. :)

> Not necessarily true, since it is not static...

    All uninitialized explicitly non-auto variables go into .bss section and 
get initialized to 0 and 'static' has nothing to do with it, IIRC...

WBR, Sergei
