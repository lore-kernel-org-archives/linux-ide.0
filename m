Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0B1474A4
	for <linux-ide@vger.kernel.org>; Tue, 24 Sep 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164763; cv=none; b=iS1MazZTk6M3Mm8hgIprnMumuuiDW6y+zN/8p5y/XqCHL/Xi2jH+5pYbm7RAqEChRju9xdlscS0oLpnR4xFMCiaIooDMvG5RIfqL7zniEJK4a6KHfEquh+Rivcux1iGBWNWvFpsV77diJrXrYYfm2PLtjCiEJWsSFfIzkJAGamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164763; c=relaxed/simple;
	bh=mOF/2XwTdiSOVSWYGik6H7mDYmoJKeoEg8G6w8OCn6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co/Q+VEOFt6WyN8EJVYHgCIWoVnvlBSFqW7LR709mzP3MI66qf9J+IdTAh2FIurDeqqgObCHlptJsS3p8saUe3FV/4xd2XaXao2EPOAJv+IHQUu6Ax4EmsDhMzF9pvOrOX8TcTTVbcO/GHmusX3Z4WUrRp08e5RXqUf3NSFI9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXcjD47Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXcjD47Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8213AC4CEC4;
	Tue, 24 Sep 2024 07:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727164762;
	bh=mOF/2XwTdiSOVSWYGik6H7mDYmoJKeoEg8G6w8OCn6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXcjD47QyZgE+ialCvgjZW5foCEJ0CIEalrNiTXbjYTY/Mwowe4PpDXVd+3jXCMni
	 UMfWUOwE+3SKYAQxgICzm5uPZAvOgeqJgMwFf8ztbIrBr+RbXSI9lCrksAfQaqaT9x
	 Qpjfj+yTouB6QT3OO8lZraNgN1XA7mCpe9EkRk+nYxt4iP714kQAaI9bpHo1aWu/YN
	 nGYdyqXET7ZpRjNJTwAS/s04UQ2d9itAZjp1Lp24W+IvMWjPF/V1c6PCvy7Rgl32dw
	 nBEDwb4Q771s58KyZZCkLiC8HowK5mh2kWj6M35xtJiHqWt3Ak2cxqbXpK0NZhjkUE
	 DIwYss8/rsgEA==
Date: Tue, 24 Sep 2024 09:59:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/2] ata: libata-scsi: Fix ata_msense_control_spgt2()
Message-ID: <ZvJxUvd8GdatqVnR@x1-carbon>
References: <20240923133949.286295-1-dlemoal@kernel.org>
 <20240923133949.286295-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923133949.286295-2-dlemoal@kernel.org>

On Mon, Sep 23, 2024 at 10:39:48PM +0900, Damien Le Moal wrote:
> ata_msense_control_spgt2() can be called even for devices that do not
> support CDL when the user requests the ALL_SUB_MPAGES mode sense page,
> but for such device, this will cause a NULL pointer dereference as
> dev->cdl is NULL. Similarly, we should not return any data if
> ata_msense_control_spgt2() is called when the user requested the
> CDL_T2A_SUB_MPAGE or CDL_T2B_SUB_MPAGE pages for a device that does not
> support CDL.
> 
> Avoid this potential NULL pointer dereference by checking if the device
> support CDL on entry to ata_msense_control_spgt2() and return 0 if it
> does not support CDL.
> 
> Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> Tested-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> Fixes: 602bcf212637 ("ata: libata: Improve CDL resource management")

Looks good, but the commit above also changes
ata_eh_get_ncq_success_sense(), and also adds calls to free the resources
in ata_dev_free_resources(), which is called by different EH paths,
so perhaps we also need a:

if (!dev->cdl) 

guard in ata_eh_get_ncq_success_sense() ?

EH is a bit complex, but it would make sense if EH already ensures that
ata_eh_get_ncq_success_sense() can't be called after ata_dev_free_resources()
has been called. In that case, we shouldn't need to add an additional guard.


Kind regards,
Niklas
