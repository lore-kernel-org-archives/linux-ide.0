Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019DB305687;
	Wed,  8 Jul 2026 04:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486409; cv=none; b=tXnaMYnBINeQEbvAeGrX1pysZJB8lPvoYJ2oo9HJEMMfjFEorpID7x2yxqSfO2J4F8IUljcQhCBDtSHIRuPa8G3Z1V3Uhn73yWUxRtAsfg+7IA6sBxpLBMtGWHKZ7ik/VqpkBjukxY3GZWqOjWOqS9zHlWy3+7KlmVVJXVjaEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486409; c=relaxed/simple;
	bh=2DqVe3j1KPKxvL6vjsMig8k1cHIlJURG9NfKHX5yvhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDgNN7zLxCHS4SDSHjR/rk1eBE4D1YXL1yNPXeQReyyecEMsGtDoP0EFwq0+wTR08MoitHNKN7mS8Q1ObQyj7AX24XMblwUxR2PXs7Qoz8xZJF4B0A1GpEJt3+4gCnpDyOMmEsMuJferrGsWn5tdqyvD3qUAMp8WN+h+qb99Yj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIUYFnij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIUYFnij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB47A1F000E9;
	Wed,  8 Jul 2026 04:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783486407;
	bh=LDIANE/2oG7xJ7b2RUC97LKIFCkAOdou6I3atV8xVsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EIUYFnijWgB/rQe5x8ChPmeDMgXZRU8ewZwTM2DwC2e94xoJmukCzVO/sNpKs/Axj
	 8I4xxoN1GaHG41DjhVmGygezG4iZdg1nvM+N89QdyGOlaXA5Lj/ZTMcGk8c1CKNdAe
	 UPUR2ImyjuvRBoTyduJVBCvI31XVtyaxZhsCGNTUlhN3ilZqQEplvMH5z97L0VN5iR
	 baApi2qDXWJRh9bfTvNdXdr5gykzxnho/9i0NpcCA3MjWAB7EOGwrWKidZd0sExEIF
	 TJE+7d9QJocGiER+ZofuCuRlO69enrU2I9FNSN+FAqFZJCGkVOr475BH6D9n62/Els
	 VNiidyoPTJeIA==
Message-ID: <e9f103e8-6b6b-476a-8064-fb8d0bbf7506@kernel.org>
Date: Wed, 8 Jul 2026 13:53:15 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fixes for security locked drives
To: TJ Adams <tadamsjr@google.com>, Niklas Cassel <cassel@kernel.org>,
 Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Pylypiv <ipylypiv@google.com>,
 Salomon Dushimirimana <salomondush@google.com>
References: <akaHPScetfl1VbF8@ryzen>
 <20260706210054.1336654-1-tadamsjr@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260706210054.1336654-1-tadamsjr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 06:00, TJ Adams wrote:
> These patches improve libata handling of locked drives.
> 
> Changes since v1:
> - Simplified the n_sectors check in ata_dev_revalidate() as suggested by
>   Niklas
> - Added Patch 2 to disable HPA resizing for locked drives to address
>   Sashiko's feedback.
> 
> Testing:
> - Verified using the internal test suite that originally detected the regression.
> - The issue can be reproduced manually using the steps outlined in the thread
>   (runtime locking, disabling SSP, active I/O, and link reset).

Applied to for-7.2-fixes. Thanks!
Note: I added Cc:stable tag to both patches.

-- 
Damien Le Moal
Western Digital Research
