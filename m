Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5835E948
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062328; cv=none; b=t/+oHrPzN/4BdDu/bylvaaG2cPNDcDxtPDTROUKz5iX28361Fp3snRmC2DhUj0TKegb4DOqIN+AqMu/T4ayu9V2+UBfw8OIIcfoH5xehewidZh0OAeW+IOGmxLr69u/rnoX6oHzK1fk6NOCNLj/4X6MJMa4YLyIZvOXgBdSgF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062328; c=relaxed/simple;
	bh=Tx7NVKjQkq00FA6yuTdM+/ZDZ6gkrRxAsaVXWOoC9Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rAPfSVEGzgSVrW2RT2u15XCxf1JZuaz+7gQv5rSbAB9wvmHWNwsXLiqL4bXUek+E3KAOZ+49C3gwKv9Vy82wB1P3vSSHn6AV/+tJvnWufPMfjeYijcB5aM/YdWoKqEjqsCMgeX9CbP3QaOhGMJ+L8GRlhG8iD0AOYdJppxP99LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU5jgDX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU5jgDX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DEA1F000E9;
	Fri,  3 Jul 2026 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783062327;
	bh=A9zmVTyQixc2wyjTl1nFGnD/HzCBKjVaOuv8aAvewQE=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=bU5jgDX9diSOe3svjp7h50XtFnaSetRwDl7HP9D/SWXmUJHy6PFnATmk2vPcdDjV6
	 Ab1wVQSsF2CKOWyd+t6IM4VK0hNn3a2elQqT/sJbgbkli/7fj6UAz/IWnshGMOO4WC
	 Ygx88TYJLaqYsyndSzpc5WvSEvBgvNDIaB/KHGxZqP2Q4WoKDRBWH2LCI/0M279K+l
	 4Q4M3wg+Od01ZJRR1WmYXksbwCVwzoibAJNrt7H/gie0yAZMtdlon9cTidmRdnEjY0
	 re6uhLmaex8C1hHD6E2/wzTX9YE24L3krnQgmRix9s7oKt45AZhbczF6Va+aUszicU
	 VkC7yrXxUjvdg==
Message-ID: <e98e05a2-03a9-4b62-ac49-f382ea08c932@kernel.org>
Date: Fri, 3 Jul 2026 16:05:25 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
To: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260703040532.2152614-1-dlemoal@kernel.org>
 <20260703040532.2152614-3-dlemoal@kernel.org>
 <63c22af2-09df-47ff-a5cd-a9165bf265fc@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <63c22af2-09df-47ff-a5cd-a9165bf265fc@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 15:44, Hannes Reinecke wrote:
>> +	{
>> +		.op = MAINTENANCE_IN,		.cdb_len = 12,
>> +		.sa_valid = true,
>> +		.sa = MI_REPORT_SUPPORTED_OPERATION_CODES
>> +	},
>> +	{	.op = SECURITY_PROTOCOL_OUT,	.cdb_len = 12	},
>> +};
>> +
> 
> What an unusual formatting. I would have gone for multi-line
> entries even for the simple ones to keep formatting the same
> for all entries.

The multi-line for everything made the array really big, and hard to read. After
trying different things, I settled on this.


-- 
Damien Le Moal
Western Digital Research
