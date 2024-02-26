Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE656745;
	Mon, 26 Feb 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939715; cv=none; b=MTDrBp1d2efxYcNxlTj7YiasCA18/cBS0l5ike7kdxybOTP/a0ZGTSxM6FXu/WMXT0VhWdsxgCpJXjsRWSZBmNnaKW1OSaDE//BfC/VnqUKmUb65SJyGJ0jJKUoVry0+9Cik8I/+nN+7H/kd0FRH/eWTVV/ZPdc7+Pf7G0ax9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939715; c=relaxed/simple;
	bh=vrYLpVGsOGxJxBgY73QB8VPmJHe/LolDJHL4MoBY7Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6LSpaV6ffsGd8C6icBvzQnTW9CeS/HNHC2dAxGR378C2H46Xr8sOqLlqWp7jqmnbCjIx3codpt4nulzTiJuBL3eU8J5sdbbUI0TLvZ7AHMOdBfNalxJf7/cU62neN40hhAzo3ONZQAhd5sXSmV5ru+Kh3CLvGcOjEd45JoxLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmRbwWT4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmRbwWT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF65C433F1;
	Mon, 26 Feb 2024 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708939714;
	bh=vrYLpVGsOGxJxBgY73QB8VPmJHe/LolDJHL4MoBY7Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmRbwWT4DHxjtr/CqD7idD68znmVjFlhn8I9hSGYUb3blSGK8SXbTFOf0hIq+qkn4
	 NrYyXmiya3TNAtjvRgIT6ptCHtCKqwUTTOfFuLgq81m2gjhnOFW/oi1VZ6glgnCXd/
	 qeAMxvj4iQFcueIWWVrZruDwZBhQRQ+OxqYusauu8ypQgUJmumL6KStLHKLVdCepT9
	 LzlgI7TI0yAW06TxwEKHaQQzvcnYsr2L8pU2Zx12F/rqtp/ROyQsUTMETqUssK787d
	 1CpmlF/t3d3H2EROyKW7kaqf5zE9KZrdPLA0yZMHHED9tltdoRob5ZDEsh4EGDRjXF
	 G6bXKuvJK0X1Q==
Date: Mon, 26 Feb 2024 10:28:29 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Wang Zhihao <wangzhihao9@hotmail.com>,
	linux-regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH 2/2] ata: libata-core: Revert "ata: libata-core: Fix
 ata_pci_shutdown_one()"
Message-ID: <ZdxZvQtiN1up_mnn@fedora>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <20240111115123.1258422-3-dlemoal@kernel.org>
 <d63a7b93-d1a3-726e-355c-b4a4608626f4@gmail.com>
 <ZdNzvAdKKsQapx8a@x1-carbon>
 <d5b331ba-dc2a-f212-e2b2-f5485cff5801@omp.ru>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b331ba-dc2a-f212-e2b2-f5485cff5801@omp.ru>

Hello Sergey,

On Sat, Feb 24, 2024 at 12:04:46AM +0300, Sergey Shtylyov wrote:
> On 2/19/24 6:29 PM, Niklas Cassel wrote:
> [...]
> 
> >>> This reverts commit fd3a6837d8e18cb7be80dcca1283276290336a7a.
> >>>
> >>> Several users have signaled issues with commit fd3a6837d8e1 ("ata:
> >>> libata-core: Fix ata_pci_shutdown_one()") which causes failure of the
> >>> system SoC to go to a low power state. The reason for this problem
> >>> is not well understood but given that this patch is harmless with the
> >>> improvements to ata_dev_power_set_standby(), restore it to allow system
> >>> lower power state transitions.
> >>>
> >>> For regular system shutdown, ata_dev_power_set_standby() will be
> >>> executed twice: once the scsi device is removed and another when
> >>> ata_pci_shutdown_one() executes and EH completes unloading the devices.
> >>> Make the second call to ata_dev_power_set_standby() do nothing by using
> >>> ata_dev_power_is_active() and return if the device is already in
> >>> standby.
> >>>
> >>> Fixes: fd3a6837d8e1 ("ata: libata-core: Fix ata_pci_shutdown_one()")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> >>> ---
> >>>  drivers/ata/libata-core.c | 75 +++++++++++++++++++++++----------------
> >>>  1 file changed, 45 insertions(+), 30 deletions(-)
> >>>
> >>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> >>> index d9f80f4f70f5..20a366942626 100644
> >>> --- a/drivers/ata/libata-core.c
> >>> +++ b/drivers/ata/libata-core.c
> >>> @@ -2001,6 +2001,33 @@ bool ata_dev_power_init_tf(struct ata_device *dev, struct ata_taskfile *tf,
> >>>  	return true;
> >>>  }
> >>>  
> >>> +static bool ata_dev_power_is_active(struct ata_device *dev)
> >>> +{
> >>> +	struct ata_taskfile tf;
> >>> +	unsigned int err_mask;
> >>> +
> >>> +	ata_tf_init(dev, &tf);
> >>> +	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
> >>
> >>    Why set ATA_TFLAG_ISADDR, BTW? This command doesn't use any taskfile
> >> regs but the device/head reg. Material for a fix, I guess... :-)
> >>
> >>> +	tf.protocol = ATA_PROT_NODATA;
> >>> +	tf.command = ATA_CMD_CHK_POWER;
> >>> +
> >> [...]
> > 
> > Looking at the definition of the flag:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/libata.h?h=v6.8-rc5#n76
> > 
> > "enable r/w to nsect/lba regs"
> 
>    I'm afraid this comment doesn't reflect the reality in its r/w part --
> if you look at e.g. ata_sff_tf_read(), you'll see that it always reads 
> all the legacy taskfile and only checks ATA_TFLAG_LBA48 in order to
> determine whether it should read the HOBs as well...

Considering that you have experience with cleaning up a similar mess in
drivers/ide, patches for drivers/ata which fixes the comment and the
functions needlessly setting the ATA_TFLAG_DEVICE flag is more than
welcome.

From a quick look, there appears to be quite a few functions (in
addition to ata_dev_power_is_active()) which needlessly sets this flag.


Kind regards,
Niklas
