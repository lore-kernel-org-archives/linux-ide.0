Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9B1531C2;
	Wed, 21 Aug 2024 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724273405; cv=none; b=tzlrjcBKhy9s0rKwxlQKgU37/6ExTTB3c2DcbmYHFrhaTTN1q+bknFOz97GKQ4kegvUjJG0vf+PgHK0qSN4yf/576w+LqWGDJprexgMq1/NoC0cm5EvEuH1ikrSu+CYJn9usx7V+KpuYWIrvGq2WRkbtPoE6ol5DzidndeVNWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724273405; c=relaxed/simple;
	bh=bskqMDGqvGrDuMpfciDhhbVvJnZ973MkLP0jG3EJ4qc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HlFfyeRi+VspDZAUb8Qup1aZAmBgzMhUBKaxD9BsBFAGUn8IpFo0PHIgwrsPuQUXFfQu7wDViOcHY98EC5bAfo8Lij1z5qWvlmgl46CIQ/EaoFTKLq8XEMVuJVR2BzzRFg50odadmyMwrHh7GQ0siQU7N2/xSjNsn4/emRRUg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.81.178) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 21 Aug
 2024 23:49:50 +0300
Subject: Re: [PATCH] ata: Replace deprecated PCI devres functions
To: Philipp Stanner <pstanner@redhat.com>, Damien Le Moal
	<dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Mikael Pettersson
	<mikpelinux@gmail.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240812084839.37580-2-pstanner@redhat.com>
 <c2d21da0-7fe1-f995-5562-7ff04e9f1b8b@omp.ru>
 <94a378e6c2d442e0e7ae06fbd496d02983f9baaa.camel@redhat.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <c4111bbb-b59c-be35-561b-4eb79809918d@omp.ru>
Date: Wed, 21 Aug 2024 23:49:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <94a378e6c2d442e0e7ae06fbd496d02983f9baaa.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/21/2024 20:34:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187220 [Aug 21 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 27 0.3.27
 71302da218a62dcd84ac43314e19b5cc6b38e0b6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.178 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.178
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/21/2024 20:37:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/21/2024 4:20:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 8/16/24 10:47 AM, Philipp Stanner wrote:
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

[...]

>>> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
>>> index 250f7dae05fd..d58db8226436 100644
>>> --- a/drivers/ata/libata-sff.c
>>> +++ b/drivers/ata/libata-sff.c
>> [...]
>>> @@ -2172,8 +2173,41 @@ int ata_pci_sff_init_host(struct ata_host
>>> *host)
>>>  			continue;
>>>  		}
>>>  
>>> -		rc = pcim_iomap_regions(pdev, 0x3 << base,
>>> -					dev_driver_string(gdev));
>>> +		/*
>>> +		 * In a first loop run, we want to get BARs 0 and
>>> 1.
>>> +		 * In a second run, we want BARs 2 and 3.
>>> +		 */
>>> +		if (i == 0) {
>>> +			io_tmp = pcim_iomap_region(pdev, 0,
>>> drv_name);
>>> +			if (IS_ERR(io_tmp)) {
>>> +				rc = PTR_ERR(io_tmp);
>>> +				goto err;
>>> +			}
>>> +			host->iomap[0] = io_tmp;
>>> +
>>> +			io_tmp = pcim_iomap_region(pdev, 1,
>>> drv_name);
>>> +			if (IS_ERR(io_tmp)) {
>>> +				rc = PTR_ERR(io_tmp);
>>> +				goto err;
>>> +			}
>>> +			host->iomap[1] = io_tmp;
>>> +		} else {
>>> +			io_tmp = pcim_iomap_region(pdev, 2,
>>> drv_name);
>>> +			if (IS_ERR(io_tmp)) {
>>> +				rc = PTR_ERR(io_tmp);
>>> +				goto err;
>>> +			}
>>> +			host->iomap[2] = io_tmp;
>>> +
>>> +			io_tmp = pcim_iomap_region(pdev, 3,
>>> drv_name);
>>> +			if (IS_ERR(io_tmp)) {
>>> +				rc = PTR_ERR(io_tmp);
>>> +				goto err;
>>> +			}
>>> +			host->iomap[3] = io_tmp;
>>> +		}
>>> +
>>
>>    Ugh... Why you couldn't keep using base (or just i * 2) and avoid
>> such code duplication?
> 
> I mean, this would at least make it perfectly readable what's being
> done.

   It looks pretty horrible, to my taste... :-)

> I guess we could do something like this, maybe with a comment explining
> what is going on:
> 
> for_each_set_bit(j, 0x3 << base, PCI_STD_NUM_BARS) {

   We're only interested in 4 first BARs, not all 6 of 'em. :-)
And you can't just pass 3 << base to for_each_set_bit() -- it needs
a bitmap ptr... :-)
   Why not just do s/th like:

for (j = base, j < base + 2, j++) {

> 	host->iomap[j] = pcim_iomap_region(pdev, j, drv_name);
> 	if (IS_ERR(host->iomap[j])) {
> 		rc = PTR_ERR(host->iomap[j]);
> 		break;
> 	}
> }
> 
> if (rc) {
> 	dev_warn(gdev,

[...]

MBR, Sergey
