Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128BD18E35B
	for <linux-ide@vger.kernel.org>; Wed,  9 Oct 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465504; cv=none; b=K/GVKBuIZHcUdgvoiOW8beCsOL+pxmJYFynW49/qw1fSForF1Inrephzlap3PSswWjRZpOYyxG8rVD5+ozoyCkPjLPFexwpicpGEa0uCwV7bTJsSiDjp6DgGKywWd0GWs/q5lvcy0s4BIfTF4OwlLMV4MEw3OuVrJpBb2Lh3Qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465504; c=relaxed/simple;
	bh=XNyn70Kc9wEZK864HwiLPBH5pE4qHA30g8N8fomKxak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaFWgv6H5pxQYl4nTWFyFyd93oFphpTLCLs3ZZWd95hQVeTt6ttYhFQfJcveaUZG4taB4eUTKQl7Nvuuozvccznq3v8PUtNqlKwJY6p05PbNLDMOsRh/Kn0Vmx//xUTqYqBgb5irY0+OlQ5L6VFWf1Wvvijwquo5ieA6yHn6ovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKcHVPRw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKcHVPRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B832FC4CEC5;
	Wed,  9 Oct 2024 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728465503;
	bh=XNyn70Kc9wEZK864HwiLPBH5pE4qHA30g8N8fomKxak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKcHVPRwimDdAbyiPCgL0COY2fz2RpeZKA4DAyxCpRRkuuQgKvyrFudBcycGarrY6
	 xsTDBzRxxNz0crJsRGLFu+/hg2VNF385fdb/hv6RIKH4yGfJUs19ID81TK1T8HNqTB
	 gmohgHJ5xX7K+N0hFNA4eoHkkvaC0RAM5vDl6VvOkay1NjgDyqhAdu0wW5Bemx7nS4
	 ANs4XIk7C1LSLq2YTTAlk2q+kEsaFbH92wamKxqsDn2HIhEb5vIO4YZK6z/hZSR5lb
	 6aKToYQEfVcWJ8AOJ6VpdJ/ar9kJLO87an05Fyi3seQD4YqUTRPzx5pbj1ZpUuh3Ah
	 yFm7KcOvBkyuw==
Date: Wed, 9 Oct 2024 11:18:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ata: ahci_platform: Modify MAINTAINERS entry
Message-ID: <ZwZKW-KlUZR0UMDd@ryzen>
References: <20241009081557.377035-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009081557.377035-1-dlemoal@kernel.org>

On Wed, Oct 09, 2024 at 05:15:57PM +0900, Damien Le Moal wrote:
> Modify the MAINTAINERS entry for the ahci_platform driver (LIBATA SATA
> AHCI PLATFORM devices support) to remove Jens as maintainer.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c27f3190737f..d377e81ab2bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12961,7 +12961,6 @@ F:	drivers/ata/sata_gemini.h
>  
>  LIBATA SATA AHCI PLATFORM devices support
>  M:	Hans de Goede <hdegoede@redhat.com>
> -M:	Jens Axboe <axboe@kernel.dk>
>  L:	linux-ide@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

This entry, and other "LIBATA XXX" entries still mention
axboe/linux-block.git as the tree.

Another "LIBATA YYY" entry mentions dlemoal/libata.git as the tree.

Anothe "LIBATA ZZZ" entry has no tree defined at all.


It would be nice if you could either:
-Update all entries to use libata/linux.git as the tree
or
-Remove the defined tree for all entries except "LIBATA SUBSYSTEM".


Kind regards,
Niklas
