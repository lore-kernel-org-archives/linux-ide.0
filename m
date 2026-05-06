Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC873EF0BE
	for <linux-ide@vger.kernel.org>; Wed,  6 May 2026 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079624; cv=none; b=FnSpgh41cHUxSOMbRkiZNSyT42WigKf5XqBDRj/tdbsqAVB/nxi/OUcs+hWte3Lw5evJ6AF/dd8F0D/pMCaq7xWIHIQn95B0pFECyriSqK+u2moEmDhdmDXkUiD7jQ+d+SrzbCK5FDcoZRYOfe5VkeNIE5ft5trBXRaXt05zseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079624; c=relaxed/simple;
	bh=Ukc/tFdYxOAKLJVohv2yxpmIfqZ8YC3OKpt/HJ49FHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQg2xFufEu0/Hd+7L7qOXkd/6mA+teIuU9JOh6YCSyJWe9oHQ6a+r2HXZcvSgjVIIPEMfoRG9AoY0FAiJ0+oRXNpMWNr3BTSSSzZ1US9fPbicH+icObqhleTjWZ6f9rmwDv/9H1ASV2lMUHmRDjbtb6fB+atracLo9p9npxmR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoU76SDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoU76SDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20682C2BCB0;
	Wed,  6 May 2026 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778079624;
	bh=Ukc/tFdYxOAKLJVohv2yxpmIfqZ8YC3OKpt/HJ49FHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoU76SDauubUYRuTzEbE2w0rWbSO37YRgbdrvhHcrzAkIDaNcbxs5s+mGMU3XwJfL
	 fhFCEAC0qhrRfyovPZERzXSAGIPP2XUHWW4xUDeBJE0gzwblQedn0VDULlNtmGczpD
	 5raKYbKHw2iu9Yx0oYZaPgh5HGIeEiRKUKSnzATrs3iigfU6PsiiakMsByAra+a92B
	 4svQvJsqhs2INqZugEKwcjYzg1ArLUYSvipGd0clTSENUMS+GaiqH8CAAZcGyVhchr
	 qnuUoGt8HG4p/FVyxQA9h3M//HqYoit2plPOx4GfFkqslMmjZMn/KRscM6p7bAMqhW
	 rI2Tl9b5FpjGA==
Date: Wed, 6 May 2026 17:00:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <htejun@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/3] ata: fix deferred QC handling for port multipliers
Message-ID: <aftXfTL98eqhpWLN@fedora>
References: <20260501125410.1204490-5-cassel@kernel.org>
 <88ea5d12-520b-4022-9faa-3ea879a8bfb6@tkel.ly>
 <ec407a6d-2164-4252-90f0-0aebe8227290@tkel.ly>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec407a6d-2164-4252-90f0-0aebe8227290@tkel.ly>

Hello Tommy,

On Tue, May 05, 2026 at 05:13:41PM -0700, Tommy Kelly wrote:
> > 
> > I will also apply the FBS devicetree change (5918bf2) and test with that too.
> > 
> 
> Special thank you to Heiko for the FBS support!
> His patch setting PxCMD.FBSCP works: https://lore.kernel.org/all/20260201191804.41421-2-heiko@sntech.de/
> 
> I compiled the FBS devicetree change into u-boot (which passes the fdt to linux),
> and running on unpatched linux 6.19.12,
> FBS works, and no regressions are present.

Nice!


> Again, that is before this patch series, I see no queue_depth regression with FBS.
> As opposed to CBS which had a regression in the 6.19.x series.
> 
> I can test with this patch series + FBS if you'd like.

That would very much be appreciated if you could.

Since:
1) This series actually modifies PMP FBS behavior. Basically after this
   series, the performance should be the same as with 6.19.
   (We currently have a performance regression in mainline.)
2) I do not have a PMP with FBS available to test with.
3) I tried to reproduce your problem with a PMP with CBS, but was
   unsuccessful to reproduce it.

Thank you once again for your help!


Kind regards,
Niklas
