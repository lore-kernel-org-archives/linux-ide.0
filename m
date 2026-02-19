Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638F2C1589
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537140; cv=none; b=ZpBBEWOG6eagew9mYRv3FmKTTViEuUlFMRW7zfFvuBYxnQE1eL9em18ozogypXJ/mkUSsBv5xFQ1albsHOlO1cB7dnzW4oSD3JIYS1Tei9l+XZPtrVhlPwNTCBNmwAdTTshKwtggT2Nxp7z9i1fcgTrhYS46OjDQlVqZpTM/7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537140; c=relaxed/simple;
	bh=t4Fbc586aGy1fkIS05d74Gz2kLABUkuSQ8lb1AYEwp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DYVjXLXnKgL+oexwP8ZBwz4ACpA1JaG+locL2VxIOuKJS76d19TnjTlnCpzagcgYdS2rvH2zXMseXbb8LlaqLN6oN/LjqAwDnb7DnZ0JP9fq0GWDQtnJxFsS6iOoXWomsBKwFadDboto0zb3DvdPb6a+Sv5paDrh2ASumEP5XhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA+wkR8B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA+wkR8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C4BC4CEF7;
	Thu, 19 Feb 2026 21:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771537140;
	bh=t4Fbc586aGy1fkIS05d74Gz2kLABUkuSQ8lb1AYEwp4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HA+wkR8Bf7JAAzLssYCtqrloe0HvBlgrGwsZrESjhgsxi9C2RXusCb5oB2e+vQAmV
	 JEcF+vrVPyFmRyVsl2BINQl2O21NPvkvXe8Qa1e5dxKKagqxhrK9zgyHP+fhCQbQrQ
	 asAszWBKDveOxHFQ7MIgodHNjek9hNEbW2E0nW/3yJBvh9jumjLWMkEihvotOi2Uk0
	 tgZZv+k/vdt50PXTWg6SCPtPsqAVRpyY0zrVaiTyZckwt72AbXovxqqhE53rHRxY1P
	 j1Dsn1olAcHj1J/g8Bag4ZNa7O5Spg0GAIv/YHcwi5ImuxoCAMTEVRvA6i2d2f3k4/
	 sTWamXG6a8kPw==
Message-ID: <93cd8b3e-b0ec-46e3-ae38-a29ee63cf3bf@kernel.org>
Date: Fri, 20 Feb 2026 06:38:58 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ata: libata-scsi: simplify
 ata_scsi_schedule_deferred_qc()
To: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
 <20260219062312.1030867-4-dlemoal@kernel.org>
 <3da46b3a-44d4-4c3d-9ca4-32089f36415c@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3da46b3a-44d4-4c3d-9ca4-32089f36415c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/26 17:21, Hannes Reinecke wrote:
> On 2/19/26 07:23, Damien Le Moal wrote:
>> Use ata_qc_done() instead of calling ata_qc_free() and scsi_done()
>> directly.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   drivers/ata/libata-scsi.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
> As noted by Sergey, the description refers to the wrong
> function.

Oops. Corrected.

> Other than that:
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Thanks.

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
