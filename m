From: Mark Lord <mlord@pobox.com>
Subject: Re: libata total system lockup fix
Date: Thu, 18 Aug 2005 20:46:59 -0400
Message-ID: <43052C03.7060306@pobox.com>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <42FA70A9.6080608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:57777 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932541AbVHSArA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 20:47:00 -0400
In-Reply-To: <42FA70A9.6080608@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

After a week of further experience with this patch,
I regretfully inform one and all that it does not
entirely fix the lockups.

My system has experienced three of them during the
past 24 hours.. after many days without.

I'm now reverting to the original "broken" patch
that keeps my system alive.

Cheers!
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com


Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
>> --- a/drivers/scsi/libata-scsi.c
>> +++ b/drivers/scsi/libata-scsi.c
>> @@ -385,6 +385,7 @@ int ata_scsi_error(struct Scsi_Host *hos
>>          * appropriate place
>>          */
>>         host->host_failed--;
>> +       INIT_LIST_HEAD(&host->eh_cmd_q);
>>
>>         DPRINTK("EXIT\n");
>>         return 0;
> 
> 
> 
> applied to 2.6.13
> 


