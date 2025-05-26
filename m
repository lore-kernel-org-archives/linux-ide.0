Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D001DF97C;
	Mon, 26 May 2025 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247096; cv=none; b=oCNASIfS3+Jksj+oTS4QLhkxqJvtCa0R7O4IC9XWRZGwtqGncCdgNffQuFxInCzRndLIP1dYnOob7r6p0i0A9VxhmFyhjzKUh7zrVk+5+02te5FZx6q1qcohZDDNW6nZ2AijKmMVKFJJ1ewI1RKkJYcWvZq7Hlxo+xnziJ0K20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247096; c=relaxed/simple;
	bh=NxBQi95Sd6kLf8zT6L+TAoUucgvACen/25JQI/ufpi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNG4cxVLLvjMa6lSnlUjqCtNtiK0/a9IVzrx48ZQVRS5a4eFThT5ABkFpZqfmbnA7XXKVTcQMe3hGi0meqXpVel0/x8rAyaDu3Y2lg5lrXixBcy4Hyc8InlKMwgYvzUqRLOej/b4XGYSkxTponbl+DwqNMeIjIhJUiEZHJMi6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN1LAtxl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN1LAtxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BD3C4CEE7;
	Mon, 26 May 2025 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748247095;
	bh=NxBQi95Sd6kLf8zT6L+TAoUucgvACen/25JQI/ufpi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XN1LAtxlNzPEyPUsavTAO9GL3aVrZHQ6B58N9Z7nq8RYw/SAzgbHpzv7v7qn2q1LO
	 eouE2oZ9d+I8xaowss4ryXorN2rla0dRYMzKPaE87rC9FZp0A6BwomIcPL7u3KB220
	 ajHUC8lC020YzWKCLhz5DDjcGRfI2ptjTl0Yrt6LRV3vppxS9lUNKTu5HkiwMSJKwI
	 8Dxxa9rEN7NDxpv7ZA4SZ9sKKyQLsoHuNRY7AmWvhxe6fHzDtXZTMWbOCXHbFHLCeJ
	 deWgCikZkUAnxEraxuwF+bLF+sLUfYqHlPsbtn7gE5MXWsWVwZB0q1jM0i6GrwCBFv
	 3mAjUxWl1vdzw==
Date: Mon, 26 May 2025 10:11:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Alexander Roman <monderasdor@gmail.com>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] ahci: enhance error handling in ahci_init_one
Message-ID: <aDQiNEfh2i-XTAxs@ryzen>
References: <f2db43ab-97d0-4731-9b51-18876f342b42@kernel.org>
 <20250522102653.1169-1-monderasdor@gmail.com>
 <7533f274-dcc9-42a5-9e5a-74019255fd3c@kernel.org>
 <C819CAA3-3F8B-44A3-BD65-82B06378839E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C819CAA3-3F8B-44A3-BD65-82B06378839E@kernel.org>

Hello Alexander,

On Sun, May 25, 2025 at 12:10:07AM +0200, Niklas Cassel wrote:
> >> @@ -1619,60 +1619,72 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >>  	VPRINTK("ahci_init_one enter\n");
> 
> There is no VPRINTK() here since a long time ago.
> 
> So this must be based on some ancient kernel version.
> 
> Please base your patches on:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next

Sorry, but I forgot to mention, please don't use the In-Reply-To: header
to reference older versions of your patch.

To quote Submitting Patches, it creates an 'unmanageable forest':
https://docs.kernel.org/process/submitting-patches.html#explicit-in-reply-to-headers


Kind regards,
Niklas
