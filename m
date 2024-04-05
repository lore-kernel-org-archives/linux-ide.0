Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF0516190F
	for <linux-ide@vger.kernel.org>; Fri,  5 Apr 2024 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321138; cv=none; b=nnVApyIzZBlnXEmEesSp6us0qTrRC+OUPji0V322Lg+nmOBeO5ktkALZEUyFu59najX0mLPsXrk1yFphjvQO3I3DIDMB9ZB8Eo4gDy4SsseHrKXRjyRiuHVpZdccRfbey87cb5wYKUZLmPuXqg0hXVFBwTmyAHLxyAAy8+Flm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321138; c=relaxed/simple;
	bh=6cX5GwPX21ANRTG6oUfRtapA9/jzxHrvKkrLWzWJslU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXMxACEctmP+AvZwRYm8PqBPZzeucJRv/il0lflJb+KmJvfnS/WwqevjzanO16IDhFZGE5FmIpBwZndVvJQTDG2SdM0IYSD04bFWWeZ/7wrBIZnggm9lbMvEMpgm5nMPDJTQKgFPXY5orYJ79J988bKv7OsFg0rxpE04ViF/uZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+MujAXR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+MujAXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8250BC433F1;
	Fri,  5 Apr 2024 12:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712321138;
	bh=6cX5GwPX21ANRTG6oUfRtapA9/jzxHrvKkrLWzWJslU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+MujAXRpk1k9P7Ei+LDyOWh1/W6RBS0p+LfHrRvZwtYnA6dIUHBziMdpOXsiY3O4
	 lMCrOousIseHwfhj/wAAi71eg36UxUN05wvDgNULtCI2Vp9VxYrddna5ttKyEc1lv2
	 Guok4XpkxoBev2CDTdHZkiKIAkNcLb4sKQ36owvbo/57fPc6H1KnvG+pyFfqAcueFv
	 5gyngD8HeFtiVlJUr69T2Mw22O2O6KPgJXrkFjDR5pcGmouZj5ulD/pxd5jrbl7hha
	 nJ8FwvLEMomTAVXdjo/UXb5LKh+M+p/TdWJ5zlHGf26l39Lr/fFJNN6RrkJmX2k8Ck
	 eWvhUSJf9DNmA==
Date: Fri, 5 Apr 2024 14:45:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Conrad Kostecki <conikost@gentoo.org>,
	Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] ata: ahci: Add mask_port_map module parameter
Message-ID: <Zg_ybd29wkA7w3Za@ryzen>
References: <20240404095026.929491-1-dlemoal@kernel.org>
 <Zg+51NstivN/215M@x1-carbon>
 <9e016f41-8df3-458d-91df-f3795d3a4628@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e016f41-8df3-458d-91df-f3795d3a4628@kernel.org>

On Fri, Apr 05, 2024 at 09:24:09PM +0900, Damien Le Moal wrote:
> On 4/5/24 17:44, Niklas Cassel wrote:
> >> +static char *ahci_mask_port_map;
> >> +module_param_named(mask_port_map, ahci_mask_port_map, charp, 0444);
> >> +MODULE_PARM_DESC(mask_port_map,
> >> +		 "Provide 32-bit port map masks to ignore controllers ports. "
> >> +		 "Valid values are: "
> > 
> > Looking at other MODULE_PARM_DESC, it appears that you can use \n in the string.
> > So perhaps "Valid values are:\n"
> > 
> > 
> >> +		 "<mask> to apply the same mask to all controller devices, "
> >> +		 "<dev0_name>=<mask0>,<dev1_name>=<mask1>,...' to specify a "
> > 
> > Perhaps add a \n after describing the first format.
> 
> Yes, I saw that in many places the description string is split using "\n".
> However, with that, the print of the parameter description with "modinfo ahci"
> is rather weird, with the parameter type (charp) ending up on its own line. I
> did not like it so I did not add any "\n".

Ok.


> 
> >> +static void ahci_apply_port_map_mask(struct device *dev,
> >> +				     struct ahci_host_priv *hpriv, char *mask_s)
> >> +{
> >> +	unsigned int mask;
> >> +
> >> +	if (kstrtouint(mask_s, 0, &mask)) {
> >> +		dev_err(dev, "Invalid port map mask\n");
> >> +		return;
> >> +	}
> >> +
> >> +	if (mask) {
> >> +		dev_warn(dev, "Forcing port map mask 0x%x\n", mask);
> >> +		hpriv->mask_port_map = mask;
> > 
> > I think this should use saved_port_map instead of mask_port_map, see:
> > https://lore.kernel.org/linux-ide/uu2exwldqvbdjus6t4r3cxuto5jpeqtjfvc7qiikulfwiyntf3@j4btf2bt23ld/
> > 
> > ""
> > 1. saved_port_map defines the ports actually available on the host
> > controller.
> > 2. mask_port_map masks out the unused ports if it's initialized,
> > otherwise all available ports will be initialized and utilized.
> > "">
> > (We don't want to initialize them at all.)
> 
> Correct, and they do not. The masked ports are using the dummy ops. So it works
> exactly as intended. This module argument defines a *mask* for a port map, not
> the port map to use.

Ok, as long as there is no real initialization, there should be no extra time
spent during probing at boot, so using mask_port_map should be fine.


> The patch results in this:
> 
> modrpobe ahci mask_port_map=0000:00:17.0=0x1
> dmesg | grep ahci
> ...
> ahci 0000:00:17.0: Forcing port map mask 0x1
> ahci 0000:00:17.0: masking port_map 0xff -> 0x1
> ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
> ahci 0000:00:17.0: (0000:00:17.0) 1/8 ports implemented (port mask 0x1)
> 
> So I could remove the message I added I guess...

Right now, it does seem a bit redundant.
I guess we could change the print to be more like:
"overloading port map via kernel module param",
but I presume that we don't have any prints for other module params,
so I don't see why we should have one here, especially since we already
print that the mask is forced.


> I prefer that this module parameter defines a mask rather than a map as it is
> more general: it can be used for testing to override saved_port_map or masks
> already set for some controllers.
> 
> > A mask of 0 is valid, so I don't think that you can do
> 
> A mask of 0 would mean "no ports". So better off completely ignoring the
> controller for that case :) So no, I do not want that value to be valid.

Yes, and that is how it is defined in some controllers, see e.g.:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=566d1827df2e

So I don't see why we shouldn't allow that.
It would allow us to quickly "emulate" a controller with a port map that
is all zeroes. (Which apparently do exist in the wild.)
So it could be a quick way for us to test that the code correctly handles
such controllers.


Kind regards,
Niklas
