Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC791CAA2
	for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936949; cv=none; b=qW1v6xk5TpkQddFLTMtrLig75jAMv1GFlYoRe7dbDohn0+M+xfUhl7v/+fLfS9jC2yMp1Kanzc2fWNOqF0NtANHbyA/XS6msUX0H21zPTmAA2NCMn+9ZW1ukiscbo2EMEckxoMgDLk4oJq7wMqBpq2py3pQhx9t4Q8mR7eHegFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936949; c=relaxed/simple;
	bh=2BCrPOpsfwVkAmYCo0Haop+b6PXJoYpyHmMDfeGx/0Y=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=meWPQ2BHa5GXy05sGOGF7TspQJ4B048WlpGFIqpqnMNuZv2iutveHogHYo0LAQiTl2yTi0Gi9KaoX35YxTvx5ZSB+UDmd4dXpIgic/pXU0ofT+7RFvlZ8TXsjEtfmaJ/qstVz9jZACvjQXAOXIbt855WoKm6UDR7KavDWfrN7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.87.85) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 26 Feb
 2024 11:42:16 +0300
Subject: Re: [PATCH] ata: ahci: stop using saved_port_map for quircks
To: "Andrey Jr. Melnikov" <temnota.am@gmail.com>, Niklas Cassel
	<cassel@kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
References: <bc76towgdmpv3xilmhlerrshpubrd7feecl2tu6xanwtbkv3ze@zwizzrmcu43w>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f27be82d-8c93-346a-aab2-836e5357e4b2@omp.ru>
Date: Mon, 26 Feb 2024 11:42:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bc76towgdmpv3xilmhlerrshpubrd7feecl2tu6xanwtbkv3ze@zwizzrmcu43w>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/26/2024 08:20:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183714 [Feb 26 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.85 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.85 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;31.173.87.85:7.1.2;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.85
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/26/2024 08:24:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/26/2024 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Hello!

   s/quircks/quirks/ in the subject... :-)

On 2/25/24 12:55 PM, Andrey Jr. Melnikov wrote:

> Stop using saved_port_map for masking port quirks, use force_port_map
> instead.
> 
> Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>

[...]

MBR, Sergey
