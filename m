Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86A1862
	for <linux-ide@vger.kernel.org>; Wed,  7 May 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608180; cv=none; b=skV5RRg73VHcRIY1uyWiv8m5UNJFurXS37Qv0Ol3vpCvEzWovn2eaoj9XCpJ++Fb6Pc1tN5GnhIkZZDLx90MAYl8bht/+j0x9QaNJYTw+GmllJ1TTEoMfkslEQfA99yYZPu+VVP8zZ29kasRW7eOfMowhjMQxMN1VNV6jVpfa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608180; c=relaxed/simple;
	bh=Ttinqa4vvIroW6fMCi8q0sLxGxxlVLjn1lF3+rwz+2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbTRcqydEQCqlOkCcBX0I/ejZ7c0GY0QAJChYvKdu0pfwkrr2hqk/oe6p31Nsg+WQ05JEoOJIs/9zfcyiG4642BROTslYRO5+2QeJ8xfnw0JWyXk7Nzh2JXoADAW9aRnh4qVmu1qJv/WvvZlks3Zuq4HjENvF0tyVcteO9+3rqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQtCw17l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQtCw17l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472C5C4CEE7;
	Wed,  7 May 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746608179;
	bh=Ttinqa4vvIroW6fMCi8q0sLxGxxlVLjn1lF3+rwz+2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQtCw17l3+1251gmA0lGhAV4qeD7CrVAp/Kbw+6+Tf77HsoxN37cqfKyVkaIHuVJb
	 piHTpj3en8KPVhh3ZWWpb0LK5fAQql8Foi4acBXrcug5VNXdYKJ6FWoAo8/2IHqdCX
	 srelUzGpQaNCdBkvkja652jB+zuWzdak0D8eRuuRy6UjVqk5jPRVn6yHANj0p01/Ie
	 k353dFZjZs2Wao+1Tn7o9RFRWbiHW652UNvv4mwd8BlOWyYIAGBx89k8hl+vLosiV3
	 sgCC6Bo4UYukIasQ1SNfmW/+6NCqn+EBp0xROPJpyME1AIc3It7f/w+WJRi44M158T
	 4MCjMXAHpG+IA==
Message-ID: <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org>
Date: Wed, 7 May 2025 17:55:08 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard
 drives
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org,
 Niklas Cassel <Niklas.Cassel@wdc.com>
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org>
 <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
 <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>
 <aBjbSt5hTaUP_JhG@ryzen>
 <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 2:09 AM, Mikko Juhani Korhonen wrote:
> ma 5.5.2025 klo 18.37 Niklas Cassel (cassel@kernel.org) kirjoitti:
> 
>> On Mon, May 05, 2025 at 10:58:22AM +0300, Mikko Juhani Korhonen wrote:
>>>>> On 5/1/25 05:36, Ioannis Barkas wrote:
>>>>>> It would be better to have more details on this since only the 2TB
>>>>>> model is targeted.
>>> I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
>>> from 6.9.0 on as they just keep resetting the SATA link , but they
>>> have worked flawlessly with 6.8.x for a year and also now with the
>>> quirk applied.
>>> I have also tested a different WDC model with med_power_with_dipm on
>>> the same SATA port and there are no problems.
>>> But after you guys got suspicious I found there is in fact a SATA port
>>> on my motherboard where the WD20EFAX-68FB5N0 works with LPM on
>> This motherboard looks to be AMD chipset, so I assume AMD AHCI controller.
>>
>> Could you send the output of:
>> $ lspci -nn | grep -E "SATA|AHCI"
> 
> mjkorhon@taavi:~$ sudo lspci -nn | grep -E "SATA|AHCI"
> 01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 500
> Series Chipset SATA Controller [1022:43eb]

Mikko,

Can you share a dmesg output for the good case with 6.8.x kernel ?
We would like to see differences with the non-working case.

-- 
Damien Le Moal
Western Digital Research
