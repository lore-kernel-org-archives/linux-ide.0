Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6E21ABC9
	for <linux-ide@vger.kernel.org>; Mon, 26 Jan 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769410126; cv=none; b=r7ts1LUNtmh4fAtfp8NFXvJsCNadUnZwPfF8pCJNMO6VJhEj53UADnSCuyHkkTICd1QeIV5PcBRTLMQx0+y1vzdUHFzsJz2xaZCwclZXSet/EC5Ww/GD46okvWiZYMZYThs5BJCPFcRixEwiuPx3yXbdL7IrVgtTKrQ3lvimHVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769410126; c=relaxed/simple;
	bh=3CZsmqY660ER814DDR8CPC7eDpR5TZXo48nwr7iXRXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbVmv7ASWXMjtGJJ4btbWIZCilxYXEZo2twvvK1GdA25GRTO4rAS+TLajBFnmPyX1yDIyNJNdR40M8Q72+0x+A59Ac9+HAgwrDO3/WmmNL8jxGmAV/0sjb8v7sSX6pHPpFJ6uiOOTpGV0G48S9zY59usC8cPhbgd86KidtGaNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF6CZg5o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF6CZg5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF68C116C6;
	Mon, 26 Jan 2026 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769410126;
	bh=3CZsmqY660ER814DDR8CPC7eDpR5TZXo48nwr7iXRXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GF6CZg5oX0IrZx6kfq/HVrDksg3C2iWlFnIwoN/Ivj2PetaTGjH9eSKE5Goys0Gu6
	 wBGl9Im20kMuCVA+K3l6b+0OnvHGBzI7nMJ6istnZFp6RWrSYy/SHmfFVOJXall+WA
	 xVILUUea4DVKFCnKNzqXKVyw+n5QBJ3kdzEIZjxHifxCSmYsL+z1STNBhFt1NnTqXd
	 VTx5AsS2nOajmlHJV74sp20j6e+Nt0RRzU5T54ETds7XPQHX9SiO9bUuT6MuVLRZHe
	 vev54pnpgE49gl4DtPNFKZVgs5WFaqG7frOZOamBEZL6f16Dzq5CD6BFk/yZLmb9cu
	 cPK5Hp4Nt4ZOw==
Message-ID: <a293512b-dac6-46d8-b9fc-6dd6433816a2@kernel.org>
Date: Mon, 26 Jan 2026 15:43:46 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Quirk INTEL SSDSC2KG480G8 max_sectors
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Wolf <snow.wolf.29@proton.me>,
 Salvatore Bonaccorso <carnil@debian.org>
References: <20260120103237.3922391-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260120103237.3922391-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/26 7:32 PM, Niklas Cassel wrote:
> Commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP") increased
> the default max_sectors_kb from 1280 KiB to 4096 KiB.
> 
> INTEL SSDSC2KG480G8 with FW rev XCV10120 times out when sending I/Os of
> size 4096 KiB.
> 
> Enable ATA_QUIRK_MAX_SEC, with value 8191 (sectors) for this device,
> since any I/O with more sectors than that lead to I/O timeouts.
> 
> With this, the INTEL SSDSC2KG480G8 is usable again.
> 
> Link: https://lore.kernel.org/linux-ide/176839089913.2398366.61500945766820256@eldamar.lan/
> Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Applied to for-6.20. Thanks !

-- 
Damien Le Moal
Western Digital Research
