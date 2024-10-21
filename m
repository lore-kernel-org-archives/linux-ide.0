Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8ED47A73
	for <linux-ide@vger.kernel.org>; Mon, 21 Oct 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529628; cv=none; b=hEfhiZtj+Z/eE9FP7K6sfeI+1v21yEeVFyakkITuZd1QZnYVBpVyV9/lMApKjJRtmx7OZx+QoxZzwjpTXaRGL4kyG6yVSVYOtyk9+6+AW81ZXP5CxQQ8CJtN/5CdAqU8MuCs9YeTkLPamSqFXpI6oydYjXiyZoGBmpXzsRFuFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529628; c=relaxed/simple;
	bh=Oo2EL6xDfwKWeTke31YqvNS/ARjvUUIqQncfCOtwjO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YdC1g/q7YS3+CCuOVswDLtwDB2WqMZzKJ/9kNIaxLGNZiFpuLn+SkR3LM5y0UV35+EQqbO5MXetsnMSXDiRDnr6N0tE3kQ9N+Kt360F9UtUyonk95WoC2gSJ11kbk2a+KRGV+BK7aufuGL5xogTQBp7aedsl0X+yw/BKuod6ldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.162.141) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 21 Oct
 2024 19:53:28 +0300
Message-ID: <c3ffd07d-b1ac-4c67-a7be-0047261e8301@omp.ru>
Date: Mon, 21 Oct 2024 19:53:28 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: ata_generic: add comment about Toshiba
 Piccolo
To: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>, Niklas
 Cassel <cassel@kernel.org>
References: <c1b91a7a-74a9-46bf-914a-b8dfc669849e@omp.ru>
 <7d8a58b7-dbc9-474c-8996-6218aa89d0be@omp.ru>
 <23f2e1d5-eec0-4886-8fcb-760ed81c672a@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <23f2e1d5-eec0-4886-8fcb-760ed81c672a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 10/21/2024 16:36:26
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 188594 [Oct 21 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 40 0.3.40
 cefee68357d12c80cb9cf2bdcf92256b1d238d22
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.162.141 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.162.141
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/21/2024 16:39:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/21/2024 3:10:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 10/21/24 3:48 AM, Damien Le Moal wrote:
> On 10/21/24 01:49, Sergey Shtylyov wrote:
>> Before the dedicated Toshiba Piccolo driver was written by Alan Cox,
>> these chips were handled by the generic driver; in case the dedicated
>> driver isn't enabled, the generic driver keeps claiming these chips --
>> add a comment clarifying that...
> 
> Nice. But this really does not need to be a separate patch.

   It does. I don't want to break the basic rule "do one thing per patch".

> Please squash 1/2 and 2/2 together.

   Sorry, I'm not going to re-spin this once more.
   Besides, I've forewarned you that the comment will be added in a separate
patch, and you didn't protest:

https://lore.kernel.org/all/09af52c9-542f-b920-6ff1-e0b624300947@omp.ru/

>> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
[...]

MBR, Sergey

