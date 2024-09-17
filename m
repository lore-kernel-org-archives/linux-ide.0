Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D218A956;
	Tue, 17 Sep 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605877; cv=none; b=u1Yc2Bc81Y1ELgUHiK46ZTXLSU2wHC68ua7q9sRg06V6ZcE9sJ672kPLUiQ+CBJWI+ijo7sgac+uj/PhS6AmpGuwTsu4knv6svY5WcpSv7chBpxTdSX7pnxIzP/2wfOccUBkCsn80+rjncTfyD4CMjutAyUQhrR/qrzBCHGiUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605877; c=relaxed/simple;
	bh=iMxZB+YttnhccaC3XGRZRTY+r8Kip8OD0WLKB804tlA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=sCW8XHKR+zC1WYtf7NrFmMtTjRNH1j14RiheD8PSt7kxhD8w8ZUD60rF++Q6BE132jWNbWdKGgPi+7XUd/rePuszzN/js1L6wMjRbL/w08+jrbxKorF5buie77tLtjwRj/OQ5HEGSsu9iBo0yLg8plEAQlO4LeSFPVzxuZmADfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.108] (178.176.74.43) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 17 Sep
 2024 23:44:24 +0300
Message-ID: <abe87c03-3a73-3f16-92eb-a988a61649d5@omp.ru>
Date: Tue, 17 Sep 2024 23:44:23 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ata: pata_octeon_cf: Use common error handling code in
 octeon_cf_probe()
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Markus Elfring <Markus.Elfring@web.de>, <linux-ide@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>
References: <4ca111f2-9b38-47a1-88d5-7dfaedcc6ea5@web.de>
 <2e38a924-a68a-8d19-8c3a-c19708f9ab74@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <2e38a924-a68a-8d19-8c3a-c19708f9ab74@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/17/2024 20:26:13
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187809 [Sep 17 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.43 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.43 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.43
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/17/2024 20:28:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/17/2024 6:58:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/17/24 20:43, Sergey Shtylyov wrote:

>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Tue, 17 Sep 2024 13:43:24 +0200
>>
>> Add a label so that a bit of exception handling can be better reused
> 
>    s/exception/error/.
> 
>> in a subsequent if branch of this function implementation.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>  drivers/ata/pata_octeon_cf.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
>> index 0bb9607e7348..62289f6aef95 100644
>> --- a/drivers/ata/pata_octeon_cf.c
>> +++ b/drivers/ata/pata_octeon_cf.c
>> @@ -848,14 +848,13 @@ static int octeon_cf_probe(struct platform_device *pdev)
>>  				struct resource *res_dma;
>>  				int i;
>>  				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
>> -				if (!res_dma) {
>> -					put_device(&dma_dev->dev);
>> -					of_node_put(dma_node);
>> -					return -EINVAL;
>> -				}
>> +				if (!res_dma)
>> +					goto put_device;
>> +
>>  				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
>>  									 resource_size(res_dma));
>>  				if (!cf_port->dma_base) {
>> +put_device:
> 
>    Ugh... :-/
>    Please use the new-fangled *devm_platform_ioremap_resource() instead of those
> old-fashioned APIs.

   Another option is to place this error patch somewhere at the end
of this function but I think I prefer the new APIs.

[...]

MBR, Sergey
