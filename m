Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6113D334C39
	for <linux-ide@vger.kernel.org>; Fri,  4 Sep 2026 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527819; cv=none; b=moQVgKn8wrFrqUR7RbZPIbw7RjDO9PRzUvvKSHaduNRU1i4sAdUw8QFanXDoCNRmiTU2uPLI5FqTZTHZhdPwwsGtp9l82zC2ArNiN4MJoMjhn2Q1zzQkGRlwS/nA3uToYdnyOSkjiKK5tRKzUB/r/7o18W4Kwj8LP7qzge3BwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527819; c=relaxed/simple;
	bh=jd3OyC+/0iL+f9tfAP0n1mkDflhWf9ID8/C22G5rPV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLHD/OPbm1+JOZaJy75ZPJIophv15seO/hhPouMMvPU5fafEptPnO6HbLdqEhp/0kUdhZZOMUVms7REL6GgHhPXNfJ5wHxEDF1tDY8Jn/oLcoLt+EOB4ziPfiqg1kX/50/1eyaAMeyUHEoRExpnGMrgqs2w1oQhucbb0ObUk6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI071x1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI071x1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB2D1F00A3D;
	Fri,  4 Sep 2026 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527818;
	bh=hhL8eJlC817+JdgyGdBl0m3S6J9yzgWjzAlrO1I3WwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TI071x1No+DD/GV1USpFEZVpVrZIb+4FjwWNeDmds14PSH4/H/0njhhVP1BIeIzqs
	 XpcfHSmW8stoZ6lcIhrCy/0q4+nJ9MFpO6WkVODPQCz73PtwT8aYo61PmnWFeQTnyG
	 64/uCSprwjxOkyZR5lDmA5NnwZ4FJyCBbXdUudztIepwYdSFy3wfiw78Oo/KFyZInf
	 XkpD5/iC5YrsuxUGIXKKouHX9gO5Et1uZHn24yWtfhLwvOEtM/3xkQcypsB69lQM/J
	 pBlnvo6+YjXCrG3Vb581fsVBxxlPTZ3EF0F1aMJPmmlLuhPzTQsEW559JRGSOKrulB
	 62bVqNC6mduoA==
Date: Fri, 4 Sep 2026 15:16:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Roland Waltersson <roland.waltersson@netinsight.net>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libahci: clear PxCLBU and PxFBU for
 AHCI_HFLAG_32BIT_ONLY
Message-ID: <aprExq5TdRMnMQki@ryzen>
References: <20260903200349.1316460-2-cassel@kernel.org>
 <1a39c034-ecee-42cb-beea-c15f32c831c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a39c034-ecee-42cb-beea-c15f32c831c0@kernel.org>

On Fri, Sep 04, 2026 at 08:54:37AM +0900, Damien Le Moal wrote:
> On 9/4/26 05:03, Niklas Cassel wrote:
> > A user reported that commit 105c42566a55 ("ata: ahci: force 32-bit DMA for
> > JMicron JMB582/JMB585") made the JMicron JMB585 unusable on his board.
> > 
> > The failure is seen as soon as the ahci driver is probed, and booting with
> > iommu=off does not solve the problem.
> > 
> > Looking at the AHCI specification, PxCLBU and PxFBU are both read only '0'
> > for HBAs that do not support 64-bit addressing.
> > 
> > For HBAs that support 64-bit addressing, the registers are read write,
> > with a reset value that is Implementation Specific.
> > 
> > When using the AHCI_HFLAG_32BIT_ONLY flag, the HBA does support 64-bit
> > addressing, but we are simply setting a 32-bit DMA mask. Thus, in this
> > case, we need to explicitly clear the registers to 0.
> > 
> > Fixes: c7a42156d99b ("ahci: disable 64bit dma on sb600")
> > Reported-by: Roland Waltersson <roland.waltersson@netinsight.net>
> > Closes: https://lore.kernel.org/linux-ide/IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com/
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/ata/libahci.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index 6d72eb017b49..3a40ea926588 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -748,11 +748,25 @@ void ahci_start_fis_rx(struct ata_port *ap)
> >  	if (hpriv->cap & HOST_CAP_64)
> >  		writel((pp->cmd_slot_dma >> 16) >> 16,
> >  		       port_mmio + PORT_LST_ADDR_HI);
> > +	/*
> > +	 * On HBAs that do not support 64-bit addressing PxCLBU is read only,
> > +	 * however, when forcing a HBA that has CAP.S64A in 32-bit only mode,
> > +	 * the register is RW, and the reset value is Implementation Specific.
> > +	 */
> > +	else if (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)
> > +		writel(0, port_mmio + PORT_LST_ADDR_HI);
> 
> I find the comment very confusing as it is not directly describing what is being
> done here. Furthermore, it says "when forcing a HBA that has CAP.S64A in 32-bit
> only mode", but the added code is an "else" of "if (hpriv->cap & HOST_CAP_64))",
> so that is for the case where the adapter is not 64-bits DMA capable. I am not
> understanding something here...

I think this will clarify things:
https://github.com/torvalds/linux/blob/v7.3-rc1/drivers/ata/libahci.c#L481-L485

libahci clears CAP.S64A from hpriv->cap for broken controllers.

If you do a:

$ git grep -C 4 HOST_CAP_64 drivers/ata

you will see that there are a bunch of drivers that use libahci.c, that relies
on "hpriv->cap & HOST_CAP_64" when setting the DMA mask.

So, while my initial idea was to just change so that the quirk does NOT clear
CAP.S64A from hpriv->cap, that would also mean that we would need to grow an

if (hpriv->flags & AHCI_HFLAG_32BIT_ONLY) in all these drivers that set the
dma mask:
drivers/ata/acard-ahci.c
drivers/ata/ahci.c
drivers/ata/libahci_platform.c
drivers/ata/sata_highbank.c

So I opted for letting the quirk continue doing what it is doing, make all
libahci.c based drivers set the DMA mask to 64 or 32, only based on
hpriv->cap & HOST_CAP_64.

> 
> Could you clarify please ? Also, please move the code comment above the "if" so
> that it describes both the "if" and "else". Having the comment in the middle of
> this if/else makes things hard to read.

Sure, will send a v2.


Kind regards,
Niklas
