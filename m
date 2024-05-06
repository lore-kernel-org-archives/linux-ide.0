Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38225569
	for <linux-ide@vger.kernel.org>; Mon,  6 May 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013462; cv=none; b=k7JbyhA2mDt7YBXV5cJn0RLiIBept1SN46MUR+C1gFMfrrbGQe1MEHk0vu0QsBdNAaYc1fjWxvug/K3hln3RWNwE1Lb/2dc9F80EeoSI3n3oUS1E4OjtbxsT/xn6X2AQsXrY3pDoosOwgVi7EI5dK5l+JnhGjVQnFSraQUHYc98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013462; c=relaxed/simple;
	bh=momGtO/6sJQ5uPR2DIfPyGO5637ap1YsDQW+A3GX6U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxx2r6jNLgQcRHiUMlekV7LP30AEoB3pGW/VQbLhlny1DntH09bLppIYUsfHlkY6P6ELI4esYxaO/UNXh0BZMkYU7eEqQOolawz5qfqX2rlK+kh6UiFtVcT9z3OS2QdfXbnxr+Vjnzh5gatioNpJrJE3854ckto/p8buU6kU22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihSZK7pO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihSZK7pO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CE0C116B1;
	Mon,  6 May 2024 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715013461;
	bh=momGtO/6sJQ5uPR2DIfPyGO5637ap1YsDQW+A3GX6U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihSZK7pO0OSf4jzzLtsjywCFUOWZ0BhlHXT6DJj3dYFJIn3r4yRngSw+gA7lvixRs
	 EB86j5xaVgqsPB0fBEKf/ehvSM8guPv/YaDnZQfb3W/haj9dAlY+ohnf5RQBguC8Hy
	 z76lZPpdph1amWhYUzkyjmd2O2SPutALR55o7XnShlCL3pa1SGe/jptmd4DTEHV30C
	 qiv7TzpSYON3f47o6FCr6K/DJOJsY9LSQplFqsaA00cJwthWS8noz7hqCHO1a23XVT
	 bTYaWlog4KlWed2TCS/hC5iHe2ljwFbgKfVTuJ/aOuy47e/7+tsFS53sfwjr2i269x
	 1YNqv4uz0oJ7A==
Date: Mon, 6 May 2024 18:37:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] ata: pata_legacy: make legacy_exit() work again
Message-ID: <ZjkHUcfFMXtAmdYS@ryzen.lan>
References: <c6ad7d07-4dc8-7087-4018-6ebdf93d6580@omp.ru>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ad7d07-4dc8-7087-4018-6ebdf93d6580@omp.ru>

On Sat, May 04, 2024 at 11:27:25PM +0300, Sergey Shtylyov wrote:
> Commit defc9cd826e4 ("pata_legacy: resychronize with upstream changes and
> resubmit") missed to update legacy_exit(), so that it now fails to do any
> cleanup -- the loop body there can never be entered.  Fix that and finally
> remove now useless nr_legacy_host variable...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: defc9cd826e4 ("pata_legacy: resychronize with upstream changes and resubmit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the master branch of the LibATA Group's linux.git repo.
> It's only been build-tested...
> 
>  drivers/ata/pata_legacy.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux/drivers/ata/pata_legacy.c
> ===================================================================
> --- linux.orig/drivers/ata/pata_legacy.c
> +++ linux/drivers/ata/pata_legacy.c
> @@ -173,8 +173,6 @@ static int legacy_port[NR_HOST] = { 0x1f
>  static struct legacy_probe probe_list[NR_HOST];
>  static struct legacy_data legacy_data[NR_HOST];
>  static struct ata_host *legacy_host[NR_HOST];
> -static int nr_legacy_host;
> -
>  
>  /**
>   *	legacy_probe_add	-	Add interface to probe list
> @@ -1276,9 +1274,11 @@ static __exit void legacy_exit(void)
>  {
>  	int i;
>  
> -	for (i = 0; i < nr_legacy_host; i++) {
> +	for (i = 0; i < NR_HOST; i++) {
>  		struct legacy_data *ld = &legacy_data[i];
> -		ata_host_detach(legacy_host[i]);
> +
> +		if (legacy_host[i])
> +			ata_host_detach(legacy_host[i]);
>  		platform_device_unregister(ld->platform_dev);
>  	}
>  }

Reviewed-by: Niklas Cassel <cassel@kernel.org>
