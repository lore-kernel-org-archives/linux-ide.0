Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E839021E
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975682; cv=none; b=ZQ8m7ohGV6G9gxao7J6QSoRJzaNAFD/fvJ9PNb1dgzOPsEYVVksX/YdCAFTYlseIWFmeabzOqSXu9oLFUqii8jK1Ua83T8BIM6XG7Ti5KgC5R/N9baMHg1pIXVWj8Q9AK7cY4dm7W4k0dFLvSZxdGpdRt6Cc5lplWopEbX4BT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975682; c=relaxed/simple;
	bh=8NG4YEyXaCleml4kUzGdYEZggXpxQRfVR/TcLZWRPEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FL6N8r7jTsWnNBOGeBqtE8wkFAj1nkhwFkZnwIGwk4Nd4/LWR6EpNsOAzwQJ19xhTJd/EYwuaivQ7hJzGotuPcd0LaicXDXbH8l39PvhAlfNB7IgS/AKlFKwK3JozhGJnOs7P3dbQmMhchyQ6N4STXFx0RnhnY+CO6lTjUtWZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhZd+Fda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhZd+Fda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E111F000E9;
	Thu,  2 Jul 2026 07:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782975681;
	bh=FMceUkbcj6jdBIRng76B4Zha3iz69Fn4RfFUcCE6Zvk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=dhZd+Fda1WZPtE78kP5LnZ9FfAh2t33DffeMwWbF8OMooO54c+a1qWNdRDz4n3maM
	 vp/jD4rJNDmKyschho5vt6jDJdxDzfRWl2tXAawEE6GW0qPWHLOY1zjl+qe0zqpNcd
	 u3kPzMuJ2iLSTc/47WtKJE73SCJkMfgm2X9ECrj1UKudVuyRN0/o1IaFu1EdupJmN8
	 UAl/etWogL0JfmNlMhvzj/R3Mz/IIoC4MP4qZ8F3BUxv/ERPE4fJphWVPmJQG4KGsQ
	 ROaVy1kg68EKKb+Z0z2mUXGhfO+ashVXpU+rgGLVyrYaf0/RAxZL1W1LeFlAZ5GSie
	 ndNiM33eZjgkg==
Message-ID: <d56b355d-72c2-4f24-b361-c47eb49da222@kernel.org>
Date: Thu, 2 Jul 2026 16:01:19 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
To: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-3-dlemoal@kernel.org>
 <7bbaa305-1b0d-41d0-a297-7159a8db15d5@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <7bbaa305-1b0d-41d0-a297-7159a8db15d5@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 15:44, Hannes Reinecke wrote:
>> +	{ REPORT_LUNS,		12,	false,	0 },
>> +	{ ATA_12,		12,	false,	0 },
>> +	{ SECURITY_PROTOCOL_IN,	12,	false,	0 },
>> +	{ MAINTENANCE_IN,	12,	true,	MI_REPORT_SUPPORTED_OPERATION_CODES },
>> +	{ SECURITY_PROTOCOL_OUT, 12,	false,	0 },
>> +};
> 
> This probably is a tough ask, but wouldn't it be better to
> move to named initializer?
> IE things like
> 
>   { .op = TEST_UNIT_READY, .cdb_len = 0, .sa_valid = false, .sa = 0 },
> 
> that will not only make it easier to read, but will also be
> more user friendly if someone needs to expand the structure.

Arg. OK. Will do.

-- 
Damien Le Moal
Western Digital Research
