Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B22D4816
	for <linux-ide@vger.kernel.org>; Thu, 20 Nov 2025 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682804; cv=none; b=HCsqKhxNBJWySQ/U2nXiZPbw2tAoehpTDbP1XKFFDOk443Bc086VBxQRvlomgcLzIBvnY3vCaq1yii3tZ6+qOfofFoYeJbt2hodAlxHI/IVG8GCGmSOULRV2pKNiohnngX8BkZePOIuvh9vOkcydfKmr1xG5IbEdjBPVat18Pmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682804; c=relaxed/simple;
	bh=r+7LOJCaqd/cP83KLLQL1+4xQU0RrMwRKPVT3C1bn0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSo3v7R5eW70Be1XBkBDdwZsQY9SF76zRSBqmVSB93R/JnopmP0qw1+DDGgLItvjyOH5E63dPFgCToB0efBV/0r9qWkJNIpG51AGPDe0Fwj1aNWo4MAorTAjuMNgPuMU7NeheiBFEnJx/W9xHukLMzbbo4bazXkMYPzbA7MqcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.72.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dCFXt3f04z8txK;
	Fri, 21 Nov 2025 10:53:18 +1100 (AEDT)
Message-ID: <876fb997-3ae6-4597-bb3a-52fd5dd12778@eyal.emu.id.au>
Date: Fri, 21 Nov 2025 10:53:17 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Subject: Re: ata timeout exceptions
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <4f0fa70c-b259-4998-bf94-c6c6fd8c733c@eyal.emu.id.au>
 <aRyOFRCQ_nSWtmsh@ryzen>
 <f8eebba8-176b-44b8-877c-75de8b00db38@eyal.emu.id.au>
 <7cf8b035-c884-4691-a35b-ee8a2e149e03@kernel.org>
 <5f690ea7-5e10-4129-87be-ba4b618e65b8@eyal.emu.id.au>
 <3accb08b-73bd-4281-9cad-069f512c7f9c@kernel.org>
 <4f30c170-e5c8-4961-94a7-d903acdb9633@eyal.emu.id.au>
 <df236b8e-f514-4139-a4a4-1ebf5df9b22b@kernel.org>
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
In-Reply-To: <df236b8e-f514-4139-a4a4-1ebf5df9b22b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Damien,

On 20/11/25 23:18, Damien Le Moal wrote:
> On 11/20/25 20:38, Eyal Lebedinsky wrote:
>>> Ah ! This is a drive-managed SMR drive ? I missed that point. Yeah, with these
>>> drives, the performance profile (throughpu & command latency) can be all over
>>> the place depending on the internal state of the drive. So all bets are off in
>>> terms of timeout... In your case, this seems extreme though, so there is likely
>>> a head going bad and lots of internal retries going on that make latency even
>>> worse than usual. Maybe have a look at SMART output to see if you lots of bad
>>> sectors remapped ?
>>
>> Nothing bad in smart report.
>>
>> Another positive: After setting a lower max_sectors_kb as suggested, the drive is
>> running smoothly. I also added --fsync to the rsync which probably also regulated
>> the pace a bit.
>>
>> So far today there was no reset required, and also no pause at all.
>>
>> Maybe after the disk was used for a long while, and as a large amount of data was
>> replaced regularly, the data is now distributed wildly.
>>
>> Is there an equivalent to 'trim' that can be used to tell the drive what blocks
>> can be discarded (and reused)? If so, worth a try?
> 
> If you drive shows a non-zero value for:
> 
> cat /sys/block/sdX/queue/discard_max_hw_bytes
> 
> then you can run fstrim against the FS on the drive to trim (discard) the unused
> blocks. If the value is zero, then the drive does not support discard/trim.

Not supported.

Is there a way to mark everything unused? Or was SMR not designed to handle this, way back in 2014?
I am able to copy the disk elsewhere, clear?, then copy back.

<unrelated>
Seagate shows the disk (ST8000AS0002-1NA17Z) as released in 2014. Says "No Newer Firmware Available".
Latest fw I found mentioned are AR15/AR17 (mine is AR13) which still do not support trim. It is for a later disk revision.
	https://smarthdd.com/database/ST8000AS0002-1NA17Z/
</unrelated>

Regards,
	Eyal

-- 
Eyal at Home (eyal@eyal.emu.id.au)
