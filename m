From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/5] sil24: add sil24_restart_controller
Date: Wed, 16 Nov 2005 22:20:58 +0900
Message-ID: <437B323A.7010107@gmail.com>
References: <20051116080244.GB22807@htj.dyndns.org> <437B2422.6040107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:11457 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030319AbVKPNVF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 08:21:05 -0500
Received: by zproxy.gmail.com with SMTP id 13so1768554nzn
        for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 05:21:04 -0800 (PST)
In-Reply-To: <437B2422.6040107@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> When an error condition is raised by device via D2H FIS or SDB.  sil24
>> controller should be restarted by setting PORT_CS_INIT and waiting
>> until PORT_CS_RDY is asserted instead of resetting the controller.
>> This patch implements sil24_restart_controller for those cases.  This
>> patch also makes sure that PORT_CS_RDY is asserted on
>> sil24_reset_controller completion.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> -- 
>>
>> Jeff, the patch named "sil24: add constants" is 1/5 and should be
>> applied first.  Sorry.
>>
>> Index: work/drivers/scsi/sata_sil24.c
>> ===================================================================
>> --- work.orig/drivers/scsi/sata_sil24.c    2005-11-16 
>> 16:54:10.000000000 +0900
>> +++ work/drivers/scsi/sata_sil24.c    2005-11-16 16:58:01.000000000 +0900
>> @@ -486,6 +486,31 @@ static void sil24_irq_clear(struct ata_p
>>      /* unused */
>>  }
>>  
>> +static int __sil24_restart_controller(void __iomem *port)
>> +{
>> +    u32 tmp;
>> +    int cnt;
>> +
>> +    writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
>> +
>> +    /* Max ~100ms */
>> +    for (cnt = 0; cnt < 1000; cnt++) {
>> +        tmp = readl(port + PORT_CTRL_STAT);
>> +        if (tmp & PORT_CS_RDY)
>> +            return 0;
>> +        udelay(100);
>> +    }
>> +
>> +    return -1;
>> +}
> 
> 
> NAK, this potentially soaks up an entire timer tick (~100ms).
> 
> It's probably better to schedule_work(), and poll using msleep().  Or 
> you could cut the worst case down to 10ms.
> 
> FWIW, I have no idea what the max is, I don't see it in the docs :(
> 

Yeap, it might consume quite some ticks.  So did 
sili24_reset_controller.  I almost infinitely prefer to take all these 
resume/reset/request sense stuff into EH thread rather than using 
separate mechanism.  No?

-- 
tejun
