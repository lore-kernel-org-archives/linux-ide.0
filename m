Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7412B383A1;
	Mon, 19 Feb 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356545; cv=none; b=ZH5MSeFo15gHrowrUZ/8FdHiKfJvSdy3C9QQJ3aI+0CAueq4StjXjHTVE7yO02S83BmbMKmR/znr66vHu2k+fyEEJHaEPcaqXAvA2p/+NBo5tUODXKdX8uOAawufU56ynN+bxqB7Zp3vFIHyPkx6I8KqSbAplRToG9CqStJFFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356545; c=relaxed/simple;
	bh=UmQt6AhNUj3p0y4kNfgsnMins5mxo/egCuxtwYpabKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEmaWiblMxjHqDPVa5wHg+TUf1tvA73JxpD5RHISccFkU9fW5QWSlxvizBns9JAYRiTvxuRvzUqO5dHAxr5zEJwWzNXim8I9KeDqnscaKFVM1TyOMbL4oNXmVuxlaagPtT8Y820PjyQlXNct0ePZ3nqQUltFIbJ+i5Rr6e7a/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R91dznXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R91dznXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F55C433F1;
	Mon, 19 Feb 2024 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708356545;
	bh=UmQt6AhNUj3p0y4kNfgsnMins5mxo/egCuxtwYpabKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R91dznXjVmg0dPVU+qeSDpxmZvpNkaeOM+o/tZPEYO7gyb3Sl4Mw3g3S/0Ts5Gq6o
	 Q6rIlDnR0dpRv6uRvhGL9D6oFApEZsDyi3Do9EpwJQ0iq8wbG4DnvU8aEaWOTt1yTi
	 K+/kM1W3C53rKq2mmS6bCb5v8t7y7JTdT1vDLYWAsTGCfexezFnElTLxnTid2+rGLP
	 U81pRbwxVd1ZU5+XZWzimvhHemg6fyBxvtHvw9AMWKgdS4C+b7BtwoV/KqJy7U6zcn
	 NM4WWLE1HHEaCLdqQrVwRbXgOqqpQ4uFLvUCtKrYMSJVE7oI+l/bdIEveYD2l306sl
	 k7UGpwCUoj42g==
Date: Mon, 19 Feb 2024 16:29:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Wang Zhihao <wangzhihao9@hotmail.com>,
	linux-regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH 2/2] ata: libata-core: Revert "ata: libata-core: Fix
 ata_pci_shutdown_one()"
Message-ID: <ZdNzvAdKKsQapx8a@x1-carbon>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <20240111115123.1258422-3-dlemoal@kernel.org>
 <d63a7b93-d1a3-726e-355c-b4a4608626f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63a7b93-d1a3-726e-355c-b4a4608626f4@gmail.com>

Hello Sergei,

On Thu, Jan 11, 2024 at 09:10:43PM +0300, Sergei Shtylyov wrote:
> On 1/11/24 2:51 PM, Damien Le Moal wrote:
> 
> > This reverts commit fd3a6837d8e18cb7be80dcca1283276290336a7a.
> > 
> > Several users have signaled issues with commit fd3a6837d8e1 ("ata:
> > libata-core: Fix ata_pci_shutdown_one()") which causes failure of the
> > system SoC to go to a low power state. The reason for this problem
> > is not well understood but given that this patch is harmless with the
> > improvements to ata_dev_power_set_standby(), restore it to allow system
> > lower power state transitions.
> > 
> > For regular system shutdown, ata_dev_power_set_standby() will be
> > executed twice: once the scsi device is removed and another when
> > ata_pci_shutdown_one() executes and EH completes unloading the devices.
> > Make the second call to ata_dev_power_set_standby() do nothing by using
> > ata_dev_power_is_active() and return if the device is already in
> > standby.
> > 
> > Fixes: fd3a6837d8e1 ("ata: libata-core: Fix ata_pci_shutdown_one()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> > ---
> >  drivers/ata/libata-core.c | 75 +++++++++++++++++++++++----------------
> >  1 file changed, 45 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index d9f80f4f70f5..20a366942626 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -2001,6 +2001,33 @@ bool ata_dev_power_init_tf(struct ata_device *dev, struct ata_taskfile *tf,
> >  	return true;
> >  }
> >  
> > +static bool ata_dev_power_is_active(struct ata_device *dev)
> > +{
> > +	struct ata_taskfile tf;
> > +	unsigned int err_mask;
> > +
> > +	ata_tf_init(dev, &tf);
> > +	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
> 
>    Why set ATA_TFLAG_ISADDR, BTW? This command doesn't use any taskfile
> regs but the device/head reg. Material for a fix, I guess... :-)
> 
> > +	tf.protocol = ATA_PROT_NODATA;
> > +	tf.command = ATA_CMD_CHK_POWER;
> > +
> [...]

Looking at the definition of the flag:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/libata.h?h=v6.8-rc5#n76

"enable r/w to nsect/lba regs"

This function does read from the nsect reg:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-core.c?h=v6.8-rc5#n2069

So I would prefer to keep it as it.


Basically the whole motto for libata right now:
"If it ain't broke, don't fix it."


Sure, if we look at:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-sff.c?h=v6.8-rc5#n343

it seems that flags ATA_TFLAG_ISADDR, ATA_TFLAG_LBA48, and ATA_TFLAG_DEVICE
is used to "guard" if these regs should be written to the TF.


However, if we look at:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-sff.c?h=v6.8-rc5#n392

is seems that only flag ATA_TFLAG_LBA48 is used to "guard" if the regs should
be read from the TF.

So it looks like the intention was that these flags should be used
to guard if certain TF regs should be written or read, but in reality,
only some of the flags are actually for guarding reads.
(While all of the flags are used for guarding writes.)


Personally, I don't really see the point of using flags to guard writes
to the host controller. Why would we want to skip writing certain TF regs?
The struct ata_taskfile should be zero-initialized before filling it with
a command, so why not always write all TF regs and remove these flags?

Anyway, why touch it now and risk introducing regressions on some old PATA
hardware?


Kind regards,
Niklas
