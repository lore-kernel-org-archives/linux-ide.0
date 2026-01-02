Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD40C4C97
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767335472; cv=none; b=vDFP/rwYGKMHOUN0Axsp9MkBwqPbepmM3v00x+UCYbJDgGWYEBj2rF++xpX4tCxMoL7sLImFd8s6+QpxnrVWcxOUYQD1oCSpQTqN+aetpSsIU0vMz8T9YsQReX8Vr3M4aKBpn6ou/RwouEfdA+tgeUnFBT0hyHoWKs69vDOdbMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767335472; c=relaxed/simple;
	bh=tAzArRglwbXYeCHTUm3DIbahYCf3+25jEONU8323aTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oa2a8v5tVs9diCDAv6o1xsB71s0pjhFzHvBvDxq9tD+YeyPOtJ56cW+tXBKN1lVtaa5bgF/f1lTgo+Gautxnasz2igCVNEAu9O+lqhiP/DsUstODkPr+NTB4W4KL6R7d8bS+bBel+DAPmW2gulpcMCYK/Nni8jABu2GKjkce5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.78.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4djDNN5YWHz8tsB;
	Fri, 02 Jan 2026 17:31:00 +1100 (AEDT)
Message-ID: <127d0520-795d-4c1c-8876-d5d71e9a285a@eyal.emu.id.au>
Date: Fri, 2 Jan 2026 17:30:53 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Subject: Re: ata timeout exceptions
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
 <893cb476-ca89-417a-a710-95f1e8c77c04@eyal.emu.id.au>
 <6a821520-a4a2-454f-b220-c62ef4bf7a99@kernel.org>
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
In-Reply-To: <6a821520-a4a2-454f-b220-c62ef4bf7a99@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/26 12:21, Damien Le Moal wrote:
> On 12/31/25 07:43, Eyal Lebedinsky wrote:
>> On 22/12/25 16:57, Eyal Lebedinsky wrote:
>>> On 22/12/25 14:43, Damien Le Moal wrote:
>>
>> [trimmed]
>>
>>>> Once you confirm if we really need to maintain NCQ off or not with a small max
>>>> sectors limit, we can write a proper quirk for this drive.
>>>
>>> I am leaving it this way. It runs the usual workload (rsync in) every 2 hours. I will report back in a few days.
>> It is now "a few days" later (9 days). All is well and not a single pause observed.
>> My job (rsync'ing 21GB into this disk every 2 hours) reports:
>> 	max_sectors_kb=1024 timeout=120 queue_depth=32
>>
>> I am keeping it with these parameters, but can try different values if it tells us anything.
> 
> If you are OK with keeping these as your default with this drive and setting
> that through a udev rule or whatever else you prefer, then I think we are good.
> We can make the max_sectors_kb=1024 permanent as a quirk though, but that would
> be a little extreme since in the end, we are dealing with a very very slow drive
> here, not really a buggy one.

I agree. I will keep these setting here.

Thanks again for your effort,
	Eyal

>> Happy New Year Everyone,
> 
> Thanks. Happy new year to you too !
-- 
Eyal at Home (eyal@eyal.emu.id.au)
