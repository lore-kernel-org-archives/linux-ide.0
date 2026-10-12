Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328743B71BF;
	Mon, 12 Oct 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794024; cv=none; b=XC+mdxaysYc6hjnp0B+l7L/tudYZPwfEa/euznhLW5gUPCi5KhAvONrIUsYoOVfMjtBoHIn9Dq1Z6wdvY4RgzpkiLOPuKoFarW2FT4nmzHs+w/xSHtLYTVqs8G89/usBDTnBMQt0rl8osJtZ7P9fjp8n9VF51oMqJUqerfzSM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794024; c=relaxed/simple;
	bh=UKBNkYyqM9a1PrMnDWbq+yw8tbPB4Niwx6ldXweKuZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/gLQ6J9SNXMO09JjBWc/d5Fh3w/oZlf20m7S0UwB/d6FD7I/fDrjHfItlZsiro/usNDR6EG/ZBARRRMs18pTJbV45Z7kekadCIlATPXL2Dwra4osxzSEv/jfqI8WJ4alfmw/CMvy6gC9NLcMY8+ThZdJoyxO6Ppr4IiDJfKX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlNo8X01; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlNo8X01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC09D1F0089B;
	Mon, 12 Oct 2026 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791794022;
	bh=OvydJ7BmkwWTpQPEMUx/XYl6l9cAJYw44N4LAtpR2y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JlNo8X01NqVFGEQKOCNGRR/ORYwQx1m+LpnjgfZl5ML+muZRa5HI+8RCX/tbOrOyW
	 MwFlUPUNd/MF316rqt0tOVKtiiy76rZYUYWHz755V0iVeZMnpGwW3jWthw2t35jeYX
	 aFbB69donMdSQLJy/Iz0V7n758V4oOfaRbEnjzImEV+eFfN2a1iEfQQavH2bpB4Z/3
	 76o8qpeOJKeXYUWLoHiz1ntubJdxQSt/Wolmlz/+sbxKA+iC5ZWJbvr6iXEX7bRhem
	 lWoss0MT2CE39hM+ZcZXCqthOBR6+vWYz6vKzp1rkTOS/KO1lpE483UidSxK3d3TMX
	 ftYOnnEhkGeVA==
Date: Mon, 12 Oct 2026 10:33:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Kyrylo Biryuk <illofspeed@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libahci: re-enable FBS after error handling on a
 port multiplier
Message-ID: <asybY_hEtxhoAgrV@ryzen>
References: <20261011180236.735-1-illofspeed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011180236.735-1-illofspeed@gmail.com>

On Sun, Oct 11, 2026 at 08:02:36PM +0200, Kyrylo Biryuk wrote:
> ahci_do_softreset() disables FBS before resetting a device behind a port
> multiplier, as required by AHCI 1.2 section 9.3.9, and re-enables it only
> when that softreset succeeds. If it fails, for example because a
> hot-plugged drive is still spinning up ("softreset failed (device not
> ready)"), EH escalates to a hardreset of the PMP link, and nothing turns
> FBS back on: only ahci_pmp_attach() does, which runs at the next boot.
> The port keeps working with command-based switching until then.
> 
> Seen on a Marvell 88SE9235 (1b4b:9235) with Marvell 88SM9705 port
> multipliers (1b4b:9705, in a Synology DX1222 expansion unit): after
> hot-plugging a drive, the kernel logged "FBS is disabled" followed by
> "softreset failed (device not ready)" and a PMP hardreset, and never
> "FBS is enabled" again (twice, on two different ports).
> 
> At the end of ahci_error_handler(), re-enable FBS if a PMP is still
> attached and FBS is supported but disabled.
> 
> Tested on 7.2.6 with the patch built as an out-of-tree libahci (the stock
> ahci module binds to it, symbol CRCs are unchanged). Hot-plugging a drive
> into a free port of the multiplier then logged "FBS is disabled",
> "softreset failed (device not ready)" and a PMP hardreset, followed by
> "re-enabling FBS after error handling" and "FBS is enabled". Afterwards
> two other drives behind the same multiplier read 259 + 259 MB/s in
> parallel (O_DIRECT, 4 MiB blocks), against 268 MB/s for one drive alone,
> so their commands overlap again.

This whole testing paragraph belongs after the '---'.
Having specific information about exact kernel version, or if the module
was built as an out of tree module, or built-in, is not information that
should be in the commit log itself.


> 
> Fixes: 89dafa20f3da ("ahci: disabled FBS prior to issuing software reset")
> Assisted-by: LLM
> Signed-off-by: Kyrylo Biryuk <illofspeed@gmail.com>
> ---
> 
> Notes:
>     v3: no code changes. From and Signed-off-by now carry my full name
>     instead of the GitHub handle "illofspeed" used for v2 (same author).
>     
>     The controller is passed through (VFIO) to a KVM guest; the tested kernel is the
>     guest's. The two earlier occurrences without the patch were on ata8 and ata10 of the
>     same controller; this test was on ata7.
> 
>  drivers/ata/libahci.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 08ab56e9556..6f374fd79f5 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2233,6 +2233,23 @@ void ahci_error_handler(struct ata_port *ap)
>  
>  	sata_pmp_error_handler(ap);
>  
> +	/*
> +	 * ahci_do_softreset() turns FBS off before resetting a fan-out link
> +	 * and turns it back on only if that reset succeeds. When it fails
> +	 * (e.g. a hot-plugged drive is still spinning up), EH escalates to a
> +	 * PMP hardreset, which never re-enables FBS, so the port would keep
> +	 * command-based switching until the PMP is attached again (reboot).
> +	 * Restore FBS once recovery is done and the PMP is still attached.
> +	 */
> +	if (sata_pmp_attached(ap) && ata_dev_enabled(ap->link.device)) {
> +		struct ahci_port_priv *pp = ap->private_data;
> +
> +		if (pp->fbs_supported && !pp->fbs_enabled) {
> +			ata_port_info(ap, "re-enabling FBS after error handling\n");

I would drop this print.


Kind regards,
Niklas
