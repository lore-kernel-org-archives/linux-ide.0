Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE98192B7D;
	Mon,  9 Jun 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462262; cv=none; b=dMXJ4uC5TmZdZZWDrm0QxyzOx2TU3pky13D24njHhoiYNR+UtIOAHAQiUu4M8urvBNZMaYT2L4sG4Z+TFwAKyFx3xFQ53vl2flKFJbug+aRaDLEN5ymKIiGpQIPyf69k6J78dJvzugz4PrR9VWRNdOKBWZk6B/CWJ4lpKiGcWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462262; c=relaxed/simple;
	bh=6VKT7iisO0XJVEPjUyklbYNC/poB3XqRGQFAUxfDly0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeJ+1uQMNmPrURpgbrJFZW7DxZgLaa4V+lUjlKUZoCPgdhjO6sxURGryIS62KvfrQaMEKFDe3TMSzv+bIjW6TptfbuKnalLowc3iGv3xUs+UsU5om2GNJGKYvetO+10qe6IMIJYBPJSbFSVwVyL/NDEofMCrIOvf7fO9rzzLK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d22qlhG2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d22qlhG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BFCC4CEEB;
	Mon,  9 Jun 2025 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749462262;
	bh=6VKT7iisO0XJVEPjUyklbYNC/poB3XqRGQFAUxfDly0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d22qlhG23+Tjy3QEAKLC6qxql7yhrTkY0DpJN1is92G41+ZY7eznwpnlZUS0A/4yM
	 Rb0B6YtAQXBIv78cHxEoLs0muXlOjBXRwwwezRmj60FjlObxXpBII8CrSHtvpIWPIR
	 c2bKNyaL1lT100gaKWuT7Uz2h2+0rPjDKiZhwNdMFwS46ipv8c1UVkasxK4+8+yAzO
	 XjJEh4x9hrT3Nex1ZC6p0W/q0OQd1g8eYT0cu1oSSt/8ZbOKOtIQGX2LdMM1rlxno+
	 tXFq7t0nM3BMv9cuEloGeyGFvgJbiD/pXtnDCIFwjyPx5MUTzvNQiJdLryl90S7omW
	 q1zyWjwc89kGw==
Date: Mon, 9 Jun 2025 11:44:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: pata_cs5536: fix build on 32-bit UML
Message-ID: <aEas8qlzCQRJrfip@ryzen>
References: <20250606090110.15784-2-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606090110.15784-2-johannes@sipsolutions.net>

Hello Johannes,

On Fri, Jun 06, 2025 at 11:01:11AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> On 32-bit ARCH=um, CONFIG_X86_32 is still defined, so it
> doesn't indicate building on real X86 machines. There's
> no MSR on UML though, so add a check for CONFIG_X86.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>

Reported-by: should be followed by either a Closes: or Link: tag, see:
https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes


Kind regards,
Niklas

> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/ata/pata_cs5536.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
> index b811efd2cc34..73e81e160c91 100644
> --- a/drivers/ata/pata_cs5536.c
> +++ b/drivers/ata/pata_cs5536.c
> @@ -27,7 +27,7 @@
>  #include <scsi/scsi_host.h>
>  #include <linux/dmi.h>
>  
> -#ifdef CONFIG_X86_32
> +#if defined(CONFIG_X86) && defined(CONFIG_X86_32)
>  #include <asm/msr.h>
>  static int use_msr;
>  module_param_named(msr, use_msr, int, 0644);
> -- 
> 2.49.0
> 
