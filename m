Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8B17D2
	for <linux-ide@vger.kernel.org>; Mon,  6 Apr 2026 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775460632; cv=none; b=bLfQigpDK2x3+/TgffBQg5kBGuxQnaBH3CiOjvxfr8MDLZvVUVJkU37pdXmLvzwM3Pk+3ZrvF1rogoUHd3jhlUCxmBNKSeFAX7yggClJXkRajliq3SN+ldjxeQs1h8moMBS3qZohYgHLZJExgHcnwPo5mH2EC3JaJjNCGnZWM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775460632; c=relaxed/simple;
	bh=03lQLDR95FItSY5pGeU4zmCi+QahYzqX8JqMH8qgAR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCSBo9/N4kvH5K3j7bBYUlkVaBPShr7dl6jIZJU4+y/HZzSAbegIw3QORq5CIJYsqrxzf7MrTqYVVGumr+2iUVVlpDOd8iKF8xRgoTG/5RpdHVWXnyPWghbtpEsr3uMNXrCkZwLX1ZoqPAnLjYufCyNVFfntMH1t3iourAK9i1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcsYbt/V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcsYbt/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823DDC4CEF7;
	Mon,  6 Apr 2026 07:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775460632;
	bh=03lQLDR95FItSY5pGeU4zmCi+QahYzqX8JqMH8qgAR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcsYbt/V/viUJSD86+m8DCpvEvJC5J30ztTePonyyKMiakdQK0sYUCMdpNxvQ25BO
	 fOZsDd6su7911EjhbrdWR3agcI3Ovtkiim1dFFDr0dOBnxAr1CFkS6VuJQbKtKHr+Q
	 DA/IS2VbyDETbBlYDolNgUkvBz77to/rfnOGJYtrysjk3WzWLSymTgZNhXU0KATWrB
	 n5ANo5RhBto3+RoEJ8KyR+kC1pDRv1iYoa/H6PSxTd4Mut7kAguy3l3IG+JINwnHPZ
	 FgqEfHQs/jeDHUPF3W944mL4hnbP2tLA9sl7EBIYpIpRxWfC+uWrBzeh+9K0k61v0t
	 AX3zpVcEQWgHQ==
Date: Mon, 6 Apr 2026 09:30:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Arthur Husband <artmoty@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v2] ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585
Message-ID: <adNhFOz6IRUSGfq0@ryzen>
References: <20260403050418.50398-1-artmoty@gmail.com>
 <20260403225314.96459-1-artmoty@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403225314.96459-1-artmoty@gmail.com>

Hello Arthur,

On Fri, Apr 03, 2026 at 03:53:14PM -0700, Arthur Husband wrote:
> The JMicron JMB585 (and JMB582) SATA controllers advertise 64-bit DMA
> support via the S64A bit in the AHCI CAP register, but their 64-bit DMA
> implementation is defective. Under sustained I/O, DMA transfers targeting
> addresses above 4GB silently corrupt data -- writes land at incorrect
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
> ---

You have sent two different V2 patches, however both of them fail to apply:

error: patch fragment without header at line 18: @@ -115,6 +116,14 @@ static const struct ata_port_info ahci_port_info[] = {
error: could not build fake ancestor
Patch failed at 0001 ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585


>  drivers/ata/ahci.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index XXXXXXX..XXXXXXX 100644

I think the problem is that you have index XXXXXXX..XXXXXXX.

The XXXXXXX should be pre- and post-image blob object SHA1s, e.g.:
index ad798e5246b49..3b65df914ebbe 100644

Please use git-format-patch to generate your patch and send a V3.


Kind regards,
Niklas
