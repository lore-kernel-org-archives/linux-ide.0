Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC315B991
	for <linux-ide@vger.kernel.org>; Mon,  6 May 2024 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715034536; cv=none; b=f3wOryWTpciD61xhtM7EqMRPdkAWkBDJfF5j02Zh2G3Hz7nwNmzc2y66uvh/MyJm+SuSLuXSoTPkJRP6l/RILzo2gAE0B7ijSFLqo9S4y7jiZaLqFyrJB9QSEJ4KlyNpLHYFbLDcl3qktHUgv+w3XT5dQtMmsfgZZ2kIHCxy2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715034536; c=relaxed/simple;
	bh=cbZdWSB4YR2loLcre+q7S7h3BY5XaqHuoN+YmtYdZ/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mViKACh+k+KlPmof8G8ZxiKkvA8zm75C3ezxBdn/I8NtPVGil2SJb/Yl7NRZXM06lvSywg7bj5tFEtHfJl4mdA6kqcaJypi7koKI982aSR2mi/CAJ5R2YqfKxHVfqu8Xw9hGFYcanhKM2E2uJgJOzh88xfLnNQ9f6EoRD2APkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvHO0qcL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvHO0qcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C5AC116B1;
	Mon,  6 May 2024 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715034536;
	bh=cbZdWSB4YR2loLcre+q7S7h3BY5XaqHuoN+YmtYdZ/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JvHO0qcLSOVleukq+wwl9N88WO4I1f84dcwyD0DPv/O+AzHIk6DqncQbcXc+oiaIs
	 g6ODkVGLtapex86j86AcUlm3EaAZNqtZoEQvueqH5h8c6TC5IMls3+Ce/Q0eBeeS5d
	 L0glPb+ZwBWkN+KHEP/kCYmTj2d2+/iDF+Xj11+wRv4pqdt5XCnLGGgdrLSDb5bbMn
	 luHUuSeHOyURQcotmxPn4K6hIzByvAmGlVslamigiteg/lbcEGdamRn2tBwkqjgJ/Z
	 Z7qFLMPOpfIGALYiKSGsr8E5myo2H0PynY0aya0L1MflM4cdlfCCo17R+8ecz8Jq2O
	 ieXLCJKeywq3Q==
Message-ID: <f9dde70c-fd16-4fed-864b-7a8c73378206@kernel.org>
Date: Tue, 7 May 2024 07:28:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_legacy: make legacy_exit() work again
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: lvc-project@linuxtesting.org
References: <c6ad7d07-4dc8-7087-4018-6ebdf93d6580@omp.ru>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <c6ad7d07-4dc8-7087-4018-6ebdf93d6580@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/24 05:27, Sergey Shtylyov wrote:
> Commit defc9cd826e4 ("pata_legacy: resychronize with upstream changes and
> resubmit") missed to update legacy_exit(), so that it now fails to do any
> cleanup -- the loop body there can never be entered.  Fix that and finally
> remove now useless nr_legacy_host variable...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: defc9cd826e4 ("pata_legacy: resychronize with upstream changes and resubmit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-6.10. Thanks !

-- 
Damien Le Moal
Western Digital Research

