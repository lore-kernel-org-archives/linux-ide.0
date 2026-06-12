Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385061D61B7;
	Fri, 12 Jun 2026 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287419; cv=none; b=BDKbPQX1uegjeheXlQ8aZZ00FJyiJsEHdgD7p1VqbCEbqm8DBd7eIgOOXGWlg95Q9KrrzhUYO5DZbUU3rtp4Vo6uyvjNaRe6H1vu1EqVVIBaeVKEaVSLVWX2HJbzXHy8mLmP1CgZHCngM9khKxhk2yIVLAO5crjCYKZHldbapCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287419; c=relaxed/simple;
	bh=JJ87vytCTJhJXYYB+2tr8wnILQUdD3Qlfv5/1hpr3ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oap9Q8qEgJ9eMnNogRwnJ2fRgC4QGIIlIskmBbBjatQ6F4haCvde7meB2Pq74BBEAYFl8Qzu6VdSmXXOtA1p0HHfn32jM0yvm2IVvgPvchpVF6jhxvfuPuaiK1AYG6SXUyfDnCzHY3MV55j1JXp49WuI8TC9z9gH6xguO8e7Zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw0saJNj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw0saJNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6260C1F000E9;
	Fri, 12 Jun 2026 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781287417;
	bh=eCl8rWp6cEiE+ajrAEQCyJLVFD9vqGI8x3pcL//exes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tw0saJNjQwwd0L/4N0nj9lFUuMrnH8//tbflN1+x4LY2CdPvNbCqBIkFfwnO/InMy
	 ZhYcAm+oPdHTed6YuCmFIjU1QJBF56AZ1C1N/TzLPZqfn0jZ2oGaM4lIT/H5a4NqN7
	 YVl71cdmpfiSxCHOCL4j4Ca1dKXYncwx2apWW+9azwBDQgPMlfkMmh/gSG9C34xHWa
	 skRnLZpWQSoTP1aqqg9ih5G+zvTd+cZH23Zny9ZB4iSGWNebH3NV4hEohvmAijoMIP
	 KRUGU08/CFPBMQ6VWOK1rMg60iiBYlGJMJtQCuG9ez02ov8nKb6lsjm3frPTqb2HQZ
	 Lt2/ZfIQMl9Jg==
Date: Fri, 12 Jun 2026 20:03:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ata: Use named initializers for pci_device_id
 arrays
Message-ID: <aixJ9VAzpOSNKxNm@ryzen>
References: <cover.1781252167.git.ukleinek@kernel.org>
 <616e527a0c6cd367f3301438501d8345b0675df1.1781252168.git.ukleinek@kernel.org>
 <20260612162904.396dbc1f@pumpkin>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612162904.396dbc1f@pumpkin>

Hello David,

On Fri, Jun 12, 2026 at 04:29:04PM +0100, David Laight wrote:
> On Fri, 12 Jun 2026 10:21:48 +0200
> Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com> wrote:
> 
> > While being less compact, using named initializers allows to more easily
> > see which members of the structs are assigned which value without having
> > to lookup the declaration of the struct. And it's also more robust
> > against changes to the struct definition.
> 
> I think I'd try to keep each entry on one line for readability.
> Either by just letting the line be long or using a #define for the initialiser.
> 
> ...
> > diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
> > index 3999305b5356..402d3304b94b 100644
> > --- a/drivers/ata/acard-ahci.c
> > +++ b/drivers/ata/acard-ahci.c
> > @@ -91,9 +91,11 @@ static const struct ata_port_info acard_ahci_port_info[] = {
> >  };
> >  
> >  static const struct pci_device_id acard_ahci_pci_tbl[] = {
> > -	/* ACard */
> > -	{ PCI_VDEVICE(ARTOP, 0x000d), board_acard_ahci }, /* ATP8620 */
> > -
> > +	{
> > +		/* ACard ATP8620 */
> > +		PCI_VDEVICE(ARTOP, 0x000d),
> > +		.driver_data = board_acard_ahci,
> > +	},
> >  	{ }    /* terminate list */
> >  };
> 
> 
> Why not extend PCI_VDEVICE so you can pass it the .driver data
> (and other named initializers), something like:
> 
> #define PCI_VDEVICE(vend, dev, ...) \
> 	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
> 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0 \
> 	__VA_OPT__(, .driver_data = __VA_ARGS__)
> 
> The change to all the files is then just to move the )
> (and the old versions will still compile).
> You can also do:
> 	PCI_VDEVICE(XXX, 0xx, board_xxx, .override_only = 1)
> 
> At which point you can move the {} inside - but that is a breaking change.
> 
> Note that sparse won't grok __VA_OPT__() so will need an alternate definition.

Sounds like a good idea to me, but it also sounds like it would touch
include/linux/pci.h, so probably would need to go via the PCI tree.

But if you manage to get your suggested macro included, I would be happy
to take patches that makes use of it. (Or even carry to carry a patch that
adds the macro if you manage to get an Acked-by from the PCI maintainers.)


Kind regards,
Niklas
