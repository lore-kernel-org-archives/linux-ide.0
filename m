Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A042AA1
	for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2025 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592908; cv=none; b=YvxJuZ1+LL6wVUwco7c0TNBdKn0TaBShqknq41TFmGx1VWY1dnAcQJfpxfc1/5073tWVC5KNBE16HBb3sz7fYrUYjLCEyvJjEINy/4UOy2Rux/ScZ+/4RN8KEOTJixlOWHGWdLEynIKtthMVaYGd937Yb2gwnRzIriOYnw4tcsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592908; c=relaxed/simple;
	bh=lQDyHbKaTmxLDOgy5Q7KvFV/pToUjrzalrWzWV99syM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lReHIfRm18z/UrRJYMawtOdy0AjW4Lude5bBtfbsMqFPpqMjw0RPwrOuf9CGmocmyfhTdjPgZj1771FfUuLkZwFe0fpOgAvycZB9c32WgbZZjEwCf754yOM19D0dLJLRPGlWkiTVPWMTC9xckailGMaTTC06TrpuNBjINOA0Lto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0jngsUq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0jngsUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC463C4CEDD;
	Mon, 14 Apr 2025 01:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744592907;
	bh=lQDyHbKaTmxLDOgy5Q7KvFV/pToUjrzalrWzWV99syM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H0jngsUq63g4fiIqmo8jj1kYJ++DVmaKEOTxd/f4xElOdlf73Cz/KSPAlxVDEI9LD
	 8olMoTBc4ROKIKo/BnEZYFG0EMR4CWHNNDbl1TvCtMkdKIey/JZczl1QRSQbTHTjZy
	 XSuL4ouHljskiq0aF9kehsv2TJiQ5MRWWeE6RpqsTis0QLBoVR+xRpGaFLdZoydD6/
	 vUJhluLR5NbkF0EoNo9IKwImY+6kzhDQ4fYKefdGHfcNx5K6wY/6c78Cw5NVcTEfgD
	 V3yKu77oNxuOC9OSoe8hhZtrdqeDmuvvnx8/V+b25rXYVSAa6ZkqLPp166rzI/QhKY
	 PzsY8b3jSMcXA==
Message-ID: <d2ffd49d-4148-47fc-9377-949dfa7dcd68@kernel.org>
Date: Mon, 14 Apr 2025 10:07:39 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-core: Simplify ata_print_version_once
To: Heiner Kallweit <hkallweit1@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <3c13edc3-89ee-442f-ac7a-767ea5097424@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <3c13edc3-89ee-442f-ac7a-767ea5097424@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 2:59 PM, Heiner Kallweit wrote:
> Use dev_dbg_once() instead of open-coding the once functionality.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to for-6.16. Thanks !

-- 
Damien Le Moal
Western Digital Research
