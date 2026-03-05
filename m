Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4173358B9;
	Thu,  5 Mar 2026 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697283; cv=none; b=Ft0icH2akF/yT10wouUtSHlB2g1QpR471t9yKCn92jcIWbpnGD04s/sfV+ZEMmfRFDhng+3VlLe2h4ZQ7qxPZ+4g+LmxskTQWD8m7Wl/36u7u+eaoYuD1hc1NxxrIMd8abjpQqN+9kGyRp/KMCoZzx/kqpun6FslFs4Md1erjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697283; c=relaxed/simple;
	bh=mKzfdrF2KFd5LnqYazN15TiiL6CnhMc6j8LVnhI2t7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji4HXhYCbC5fgTtUORuGbiRP0NdhkUrRClNXbEickxKHlF14FKE8dIU4HohwW/eXM1IBqWpTRIXiRjBON6V8O8ptv3QEykH/45R2wzCv+1FMOs5Aq+0MVGpJUkxlszh/gEd9qHsI2sOiQSv+1ldbR8mCn/+RJYFbwBHykrsAPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krawvplX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krawvplX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6571DC2BCAF;
	Thu,  5 Mar 2026 07:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772697283;
	bh=mKzfdrF2KFd5LnqYazN15TiiL6CnhMc6j8LVnhI2t7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=krawvplXiYws+OYkdGtzrrSW0AjK16IlTB+Jw3VaIW2zn8K3CBH1MXWjP0KC/lGoL
	 orlpRPEFJrE3wq5bpesEjke2PvSiKKXxdkjJX3Gv2W4p7ua0GhWQfgUsciXxye+3jb
	 bceqwxR2T9Tr3L/hscPk4KDRJvObHZgPMNmoyFzU+5p4W5gnhTy5vG7ngEcb4ZaPKb
	 zjhpguBLgJMgiMTFQhOKbjI5FikxoKl1VtPqA9N2eUSTZDKkMO+RFXtkHb0xKQIlgm
	 InFQZZ4pPKjJ1lwqhs4OktXsT28PtfVWcnk1tb2pX60hHl74+9I0Cl7+1kL9RLSQVa
	 I6vI5izTeETzg==
Date: Thu, 5 Mar 2026 08:54:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
Message-ID: <aak2vxjO2aAtnuwD@ryzen>
References: <20260303183337.1013474-1-pfalcato@suse.de>
 <aaf5f1_131S1aVnm@ryzen>
 <azwfeaf5hdn5g2vutuhzkjl42ld52vyjs4go2coer3yuagiep2@r5hejnknuwj2>
 <aaggw9ezzeY2_aEO@ryzen>
 <bkkhps3grvckjjvw6ncgygb3qxqrftlwnmixmv3ibe726kc35o@uih2pher4s6e>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bkkhps3grvckjjvw6ncgygb3qxqrftlwnmixmv3ibe726kc35o@uih2pher4s6e>

On Wed, Mar 04, 2026 at 07:34:29PM +0000, Pedro Falcato wrote:
> On Wed, Mar 04, 2026 at 01:08:35PM +0100, Niklas Cassel wrote:
> > Hello Pedro,
> > 
> > On Wed, Mar 04, 2026 at 11:23:01AM +0000, Pedro Falcato wrote:
> > 
> > (snip)
> > 
> > > So, does this look better?
> > > 
> > > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > > index d61846f03edc..c57e35ccc092 100644
> > > --- a/drivers/ata/libata-core.c
> > > +++ b/drivers/ata/libata-core.c
> > > @@ -4231,6 +4231,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
> > >         /* Devices that do not need bridging limits applied */
> > >         { "MTRON MSP-SATA*",            NULL,   ATA_QUIRK_BRIDGE_OK },
> > >         { "BUFFALO HD-QSU2/R5",         NULL,   ATA_QUIRK_BRIDGE_OK },
> > > +       { "QEMU HARDDISK",              "2.5+", ATA_QUIRK_BRIDGE_OK },
> > 
> > Yes, I would prefer that.
> > 
> > When booting a device that has quirks applied, we will get prints in dmesg
> > showing which quirks were applied.
> 
> Yeah, makes sense. Can you use this diff and add Cc: stable when applying,
> or do you want me to send a v2?

Please send a V2 without the text:
"QEMU shares IDENTIFY data between PATA/SATA drives"

I don't think this is 100% true, as we can see that the QEMU AHCI emulation
e.g. sets s->ncq_queues in ahci.c:
https://github.com/qemu/qemu/blob/v10.2.1/hw/ide/ahci.c#L632

So the identify data is already different for PATA/SATA drives IMO.


Kind regards,
Niklas
