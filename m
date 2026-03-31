Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF62AD0C
	for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2026 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921628; cv=none; b=SbEmR5CmcH/PXMrzismZ03FOPoQCsXgxYI9pxMg1KB2TwuKrWG+NYKZdE264VBMANGv8SWwbO7SUWgIsgVaSE8F5oDAedMVn7k5HQJynkMTIoADLM548VCu936lZrIWBkbo9vlpv7duuwXcti9qm2kFGpFUFXmRBgFdqlxZeDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921628; c=relaxed/simple;
	bh=F8KdfMsA63n8ZKSLyLtXGVt2FRaDpmyLZc+L02G6S0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shkBV3tcPKIBtpNJ+dk/s2Yy8S/RWTmHbqXxJFtgNnQnmR0nSmn+OXO2Nepw900UZv+dqOSSdLLaDKqol4yoDzZTHwNM0UAAII+/TDDrEsvmll5q4dnxajaiLI/kszYiM+ypzvBXrKeCjUxU5gLuopEZRYNZv1neyelzYa3HeBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbzSHaMk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbzSHaMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5DAC4CEF7;
	Tue, 31 Mar 2026 01:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774921628;
	bh=F8KdfMsA63n8ZKSLyLtXGVt2FRaDpmyLZc+L02G6S0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UbzSHaMkpRgezMEcP24PVMd0hG9Lk6Z3bcsqW1yOol3YcQM0179pxVkxnyTWvgwXl
	 XbaqDHx6LQz2hm+LZr1j2Xlj1s4y2BVEWl8RVar8zKvtQpzyFa1hn0MLst1wi1eQf7
	 PddzLTPPvyRujX18at3TdDA3pHumAtAMdNfWmBRzZcDuwxt7u6ihhvkURBXlfV6unf
	 AGcQ0VIFPFSSIRn4MU++BKDCn6g5ohMB6h37zqsaYHAQl0WiflJb02K4nwThTzMtEk
	 3MIfwX1fnmpfkfsUqaGnBjTzOcMmqWjMOfb818pPpwXf1Thgvh3ZkDEJdLwHYnczrw
	 GLfuX0uacHDDA==
Message-ID: <4c1259c9-ca10-43cf-bf78-745fbd0f068a@kernel.org>
Date: Tue, 31 Mar 2026 10:41:09 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ata: libata-transport: split struct ata_internal
To: Heiner Kallweit <hkallweit1@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <bf2ecd99-cab3-413a-97e4-1828aecd2c23@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <bf2ecd99-cab3-413a-97e4-1828aecd2c23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 12:20 AM, Heiner Kallweit wrote:
> There's no need for an umbrella struct, so remove it. It's also a
> prerequisite for making the embedded struct scsi_transport_template
> public.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
