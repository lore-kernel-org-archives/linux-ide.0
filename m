From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [RFT PATCH] libata: implement ATA_FLAG_SETXFER_POLLING and use
 it in pata_via
Date: Tue, 10 Oct 2006 20:47:19 +0200
Message-ID: <452BEAB7.9010901@free.fr>
References: <20060928111151.GN25800@htj.dyndns.org> <452BEA3D.4020204@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1-g19.free.fr ([212.27.42.27]:18908 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751081AbWJJSq5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Oct 2006 14:46:57 -0400
In-Reply-To: <452BEA3D.4020204@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

matthieu castet wrote:
> Hi,
> 
> Sorry for the delay.
> 
> Tejun Heo wrote:
> 
>> This patch implements ATA_FLAG_SETXFER_POLLING and use in pata_via.
>> If this flag is set, transfer mode setting performed by polling not by
>> interrupt.  This should help those controllers which raise interrupt
>> before the command is actually complete on SETXFER.
>>
>> Rationale for this approach.
>>
>> * uses existing facility and relatively simple
>> * no busy sleep in the interrupt handler
>> * updating drivers is easy
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>
>> Matthieu Castet, can you please test this patch?  It's against
>> libata-dev#upstream, but -mm might work too.  If you want a patch
>> against -mm, just let me know.
> 
> 
> With the attached patch against 19-rc1-mm1 (I had to remove pata irq 
> handler), it seems to work (see the attached log).
> 					      * polling IDENTIFY */
> +	ATA_FLAG_SETXFER_POLLING= (1 << 14), /* use polling for SETXFER */
>  
opps i forgot to change ATA_FLAG_SETXFER_POLLING to 
ATA_FLAG_SETXFER_POLLING (1<<15).

I suppose I need to retest that ?


Matthieu
