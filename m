Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE83C465
	for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268341; cv=none; b=Erf3CuGIecbWqQJfPxjpZ3gMqXgEiUCnRIJPZLeG2bCBRBGl3xf6EBTCWruKd6d/Bo9iYpCZDfwaBh90kcBmfWZNzLT98okvsBTzqxs2VKs8sCUqprIO20HT0d68zWC6WZawdioBqjeQFlTySK1y/mfn8Os8efaGu59GZAKtrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268341; c=relaxed/simple;
	bh=LH6Iq3j6JsOkNQ560qIHHXDt+2hdWhE+g9QluxxGJrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv6UJgj+6fpLUhPQQfNg6ThtHiQrHTegzc4SQkkNn67dpdvUi19qSvZ1YuPH+/Cbn6+/0V3HOzqI8y1Zz5uYKfN5MIZeAei9xIDVYS83QX7cA7v6zsa46j+a6OlMFiG2tzLEm1HaK6fM/AjXyYQpt9eoAFfRJkXCUNFGiQo+iIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alwUrqQe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alwUrqQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C35C4CEE9;
	Mon, 26 May 2025 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748268340;
	bh=LH6Iq3j6JsOkNQ560qIHHXDt+2hdWhE+g9QluxxGJrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alwUrqQeA58v50sO5AwnAj8HiAqt9wWu35kKVXg4nHl8l5IytmT/Hufo4YBkpS/H+
	 CpZGqW4La9mxRglDKzjhMMDySTThfmBhWAss/yjmBEOyswHzRaDdlEGewoIIoVFuQr
	 vIilPX7KZNm6c+Jg/8aOSGtke62xez3Lu0c0MswfLSW3weew65ZOgJJXFlp8WlqhRJ
	 /40N3e5f0/i7lhZ9lsNzcyHxv6eKsFAQkMI+8xZs/LfnlHPt9+qTO5Qg5fxPAetGAP
	 CvN6Qn48c3qliUqqQjdgcS2PkUkrVXIiwxciG27jo652ehOyR+/QhnGg/bHEgumvIZ
	 mhp/EIf9PRFuQ==
Date: Mon, 26 May 2025 16:05:36 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>
Cc: kernel-dev@rsta79.anonaddy.me, Hans de Goede <hdegoede@redhat.com>,
	Andy Yang <andyybtc79@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
Message-ID: <aDR1MB2ppvRq_9-C@ryzen>
References: <20250526140312.228894-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526140312.228894-2-cassel@kernel.org>

On Mon, May 26, 2025 at 04:03:13PM +0200, Niklas Cassel wrote:
> A user has bisected a regression which causes graphical corruptions on his
> screen to commit 7627a0edef54 ("ata: ahci: Drop low power policy board
> type").
> 
> Simply reverting commit 7627a0edef54 ("ata: ahci: Drop low power policy
> board type") makes the graphical corruptions on his screen to go away.
> (Note: there are no visible messages in dmesg that indicates a problem
> with AHCI.)
> 
> The user also reports that the problem occurs regardless if there is an
> HDD or an SSD connected via AHCI, so the problem is not device related.
> 
> The devices also work fine on other motherboards, so it seems specific to
> the ASUSPRO-D840SA motherboard.
> 
> While enabling low power modes for AHCI is not supposed to affect
> completely unrelated hardware, like a graphics card, it does however
> allow the system to enter deeper PC-states, which could expose ACPI issues
> that were previously not visible (because the system never entered these
> lower power states before).
> 
> There are previous examples where enabling LPM exposed serious BIOS/ACPI
> bugs, see e.g. commit 240630e61870 ("ahci: Disable LPM on Lenovo 50 series
> laptops with a too old BIOS").
> 
> Since there hasn't been any BIOS update in years for the ASUSPRO-D840SA
> motherboard, disable LPM for this board, in order to avoid entering lower
> PC-states, which triggers graphical corruptions.
> 
> Reported-by: Andy Yang <andyybtc79@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220111
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Hello Andy,

Could you please test this patch?


Kind regards,
Niklas
