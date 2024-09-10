Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81418EFF9
	for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978999; cv=none; b=XgZ3azSoZMJeBlcWkosmg1VE3veUW4egWhcxkm+YNjmccjPiByQKpGul2ylElQQqrPRXowrEd9NScwtTZ2o16ZVFV7M3lOLeF7/OT7gvsUJPx2tkw6VI3k/Yh0pyqcWAkB4cEbU6u5Wf76n1duYOJOP6WcxtvNk65H1hEK16qZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978999; c=relaxed/simple;
	bh=I+uyPh+b0VPgOThc4tWKy6V8KWslEVHtvYAlcrTutcg=;
	h=From:Subject:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UdWeymBk+UQ6uP55FKlbGbu7lYKizB0KytYJg3TGXA7MEV7BHhBkAQIZeq7NY159dPn51Ga0dEHIjXHbSmwWjdWv6Q63DLJKh+tbLocGGfGJIkyD9xRYe6G0+c3fXPxBdik1SHLkC23aceup512pJKiJEhLnxDXqFN6OgCZCV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.106] (31.173.81.148) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 10 Sep
 2024 17:36:27 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] ata: ata_generic: use IS_ENABLED() macro
To: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>, Niklas
 Cassel <cassel@kernel.org>
CC: <lvc-project@linuxtesting.org>
References: <d9c0acab-909e-da06-decf-be5de59d23bf@omp.ru>
 <87f85704-656d-4c08-b729-87c9b2e6d686@kernel.org>
 <4414c20f-7e0e-de47-8311-4a8948f2504d@omp.ru>
 <f5209cc3-a0c6-4722-92b7-533c0b244527@kernel.org>
Organization: Open Mobile Platform
Message-ID: <65e70327-62e1-3b1a-7b69-eae765241b5c@omp.ru>
Date: Tue, 10 Sep 2024 17:36:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f5209cc3-a0c6-4722-92b7-533c0b244527@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/10/2024 14:18:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187664 [Sep 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.148 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.148 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.148
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/10/2024 14:23:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/10/2024 11:54:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

[Resending after adding the missed test, please ignore the previus reply.)

On 9/10/24 4:09 PM, Damien Le Moal wrote:
[...]

>>>> Replace now gone out of fashion defined(CONFIG_PATA_TOSHIBA[_MODULE])

   I'll probably rephrase this a bit in v2...

>>>> with the new-fangled IS_ENABLED() macro in the ata_generic[] definition.
>>>
>>> Please mention that CONFIG_PATA_TOSHIBA_MODULE actually does not exist at all
>>> and so can be removed.
>>
>>    Huh? =)
>>    CONFIG_PATA_TOSHIBA is a tristate option, so CONFIG_PATA_TOSHIBA_MODULE
>> does exist; else there would be no point in using IS_ENABLED() at all...
> 
> Oops... Indeed. Got confused with something else :)

   There's something to be confused about this driver vs its Kconfig option
naming: the driver is called pata_piccolo.c and its option CONFIG_PATA_TOSHIBA.
However, Toshiba seemingly has more than one family of the PATA controllers:
there's also TC86C001 PCI multi-function chip (dubbed GOKU-S by Toshiba) which
supports up to UDMA66 and doesn't seem compatible with Piccolo, judging by the
driver code and Toshiba GOKU-S datasheet I have: the timing regs are mapped @
AR5 and not in the PCI config space, like with the Piccolo chips.
   If somebody like me (it was me who submitted the reworked Toshiba's TC86C001
driver for drivers/ide/ back in 2007) added TC86C001 libata driver, the confusion
would probably worsen... :-/ Luckily, the chip is a bit tricky (I had to somewhat
abuse drivers/ide/ to work around some "limitations", as Toshiba calls their errata)
and I don't have access to the chip to properly test the driver anymore.  Obviously, there should be a little interest now in adding the "new" PATA drivers... :-)
   Any thoughts on the naming confusion?

>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> [...[
>>
>>>> Index: linux/drivers/ata/ata_generic.c
>>>> ===================================================================
>>>> --- linux.orig/drivers/ata/ata_generic.c
>>>> +++ linux/drivers/ata/ata_generic.c
>>>> @@ -220,7 +220,7 @@ static struct pci_device_id ata_generic[
>>>>  	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
>>>>  	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
>>>>  	  .driver_data = ATA_GEN_FORCE_DMA },
>>>> -#if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
>>>> +#if !IS_ENABLED(CONFIG_PATA_TOSHIBA)
>>>
>>> I do not understand the negation here... It seems very wrong. If the driver is
>>> indeed enabled, we need to add its PCI ID, no ? and the reverse when not defined...
>>
>>    The separate driver was added by Alan Cox in 2009, before that
>> Toshiba Piccolo controllers were handled by this generic driver...
> 
> OK, makes sense now. Maybe we should add a comment above that IS_ENABLED() to
> say so ?

   Makes sense, indeed. Do you think this is acceptable to be done in v2 of this
patch?

MBR, Sergey
