Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445A71B1429
	for <linux-ide@vger.kernel.org>; Wed, 11 Sep 2024 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074881; cv=none; b=s0WTPhPS9FF0Kgz8GIVAgClUNqeHqUGHewTnafbMiM9+wOBHFSDcwc6GVJNf9/lGBaX5A3k+ihO7Nd3RVQ1/uPLaNvf/uXe2Ct9KnSheX5aIacmpXbG1CuaXdjYMU3AHzzkHOFRt3lUUx1mu4k5O2x+RVyffH1NBluMSQl61FqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074881; c=relaxed/simple;
	bh=V2v0XvrhwX6Q/lX6ACFDtSmuqTnyJoWHBH1KaSPP6Mk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rnYJEp11aRswiXEYBD9iyMLVFpmn7GpP+QX3fJSA9FFtj9um55tSMZEJexc3KqzZ6nS2GdYsRLKYUyVTIe2rgLnAt990UVvj3+mMn88mcc8b0p1xH2tmOYZQt0bvghdaA0wW/u+HOfsc9Rt1v2tJt+u6ttz6uAi/ABgZIFYzinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.106] (31.173.82.153) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 11 Sep
 2024 20:14:33 +0300
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
Message-ID: <5bed15cf-b6c2-62e9-c23d-7a3c94f2dcc2@omp.ru>
Date: Wed, 11 Sep 2024 20:14:32 +0300
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/11/2024 16:54:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 187691 [Sep 11 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;elixir.bootlin.com:7.1.1;git.kernel.org:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.82.153
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/11/2024 16:57:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/11/2024 2:18:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/11/24 1:22 AM, Damien Le Moal wrote:
[...]
>> [Resending after adding the missed test, please ignore the previus reply.)

   Oops, some more typos! :-)

[...]
>>>>>> with the new-fangled IS_ENABLED() macro in the ata_generic[] definition.
>>>>>
>>>>> Please mention that CONFIG_PATA_TOSHIBA_MODULE actually does not exist at all
>>>>> and so can be removed.
>>>>
>>>>    Huh? =)
>>>>    CONFIG_PATA_TOSHIBA is a tristate option, so CONFIG_PATA_TOSHIBA_MODULE
>>>> does exist; else there would be no point in using IS_ENABLED() at all...
>>>
>>> Oops... Indeed. Got confused with something else :)
>>
>>    There's something to be confused about this driver vs its Kconfig option
>> naming: the driver is called pata_piccolo.c and its option CONFIG_PATA_TOSHIBA.
>> However, Toshiba seemingly has more than one family of the PATA controllers:
>> there's also TC86C001 PCI multi-function chip (dubbed GOKU-S by Toshiba) which
>> supports up to UDMA66 and doesn't seem compatible with Piccolo, judging by the
>> driver code and Toshiba GOKU-S datasheet I have: the timing regs are mapped @
>> AR5 and not in the PCI config space, like with the Piccolo chips.

   I'm sure I typed BAR5 but apparently B went somewhere with further editing... :-)

>>    If somebody like me (it was me who submitted the reworked Toshiba's TC86C001
>> driver for drivers/ide/ back in 2007) added TC86C001 libata driver, the confusion
>> would probably worsen... :-/ Luckily, the chip is a bit tricky (I had to somewhat

   If you want to see the original patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=33dced2ea5ed03dda10e7f9f41f0910f32e02eaa

   Some fragments of the patch lived thru the drivers/ide/ removal, see e.g.:

https://elixir.bootlin.com/linux/v6.11-rc1/source/drivers/pci/quirks.c#L2319

>> abuse drivers/ide/ to work around some "limitations", as Toshiba calls their errata)
>> and I don't have access to the chip to properly test the driver anymore.  Obviously, there should be a little interest now in adding the "new" PATA drivers... :-)

   The interesting fact is that the TC86C001 (GOUKU-S) USB device controller (PCI function #2) is still supported by its own driver (drivers/usb/gadget/udc/goku_udc.c), mereg back in 2004... :-)

>>    Any thoughts on the naming confusion?
> 
> Maybe rename the option to CONFIG_PATA_TOSHIBA_PICCCOLO ?

   Nah, that doesn't make much sense to me; if we rename it, we should match the driver's name, i.e. make it CONFIG_PATA_PICCOLO.  I'm mainly concerned about the
Linux distros which would have to handle such rename somehow, IIUC...

[...[

MBR, Sergey
