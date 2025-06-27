Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108A299957
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021674; cv=none; b=K22svu3dD+zpBF/HEre6BRenScJTVDV+w3keiDS0GoMLDG8jf9d3jMsLTmk30+iK/hnAEAvOBCDeo29LjvnCMyHr3O7tDgx55gexyFk/iXvmoaqXx9eARE1qPCDvN8yfU8QWdZG/sZ4VmSVFoLGzJ/CaXWDF1MyEoevBsunJw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021674; c=relaxed/simple;
	bh=eKkm7ciz0ulL6DoMSJizDpxShfDIpd6NofVwd9LN7Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+8YOy9dk0W5krV+pt9VUIhLjuQJP4f7Nc/W/GHTUZ/eaCkSUGlrAzKZt5U4qEjhRbzKC2cZPxtHHHgnERvN0CPcsNbp3Uy6GyRR78rcJ3EFPhYnIjNS8rBZRzqXC4sLH6GFVRv4LrFk6YuA1Prv/gZVGuZtSw0KLCkQS0kVxuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAbvvfXr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAbvvfXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED11C4CEE3;
	Fri, 27 Jun 2025 10:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751021673;
	bh=eKkm7ciz0ulL6DoMSJizDpxShfDIpd6NofVwd9LN7Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAbvvfXrZIBS0g6jyqq1ThpErsYh/8nKu+EX7pePQXIfT+0RZOqtaAg/mDoUYY3pi
	 fy7ppwBQd8JiyNSQE3J9gG09jsVxRcXI/6JGFXmNHXpSN8tF90d03tms7BGl5hbX4Z
	 /IhWxyf93j4G5TLuSEdqE4IMuvovDO8Swg2XsdrCOGtQpdEhC3sAxcpih4SpMjJqKa
	 KF6sKj3yOsLwApCEvk+9N0iRWpcsMYrIxNnDkWkZrdRhOV+GSC0wg+KbXjxIHEW66a
	 SNnIchGUbjnSGHjZuI6eu1vdFb4TfZUJg2Mip4fJgTsu6et5sGeQWDSVkkyLg+I/Ac
	 ff5pZOrLuXheg==
Date: Fri, 27 Jun 2025 12:54:30 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 3/6] ata: Fix SATA_MOBILE_LPM_POLICY description in
 Kconfig
Message-ID: <aF54ZpjsKP6Efezi@ryzen>
References: <20250627075207.23969-1-dlemoal@kernel.org>
 <20250627075207.23969-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627075207.23969-4-dlemoal@kernel.org>

On Fri, Jun 27, 2025 at 04:52:04PM +0900, Damien Le Moal wrote:
> Improve the description of the possible default SATA link power
> management policies and add the missing description for policy 5.
> No functional changes.
> 
> Fixes: a5ec5a7bfd1f ("ata: ahci: Support state with min power but Partial low power state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/Kconfig | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index e00536b49552..1d53d7b568bd 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -117,23 +117,39 @@ config SATA_AHCI
>  
>  config SATA_MOBILE_LPM_POLICY
>  	int "Default SATA Link Power Management policy"
> -	range 0 4
> +	range 0 5
>  	default 3
>  	depends on SATA_AHCI
>  	help
>  	  Select the Default SATA Link Power Management (LPM) policy to use
>  	  for chipsets / "South Bridges" supporting low-power modes. Such
>  	  chipsets are ubiquitous across laptops, desktops and servers.
> -
> -	  The value set has the following meanings:
> +	  Each policy combines power saving states and features:
> +	   - Partial: The Phy logic is powered but is in a reduced power
> +                      state. The exit latency from this state is no longer than
> +                      10us).
> +	   - Slumber: The Phy logic is powered but is in an even lower power
> +                      state. The exit latency from this state is potentially
> +		      longer, but no longer than 10ms.
> +	   - DevSleep: The Phy logic may be powered down. The exit latency from
> +	               this state is no longer than 20 ms, unless otherwise
> +		       specified by DETO in the device Identify Device Data log.
> +	   - HIPM: Host Initiated Power Management (host automatic transisitons

s/transisitons/transitions/

Perhaps:
s/automatic/automatically/


> +		   to partial and slumber).
> +	   - DIPM: Device Initiated Power Management (device automatic

Perhaps:
s/automatic/automatically/


> +		   transitions to partial and slumber).

With that:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
