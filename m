Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A356117555
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2025 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744329720; cv=none; b=YFNyujwiSKzrzg521zoQGea2boMlKRbslHffiP/GFNNywhhObStzu3V5xRtZG8k29R2kADmXUsDaQwHYkbjdB7XPxQnUHmW7s7yzIggPqEtCFU7jlxqkoKc4nbxp+LkKDFECGm6NUH++UJUmP6ouRDLAIpT7iU4YlWWhuKYVUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744329720; c=relaxed/simple;
	bh=EQu3g0eKZwsu0aqE9OAzj+zRdTDNweA8lKKdHkNTCZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rp6ox0FsuARG80tCDHkxN2NQoHZ/3sCtKiQun+LD9Qcn35lro6MhnJhhbhktL/Zs9pvTE41ntFb8JF/9dZ4HXXlC+7pL2SQCQY9mh3mE+4QChlNMI7pVI1XkbGZMYH4+DN519rUZ5HK0TJxLxMmUonWQwZirFGoRAaZcR1oTies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjouhSZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjouhSZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E57C4CEDD;
	Fri, 11 Apr 2025 00:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744329720;
	bh=EQu3g0eKZwsu0aqE9OAzj+zRdTDNweA8lKKdHkNTCZk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FjouhSZaTt+gautUqSGidqCUFzz1DDSFwGuBCNK0twRngQytL+XG8fOzGomWGHHR8
	 wYJvpPUIgbbxa6vuXlmrxqnVkv3zQ73jgP6e8+j8MPCjiYnz5Vf36079lOiQ0cZG2S
	 pnennSON476vfJkKs1zdg+AemR8u0ZmOnX6n0RXfmuA0afc4K18qMui3DUb1pEg9Q9
	 mBQvprKfmkZ5Od1YXE4FEPJkim43QtPSxs1JrBXOoIJYuOgd8Po89nlilc7f+wIAT0
	 t0YAntMCTX8YbAe769rWyoZBL9qS0ND2Nli5RBsO+yjbVJyE8APOm/u+puxXx0dOym
	 6y7C+3XIyV2ow==
Message-ID: <a0626203-bdb4-41ad-a658-03b34a436df9@kernel.org>
Date: Fri, 11 Apr 2025 09:01:58 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-sata: Use LBA from sense data descriptor
To: Niklas Cassel <cassel@kernel.org>, Igor Pylypiv <ipylypiv@google.com>
Cc: linux-ide@vger.kernel.org
References: <20250409084546.121694-2-cassel@kernel.org>
 <Z_aul100eqb2-naM@google.com> <Z_fBaVZkcD9AtTaR@ryzen>
 <Z_fP7RKf5AbybyXB@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z_fP7RKf5AbybyXB@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 23:04, Niklas Cassel wrote:
> On Thu, Apr 10, 2025 at 03:02:33PM +0200, Niklas Cassel wrote:
>>
>> I guess now when we do have access to the information, the most consistent
>> thing would be to fill all field we can in qc->result_tf... but, to do this
>> for every IO might slow things down.
>>
>> So is there perhaps some logic to only filling LBA (in addition to STATUS
>> and ERROR, which are filled for all NCQ commands), since that is the only
>> field that can change, as per the specs.
> 
> Looking at this more closely:
> https://github.com/torvalds/linux/blob/v6.15-rc1/include/linux/libata.h#L574-L577
> 
> FEATURE is a union with ERROR, so we cannot save it in qc->result_tf.
> 
> COMMAND is a union with STATUS, so we cannot save it in qc->result_tf.
> 
> 
> The sense data descriptor does not provide AUXILIARY, nor DEVICE,
> so we cannot save these.
> 
> 
> I will send a v3 that does populate COUNT (7:0) and COUNT (15:8),
> since it is only so few fields that we do have, we might as well
> populate them properly.

+1

> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
