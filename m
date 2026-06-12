Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA52E3A875F;
	Fri, 12 Jun 2026 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265165; cv=none; b=J3dUYdWBPmB+f2Ord4V4zETMW1RPH8wo03euSh2PBPVIVfx9nbl9DZeCYLj9Yv/CeGHdPzUek00QnVVegItYVmAqSmxWz237XHcfUSHYxrvchl9PvUqqp701DzL/i7UM0xtH68639ZYIDsEP97pRvYL74zdcPFdneivg8i5nEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265165; c=relaxed/simple;
	bh=nrQSWQ2k5ZUTm1i+TNQfVTh6lZswSUQDUV4benxthmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctf6SGoVNLwZRStDnWaLG5mZlzJRmYEkbD529eYRDCHdi77bbGy7SBKbP+p0jyC38wqFkN0FBuHIVpmDRN1jR355REkC5nTyFwMzLItxNc9hysmYiFTegNiF1p7+9UbHHlsCSXEWmm8A/B5lZeMZZhPLFltaw53btUu5WVO//3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0OUhJoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0OUhJoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834CD1F000E9;
	Fri, 12 Jun 2026 11:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781265164;
	bh=THNlTBPVQcvlbxTtcyzANWt+I1ZF2zQHHJAMNrMX4yQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=e0OUhJoVRqLb2Gi5UI6tCvwvhyZmm3ENbD5Eabz98udOLMr7MFgMms/5EV2it8tAa
	 gY5qJT1qm42nyCJJqTw9cuOM/R1WaPteQfGgKDL0KomR4/dJ/GWE+We+FOMwPgz5cZ
	 Z3tT/yYhvNJIVYfP2HJSJEgAR2DPwoIsqKVQcJEl/PMyJhWdZru5p0BuaANArza3XF
	 L1grwImy84DWpGZe2NwZVipPoQxMQ32WuHDq8YQmmweJV0qnQpWOjrmVU88nv4NOuc
	 TmJf61XjwAAVCRIxL8bqBRi25I2GwlAk2yY1HYc2tzf4xPosGiiV1Z8Ke3Mw6hSFcX
	 7rJ7FxOZKV4sQ==
Message-ID: <2d79fa9b-67e1-4da9-b967-03e64bae0050@kernel.org>
Date: Fri, 12 Jun 2026 20:52:42 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ata: Consistently define pci_device_ids using
 named initializers
To: Niklas Cassel <cassel@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Mikael Pettersson <mikpelinux@gmail.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1781248922.git.ukleinek@kernel.org>
 <bc1234d8-c202-4418-b85f-7672c667ceb1@kernel.org> <aivmazTaUB73ZX3n@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aivmazTaUB73ZX3n@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/26 19:58, Niklas Cassel wrote:
> On Fri, Jun 12, 2026 at 04:42:03PM +0900, Damien Le Moal wrote:
>> On 6/12/26 16:35, Uwe Kleine-König (The Capable Hub) wrote:
>>> Hello,
>>>
>>> (implicit) v1 of this series can be found at
>>> https://lore.kernel.org/linux-ide/20260430170612.510869-2-u.kleine-koenig@baylibre.com
>>>
>>> Damien asked to rework the patch adding more line breaks to make the
>>> resulting lines shorter. I didn't rewrap all arrays, only those that
>>> appeared too long to me; the longest line I kept is:
>>>
>>> +	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), .driver_data = GENERIC },
>>>
>>> which is short enough to not trigger a checkpatch warning.
>>
>> Yeah. But we tend to stick with the old 80-char max lines.
>> But no big deal as this was already a long line anyway.
>> That said, it is a chance to rewrap that too. If you are willing to send a v3,
>> we'll take it :)
>>
>> Nevertheless, overall, very nice cleanup. Thanks for doing it.
>>
>> For the series:
>>
>> Reviewed-by: Damien Le Moal <dlemoal@wdc.com>
> 
> This email does not appear valid according to internal company (wdc.com)
> address book.

Arg. I did it again. I keep mixing up my email addresses :)
Sorry about that.

> 
> I will replace it with:
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> when applying.

Thanks.

> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
