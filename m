Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCF2DF154
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320409; cv=none; b=JdkNhqGntUK8tGpuY1UxLSKOCSGjezF5A/i0JGwEa8pn+PZ/cDT5/HITfi0eK2K/OG1HQkazMePoYzBAbPuqTaiML+lyR9hdeVFrUg/+8GThUYPBH7ZK8YMKAw9ZDQcNZPwmBdmQuqSInrehemh1Kl4RuxHvmIPKYM3LeTcWUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320409; c=relaxed/simple;
	bh=5Vcaq+Mv37yJ01mHDMGU/LxknqujY12wrw3iuNB9wRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmwzqmwqQw8mQRKR0TrPLLMpwfRIY61lkYh9VqhrlH09SxBa3SPodtuqxmkQH/Oysfrh//XWtDbQTLgM2o78mAMYtiAyp+M0u5w9kl9S7fYclQgmnYUrR3cHzEC4k12SUxvVCfiV1fnYv39WiJikJDZqAK1atDa4oG0ZRjt5L6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9ZotuCA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9ZotuCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8538C4CEF1;
	Fri, 28 Nov 2025 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764320408;
	bh=5Vcaq+Mv37yJ01mHDMGU/LxknqujY12wrw3iuNB9wRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9ZotuCAVbnqMfDHtuu7AYlBT9dSwAvW4B3GE6XWGLsgvoeWgLutn5cfrIquE8zVY
	 srxjvlq7mvVj2qp5Z/92ORVerX8CF7FdmaihpIMYkuPiFd9ngpx+k2mRNfOU78ZPlg
	 O+wDu6bRk/XUKWFC8J3GND0pvJOq4B4Hug4t1Ro3yAU1QZeFgtAer+U7f3QQ8yauGE
	 tWwoi2bDXmixZ1hJuLdDTtrDZvm5LmBzKtbYXTS4O55W1OrLqjAtcAN2bzJDWqgjoS
	 BqewC34NoVxOMjhE5k/B3CmhQmNJY3d+/ko+tBB82MEzuL+KOrfzlIgycqWBLzuyCq
	 u4fEedZp+GEWA==
Date: Fri, 28 Nov 2025 10:00:05 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com
Subject: Re: [PATCH v2 5/8] ata: libata-core: Quirk DELLBOSS VD max_sectors
Message-ID: <aSlklcOzcgejG5nx@ryzen>
References: <20251128084814.3798425-10-cassel@kernel.org>
 <20251128084814.3798425-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128084814.3798425-15-cassel@kernel.org>

On Fri, Nov 28, 2025 at 09:48:20AM +0100, Niklas Cassel wrote:
> Commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP") increased
> the default max_sectors_kb from 1280 KiB to 4096 KiB.
> 
> DELLBOSS VD with FW rev MV.R00-0 times out when sending I/Os of size
> 4096 KiB.
> 
> Enable ATA_QUIRK_MAX_SEC, with value 8191 (sectors) for this device,
> since any I/O with more sectors than leads to I/O timeouts.

"since any I/O with more sectors than that lead to I/O timeouts."


Could fixup while applying (unless there will be other major review comments).


Kind regards,
Niklas
