Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DFB522F
	for <linux-ide@vger.kernel.org>; Sat, 14 Sep 2024 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726336448; cv=none; b=fuMgnrM3WlAUahLSg784+5iIcmRPkJf+SvfyQJ35puAgqWlextd7qycNNvXgu9XwMG6aCNCb+8W0ZFK5PHTS7ygwri7z9WqWe61pxrZaSQESkYtryDnwXSzmPvO5KDP5gen+5gMmUi9fzZWvXo+0/pv6V1OlEqJBAlw9sXzXe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726336448; c=relaxed/simple;
	bh=D+1lNJ7q3lUwPMD9ZDZjRaHw1ELps72hgM9ltYlgFJs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V5DC+BOtk4J/alDsqqvNnnRn+t1KZ/rMUD8leMF1OjgpaFyHc7Z9MyRPqN2jrHqapYxponcaml5sJoKF2NAdcPv7HgGPpsrfLKIlSpW1FsVIzofWnQG49M+Q+HQc6S+5KVXuWMWGBxDGER1nJqwxRwS0mU+iz9UEtJfhxYnkOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.106] (31.173.80.129) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 14 Sep
 2024 20:53:52 +0300
Subject: Re: [PATCH] ata: ata_generic: use IS_ENABLED() macro
To: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>, Niklas
 Cassel <cassel@kernel.org>
CC: <lvc-project@linuxtesting.org>
References: <d9c0acab-909e-da06-decf-be5de59d23bf@omp.ru>
 <87f85704-656d-4c08-b729-87c9b2e6d686@kernel.org>
 <4414c20f-7e0e-de47-8311-4a8948f2504d@omp.ru>
 <f5209cc3-a0c6-4722-92b7-533c0b244527@kernel.org>
 <65e70327-62e1-3b1a-7b69-eae765241b5c@omp.ru>
 <9d7e0d4f-1445-4729-9e4d-9058c35db1b2@kernel.org>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <09af52c9-542f-b920-6ff1-e0b624300947@omp.ru>
Date: Sat, 14 Sep 2024 20:53:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9d7e0d4f-1445-4729-9e4d-9058c35db1b2@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/14/2024 17:34:04
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187749 [Sep 14 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.129 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.129
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/14/2024 17:42:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/14/2024 2:30:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/11/24 1:22 AM, Damien Le Moal wrote:
[...]

>>>>>> Replace now gone out of fashion defined(CONFIG_PATA_TOSHIBA[_MODULE])
>>
>>    I'll probably rephrase this a bit in v2...
>>
[...]
>>
>>>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>>
>>>> [...[
>>>>
>>>>>> Index: linux/drivers/ata/ata_generic.c
>>>>>> ===================================================================
>>>>>> --- linux.orig/drivers/ata/ata_generic.c
>>>>>> +++ linux/drivers/ata/ata_generic.c
>>>>>> @@ -220,7 +220,7 @@ static struct pci_device_id ata_generic[
>>>>>>  	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
>>>>>>  	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
>>>>>>  	  .driver_data = ATA_GEN_FORCE_DMA },
>>>>>> -#if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
>>>>>> +#if !IS_ENABLED(CONFIG_PATA_TOSHIBA)
>>>>>
>>>>> I do not understand the negation here... It seems very wrong. If the driver is
>>>>> indeed enabled, we need to add its PCI ID, no ? and the reverse when not defined...
>>>>
>>>>    The separate driver was added by Alan Cox in 2009, before that
>>>> Toshiba Piccolo controllers were handled by this generic driver...
>>>
>>> OK, makes sense now. Maybe we should add a comment above that IS_ENABLED() to
>>> say so ?
>>
>>    Makes sense, indeed. Do you think this is acceptable to be done in v2 of this
>> patch?
> 
> Yep, that is fine and would fit with the config option renaming.

   I started respinnig this patch and decided to add the Piccolo comment in
a separate patch, while deferring the Kconfig entry rename until/iff it becomes
truly necessary, as per Niklas' comment).
   Unfortunately, I seem to be late for the coming merge window... :-/

MBR, Sergey
