Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F03A6EF0
	for <linux-ide@vger.kernel.org>; Mon, 13 Jul 2026 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930678; cv=none; b=UNUiQ4l4R2Fja8azwYHRMOSZQHGZdShRro10NiSgeKClu3/jQYp69+GVpEuA+uRQdBqr3U3bzoi1WbOBdjtLG+qs0R+aMs374ilxUGudxPuT2iVxd9gI7OdKBQ0hYpEwi6OBCyNwSbG5j3PwUEunBzIP2RTxTQj5p4cuSn/aEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930678; c=relaxed/simple;
	bh=ZjQUfw+jwrheIU219dlfYi9qeB85xoF7F6RU4MLFbog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3KThSeXUI+m2HYc0WPfU9mjc5L7TcjNiR3VfJhWpR68eDBXurppU5+ASrSNiLTIx//I3TWtpptqyZXWqqO2UODMno2lZv6/k6HoNAybMqg+FfizGwlX1nr9+nOnSUV0UAztyB7keVid84TLR/5wL0oeIHsWPDBiC2oTnWNsFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt7xcAZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt7xcAZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9571F000E9;
	Mon, 13 Jul 2026 08:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783930677;
	bh=RWq+YuQexOWNUyNuvtyZ2BQYLs+4ZM/imA5k+C7RuG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gt7xcAZzs4ACS85bJh/UuaDwkTCBjHE0L8asgmmUtFboWTi1RsqLxEH1A3OWclbQT
	 IpsJ6lkJps0JItvZmQFOcqwisyjF2IzeFglnwGYb2oOkOWQ8+qQhWpCOZ5gyASid+z
	 2+0dIptfHZBGQOo9Kg9twq9ddeNsZn92luMz/Cy46kT6DSPLtsR6gArBHFPF/OVxex
	 uITvlI34t2ZsDvN2VVBXVewVX4DqaG1joEVV8osRbse58Arc18mPZsjXLHf5wamjro
	 G2SE4/VYyebJ5616R2ZuaqOIsRgvJpO6kypGrxLoiL44bLGAwPWFHa+02SLHNEWogl
	 dZtQRCic0ct9Q==
Date: Mon, 13 Jul 2026 10:17:52 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: make ata_eh_qc_complete() and
 ata_eh_qc_retry() static
Message-ID: <alSfMHUAzBoitCI7@fedora>
References: <20260713050942.576415-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713050942.576415-1-dlemoal@kernel.org>

On Mon, Jul 13, 2026 at 02:09:42PM +0900, Damien Le Moal wrote:
> The functions ata_eh_qc_complete() and ata_eh_qc_retry() are used only in
> libata-eh.c. So remove the declaration of these functions from
> include/linux/libata.h and define them as static. While at it, add a
> missing blank line between variable declaration and code in these two
> functions.
> 
> No functional changes intended.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
