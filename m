Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74108244688
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294875; cv=none; b=KPjW8afLQ1SLYCJ6GxTDeyxMLlwO7BITydWvJp5FB41IShZPqMp+r8ruzaD7Gf1/orbg1BdqftsZPY4X0DNNV3tdVImxYCNwTzTkUHu8q6eBu5ra3mCUTm6EXBFDIbhSNnAriCsWic69y1H6H3tC8a6fXDO855iUbxhUTlQM0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294875; c=relaxed/simple;
	bh=tONf1i8CuiFnCbcUTptIZLdfpY/lRzZRhGePJYtchH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fawk6nki7f4DoLK1CCKqS6WlJGOw0Yp8BvTaa4d6slxagQFzp8767KjfnkejYH7po8ZikBxJvPVIiPt6dULF6YfcnuTfTABzuR4NA+qozQ6MAS7yuDaJ/YIuHhBEZpTtaKzK5p7MJRLncee/pp44kdjVNGzdKiyVCbBlvFMe+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX/tHWyz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX/tHWyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B97C4CEE3;
	Mon, 30 Jun 2025 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751294875;
	bh=tONf1i8CuiFnCbcUTptIZLdfpY/lRzZRhGePJYtchH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NX/tHWyzDgEHY7F1OnAEe8Wr+HrFGTK12MH5w5OgDisP2kS1QlgSxz7fh+zVkeU3G
	 rEnBOASUIDVzhzaq4xe/D/RPEkpqFk70UeZ0tILdnAkvLumkO9KQXDoMgyVuvcJ0EK
	 GKVZyRlcVzaoY5yFiRZzK8C6YdtPMqh9F5uSpDwPkMj29IaqsrFtXO6Ix+QP6vk+/J
	 CNc7jLWjh45wSZlHZlDV30N3CB2dVhqVnr1h0H1Xjhj5wG07+2BbmMMxj4IqdMp5e8
	 GisL4Fvf7v+8J9jdCvMKKmsKOhshO4wipItBTg5pOozM3HNt+QfCZoLtjGpcLM4KUp
	 zdwjQy4KppyFA==
Date: Mon, 30 Jun 2025 16:47:51 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 04/10] ata: libata-eh: Avoid unnecessary resets when
 revalidating devices
Message-ID: <aGKjl4PtYfaFikfY@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630062637.258329-5-dlemoal@kernel.org>

On Mon, Jun 30, 2025 at 03:26:31PM +0900, Damien Le Moal wrote:
> In ata_eh_revalidate_and_attach(), a link LPM policy is always
> set to ATA_LPM_MAX_POWER before calling ata_dev_revalidate() to ensure
> that the call to ata_phys_link_offline() does not return true, thus
> causing an unnecessary device reset. This change was introduced
> with commit 71d7b6e51ad3 ("ata: libata-eh: avoid needless hard reset
> when revalidating link").
> 
> However, setting the link LPM policy to ATA_LPM_MAX_POWER may be
> visible only after some time, depending on the power state the link was
> in. E.g. transitioning out of the Partial state should take no longer
> than a few microseconds, but transitioning out of the Slumber or
> DevSleep state may take several milliseconds. So despite the changes
> introduced with commit 71d7b6e51ad3 ("ata: libata-eh: avoid needless
> hard reset when revalidating link"), we can still endup with
> ata_phys_link_offline() seeing a link SCR_STATUS register signaling that
> the device is present (DET is equal to 1h) but that the link PHY is
> still in a low power mode (e.g. IPM is 2h, signaling "Interface in
> Partial power management state"). In such cases, ata_phys_link_offline()
> returns true, causing an EIO return for ata_eh_revalidate_and_attach()
> and a device reset.
> 
> Avoid such unnecessary device resets by introducing a relaxed version
> of the link offline test implemented by ata_phys_link_offline() with
> the new helper function ata_eh_link_established(). This functions
> returns true if for the link SCR_STATUS register we see that:
>  - A device is still present, that is, the DET field is 1h (Device
>    presence detected but Phy communication not established) or 3h
>    (Device presence detected and Phy communication established).
>  - Communication is established, that is, the IPM field is not 0h,
>    indicating that the PHY is online or in a low power state.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
