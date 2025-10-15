Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B349659
	for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551199; cv=none; b=lzBAEPSKT5MIlZ3kI9ZS5IFM8VQiRum+denplrpcyuCTHtkq785R6QKz3aMG8l8sH7/j285/e9bB8/BBjJadloFV4n8Gs2HWPKctsESPuQkVPAFMSlPwKfq1PQvIDsqU9hU/hs0nwztovRsrox7xVLGPyuKlaiBblmgohEagi7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551199; c=relaxed/simple;
	bh=PvtAbKG33LDEy/UkaCa/1k7IRw9gPGWh7JbOiIaQOm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niVLHToSVW3kT/d2q2k+fkquDcHd4YhY4nuCjyLFRzE/pOZqfRO/YcUjK4E4Wu4/YkvTtuqj9pOCtM/RapB9K3Oiwe6KP1Le3L5GE0v5IwtFzVJPu8k4RV1ld1ev9tTwAdndUIt8rHQqTJCa5zsnwAIMnhTO89nBDXunhpdjnmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUDWS8Ol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUDWS8Ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCF9C4CEF8;
	Wed, 15 Oct 2025 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760551198;
	bh=PvtAbKG33LDEy/UkaCa/1k7IRw9gPGWh7JbOiIaQOm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUDWS8OlCiLodRH9bSS5DqyPkcAKFApMFwFZo8O5Bz5UIGtfEHRxl/ECkB/T/Knnh
	 jjdSaXg3y+O/2ZB+YDYUvyvbJrJYl8kde1sLevFxfGcVVYeV5cGSL6Tm4lWTtDDBrW
	 mywwWB2qAMACcfNoMZvyoavDMBBzdTtOPrPm+pB6TakkC5PShP67zIS9RpRQGpuPDO
	 skBaFR2OyZX3hbSTXtbl1nZhL1BSjLZtgYkxLj9ApT3fgwoih/r9atPtQUjPjI4uOz
	 nSrkZ0OuigxppZCcKhuuMf5whty8LvEMc0cb5qNpkI5NpIQ1Ag1p7hpIl827XKR43/
	 x4e4LRQRn3sbg==
Date: Wed, 15 Oct 2025 19:59:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: invalid log directory version error
Message-ID: <aO_hG8FYhWA_7mAT@ryzen>
References: <DDJ38NYG2CVM.1DZTADYTDITT8@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDJ38NYG2CVM.1DZTADYTDITT8@matfyz.cz>

Hello Karel,

On Wed, Oct 15, 2025 at 07:56:31PM +0200, Karel Balej wrote:
> Hello,
> 
> ever since updating to kernel v6.17, I have been getting
> 
> 	ata2.00: Invalid log directory version 0x0000
> 
> errors (one upon every boot).
> 
> I have not bisected the issue but it seems that the guilty ata_dev_err()
> call was introduced in 6d4405b16d37 and by the looks of that it is more
> likely just an uncovering of an existing issue rather than a new
> problem.
> 
> I have not been seeing any functional regressions (which along with the
> above is why I'm not marking this as a regression) but error is an error
> so I'm wondering whether there is anything to fix (or maybe just tone
> down the log level?).
> 
> Please let me know, I can also test patches and if necessary, try to
> perform the bisect.

There is a fix queued up for this already:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?h=for-6.18-fixes&id=12d724f2852d094d68dccaf5101e0ef89a971cde

Will most likely be included in v6.18-rc2.


Kind regards,
Niklas
