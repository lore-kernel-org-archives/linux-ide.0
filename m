Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67013B586
	for <linux-ide@vger.kernel.org>; Tue, 24 Sep 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165018; cv=none; b=QatK52zCu8ZnVsYjKw2EmaRP6a+13FG3KIvXZVmVWxp+AQ8hvIFqb+Wc4kxQizBfAFKEkF8bAF7q+FXI+rObyjjMwQtpeefzoqqtY+Hpv08y79poGOANwIVFofDm0+/hTln4MSVrU3OEI6bVug7p993H8/vNQ/5+J0GrSNYGW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165018; c=relaxed/simple;
	bh=zTf8KDGyjUN5I3EOW5ya/yBJ3AerJ3HGHk1+nzfQF8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khKAuYfiFhNifb3pxH9ejLNKREXZG7M1214/THv7u4VicOmIdNwAxLub+MyK6i5XMT9Au8GeYLsT1fxmYCRFD4KurQMcnJPl2kV0lf69iL6XbH+R0dim3zFebdIwvAmgxd7qiWDcZyj22zBJ/WljFP4aXXr/fOHSJPkaaSJlZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Psa3f2cG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Psa3f2cG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A28C4CEC4;
	Tue, 24 Sep 2024 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727165018;
	bh=zTf8KDGyjUN5I3EOW5ya/yBJ3AerJ3HGHk1+nzfQF8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Psa3f2cGljZrvVfzF6LrYJbh28fZ79fIbeyTncUmawHfjraklKSAjXNGEeg1pXtJQ
	 3kVoIeFndogCuueFtd+qKY9HS5V+DRT5okLQ35PULJkW3rQHX3RY3FKdj19iTjYau2
	 3mcORJWEpQJaHWbPNRi7ij83QqwobPUQNc4NAbTc4Hn/YVVRSo0tPoaj/BhAulWlHs
	 em3i47wXGjLYg59jw1uaJZjeorZH98YPDJQJNDoRZyPGcNroKwhcH07Bg2zlg/k0nl
	 d96V4zVLRRYPRBP2gYhbGKWvQXvNu/hMuRtmHVILUgLxToaSoH6Lb1Znl9pPGHMiLY
	 JFiZURxl01YCQ==
Date: Tue, 24 Sep 2024 10:03:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 0/2] CDL related fixes
Message-ID: <ZvJyUXE4oUPToyl6@x1-carbon>
References: <20240923133949.286295-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923133949.286295-1-dlemoal@kernel.org>

On Mon, Sep 23, 2024 at 10:39:47PM +0900, Damien Le Moal wrote:
> A couple of fixes for CDL support. The first patch addresses a potential
> NULL pointer dereference in ata_msense_control_spgt2() with drives not
> supporting CDL. The second patch fixes ata_msense_control() to report
> the correct T2A and T2B sub pages when CDL is supported.
> 
> Damien Le Moal (2):
>   ata: libata-scsi: Fix ata_msense_control_spgt2()
>   ata: libata-scsi: Fix ata_msense_control() CDL page reporting
> 
>  drivers/ata/libata-scsi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> -- 
> 2.46.0
> 

For the series:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
