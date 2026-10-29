Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284010;
	b=pRUmeJ1Yd1yr9JEpBFhDZDuhEwqrxfn2Wfi8NvaYaORQGhx7yWDNVEteWz/ehNAVguFH
	 r5JHMzu1Ve6pNz7z19PRgx7xhEe72ZD2FGM/loGplxZ3D/pANkGKsk1oLxdxWqMPzZVBR
	 NL5Njla1jbhDuLK7GPsI+fEbN7DKswz2MK8ILKrQSpELUHCKHcJIuhzb0etkPHEVznazX
	 FEu4MmhMawUHoqZeA8m+KKWBuBxxX8ItzJMB+AyUc9NY85Qs42GRhTfnn2zJ+1X6Q93G+
	 AyZPRFbN4Mkfa5dtE1m7gWAiFGKpTSbIrvOwR5t8sV8QNE9KJ/+WgRFRE01kIDdNZ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284010;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JQb3ESrNwaTiTa1pZhJ7VUII5buIR3JEqpbjiK5RdOk=;
	b=vVLeaCcyMK+jm7fHsPMxN5JU1dRscJFJz6D4HIQxc6l0HzxuVNKtUJf7/cumfwGkDnyK
	 gTAM3i9XL0SEZx7II/h6Wj5b9XPzY8S9CWKedREyaCj0zi2rM/QuayhnS29kq9MalFO73
	 HlKpW7dk/TfoIxMkm0CQGTUxykfzzVhup/otWVBPK7dSRH6UZa1JmWaRfeH2lpu5KJwZD
	 KpTqnReyy0Q2LcPVxgifStlp7tiDmQAnFesu6rbL70+Xco34Pv0ps1/0el3PNeS4K1uM7
	 ynKtkL1fvkZe0VJSzhxUhwCsD7WFgQczYIY6AHgJiXSCeRB6GGvutpBXDaqU43YG+mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYzNrHl+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB373606A31A;
	Thu, 29 Oct 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYzNrHl+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2899E1F01825;
	Thu, 29 Oct 2026 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793284009;
	bh=JQb3ESrNwaTiTa1pZhJ7VUII5buIR3JEqpbjiK5RdOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aYzNrHl+KBQrv6P2BTGZPyQ+0P+hIsX++ZAD7klJ15HjG9PRlUF3Zu2/NFH9nufMQ
	 JWU8gJMJSfg14UYBR/UKHVC/Jmtv7GKnjhRxbfgQhp7RF553LRncfdDdNu8G4izEh3
	 6MRkJfGrP8i8nOufgO2RtqUxjXE5jSQ6g6BmmkxX/mmLS/qtn8eZ5WtMLfK5XU2ViN
	 IzdjLTjnc7wll5kXH7BmdqFUtZ0J9XW7+NYpSoAosJKs683OnaGXOTvoL+HR7wKa0u
	 kYG/qQO8tUyD1eYk4NYC40bywa+Ahw2tnpTFyNKwrV2B35kx7Y5EK/n70nhxxwvt12
	 eAmddp+GCLMLA==
Date: Thu, 29 Oct 2026 15:26:45 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Roman Gardzinski <romanx.gardzinski@linux.intel.com>
Cc: dlemoal@kernel.org, szczepan.durawa@intel.com,
	szymon.durawa@linux.intel.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ATA: ahci: Add Intel PCH-S RAID device ID
Message-ID: <auNXpco9zBLtG59w@ryzen>
References: <20261029140004.6991-1-romanx.gardzinski@linux.intel.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029140004.6991-1-romanx.gardzinski@linux.intel.com>

On Thu, Oct 29, 2026 at 03:00:03PM +0100, Roman Gardzinski wrote:
> When the Intel Nova Lake SATA controller is configured in RAID mode (rather
> than AHCI), the generic entry in ahci_pci_tbl which matches any device with
> the PCI class code for AHCI, is not sufficient, since the SATA controller
> in RAID mode uses a different PCI class code.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> 
> Suggested-by: Szczepan Durawa <szczepan.durawa@intel.com>
> Reviewed-by: Szymon Durawa <szymon.durawa@linux.intel.com>
> Signed-off-by: Roman Gardzinski <romanx.gardzinski@linux.intel.com>
> ---
> v1 -> v2:
>  - update RAID entry in ahci_pci_tbl to board_ahci from board_ahci_pcs_quirk
>  - update commit description
> 
>  drivers/ata/ahci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 9b8c0935001c..cee67c64fbea 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -280,6 +280,10 @@ static const struct ata_port_info ahci_port_info[] = {
>  static const struct pci_device_id ahci_pci_tbl[] = {
>  	/* Intel */
>  	{
> +		/* Nova Lake PCH-S RAID */
> +		PCI_VDEVICE(INTEL, 0x6e66),
> +		.driver_data = board_ahci,
> +	}, {
>  		/* Comet Lake PCH-H RAID */
>  		PCI_VDEVICE(INTEL, 0x06d6),
>  		.driver_data = board_ahci_pcs_quirk,
> -- 
> 2.53.0
> 

Looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
