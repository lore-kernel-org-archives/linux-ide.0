Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE229993D
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021685; cv=none; b=bKfMVFoK03ZpjhK3ac5asl9DN+F38LGGSK8FQSP2xKOC5XPFjs+qlts8GDLjbfF3ccJNpsNeopd1GsxoVjj366wxPwsRYJTrCvdGcRakgx2Sj5h3nh70S1iTUnfWkK3DPpnQUsQU1CZH70D9MljBJ6kMhikCeKNSuWwu1ib2/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021685; c=relaxed/simple;
	bh=V7FsaamrF+y8Ya099oNDtQhtpOv8ujorK0sWZqJ7eX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkT5CrEDegAK4gdwUa8kLd2ogh8QVJHN2k3Av80Z1RKs4S30Wrz7kcDJe56gnXU9qYjzZ8Nrx0zR8GUCff6SEn/1uhLlxvRVDmeB4OIT/PhBB84XO3CDrJBhhPEv5pKUgeDZbvcKIkqA9peUjlLWaaGn1uBrRw9Hr9wrgtYjYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZQeU5sj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZQeU5sj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE76C4CEE3;
	Fri, 27 Jun 2025 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751021684;
	bh=V7FsaamrF+y8Ya099oNDtQhtpOv8ujorK0sWZqJ7eX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZQeU5sjfxRtpd9G9YRO0FywrHkEOhqoo417yHVdJ8gjabVlGDp8t9mKcmTjD4t87
	 MJCgfsaaPy6iWOj8jQ5+m8Q834DtEh9EjwvOKiU4mMLpPvpOjPXwnB5YsTt1LVMMyv
	 f/216nns5yuviW/D6wddwRQdCVYC1JjyzJO/TKe703nrpppnDHwrQRwCL8WJvoqfsp
	 y70karK/sp2CipPcvnbgsblI6b9arp9mFwX6Q/e+9h94O4A4sxL2oOUwCMppmkndGC
	 2XXYmzRCWZOQq1W7kHn+02m3Fs6S4vK9PTThZFN9khZVqTphlC/+9dtRiCy3ZFy5Mk
	 AwoeL7N4Gtw6Q==
Date: Fri, 27 Jun 2025 12:54:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 4/6] ata: libata: Improve LPM policies description
Message-ID: <aF54ceVTEYToaZVS@ryzen>
References: <20250627075207.23969-1-dlemoal@kernel.org>
 <20250627075207.23969-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627075207.23969-5-dlemoal@kernel.org>

On Fri, Jun 27, 2025 at 04:52:05PM +0900, Damien Le Moal wrote:
> Improve the comment describing enum ata_lpm_policy and add comments
> within that enum to describe each of the different possible values.
> The enum values comments match the description given for the
> CONFIG_SATA_MOBILE_LPM_POLICY config parameter.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
