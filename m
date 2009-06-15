From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] ata: add ata_id_pio_need_iordy() helper
Date: Mon, 15 Jun 2009 13:21:38 -0400
Message-ID: <4A368322.10308@pobox.com>
References: <200906131821.07018.bzolnier@gmail.com> <4A3410D6.9060400@ru.mvista.com> <200906151832.03501.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37812 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbZFORVe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Jun 2009 13:21:34 -0400
In-Reply-To: <200906151832.03501.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 13 June 2009 22:49:26 Sergei Shtylyov wrote:
>> Hello.
>>
>> Bartlomiej Zolnierkiewicz wrote:
>>
>>> Cc: Jeff Garzik <jgarzik@pobox.com>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>> ---
>>> against Linus' tree
>>>
>>>  include/linux/ata.h |   11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> Index: b/include/linux/ata.h
>>> ===================================================================
>>> --- a/include/linux/ata.h
>>> +++ b/include/linux/ata.h
>>> @@ -800,6 +800,17 @@ static inline int ata_id_is_ssd(const u1
>>>  	return id[ATA_ID_ROT_SPEED] == 0x01;
>>>  }
>>>  
>>> +static inline int ata_id_pio_need_iordy(const u16 *id, const u8 pio)
>>> +{
>>> +	/* CF spec. r4.1 Table 22 says no IORDY on PIO5 and PIO6.  */
>>> +	if (ata_id_is_cfa(id) && pio > 4)
>>>   
>>    It actually makes sense to put the cheap 'pio' check first. We 
>> shouldn't call ata_id_is_cfa() for all modes.
> 
> It is a micro-optimization but why not... revised version follows.
> 
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ata: add ata_id_pio_need_iordy() helper (v2)
> 
> v2:
> Minor fixes per Sergei's review.
> 
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> against Linus' tree
> 
>  include/linux/ata.h |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> Index: b/include/linux/ata.h
> ===================================================================
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -800,6 +800,20 @@ static inline int ata_id_is_ssd(const u1
>  	return id[ATA_ID_ROT_SPEED] == 0x01;
>  }
>  
> +static inline int ata_id_pio_need_iordy(const u16 *id, const u8 pio)
> +{
> +	/* CF spec. r4.1 Table 22 says no IORDY on PIO5 and PIO6. */
> +	if (pio > 4 && ata_id_is_cfa(id))
> +		return 0;
> +	/* For PIO3 and higher it is mandatory. */
> +	if (pio > 2)
> +		return 1;
> +	/* Turn it on when possible. */
> +	if (ata_id_has_iordy(id))
> +		return 1;
> +	return 0;

ACK


