Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4F770E4
	for <linux-ide@vger.kernel.org>; Tue, 21 May 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296079; cv=none; b=DQh6qBI1QD5Cnusr/brWmyU35cXG2hETuXKOjPDHcuawoTkp+fnCzDt7NlXWHVO0VBoJWCrTXv4wqSf5oV1ENpmNc6HeqmI496uEgalgCCGMZrvsDY7e9Yfd3X/RZB7I3eCtuHQehW7KRZOaH7al+0EjIsW8S+OjyvG0YoSFY/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296079; c=relaxed/simple;
	bh=SFKtFuFUcqmuebqDcXN/4IxV1Y68c1RAaWtNxGcD+/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIi1/hq6TqNxw2//x4N6gySTG0r08W2Av4HKCglKFihAqqYCzRztokZl2sNsE+McZ0zsEaE1U+kgbxRMPQzmtJTiHwLJ/OmFCJPhDOd8h6aSZJFDNUYqb2tB4LLYDq2q+fa93We6MM4gP823Wk8384OBGzXsXnUYDt+Y59iGFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It4G1qdy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It4G1qdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8856DC2BD11;
	Tue, 21 May 2024 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716296078;
	bh=SFKtFuFUcqmuebqDcXN/4IxV1Y68c1RAaWtNxGcD+/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=It4G1qdyw/Xb/GRIkND+nugKW+e6sNz8ifQRPnQRH0ALI3g+LT73eH4LGxg22XGl7
	 MzaU+t3PesSAKi5F/aynThHD6nsvONnEqt0HIETiBiV8DFhPHQQwJrnCa0ma3ADLYj
	 0h7Xvk0tpD3UHfJrRf5UEOStvde1I333fiozHYD3d8+r3Bi9zGSb807kjEj2gkiM30
	 ydCslcWIe4DbRCKz50SQ1+eP78gCdUnJF0+6bvLMtyGjVk+AqPrw7ljkfCcp1E/q0M
	 M7pYx3HWXkE43STi3TUnk1SuOKz4iTobg6VEll3mgUWKu499xzo3mx6kWeniQsjjm2
	 JrVd+O2KCNnIw==
Date: Tue, 21 May 2024 14:54:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: dev@kayoway.com
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 0/1] ata: ahci: Revert "ata: ahci: Add Intel Alder
 Lake-P AHCI controller to  low power chipsets list"
Message-ID: <ZkyZiodz16XQO32_@ryzen.lan>
References: <20240513135302.1869084-1-dev@kayoway.com>
 <20240517053902.44622-1-dev@kayoway.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517053902.44622-1-dev@kayoway.com>

On Fri, May 17, 2024 at 02:39:01PM +0900, dev@kayoway.com wrote:
> From: Jason Nader <dev@kayoway.com>
> 
> Changes - updated commit message as per the kind guidance from Niklas.
> 
> I was not sure whether to cc stable, but if so it would allow affected
> users to start to be able to use kernel versions > 6.6.10.
> 
> Below are logs including the extra logging asked for by Niklas.
> 
> Kernel logs with this patch:
> >journalctl --boot 0 | rg 'Linux version|SATA|external port'
> Linux version linux6.9.disableAlderLakequirk@archlinux
> ata4294967295: external port, not enabling LPM
> ata4294967295: external port, not enabling LPM
> ata4294967295: external port, not enabling LPM
> ata4294967295: external port, not enabling LPM

Since the prints below are for ata5-ata8, that most likely means that the
"external port, not enabling LPM" prints above are for port ata1-ata4,
so they are not really relevant and might even belong to a different SATA
controller.

Anyway, lpm-policy for ata5-ata8 is the same before and after this patch,
so everything looks fine.


Kind regards,
Niklas

> ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
> ata5: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802300 irq 125 lpm-pol 3
> ata6: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802380 irq 125 lpm-pol 3
> ata7: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802400 irq 125 lpm-pol 3
> ata8: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802480 irq 125 lpm-pol 3
> ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata8: SATA link down (SStatus 0 SControl 300)
> ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 
> Kernel logs without this patch: 
> >journalctl --boot 0 | rg 'Linux version|SATA|external port'
> Linux version linux6.9.enableAlderLakequirk@archlinux
> ata4294967295: external port, not enabling LPM
> ata4294967295: external port, not enabling LPM
> ata4294967295: external port, not enabling LPM
> ata4294967295: external port, not enabling LPM
> ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
> ata5: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802300 irq 125 lpm-pol 3
> ata6: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802380 irq 125 lpm-pol 3
> ata7: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802400 irq 125 lpm-pol 3
> ata8: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802480 irq 125 lpm-pol 3
> ata8: SATA link down (SStatus 4 SControl 300)
> ata5: SATA link down (SStatus 4 SControl 300)
> ata6: SATA link down (SStatus 4 SControl 300)
> ata7: SATA link down (SStatus 4 SControl 300)
