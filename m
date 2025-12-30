Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD20145B27
	for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2025 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767135002; cv=none; b=WTn5sxQtqmt22Xb9JIO0oL8aAAJBYLhjjefYJUHCZghJ3UmWPx5iNj4V0SaGq2Yuh4vMr5YH5IqcwvKuShxttNScza+D+JM5eErCslwxLchKYPrhaYy1ZZmi9ru9i0+VxxMY5C9tAur28OZ/VpVVzF5e/SUHk2ocFabaf3k7Ad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767135002; c=relaxed/simple;
	bh=TDK7yfZknvyV7y3uR1ecUWw/6aNPpkQw9LfvrbA3eiM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pfNOanStG1ZQ3mPCMEw/dh8hfGIpIZRIrl9Lxi9qL52V9FE0W9U1m1uoJCvHlnEPzpgRIBqhvlCoWQ4m8G9u3Rfgdf8wVbYkIr+5cVFJqB9Sb+f9cSSiHpDLkXRvmcbGsYiomrlqPcb/wBhX8SJKbH+yPd+ucm9HeMXVuPcIWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.78.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dgp6V3hfzz8tr6;
	Wed, 31 Dec 2025 09:44:02 +1100 (AEDT)
Message-ID: <893cb476-ca89-417a-a710-95f1e8c77c04@eyal.emu.id.au>
Date: Wed, 31 Dec 2025 09:43:55 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Subject: Re: ata timeout exceptions
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
To: list linux-ide <linux-ide@vger.kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
 <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org>
 <79fcb2f0-d09b-4649-bda0-55f309b20985@eyal.emu.id.au>
 <746FB9BB-5945-415F-915F-3F05D8A6B063@kernel.org>
 <582e748c-3e29-4f21-af7c-c799fb457e59@eyal.emu.id.au>
 <3d476e67-31a9-4e7d-b8cc-5bb298a6d62f@kernel.org>
 <9933af72-944e-4bb3-bab9-fdbd4fb0fad0@eyal.emu.id.au>
 <3e81e6ae-1ef0-454c-935f-eee2bba91176@eyal.emu.id.au>
 <cda2a663-10a5-4212-8725-8c780a2c291d@kernel.org>
 <0239be44-cfc7-4c99-b245-636e376df037@eyal.emu.id.au>
 <9d5644a9-8365-4dce-833a-5e26e2d79684@kernel.org>
 <f6665313-7b26-40e5-9185-ada5e63c41b0@eyal.emu.id.au>
Content-Language: en-US
In-Reply-To: <f6665313-7b26-40e5-9185-ada5e63c41b0@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/12/25 16:57, Eyal Lebedinsky wrote:
> On 22/12/25 14:43, Damien Le Moal wrote:

[trimmed]

>> Once you confirm if we really need to maintain NCQ off or not with a small max
>> sectors limit, we can write a proper quirk for this drive.
> 
> I am leaving it this way. It runs the usual workload (rsync in) every 2 hours. I will report back in a few days.
It is now "a few days" later (9 days). All is well and not a single pause observed.
My job (rsync'ing 21GB into this disk every 2 hours) reports:
	max_sectors_kb=1024 timeout=120 queue_depth=32

I am keeping it with these parameters, but can try different values if it tells us anything.

Happy New Year Everyone,
	Eyal

-- 
Eyal at Home (eyal@eyal.emu.id.au)
