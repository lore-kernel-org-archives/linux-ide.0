Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7BA433A4
	for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300413; cv=none; b=rtfqoUTtx7rQHzIiyU/qQmw/BUEK2HkWCH3wdoTCq3+0ZCft7skVruhSVO4RNPHqLDZ18PE9qY1LlQ/lPiF0R+uWJO/y7oR3xj5C1HGwALgM7eXbmvTAri0XYaW1R3wauL0uzMpoBwbs8GE9VyQ/aciYLAVFyjLAiPu5YmTqCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300413; c=relaxed/simple;
	bh=CKOeGsnphk2JM4+P8aJq68qr0oSxPNicLmFzaSnPGXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfxyFY6vFSGu2wWp8kkkQM8zOFz80Ph3Tn2/taPHl7S0NX/8QrQsnweByeDozgIOuRc4wXkSQJKsuCgM7ldVEJx2+iJZvLQLhUWsOuZNvFrF73UtUvWDTtjXt3mwBsKQownXjW4cINIckxQvqOS/XV2XIH73m9zE5S1R1oH4LOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fu9f2h6/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fu9f2h6/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718300409;
	bh=CKOeGsnphk2JM4+P8aJq68qr0oSxPNicLmFzaSnPGXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fu9f2h6/GDnp+v+sXS1cCGe2XVFW35RSIzJ+IpciC7tkFjbM2w3YuYyRFX4Vhh9MG
	 i/QmU91v7OtG3xjZfTJoAmdd1zcMHnKQWrLmRHUOjcKJW1fc+Wgj8Ln2MCBGqunif4
	 FBzlAw+XcZje4qGcZc+hWEraAzgiNC6BV+K8aYeE=
Date: Thu, 13 Jun 2024 19:40:09 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Manuel Lauss <manuel.lauss@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: Set the RMB bit only for removable
 media devices
Message-ID: <e9718314-8963-4d53-b4a6-8e10bca3f1a1@t-8ch.de>
References: <20240613173352.1557847-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613173352.1557847-2-cassel@kernel.org>

On 2024-06-13 19:33:53+0000, Niklas Cassel wrote:
> From: Damien Le Moal <dlemoal@kernel.org>
> 
> The SCSI Removable Media Bit (RMB) should only be set for removable media,
> where the device stays and the media changes, e.g. CD-ROM or floppy.
> 
> The ATA removable media device bit is currently only defined in the CFA
> (CFast) specification, to indicate that the device can have its media
> removed (while the device stays).
> 
> Commit 8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as
> removable") introduced a change to set the RMB bit if the port has either
> the eSATA bit or the hot-plug capable bit set. The reasoning was that the
> author wanted his eSATA ports to get treated like a USB stick.
> 
> This is however wrong. See "20-082r23SPC-6: Removable Medium Bit
> Expectations" which has since been integrated to SPC, which states that:
> 
> """
> Reports have been received that some USB Memory Stick device servers set
> the removable medium (RMB) bit to one. The rub comes when the medium is
> actually removed, because... The device server is removed concurrently
> with the medium removal. If there is no device server, then there is no
> device server that is waiting to have removable medium inserted.
> 
> Sufficient numbers of SCSI analysts see such a device:
> - not as a device that supports removable medium;
> but
> - as a removable, hot pluggable device.
> """
> 
> The definition of the RMB bit in the SPC specification has since been
> clarified to match this.
> 
> Thus, a USB stick should not have the RMB bit set (and neither shall an
> eSATA nor a hot-plug capable port).
> 
> Commit dc8b4afc4a04 ("ata: ahci: don't mark HotPlugCapable Ports as
> external/removable") then changed so that the RMB bit is only set for the
> eSATA bit (and not for the hot-plug capable bit), because of a lot of bug
> reports of SATA devices were being automounted by udisks. However,
> treating eSATA and hot-plug capable ports differently is not correct.
> 
> From the AHCI 1.3.1 spec:
> Hot Plug Capable Port (HPCP): When set to '1', indicates that this port's
> signal and power connectors are externally accessible via a joint signal
> and power connector for blindmate device hot plug.
> 
> So a hot-plug capable port is an external port, just like commit
> 45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
> claims.
> 
> In order to not violate the SPC specification, modify the SCSI INQUIRY
> data to only set the RMB bit if the ATA device can have its media removed.
> 
> This fixes a reported problem where GNOME/udisks was automounting devices
> connected to hot-plug capable ports.
> 
> Fixes: 45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
> Tested-by: Thomas Weißschuh <linux@weissschuh.net>
> Reported-by: Thomas Weißschuh <linux@weissschuh.net>
> Closes: https://lore.kernel.org/linux-ide/c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de/
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> [cassel: wrote commit message]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

While I would prefer a simple revert at this point in the release cycle:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

This patch should also have a "Cc: stable@vger.kernel.org".

> ---
>  drivers/ata/libata-scsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index cdf29b178ddc..e231ad22f88a 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1831,11 +1831,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
>  		2
>  	};
>  
> -	/* set scsi removable (RMB) bit per ata bit, or if the
> -	 * AHCI port says it's external (Hotplug-capable, eSATA).
> +	/*
> +	 * Set the SCSI Removable Media Bit (RMB) if the ATA removable media
> +	 * device bit (which is only defined in the CFA specification) is set.
>  	 */
> -	if (ata_id_removable(args->id) ||
> -	    (args->dev->link->ap->pflags & ATA_PFLAG_EXTERNAL))
> +	if (ata_id_removable(args->id))
>  		hdr[1] |= (1 << 7);
>  
>  	if (args->dev->class == ATA_DEV_ZAC) {
> -- 
> 2.45.2
> 
