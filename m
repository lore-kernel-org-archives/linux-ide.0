Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42561A2392
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118889; cv=none; b=bGDqE44WImFdCNv4GdJ/74wRpvjBFReyczSgW6Y/JtHoZKCcKktxME5vCfz9ujeRcmOX3FVs6w3fv96wmtbyc/CZ4KddgSCrYX6lg7OA6FF8EN53HfvHsQ2yYigMAnq9v37bNehlfLj2U6bcYbM99ejfScfgDE2v7DfC2fRRM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118889; c=relaxed/simple;
	bh=UJ2MzaMJSIQrC/o8Gpn/sM/JVlYbaF6uaFg4UP1trcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+40eTFrTrbWj5N5sf2VePNdlS/TTwp3Q6gTNQ88kwlEQ3IkNVtOvyMtIpEB26qEBDJ13Vtogq3PFX52G8+5/6vEgF9Cug7tg5m0Gw6z7jKBefZ6dw16zMIm1tlrq/o9FEv1oZ78SxH/azGeq7qhrUjlHhLar75XSdOD+nwMEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmWjkDZm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmWjkDZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6266BC2BC9E;
	Thu,  2 Apr 2026 08:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775118889;
	bh=UJ2MzaMJSIQrC/o8Gpn/sM/JVlYbaF6uaFg4UP1trcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmWjkDZmvXFS3sc7H7Iy0TikaxHj2SzbEvZkqYVje7tL+aif+8BI1n4eLWP97on8t
	 SiB88MW3y/ccLusMEPX5/Wv/gYdIHyOfWHTB7L/vCGTvoe3IRuJgIaL3BUlrqhiYpQ
	 rvHkIi92rgnD1kd+shE6WJysOPkwibYW75bI8O4+PN8/5FtU6NA24A9tzH6q+fX6J2
	 nh4AiaQRQp1KXiXwVfDdKMiZJW19V6jAtWQvAqSheaObkQX5jDNCD1ok74RzRz4ttE
	 ys7VSYQ6XjYzfQsXMnVfg59ahuaRVPSEmV4cVpdUaLf4Jtl3zKYg0gG10aGzdaH24L
	 VpFyJFvc5Si2g==
Date: Thu, 2 Apr 2026 10:34:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 0/5] ata: libata-transport: series with further
 refactorings
Message-ID: <ac4qJZKTLGTpob9w@ryzen>
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>

Hello Heiner,

Once again, thank you for the nice cleanup!

It would be nice if you could send a V2 within a few days,
so that this will make it for 7.1.


Kind regards,
Niklas

On Mon, Mar 30, 2026 at 05:17:12PM +0200, Heiner Kallweit wrote:
> This series aims at further improving and simplifying the code.
> 
> Heiner Kallweit (5):
>   ata: libata-transport: instantiate struct ata_internal statically
>   ata: libata-transport: inline ata_attach|release_transport
>   ata: libata-transport: use static struct ata_transport_internal to
>     simplify match functions
>   ata: libata-transport: split struct ata_internal
>   ata: libata-transport: remove static variable
>     ata_scsi_transport_template
> 
>  drivers/ata/libata-core.c      |  11 +---
>  drivers/ata/libata-scsi.c      |   2 +-
>  drivers/ata/libata-transport.c | 117 +++++++++++++--------------------
>  drivers/ata/libata-transport.h |   5 +-
>  4 files changed, 49 insertions(+), 86 deletions(-)
> 
> -- 
> 2.53.0
> 
