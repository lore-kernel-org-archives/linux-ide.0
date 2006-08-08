From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: implement to get tf's from _GTF and execute
 them
Date: Tue, 08 Aug 2006 18:07:42 -0400
Message-ID: <44D90B2E.1050708@pobox.com>
References: <1153899372.4957.61.camel@forrest26.sh.intel.com> <20060808121902.2771f60b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46477 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030313AbWHHWHx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Aug 2006 18:07:53 -0400
In-Reply-To: <20060808121902.2771f60b.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, htejun@gmail.com, linux-ide@vger.kernel.org

Randy.Dunlap wrote:
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> index 386e5f2..cd4cf97 100644
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -91,6 +91,10 @@ static int ata_probe_timeout = ATA_TMOUT
>>  module_param(ata_probe_timeout, int, 0444);
>>  MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
>>  
>> +int noacpi = 0;
> 
> Drop the "= 0".  It will be init. to 0 anyway.
> (Yes, I know my patch had that. :)

Not necessarily true, since it is not static...

	Jeff


