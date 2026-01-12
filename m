Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752502DEA97
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230515; cv=none; b=QdEtMCivlkWCuNWiUSE7HheAlg+YEDOOb7CoGvOAWicQxWG/9McYj1MsDMXahYedInujRUeJDt6EIWt5YsC7LkzRb4d2MMcfbkO3+Ey3623OzzaPdm/Bp3bzMKa74N2pogjMrjQT5pVtDMxc07+0CqYO82LBQfukquINjAA4pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230515; c=relaxed/simple;
	bh=J9xe8UqNItEQYOh/ntRPunBkWxL+WEG1ZvE6mqqQHXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCIJTGmlttmC8awwmF909VSG8OVQhtqIvypXu6rb7E1TykMCMfLzcuPxAdqGe+m9Ny6Vm7+WfPNCW50mGogBo/gOcIQpKnKpQ7kS7ibVNYZQ8NWTnRx4iP/0wHsZVtgTQmpSwPlYQmiNVSTVAV+W6TYlIdpTAb47Ww9KDqn7zrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koT5FC2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koT5FC2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32059C19424;
	Mon, 12 Jan 2026 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768230515;
	bh=J9xe8UqNItEQYOh/ntRPunBkWxL+WEG1ZvE6mqqQHXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koT5FC2WfzL1gAGuBwJUy621gwOZRoSprmbun0JB9BWNuwdeSvgUAxJZKozCxEUtT
	 QUXgoVMKq1z/z08e1xFJ8FAXmFkoFFjxCg6ZHy7diWtxoN6FiezOhEMh1BxKTDyL6M
	 L3PO5yTASsoAZda24MUxjWLzDsyomN39eJ2UeD4NwlW7QKxE8ntKHEgFgM+OFH0i/m
	 dafwSmZMSWsePxeFf1Qbg/bSFmsMtB12oW0Nw9UHjbPQ7aIV52d272vd0QLqaGpeoA
	 gKDwcNntEaPffE41EC+2pNArc0V21Ht149+e6v5BIDbgT0w/sdqOFtRNSB84jsb/oG
	 LLfOWZ7q3imJQ==
Date: Mon, 12 Jan 2026 16:08:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, wolf@yoxt.cc
Subject: Re: [PATCH v2 3/6] ata: libata-sata: Improve
 link_power_management_supported sysfs attribute
Message-ID: <aWUOb4Q2NfAVkt86@ryzen>
References: <20260112122044.143637-8-cassel@kernel.org>
 <20260112122044.143637-11-cassel@kernel.org>
 <5b945fcf-059d-409c-9475-630483c14a5e@kernel.org>
 <aWUHvdhs8oIFVgvp@ryzen>
 <698e738b-5ad2-4c03-ad5c-837123872a10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698e738b-5ad2-4c03-ad5c-837123872a10@kernel.org>

On Mon, Jan 12, 2026 at 04:05:18PM +0100, Damien Le Moal wrote:
> On 1/12/26 15:39, Niklas Cassel wrote:
> > I'm not sure if we should set sysfs attribute
> > link_power_management_supported == false if ATA_LFLAG_NO_LPM is set
> > (Currently we don't). Because if so, the sysfs supported attribute could
> > potentially change value during runtime, isn't it supposed to be static?
> > 
> > If we really want to, I guess we could do something like:
> > 
> > diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> > index 04e1e774645e..1134943f49ae 100644
> > --- a/drivers/ata/libata-sata.c
> > +++ b/drivers/ata/libata-sata.c
> > @@ -913,6 +913,8 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
> >  		return false;
> >  
> >  	ata_for_each_link(link, ap, EDGE) {
> > +		if (link->flags & ATA_LFLAG_NO_LPM)
> > +			return false;
> 
> Yeah, I think we need this. NO_LPM == max power, but cannot be changed. That's
> the same as for external ports. So we should report not supported so that
> userspace cannot change it.

ata_scsi_lpm_supported() already checks port flag ATA_FLAG_NO_LPM:

https://github.com/torvalds/linux/blob/v6.19-rc5/drivers/ata/libata-sata.c#L912-L913


Port flag ATA_FLAG_NO_LPM:
call .set_lpm() with ATA_LPM_MAX_POWER.

Link flag ATA_LFLAG_NO_LPM:
we called .set_lpm() on
the port, but the device disappeared from the port when doing so,
so make futher calls to set_lpm() for this link a no-op...
(No idea why it doesn't instead call set_lpm() with ATA_LPM_MAX_POWER?)



Kind regards,
Niklas
