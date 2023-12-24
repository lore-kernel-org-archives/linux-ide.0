Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B69E20FA
	for <linux-ide@vger.kernel.org>; Sun, 24 Dec 2023 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqxndX8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15DAC433C8;
	Sun, 24 Dec 2023 11:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703417575;
	bh=Q+QJ9E+2tLbfpYs5Qt6ABKHmftTARFJ6jKiofOte8XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqxndX8mHbmacxQ9nDOCOtv2AdIK5jPGyQ71ot4yOMSfaPihUtvF0WlN1FfLbMVho
	 1aL2NNRFh5Hfo3G74voZlAS8sTzFd+FWBTrGlcY8yYxnsRhpAOC5zONCUsaGg7EUGL
	 6gUW6HhUxHOawR08e6dCxQa9HeCryXx3+9ivO9itTmKoJU4ey7y+3kFHybNEvfkaTR
	 XVCEK+MgeWd9S+IV+/9LiAB5R3cL2lAY//fJ7WNc2hJVy20bWjKBOpDkUAXAgxGpRP
	 Yviw8yCL6or58iRtqL8gnfPJCHSic2XoJ+zpWvjesNiB2k/3g/nAvGcX0HumTYfOCM
	 T9eeXP5ujfEog==
Date: Sun, 24 Dec 2023 12:32:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Niklas Cassel as libata maintainer
Message-ID: <ZYgW4u3hYwkc0Y9E@x1-carbon>
References: <20231224005531.33788-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224005531.33788-1-dlemoal@kernel.org>

On Sun, Dec 24, 2023 at 09:55:31AM +0900, Damien Le Moal wrote:
> Add Niklas as co-maintainer of the ata subsystem (aka libata). The new
> shared tree for libata will now "pub/scm/linux/kernel/git/libata/linux"
> on kernel.org GIT.

Nit:
s/will now/is now/
or
s/will now/will now be/

> 
> Niklas and I will alternate maintainership every release.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea790149af79..28f407afd9cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12154,9 +12154,10 @@ F:	drivers/ata/sata_promise.*
>  
>  LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
>  M:	Damien Le Moal <dlemoal@kernel.org>
> +M:	Niklas Cassel <cassel@kernel.org>
>  L:	linux-ide@vger.kernel.org
>  S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git
>  F:	Documentation/ABI/testing/sysfs-ata
>  F:	Documentation/devicetree/bindings/ata/
>  F:	drivers/ata/
> -- 
> 2.43.0
> 

Acked-by: Niklas Cassel <cassel@kernel.org>
