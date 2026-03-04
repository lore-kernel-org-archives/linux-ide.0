Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA4364EA3;
	Wed,  4 Mar 2026 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616067; cv=none; b=cKOIVmo4cVZXqj63wr2odvOz49SKx4irY3eC0TU0u4Iu5upCUOy3olqMnooh9zIA7PZQ+OzvxXhN9yEv2AWNdLvLzZorZ4aRbW/oXNFvLUnuCzXQGERIdVGeeimXV5CoamgQTZS3v0Jerhy3al80ieagN+8+EGmoeZqvh9tLskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616067; c=relaxed/simple;
	bh=85MQK4J5RW9x/ySsbYyw78VAGAW9Ql2e9jPOabIOWSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGMZLPdwPkw8SIJAy++UkRoC6HPdNB7m/rjN4p9yM6zUetRshfC9Xz8y7H60ATnxt+0tN/iQLUy+qTGZwieMJaQOnRFOw9GytWEumWnIaFjS7v5kQfv63JNoK02Wv1NydxNmfUEk7l2CweKqJrnRTiI6tTOG1qrHclQN/t/62hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sn+1Hzuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sn+1Hzuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D14C19425;
	Wed,  4 Mar 2026 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772616066;
	bh=85MQK4J5RW9x/ySsbYyw78VAGAW9Ql2e9jPOabIOWSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sn+1HzucSKIFh3dqMC7UmT0R5DVJPq27QdjB9/3HwNl0WwUdBYU15sXvLq8lBKxdH
	 2OTLHe2lfYSUcnUvDJP3RS3jVYMysHD6j+yAxDfnOl6jmaUHJ8R8CQZ75fEyULf827
	 h+K5sJp7/3gGgE0rd1nqV9DCgylhfXOaA1/KU7IjllZeh+6ycYypd8B0iTYOG/fuT0
	 W19/RtbSWjWV0QPGdl8qsXmIjS3eCaywx/HEMhOlRegkcnwLdPn+sivfgeFyV9ivYD
	 zVdamj/SN+P6nQ0DltIQTXklAxQ8QK+DIPtVIuzAfwLooedJui3a6rGqfYwzkQ+IDx
	 cgmgsLWSjs7ew==
Date: Wed, 4 Mar 2026 10:21:03 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
Message-ID: <aaf5f1_131S1aVnm@ryzen>
References: <20260303183337.1013474-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303183337.1013474-1-pfalcato@suse.de>

Hello Pedro,

On Tue, Mar 03, 2026 at 06:33:37PM +0000, Pedro Falcato wrote:
> Currently, whenever you boot with a QEMU drive over an AHCI interface,
> you get:
> [    1.632121] ata1.00: applying bridge limits
> 
> This happens due to the kernel not believing the given drive is SATA,
> since word 93 of IDENTIFY (ATA_ID_HW_CONFIG) is non-zero. The result is
> a pretty severe limit in max_hw_sectors_kb, which limits our IO sizes.
> 
> QEMU shares IDENTIFY data between PATA/SATA drives (and the corresponding
> emulation of IDE/AHCI) but does not, in any way, emulate any of these
> real hardware details. There is no PATA drive and no SATA cable.
> 
> As such, add a BRIDGE_OK quirk for QEMU HARDDISK. This results in the
> max_hw_sectors being limited solely by the controller interface's limits.
> Which, for AHCI controllers, takes it from 128KB to 32767KB.
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
> Note: This may be ok for stable, but I'll leave it up to you. There is
> obviously no Fixes: here that doesn't go back 20 years.
>  drivers/ata/libata-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d61846f03edc..70703432063a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4231,6 +4231,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  	/* Devices that do not need bridging limits applied */
>  	{ "MTRON MSP-SATA*",		NULL,	ATA_QUIRK_BRIDGE_OK },
>  	{ "BUFFALO HD-QSU2/R5",		NULL,	ATA_QUIRK_BRIDGE_OK },
> +	{ "QEMU HARDDISK",		NULL,	ATA_QUIRK_BRIDGE_OK },
>  
>  	/* Devices which aren't very happy with higher link speeds */
>  	{ "WD My Book",			NULL,	ATA_QUIRK_1_5_GBPS },
> -- 
> 2.53.0
> 

I think you should just fix QEMU.

Quirks are added for devices where we will never get a firmware update.

QEMU if FLOSS. QEMU has stable releases just like the kernel.

Why should the kernel carry this extra code just because of an issue in
another FLOSS project?


The fix in QEMU should be trivial.
The argument in the commit log does not make sense, as QEMU already
protects certain SATA only features with if (s->ncq_queues):
https://github.com/qemu/qemu/blob/v10.2.1/hw/ide/core.c#L181

PATA does not support NCQ, so you could use that guard also to set the bit
in word 93.


That said, I understand that certain distros will might not ship with the
latest QEMU stable release, so we could carry a quirk even for QEMU just to
be nice to the distros, but not an unconditional quirk (FW version == NULL).

In my QEMU I have:
$ lsblk -o MODEL,REV
MODEL          REV
QEMU HARDDISK 2.5+

Which comes from:
include/qemu/hw-version.h: * Starting on QEMU 2.5, qemu_hw_version() returns "2.5+" by default

The comment in include/qemu/hw-version.h says that the version should not be
increased, but QEMU already overloads this value if dev->version is set:
https://github.com/qemu/qemu/blob/v10.2.1/hw/ide/core.c#L2660-L2664

So I suggest that you also send a patch to sets a default value to
dev->version:
https://github.com/qemu/qemu/blob/v10.2.1/hw/ide/ide-dev.c#L125-L127
to some default value larger than 2.5+, unless an explicit value was
provided by the user.


Kind regards,
Niklas
