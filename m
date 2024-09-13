Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFD57C8D
	for <linux-ide@vger.kernel.org>; Fri, 13 Sep 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256199; cv=none; b=aZ0bzKdqPt28UQib7M9kDxbCEX5+cCSaYtrX9Ga5oQpaCkG1W4o/S6Q+yIl0oFi2xaHI9sTjBuQne16SApLQu0QplDyzJDDutmZkE5r3V+dPc50e10BHuUtQsIU/vkbWzpLNdN61RlmaaNRPXCEu/chFovVquYrbnpdnlexZj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256199; c=relaxed/simple;
	bh=9ApF6ZCiUPvIQO9YhXkZVOvkkAS3qZzjItE712CGxv4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aFxmZ5VWPzJBlrsBZlZPQnphOfyH0asdTegFbwh6/UT+P7LzP8yevH1GIGkzu68IUxFcuGquRH0CZkGNbCYwUqX6lUdmXJF0vAHDTuTW8verpue+hWW0Y5DcMOm0a8iN8zvvZG2UehtbuxBTdSx87aAOy7hp9+NLl1+tdfj5m+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.106] (178.176.79.21) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 13 Sep
 2024 22:36:16 +0300
Subject: Re: [PATCH] ata: ata_generic: use IS_ENABLED() macro
To: Niklas Cassel <cassel@kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <d9c0acab-909e-da06-decf-be5de59d23bf@omp.ru>
 <87f85704-656d-4c08-b729-87c9b2e6d686@kernel.org>
 <4414c20f-7e0e-de47-8311-4a8948f2504d@omp.ru>
 <f5209cc3-a0c6-4722-92b7-533c0b244527@kernel.org>
 <65e70327-62e1-3b1a-7b69-eae765241b5c@omp.ru>
 <9d7e0d4f-1445-4729-9e4d-9058c35db1b2@kernel.org>
 <5bed15cf-b6c2-62e9-c23d-7a3c94f2dcc2@omp.ru> <ZuPiUWlcNmBt9tqH@ryzen.lan>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <1b2ee8d0-2ff1-79f0-8af2-51eb84c8d192@omp.ru>
Date: Fri, 13 Sep 2024 22:36:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZuPiUWlcNmBt9tqH@ryzen.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/13/2024 19:18:36
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187742 [Sep 13 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.21 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.21 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.79.21
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/13/2024 19:21:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/13/2024 4:21:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/13/24 9:57 AM, Niklas Cassel wrote:
[...]

>>> Maybe rename the option to CONFIG_PATA_TOSHIBA_PICCCOLO ?
>>
>>    Nah, that doesn't make much sense to me; if we rename it, we should match the driver's name, i.e. make it CONFIG_PATA_PICCOLO.  I'm mainly concerned about the
>> Linux distros which would have to handle such rename somehow, IIUC...

   I wonder whether they could be using s/th like make allmodconfig...

> I still remember:
> 4dd4d3deb502 ("ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY configuration item")
> and
> 55b014159ee7 ("ata: ahci: Rename CONFIG_SATA_LPM_POLICY configuration item back")
> 
> so I also prefer to avoid renaming Kconfigs as far as possible.

   Yeah, it does not look very likely ATM that tc86c001 support will be
revived...  Although, could be done pretty easily if I don't try to work
around the infamous limitation #5...

> Kind regards,
> Niklas

MBR, Sergey
