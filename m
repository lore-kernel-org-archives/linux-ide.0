Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA7A22F11
	for <linux-ide@vger.kernel.org>; Mon, 13 Nov 2023 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Vus6hJZd"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5773859
	for <linux-ide@vger.kernel.org>; Mon, 13 Nov 2023 11:14:44 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id 2cNFrerPZFh5i2cOPrKNl3; Mon, 13 Nov 2023 20:14:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1699902882;
	bh=cw7DzfrPCld7xSzODOtzNR7CsG05Gedc/Tg0+WmnlFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Vus6hJZdgAD6gPCyctSi31zSnS0OffNGTJcUNC8rjmd7KNN8TVaQHEsaYDS0DbwfE
	 BNjCprzVTYa0zAKJSAOnNn1BWahlyLOoeqgyL7L//dd3zzr35cfjlQ3Er4/xgMhNSa
	 rkgvBPTxuq4KV40bgzZQ+PBA33/XWVHoSsP30vch+9OCwYhmTWtzOM+pkJNu0x/P4I
	 oJrrPJWNjjMYh+Ocfww8DN+wDBzbH1U8rtPstYuMm6mGtJVEJxpb6s6bkRKk2mtuA+
	 GRLBzAlkeqejoUEIsr8O9gKrpldQ3i4myYLIO7WAV6s9TV1ZV+Rzol11mzFSz/SvNO
	 0xBX2LYqcD6ng==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 Nov 2023 20:14:42 +0100
X-ME-IP: 86.243.2.178
Message-ID: <cc2273ef-3539-41c3-b333-f87b309e895b@wanadoo.fr>
Date: Mon, 13 Nov 2023 20:14:40 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_pxa: convert not to use
 dma_request_slave_channel()
Content-Language: fr
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <f177835b7f0db810a132916c8a281bbdaf47f9d3.1699801657.git.christophe.jaillet@wanadoo.fr>
 <ZVHYK1rI9Z8DcKJP@x1-carbon> <6e798343-1880-1c58-dd8e-1bd556f6a75b@omp.ru>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6e798343-1880-1c58-dd8e-1bd556f6a75b@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 13/11/2023 à 11:17, Sergey Shtylyov a écrit :
> On 11/13/23 11:05 AM, Niklas Cassel wrote:
> [...]
>>> dma_request_slave_channel() is deprecated. dma_request_chan() should
>>> be used directly instead.
>>>
>>> Switch to the preferred function and update the error handling accordingly.
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>>   drivers/ata/pata_pxa.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
>>> index 5275c6464f57..0c9c9cf63d36 100644
>>> --- a/drivers/ata/pata_pxa.c
>>> +++ b/drivers/ata/pata_pxa.c
>>> @@ -274,9 +274,8 @@ static int pxa_ata_probe(struct platform_device *pdev)
>>>   	/*
>>>   	 * Request the DMA channel
>>>   	 */
>>> -	data->dma_chan =
>>> -		dma_request_slave_channel(&pdev->dev, "data");
>>> -	if (!data->dma_chan)
>>> +	data->dma_chan = dma_request_chan(&pdev->dev, "data");
>>
>> While the previous API could only return NULL on failure, the new API can
>> return an actual error.
>>
>> I think we should return the actual error instead of -EBUSY.
>>
>> i.e.:
>>
>> if (IS_ERR(data->dma_chan))
>> 	return PTR_ERR(data->dma_chan);
> 
>     Agreed. Christophe, please fix.

Will do.

Thx for both of you for the review.

CJ

> 
> [...]
>>> +	if (IS_ERR(data->dma_chan))
>>>   		return -EBUSY;
>>>   	ret = dmaengine_slave_config(data->dma_chan, &config);
>>>   	if (ret < 0) {
> [...]
> 
>> Kind regards,
>> Niklas
> 
> MBR, Sergey
> 

