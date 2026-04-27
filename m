Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A0364EB1
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2026 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321395; cv=none; b=M91X7rt38nyI8cYB9UQrtcqf7Va2K7sJDTg7p5Aaj/iF6ZZNF1B6gxY3wfIQikGWvXR0PqhZMiIJ+I4upy8guc2HRfZhCv3bX5iOHMuPKj9jfYXQlK6DEcigLS4Ae45Atn3aBfcYNYPuy7qZsYKw5idNwfRGG57DtnFQYVB4jk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321395; c=relaxed/simple;
	bh=1/EGzb8C9dggAU/ed/MDU8FI3IzukIkF/zU2mo+vBUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A440Yj1yKUY+e6ad5B7+orDv3zefIgKAjJgYO45QHQki0Ia1S2e5kasUu97hen4F8N+9e8wwRVK8Ipoap4KAHAAKyoUuzd8GRHglT0KHL5w+YGe3mNKUDGNU1/JwsD/A9QWsSVxsYepwcVojAjKB8L6Y92d28UFXU2RBXq+4kPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW4vfUFX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW4vfUFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEED4C19425;
	Mon, 27 Apr 2026 20:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777321394;
	bh=1/EGzb8C9dggAU/ed/MDU8FI3IzukIkF/zU2mo+vBUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GW4vfUFXog68PwCEP+j3jKwkFUSUoiD3yE3CiMG8wxN0O4QrFUuj2MJRBHk2qxDWk
	 8BzsTBhYZCs6RTNVY63mG3TJHYCYaBt8y56A/L/I5lAeIBgqkQewWTYiarR/noQRN1
	 wqdV16L1+jVjsN2zENEIoypXSybVGr8Xjo03JMuJfBFjujjSS4cdvoAfcodXUrqSFx
	 EYUu0f/H7X+UNyCIyz0KQV3pXka2R2rRGNG467DAbQ3PLJqkm5Vr1Jdhre3GEgc3zu
	 XDTEAAy2Ocp73tFnS6sv9g7xjXonVZXU2iph1lT2CejO9u6KHSVrh+MKnzrXUXI57f
	 2TI+e5n+5Aa5Q==
Message-ID: <a805fa86-0fe7-4803-ad2e-45719415f263@kernel.org>
Date: Tue, 28 Apr 2026 05:23:12 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ata: ahci: fail probe if BAR too small for claimed
 ports
To: Niklas Cassel <cassel@kernel.org>, dayou5941@163.com
Cc: linux-ide@vger.kernel.org, liyouhong@kylinos.cn
References: <20260427060546.1407439-1-dayou5941@163.com>
 <ae9TGoaQAi7dOVc0@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ae9TGoaQAi7dOVc0@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/04/27 21:14, Niklas Cassel wrote:
>> +			 max_ports, last_port_end,
>> +			 (unsigned long long)bar_size);
> 
> Print resource_size_t as %pa instead of casting to unsigned long long
> and pass bar_size by reference (&bar_size):
> https://docs.kernel.org/core-api/printk-formats.html#physical-address-types-phys-addr-t
> 
> 
>> +		return -ENODEV;
> 
> return -EIO;

I do not agree here. We did not do any I/O. If anything, this should be EINVAL.
But I think that ENODEV is safer since we are in the probe context here and we
do not want to see that device show up.


-- 
Damien Le Moal
Western Digital Research
