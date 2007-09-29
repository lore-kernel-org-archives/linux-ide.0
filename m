From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata drain fifo on stuck DRQ HSM violation
Date: Sat, 29 Sep 2007 08:34:18 -0400
Message-ID: <46FE464A.4020808@rtr.ca>
References: <46CFA08E.6090604@arbores.ca>	<6bffcb0e0708261610g10d9c59ck5789fac6feca9f42@mail.gmail.com>	<46DBCB6C.8080206@gmail.com>	<20070905095327.6277d054.akpm@linux-foundation.org>	<46DEE617.4050004@rtr.ca>	<46E0A253.7060803@gmail.com>	<46E154DE.2060602@rtr.ca>	<46FB563A.80108@gmail.com>	<20070927193701.6230d77f@the-village.bc.nu>	<46FC3D7D.90009@gmail.com>	<46FC3FDD.5060201@pobox.com>	<46FC423C.2050206@gmail.com>	<46FC7B72.2030103@rtr.ca>	<20070928112735.264733ad@the-village.bc.nu>	<46FDA4F3.7050205@pobox.com> <20070929072831.2df5f5ed@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4619 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761AbXI2MeT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Sep 2007 08:34:19 -0400
In-Reply-To: <20070929072831.2df5f5ed@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, michal.k.k.piotrowski@gmail.com, bryan@arbores.ca, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>>> Why 512 words ?
>> Though I have queued Mark's patch to be applied, my gut feeling would 
>> lean towards a single DRQ block, rather than 512.
> 
> Why not just work from the old IDE code.
>>
>>>>  	ata_altstatus(ap);
>>>> -	ata_chk_status(ap);
>>>> +	ata_drain_fifo(ap, qc);
>>> ap->ops->cleanup();
>>>
>>> might be wiser
>> If someone needs that, they can override the error handler with their 
>> own.  No need for a new op.
> 
> PDC202xx needs

Alan, you're the expert there (my condolences!).
Can you generate a fix for the PDC202xx to go with this?

Cheers
