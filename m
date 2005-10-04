From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC 2/4] irq-pio: remove ap->dataout_task
Date: Tue, 04 Oct 2005 19:54:47 +0800
Message-ID: <43426D87.7030908@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412BCF.4080408@tw.ibm.com> <434254D3.1050904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41676 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932370AbVJDLzP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 07:55:15 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j94Bt94U008047
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 07:55:09 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j94Bt96C089612
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 07:55:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j94Bt95i012235
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 07:55:09 -0400
In-Reply-To: <434254D3.1050904@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Jeff Garzik wrote:

> Albert Lee wrote:
>
>> @@ -3018,7 +3017,8 @@ fsm_start:
>>      qc_completed = 0;
>>  
>>      switch (ap->hsm_task_state) {
>> -    case HSM_ST_IDLE:
>> +    case HSM_ST_FIRST:
>> +        ata_pio_first_block(ap);
>>          return;
>>  
>>      case HSM_ST:
>
>
> Am I missing something?  You're removing the handling of HSM_ST_IDLE, 
> which looks very wrong.

The qc_completed flag is introduced to replace the volatile HSM_ST_IDLE 
state.
If we access the port when ap->hsm_task_state is HSM_ST_IDLE, the 
command is completed, next qc might be running on the same port and 
changing ap->hsm_task_state. So, we cannot rely on ap->hsm_task_state 
when it is HSM_ST_IDLE.

>
> AFAICS, even after your patch is applied, the completion of a qc still 
> transitions the state to HSM_ST_IDLE.  Perhaps your patch is missing 
> some transitions -from- HSM_ST_IDLE to HSM_ST_FIRST?
>
Yes, the completion of a qc still transitions the state to HSM_ST_IDLE. 
But we need another way - the qc_completed flag to finish the polling loop.

Albert

