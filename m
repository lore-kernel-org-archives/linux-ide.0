Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117213FEF;
	Mon, 13 Nov 2023 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E09ED7C;
	Mon, 13 Nov 2023 02:17:45 -0800 (PST)
Received: from [192.168.1.103] (31.173.86.71) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 13 Nov
 2023 13:17:34 +0300
Subject: Re: [PATCH] ata: pata_pxa: convert not to use
 dma_request_slave_channel()
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>
References: <f177835b7f0db810a132916c8a281bbdaf47f9d3.1699801657.git.christophe.jaillet@wanadoo.fr>
 <ZVHYK1rI9Z8DcKJP@x1-carbon>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6e798343-1880-1c58-dd8e-1bd556f6a75b@omp.ru>
Date: Mon, 13 Nov 2023 13:17:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZVHYK1rI9Z8DcKJP@x1-carbon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.86.71]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/13/2023 09:51:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181311 [Nov 13 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.71 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.71 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;31.173.86.71:7.7.3
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.71
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/13/2023 09:59:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/13/2023 8:54:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 11/13/23 11:05 AM, Niklas Cassel wrote:
[...]
>> dma_request_slave_channel() is deprecated. dma_request_chan() should
>> be used directly instead.
>>
>> Switch to the preferred function and update the error handling accordingly.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>  drivers/ata/pata_pxa.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
>> index 5275c6464f57..0c9c9cf63d36 100644
>> --- a/drivers/ata/pata_pxa.c
>> +++ b/drivers/ata/pata_pxa.c
>> @@ -274,9 +274,8 @@ static int pxa_ata_probe(struct platform_device *pdev)
>>  	/*
>>  	 * Request the DMA channel
>>  	 */
>> -	data->dma_chan =
>> -		dma_request_slave_channel(&pdev->dev, "data");
>> -	if (!data->dma_chan)
>> +	data->dma_chan = dma_request_chan(&pdev->dev, "data");
> 
> While the previous API could only return NULL on failure, the new API can
> return an actual error.
> 
> I think we should return the actual error instead of -EBUSY.
> 
> i.e.:
> 
> if (IS_ERR(data->dma_chan))
> 	return PTR_ERR(data->dma_chan);

   Agreed. Christophe, please fix.

[...]
>> +	if (IS_ERR(data->dma_chan))
>>  		return -EBUSY;
>>  	ret = dmaengine_slave_config(data->dma_chan, &config);
>>  	if (ret < 0) {
[...]

> Kind regards,
> Niklas

MBR, Sergey
