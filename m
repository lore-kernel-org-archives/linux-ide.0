From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT PATCH] libata: implement ATA_FLAG_SETXFER_POLLING and use
 it in pata_via
Date: Fri, 29 Sep 2006 09:28:06 +0900
Message-ID: <451C6896.9060207@gmail.com>
References: <20060928111151.GN25800@htj.dyndns.org> <451BB121.9020702@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:29080 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161222AbWI2A2P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 20:28:15 -0400
Received: by py-out-1112.google.com with SMTP id n25so980133pyg
        for <linux-ide@vger.kernel.org>; Thu, 28 Sep 2006 17:28:13 -0700 (PDT)
In-Reply-To: <451BB121.9020702@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: castet.matthieu@free.fr, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, akpm@osdl.org

Jeff Garzik wrote:
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 753b015..c71d896 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -4082,7 +4082,8 @@ int ata_hsm_move(struct ata_port *ap, st
>>  
>>  fsm_start:
>>      DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
>> -        ap->id, qc->tf.protocol, ap->hsm_task_state, status);
>> +        ap->id, qc->tf.protocol, ap->hsm_task_state, status,
>> +        qc->tf.flags & ATA_TFLAG_POLLING);
> 
> You need to update the format string too...

Ah... That's left over from debugging session.  I'll kill it.

Thanks.

-- 
tejun
