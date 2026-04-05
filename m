Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798901A4F3C
	for <linux-ide@vger.kernel.org>; Sun,  5 Apr 2026 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775371110; cv=none; b=eF/lnIAOwwNBxp1AjmLEictLA8AR0T8Xzxr6uMcteXwPsDr0lqS3fOrGBZrGYeSx+XHHNpS7OtLTaScwBt+HpxdgN6IM8KOn9KYMHogmq8jDDqAN1B8EMG2Z9uJUf1HHpaKtlQvQiPCcY8EeexqXfmaSw6a1oa52hvu45HIjNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775371110; c=relaxed/simple;
	bh=5ytUceBvnXLpac7KmpUCTptJUyH6wliwLZNANB0lDOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jo4D9OGTh5jX/4D2v2RpJckKa52XkYAi6S+zpGV8R3Tpg/Lkw0QjFRbcrMG8kq822xgbvZEnSFZ5iQn67Q/T5+FBjaDvRxQsuslkuPXuBG69uU0a1GkrGBZQ8mO+EqUYprLvRqc7wYysOnf9g8MrDG7JnSLAt+cvWBHVKDYjOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH78Z5OQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH78Z5OQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672BCC116C6;
	Sun,  5 Apr 2026 06:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775371110;
	bh=5ytUceBvnXLpac7KmpUCTptJUyH6wliwLZNANB0lDOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uH78Z5OQsIHWwMjzc1GvwkUVJ+VFgd+j356U7gFBCORc8N1nEUS2IDo1N4v2OjMuB
	 x9RrkDNWT0wFoZT+/qNX/xw+Gn6DDhrpiIQgyo2l5dQfwtkDLVsulSbeMaGicmnRzw
	 5yepN/5yZXCM9317OTZ6NT+FO5F4JdPYhebSr1sAha5LOOg2wzXraA7Yi84h4EYCzU
	 kttyhYd7/+oKnJXOf9aOEVFbJ2QikZNzK1lx0ReK/qD+iUoNJmvBF3CuYGee3qDhjV
	 4RGsze6ZzBqRR/VQkUJmspNWO4Zi3Ja+t1vJYRZen8seHbyOyy9x620lCzbSdqDNK3
	 Cq62s0io5K+NA==
Message-ID: <bbd00f2b-dd8f-40ee-a383-5fa6e35685ae@kernel.org>
Date: Sun, 5 Apr 2026 08:38:27 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585
To: Arthur Husband <artmoty@gmail.com>, linux-ide@vger.kernel.org
Cc: cassel@kernel.org
References: <20260403050418.50398-1-artmoty@gmail.com>
 <20260403191801.79888-1-artmoty@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260403191801.79888-1-artmoty@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/04/03 21:17, Arthur Husband wrote:
> The JMicron JMB585 (and JMB582) SATA controllers advertise 64-bit DMA
> support via the S64A bit in the AHCI CAP register, but their 64-bit DMA
> implementation is defective. Under sustained I/O, DMA transfers targeting
> addresses above 4GB silently corrupt data — writes land at incorrect
> memory addresses with no errors logged.
> 
> The failure pattern is similar to the ASMedia ASM1061 (commit
> 2073d0e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061
> controllers")), which also falsely advertised full 64-bit DMA support.
> However, the JMB585 requires a stricter 32-bit DMA mask rather than
> 43-bit, as corruption occurs with any address above 4GB.
> 
> On the Minisforum N5 Pro specifically, the combination of the JMB585's
> broken 64-bit DMA with the AMD Family 1Ah (Strix Point) IOMMU causes
> silent data corruption that is only detectable via checksumming
> filesystems (BTRFS/ZFS scrub). The corruption occurs when 32-bit IOVA
> space is exhausted and the kernel transparently switches to 64-bit DMA
> addresses.
> 
> Add device-specific PCI ID entries for the JMB582 (0x0582) and JMB585
> (0x0585) before the generic JMicron class match, using a new board type
> that combines AHCI_HFLAG_IGN_IRQ_IF_ERR (preserving existing behavior)
> with AHCI_HFLAG_32BIT_ONLY to force 32-bit DMA masks.
> 
> Signed-off-by: Arthur Husband <artmoty@gmail.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
