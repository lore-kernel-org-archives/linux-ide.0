From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement ata_wait_after_reset()
Date: Tue, 29 May 2007 09:33:37 +0200
Message-ID: <465BD751.8000708@gmail.com>
References: <20070510072005.GA27316@linux-sh.org> <464301D3.5060306@gmail.com> <464307CC.40701@gmail.com> <20070510072005.GA27316@linux-sh.org> <464301D3.5060306@gmail.com> <20070510124645.GA18534@linux-sh.org> <4643196B.7070806@gmail.com> <20070511005217.GA23186@linux-sh.org> <464439C8.7090309@gmail.com> <20070512034928.GB29259@linux-sh.org> <20070516003002.GA18863@linux-sh.org> <464B3505.20004@gmail.com> <465B8277.9010001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:52519 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbXE2Hew (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 May 2007 03:34:52 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1135707nzf
        for <linux-ide@vger.kernel.org>; Tue, 29 May 2007 00:34:52 -0700 (PDT)
In-Reply-To: <465B8277.9010001@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, garyhade@us.ibm.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> -    msleep(150);
>> +    /* wait a while before checking status */
>> +    ata_wait_after_reset(ap, deadline);
> [...]
>> -    msleep(150);
>> +    /* wait a while before checking status */
>> +    ata_wait_after_reset(ap, deadline);
>>  
>>      /* Before we perform post reset processing we want to see if
>>       * the bus shows 0xFF because the odd clown forgets the D7
>> @@ -3543,8 +3583,8 @@ int sata_std_hardreset(struct ata_port *
>>          return 0;
>>      }
>>  
>> -    /* wait a while before checking status, see SRST for more info */
>> -    msleep(150);
>> +    /* wait a while before checking status */
>> +    ata_wait_after_reset(ap, deadline);
>>  
>>      rc = ata_wait_ready(ap, deadline);
> [...]
>> -    msleep(150);
>> +    /* wait a while before checking status */
>> +    ata_wait_after_reset(ap, deadline);
>>  
>>      /* Before we perform post reset processing we want to see if
>>       * the bus shows 0xFF because the odd clown forgets the D7
>> Index: work/drivers/ata/sata_inic162x.c
>> ===================================================================
>> --- work.orig/drivers/ata/sata_inic162x.c
>> +++ work/drivers/ata/sata_inic162x.c
>> @@ -446,7 +446,7 @@ static int inic_hardreset(struct ata_por
>>          struct ata_taskfile tf;
>>  
>>          /* wait a while before checking status */
>> -        msleep(150);
>> +        ata_wait_after_reset(ap, deadline);
>>  
>>          rc = ata_wait_ready(ap, deadline);
> [...]
> 
> The main thing that bothers me is not the increase in delay, but the
> fact that this create converts a delay/Status-poll sequence into a
> delay/Status-poll/Status-poll sequence.
> 
> ata_wait_after_reset() immediately before ata_wait_ready() seems highly
> redundant.  Why not just poll Status once?

I was trying to minimize code disturbance around reset such that
ata_wait_after_reset() can be drop-in replacement for msleep(150).  This
was for two reasons 1. as this patch was to fix regression I didn't want
to introduce a lot of change into -rcX and 2. I was lazy.  :-)

As dont-consider-0xff-as-port-empty-if-sstatus-available patch fixes the
regression nicely, I think we can delay this to 2.6.23.  I'll merge
ata_wait_after_reset() into ata_wait_ready() (or the other way around).

Thanks.

-- 
tejun
