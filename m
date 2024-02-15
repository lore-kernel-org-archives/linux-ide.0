Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122A13FE0
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985360; cv=none; b=YjRa4aSSmHIDYIR2lJ6MpBbSSHq7e39Yrxyfu91pY7i/yhXCEd1CHgZd6GlDEM0bOp+8DKR6aAVnpuKNdDDBKoKXZ23fzpZL5DRVTN0JMvGTSON0RLmgD+LQLpTKsdkjyFt1TJnZ5dHcO5xkO4f5/AJ7+KMR6Rx6oRu/fL4/tAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985360; c=relaxed/simple;
	bh=N/mVNmpjXxis8Bv6WbfOALllwu2YpvIEvWiHIj596Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vvkkvj1STwAalyU4dDoBR5kIvuv2n+FEdlse6/oZBpRhUE++edLokEsFlCLWSvVqrh2MBIGl+pHWsoE0emSRG7ZF0V+rrMBAJV6iQzDSZojjuXdm0EAz2PE9tRjXu5Cftw3YR5KJ3rlqJi9ElbK7o12w5G+K2afhirRaMB8PH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6yb20yI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6yb20yI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A887EC433F1;
	Thu, 15 Feb 2024 08:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707985359;
	bh=N/mVNmpjXxis8Bv6WbfOALllwu2YpvIEvWiHIj596Sc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t6yb20yIvJ2pks9rqMGGacWWb9EoTavPK3sL8y7HQO7V2u6JOF14iM9FeqiZNZksT
	 D3qRDS/nA76qPVdKWVrtPzkKkjpe7NZT92HxHw8VTDMgkq/6oVJDiNrWFuTQt8BnRt
	 9wpwf/KaGX4NK+zwk+lyhZyDUJoF1WRh3rfgaRQHbHBhkdBMYhggAyxe+IRwCrr4vY
	 sN/2DY2YZPG07wT51PW88C/dxGRvAPhhVpiiu2d19LV2ko4bN/34IznJLCyJOcG8rP
	 KUZX020zJ4O/rANjWS+RJhzpRW9pp+HujAOprRl6qha0pcQ8V5mbLatkm4Cx7O4Ib1
	 RvLCWxFr+hj1g==
Message-ID: <5b2a63ad-6fe9-43b0-94c5-fc2e277b8397@kernel.org>
Date: Thu, 15 Feb 2024 17:22:37 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: print the number of implemented ports
Content-Language: en-US
To: Andrey Melnikov <temnota.am@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240214182031.1004788-1-cassel@kernel.org>
 <CA+PODjqp9q1VeCsDvhn1TZ6bgnghX9t8P2m-7aEjFfSiBuk0iQ@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CA+PODjqp9q1VeCsDvhn1TZ6bgnghX9t8P2m-7aEjFfSiBuk0iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/15/24 17:01, Andrey Melnikov wrote:
> ср, 14 февр. 2024 г. в 21:20, Niklas Cassel <cassel@kernel.org>:
>>
>> We are currently printing the CAP.NP field.
>> CAP.NP is a 0's based value indicating the maximum number of ports
>> supported by the HBA silicon. Note that the number of ports indicated
>> in this field may be more than the number of ports indicated in the
>> PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
>> Offset 00h: CAP – HBA Capabilities.)
>>
>> Print the port_map instead, which is the value read by the PI (ports
>> implemented) register (after fixups).
>>
>> PI (ports implemented) register is a field that has a bit set to '1'
>> if that specific port is implemented. This register is allowed to have
>> zeroes mixed with ones, i.e. a port in the middle is allowed to be
>> unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI – Ports
>> Implemented.)
>>
>> Fix the libata print to only print the number of implemented ports,
>> instead of the theoretical number of ports supported by the HBA.
> 
> NAK.
> Kernel must report what it got from silicone/addon-board. Different
> revisions may implement different numbers of ports.
> If you want to report real (usable) ports - add it after the mask.

Or print the mask *and* the number of ports.

E.g., on my machine, I see:

ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode

Which would be a lot more human friendly as something like:

ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8/8 ports impl (0xff mask) 6 Gbps
SATA mode

Or

ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 Gbps SATA mode
ahci 0000:00:17.0: AHCI 0001.0301 8/8 ports implemented (port mask 0xff)


-- 
Damien Le Moal
Western Digital Research

