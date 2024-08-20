Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0EF45008;
	Tue, 20 Aug 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189646; cv=none; b=IxyOWZwQzxyRjKHBq8oRzDsvbpd/OwL7zlPAboRaDAYVB2NBVxtQygEr9xvnOnWxUsWGg180kYN3byZq7QhI3+6mCIDe1ZCZ+NbbhV8OTMzpnJ13K9jjd7nguUEmJsURHvtntHvZ34ObbMzzZIR08ahmzJM0aS0+Mqi3yHUj3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189646; c=relaxed/simple;
	bh=2A/M8qkXKeLOI+c80uIXOvUvU3Rd6LJGgzUgQS21FGA=;
	h=From:Subject:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HJE7/tnDi2uzmzFubkx4gn3yWIS2yxjtb+Fkz9+ZqMi9wngMeXfV3ylb2oAFjy6XX6wRyrQAmXvmpLoeQfkB51yiJzG/YFNcXYhRC44hA0Wo+SK81DtqU1zg0nDf/mjzxAO7//Qok5+p5VB8Zqn47sojfQAJidfx0IWYb59zdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.79.162) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 21 Aug
 2024 00:33:42 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] ata: Replace deprecated PCI devres functions
To: Philipp Stanner <pstanner@redhat.com>, Damien Le Moal
	<dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Mikael Pettersson
	<mikpelinux@gmail.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240812084839.37580-2-pstanner@redhat.com>
 <c2d21da0-7fe1-f995-5562-7ff04e9f1b8b@omp.ru>
 <9c2aeec1c3f97bcebb3596b5b7c87140bc29b72e.camel@redhat.com>
Organization: Open Mobile Platform
Message-ID: <d7f0735e-9dd4-c1db-e057-bbdbafe3887f@omp.ru>
Date: Wed, 21 Aug 2024 00:33:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9c2aeec1c3f97bcebb3596b5b7c87140bc29b72e.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/20/2024 21:20:09
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187194 [Aug 20 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 27 0.3.27
 71302da218a62dcd84ac43314e19b5cc6b38e0b6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.162 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.162 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.79.162
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/20/2024 21:23:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/20/2024 5:37:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 8/16/24 11:37 AM, Philipp Stanner wrote:
[...]

>>> The ata subsystem uses the PCI devres functions pcim_iomap_table()
>>> and
>>> pcim_request_regions(), which have been deprecated in commit
>>> e354bb84a4c1
>>> ("PCI: Deprecate pcim_iomap_table(),
>>> pcim_iomap_regions_request_all()").
>>>
>>> These functions internally already use their successors, notably
>>> pcim_request_region(), so they are quite trivial to replace.
>>>
>>> However, one thing special about ata is that it stores the iomap
>>> table
>>> provided by pcim_iomap_table() in struct ata_host. This can be
>>> replaced
>>> with a __iomem pointer table, statically allocated with size
>>> PCI_STD_NUM_BARS so it can house the maximum number of PCI BARs.
>>> The
>>> only further modification then necessary is to explicitly fill that
>>> table, whereas before it was filled implicitly by
>>> pcim_request_regions().
>>>
>>> Modify the iomap table in struct ata_host.
>>>
>>> Replace all calls to pcim_request_region() with ones to
>>> pcim_request_region().
>>
>>    Huh? :-)
>>    Besides, I'm not seeing pcim_request_region() anywhere in this
>> patch...
>>
>>> Remove all calls to pcim_iomap_table().
>>>
>>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
[...]

>>> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
>>> index abe64b5f83cf..8a17df73412e 100644
>>> --- a/drivers/ata/pata_sil680.c
>>> +++ b/drivers/ata/pata_sil680.c
>>> @@ -360,15 +360,16 @@ static int sil680_init_one(struct pci_dev
>>> *pdev, const struct pci_device_id *id)
>>>  	/* Try to acquire MMIO resources and fallback to PIO if
>>>  	 * that fails
>>>  	 */
>>> -	rc = pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR,
>>> DRV_NAME);
>>> -	if (rc)
>>> +	mmio_base = pcim_iomap_region(pdev, SIL680_MMIO_BAR,
>>> DRV_NAME);
>>> +	if (IS_ERR(mmio_base)) {
>>> +		rc = PTR_ERR(mmio_base);
>>   		goto use_ioports;
>>
>>    The code under that label ignores rc, no?
> 
> Oh, forgot to address this.
> 
> Yes, it does ignore it, but it behaves as the existing code does. The

   You mean, by setting rc?

> existing version jumps into ata_pci_bmdma_init_one() if it cannot
> request or ioremap the BAR.

   Yep, it cannot use MMIO in this case, so falls back to the good old
I/O ports, (confusingly?) named PIO in the comment above...

> 	/* Try to acquire MMIO resources and fallback to PIO if
> 	 * that fails
> 	 */
> 	rc = pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR, DRV_NAME);
> 	if (rc)
> 		goto use_ioports;
> 
> 
> Is that a bug in the existing version, too?

   I'm not sure what you're considering a bug here...

> The comment hints to me that this is fine and intended.
> 
> Otherwise we want to remain consistent with the pre-existing behavior.

    I don't see a point here, rc is correctly ignored under that label,
and gcc drops this assignment anyway when generating the code...

[...]

MBR, Sergey
