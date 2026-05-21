Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D92437D10E;
	Thu, 21 May 2026 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362556; cv=none; b=JnQgZEm6YaazIiLLhTL5cEubngNYpRWnYnfi/mRNYA6FAFhwouHT7O4wQSxAr3Ib8yvC5gprf5foYYxM0NmRYQ2vVrFwbbFgQ4rHuqAM52jt75MHMT6Q3MZj9JFz2YmQqqX+c+0D2Xh/FworLalioyJ5sGwdNQhxpEkoAh8ONyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362556; c=relaxed/simple;
	bh=np4WTssUm98ZjxmaB945fxRtC0Roq2PQ0Toc5+gPBCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKdsmEM+F7oaKFJhafGA92Tt4JF5TPisD0rspeHmWUG9cl5GY551yGWNBJEDys5ktcuSpStpxzFwqBXBh3ZCkp8qd5emfvjU6SPeZVCwlGa5b3lo4EahkshAj5HM788cjnHFXgqAs3OGKa2/WBIuSRb0WPp+8Ok+FZUX15MwOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY2juhUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY2juhUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A130E1F00A3B;
	Thu, 21 May 2026 11:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779362555;
	bh=gqWO/E9FZuX5uI7p0ZHJIvqOuSUO87k+WS98B6/AV1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PY2juhUvoHdlpyPWuSiJqyREh7oZ3EzkQvBLsZiurH2XCo2/MkoPPkqyhEH45tLAe
	 LpDHSkpe4B2NqKdc8iigcs9QW7dux/S9Id968PWAw0p2RLywrwb1uwAaYxXWRs3Z4T
	 0ccd9XPY82+TRzaKMG63n7XQudiiXaOLPI85et+cnPAyXvsXp9j8ejnTF+ZMcajhzn
	 SKjFrIRSC3zVrrnVtHUd2j25fVH0l7Dt1nrEeamjwEpFzAxtNb3o43XmEfDqlYqX6s
	 VNY0tRL83hRLOPRO4i4g69PizfOuBjymOY24DwxWR54u9g3AnvsenX9GKAC6uz1Cmt
	 nBlWzu6+6Lzdw==
Message-ID: <6499a394-25f8-479e-aea1-a69b86657982@kernel.org>
Date: Thu, 21 May 2026 13:22:31 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Consistently define pci_device_ids using named
 initializers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Niklas Cassel <cassel@kernel.org>,
 Mikael Pettersson <mikpelinux@gmail.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
References: <20260430170612.510869-2-u.kleine-koenig@baylibre.com>
 <b06a2fec-441f-4be2-aae6-3796c1e45cfc@kernel.org>
 <ag16iA6JLwGGLR8_@monoceros>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ag16iA6JLwGGLR8_@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/05/20 11:12, Uwe Kleine-König (The Capable Hub) wrote:
> On Mon, May 04, 2026 at 10:09:53AM +0200, Damien Le Moal wrote:
>> On 4/30/26 19:06, Uwe Kleine-König (The Capable Hub) wrote:
>>> ... and PCI device helpers.
>>>
>>> The .driver_data member in the various struct pci_device_id arrays were
>>> initialized mostly by list expressions. This isn't easily readable if
>>> you're not into PCI. Using named initializers is more explicit and thus
>>> easier to parse.
>>>
>>> Also use PCI_DEVICE to conveniently assign .vendor, .device, .subvendor
>>> and .subdevice where appropriate.
>>>
>>> The secret plan is to make struct pci_device_id::driver_data an
>>> anonymous union (similar to
>>> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
>>> and that requires named initializers. But it's also a nice cleanup on
>>> its own.
>>>
>>> This change doesn't introduce changes to the compiled pci_device_id
>>> arrays. Tested on x86 and arm64.
>>>
>>> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
>>
>> This looks like a nice cleanup to me. A couple of nits below.
>> With that, feel free to add:
>>
>> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>>
>> [...]
>>
>>> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
>>> index 495fa096dd65..fac1266f7fa6 100644
>>> --- a/drivers/ata/ata_piix.c
>>> +++ b/drivers/ata/ata_piix.c
>>> @@ -154,184 +154,186 @@ static unsigned int in_module_init = 1;
>>>  
>>>  static const struct pci_device_id piix_pci_tbl[] = {
>>>  	/* Intel PIIX3 for the 430HX etc */
>>> -	{ 0x8086, 0x7010, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_mwdma },
>>> +	{ PCI_DEVICE(0x8086, 0x7010), .driver_data = piix_pata_mwdma },
>>
>> Please split the line before the .driver_data like for all the other changes.
>> That will make things consistent...
> 
> I would go for
> 
> 	{
> 		PCI_DEVICE(0x8086, 0x7010),
> 		.driver_data = piix_pata_mwdma,
> 	}, {
> 		...

Yes, I think this is nice.

> 
> then. Or would you prefer something more compact like:
> 
> 	{ PCI_DEVICE(0x8086, 0x7010),
> 	  .driver_data = piix_pata_mwdma },
> 
> ?
> 
> Best regards
> Uwe


-- 
Damien Le Moal
Western Digital Research
