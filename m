Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03D2C1584
	for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085246; cv=none; b=l0tyGqBX3ShVw+rbnW3wZ1p34/4T0LECtOZEDSrFpvwpwRMYkkreBwIi3SA3BuzMvvXI0U8WdTu5RUjUfNBj01UCP5ycRP8Rhn6I0IW1sIaTwTcv1/MxosKSh91JyYfcCjRKZEhcmYxNFp/djybsnwGR+/eOFdenSNcN1e+k/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085246; c=relaxed/simple;
	bh=wLax8Dm9uvI3DwsjGsOb+XgV2pl4pZYv65mAASiMMO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiMQLa9x7vEcYq+DlkOH0Ki0W0suhY4c7oyd54j/tZqwrQcFtgU9WG6M21ZE9JeQt5srKluNoMkbyMb+epOTeyNWCgvgHs6Jv3VkaJrk0jaQC7PwcTY05+KuvES4RsK8jBhOydNyrPkXhINE0EXdpIOV6ZaBkYmd0Vr3yWhd+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stTYkKrZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stTYkKrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC7AC4CEEB;
	Wed, 13 Aug 2025 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755085245;
	bh=wLax8Dm9uvI3DwsjGsOb+XgV2pl4pZYv65mAASiMMO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stTYkKrZXWeQTt1GazmpiD0nc12ceHlpaewLs9A9UbjOzEAW8yOXJ/EhQNazqmV9K
	 VWiYp2mzZf2BS37soN82OmAR9qnpVEU6c15makfeaxQUFkEahlOJMYO9iYN/5PaixN
	 kNU8ggn/Jk8lCWFddLwU47hHTnJmOHg41rHymmdCoD9gtupxU/mCWkTUOZrZE7Blgx
	 JgE31ARlvamuPuxdwaiVGUgd8j34aZdJ1dAicQRebOYHHMe//pycI0d6//cOQYe2gY
	 bJONFO1rSS4MgjCEodTCGZ12Lxj0TBVoNM57KdLY3ZSax78E80seqAVqawadlWemVM
	 pu3m++E1u90bQ==
Date: Wed, 13 Aug 2025 13:40:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] ata: libata-eh: Fix link state check for IDE/PATA ports
Message-ID: <aJx4uW4JDLoDlhrG@ryzen>
References: <20250813092707.447479-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813092707.447479-1-dlemoal@kernel.org>

On Wed, Aug 13, 2025 at 06:27:07PM +0900, Damien Le Moal wrote:
> Commit 4371fe1ba400 ("ata: libata-eh: Avoid unnecessary resets when
> revalidating devices") replaced the call to ata_phys_link_offline() in
> ata_eh_revalidate_and_attach() with the new function
> ata_eh_link_established() which relaxes the checks on a device link
> state to account for low power mode transitions. However, this changed

s/changed/change/

> assumed that the device port has a valid scr_read method to obstain the

s/obstain/obtain/

> SSTATUS register for the port. This is not always the case, especially
> with older IDE/PATA adapters (e.g. as emulated with qemu). For such

s/emulated with qemu/PATA emulated with QEMU/

(QEMU also support AHCI emulation)

> adapter, ata_eh_link_established() will always return false, causing
> ata_eh_revalidate_and_attach() to go into its error path and ultimately
> to the device being disabled.
> 
> Avoid this by restoring the previous behavior, which is to assume that
> the link is online if reading the port SSTATUS register fails.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 4371fe1ba400 ("ata: libata-eh: Avoid unnecessary resets when revalidating devices")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
