Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9CB38911B
	for <linux-ide@vger.kernel.org>; Tue,  7 Apr 2026 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543633; cv=none; b=TjtRIowMV9y6zXdi53z1bluYfSzxKux8p80FSSMqkqabm3HQru7eLcfTRFDJcv1vnu4nENqa7/MDwTd5V+xhQ+t+tRpiHahoR/GxeUas1XWXy5J9hlD/2ugRoPI0aj8iO3i12JZEfrc9DPKOFFtt8/FUKD/4touuucTaR+N0Ngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543633; c=relaxed/simple;
	bh=bxdh7htL0/cBywPR2+IRuX7Hk6UlhyRNNn9KV4JrcFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojTB8GneLuVlY96tImWCmrvFCzEUQCNqW5wFXXlzihjtVrFpq6asTZ5zAwF0r5ovgH+juQTR9c4sklP6ksqbCF8o7TG9Z0cTgCbHK+Lq28cbW89XaHOxJjuwiy8Mujfdy9G8Lr062r72pt2B+VkRk0rD44W6lHseKZ5p0vWZw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC3r7Fpz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC3r7Fpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C95C19424;
	Tue,  7 Apr 2026 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775543632;
	bh=bxdh7htL0/cBywPR2+IRuX7Hk6UlhyRNNn9KV4JrcFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XC3r7FpzZCTv01tD6+wVKnaAh4SmU2mstypRSrSlc4AFupSiaev4UESvSkeEw6Anr
	 sTPhN0+GeDvCbvZeFEshi9hu8Yk3MDTHibKrTjTht2EeEJdykNnXJqCF3rs0drR05B
	 SM8bkHnF5/nhqMbMeS/Ar3ves4w/8NQRoJTTgnjkM8jfMtICad1NE31Xa6fFhbrETx
	 JFuAUuxA/QZ0iwXQtn+kc8uewlOerk8BcxWFXcdZ8kWeLAhZuh/mDYg4jKpJ3xHafQ
	 0nQCzZWCQQfJVrIo0IcvscMMftYfiNmC4G2SZryR8tsxZ2wOeaS4wacCJGg1zpOyLA
	 hVxddGF/xOMxA==
Message-ID: <58df8c8c-98a6-47e4-81d7-f8c17e20e402@kernel.org>
Date: Tue, 7 Apr 2026 15:33:50 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585
To: Arthur Husband <artmoty@gmail.com>, linux-ide@vger.kernel.org
Cc: cassel@kernel.org
References: <20260406222335.379935-1-artmoty@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260406222335.379935-1-artmoty@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/26 07:23, Arthur Husband wrote:
> The JMicron JMB585 (and JMB582) SATA controllers advertise 64-bit DMA
> support via the S64A bit in the AHCI CAP register, but their 64-bit DMA
> implementation is defective. Under sustained I/O, DMA transfers targeting
> addresses above 4GB silently corrupt data -- writes land at incorrect
> memory addresses with no errors logged.
> 
> The failure pattern is similar to the ASMedia ASM1061
> (commit 20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia
> ASM1061 controllers")), which also falsely advertised full 64-bit DMA
> support. However, the JMB585 requires a stricter 32-bit DMA mask rather
> than 43-bit, as corruption occurs with any address above 4GB.
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

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
