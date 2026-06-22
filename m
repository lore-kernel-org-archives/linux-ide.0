Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCCC397B02;
	Mon, 22 Jun 2026 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127294; cv=none; b=SowCOM8FTT3SO14lxVx+YKKbVw/i1pvUV/zfD1ZYi/x/38554z4gR7P0BQZ7sZ1V0+JJ5ooqIt+Vri0syHEK/iwxuFpEb1OkX1YDla+n6pec2zYS1Z/0FKfLh/t41jQFNJZZwMpktAPGjg6KvPfnQrxEkV3adcZnxz0NLwxN6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127294; c=relaxed/simple;
	bh=ovwIrbKUkryzley7hYWqyPmboXqa0KcgfBb0t7WWHQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojeQsh6ZBauOAZP9TsI57Y375Bn3nkMvt1ZnmhIRgGLPtPS1kt81MSUcuUzleUOzfWq3AjKhP0S1Wk2PyXC2XAuf34s4JRKs+ykZS+Wclk7wrmZhaBjjEdhlgaoRnlCDjfI59iNBsyvY/vQ+INzmcenErEhHgQAoESBgQnYhA8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJJLSpiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJJLSpiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE461F00A3A;
	Mon, 22 Jun 2026 11:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782127292;
	bh=u/PmoG40T8TMvq7X8E9XjyNgX+reJSu3JrNfRsRbX80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WJJLSpiDZf9A4As4f6FBk7td51RWtqs+Np5+yAFkUiAKMhFrjk/UOVY41GWLcM45K
	 MCpwzwPlDfPVlT2JhjGY3Yf09pTl/MggeaxFUHG4xV5dBgzkfXeXaJtPpme8JlWKwH
	 lgMuiMthIvm3QogX9gxudex28ZwObD/6VCU205uiMBDzmOHJsBrMFXOH9RQGX4vU0F
	 Sjf44Ar99NqRHRRJPsFg5hA8CXBdC5M0JgFWmZ+lFRYL1BMWBPOk2abuop5NFOMDrE
	 Y/suQnIpg8rb+8SoDizDc89yABuX28bFxiyaxhj+kx1fMGvcmib1lPCUVZdNP+mGCK
	 N4t+EjDW2QaMw==
Date: Mon, 22 Jun 2026 13:21:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: hexlabsecurity@proton.me
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add NOLPM quirk for PNY CS900 1TB SSD
Message-ID: <ajkauSJn9vnBGYO5@ryzen>
References: <20260619-b4-disp-494070d2-v1-1-0c6d7be96237@proton.me>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619-b4-disp-494070d2-v1-1-0c6d7be96237@proton.me>

On Fri, Jun 19, 2026 at 09:54:02PM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> The PNY CS900 1TB SSD (Phison PS3111-S11, DRAM-less) drops off the bus
> after entering Device-Initiated Slumber during idle. With the default
> med_power_with_dipm policy the link goes down (SStatus 1 SControl 300)
> and does not recover, forcing the filesystem read-only. Forcing
> max_performance keeps the link stable across prolonged idle.
> 
> Add a NOLPM quirk so link power management is disabled for this drive
> specifically, leaving it intact for other devices on the host.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
