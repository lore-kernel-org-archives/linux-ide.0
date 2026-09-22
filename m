Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A85538C40E;
	Tue, 22 Sep 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088960; cv=none; b=ovw2QHMaMmqR4b+xb3lO6OzMByNmWAhX5IeRfq7H7Ycq+6ysIlCGXV1ISM0hm7sFd/+EBCD81RVPfJKCMOc0lbVCDkyid30JX3mciZiRuDGLPfiM7WcHpG8Zb1zlsx8tizp5obQQslZ9Rq6Kjrsj4Mlts44omaP50BMPPY6pNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088960; c=relaxed/simple;
	bh=4Uh+Xuu5oRkQqvvGTBVO3r0msddeLbNABPMS6EZx138=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk4dTmhoNFQY9FFiQBuWabiV0fDxA8Wo9mOSEZUJvW01vRk6rBUBrtGvlTf7Rj4Ie5osscFvUxvHQ2z0bwf1YLroyZ/83Rdumel8ysqLzSkjwkiXoSFxy9NdMNLOeKBTQnn6HWMEPUFGBAKLPNYPPPt36iwjPs8Wac7WqrX0Sl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbyrsvAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbyrsvAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA041F00893;
	Tue, 22 Sep 2026 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088957;
	bh=OrSEa3YGfA6WKD/rFjocweWXwodftwUebMShClA+130=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cbyrsvASM99FgWN9NxE3JNILd7IvjyQC2QYBV65E6y6yoNqu5edPA73RcLY8c7r6W
	 0y6tApZE0WSanr8ulAuZ0Ro+NGK0DNrm9h0ZQUj1sQXvP3q3A3hBBjgc8kORpI8Xsy
	 AO0IDYuNGjA2UcUFd+ZCOEVzU0iB0Mq2kj+/O7E1rHDVGf1paduAcRdiI3rtczjm2U
	 o3ZCC3LqOO9Da9L/gEcBNEx0VoXOTYpQDtDAKjBAzZH1f5xalfcK94AyKIDHnG7MAx
	 ynt3pLQFhERY7HV4hEGvZnZwy1Xc4oVmy7Xk90eqm00pMkrbp7l0AbA0PsCsz5HcJI
	 vsRRKcFh/NGEw==
Date: Tue, 22 Sep 2026 16:55:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ata: pata_parport: fix parport attach idr_alloc
 for
Message-ID: <arKW-l9NeFy-WT58@ryzen>
References: <cover.1790047457.git.xiaopei01@kylinos.cn>
 <cee1a15d98cd0d55f41fd65ca9d222b68a74e7d3.1790047457.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee1a15d98cd0d55f41fd65ca9d222b68a74e7d3.1790047457.git.xiaopei01@kylinos.cn>

On Tue, Sep 22, 2026 at 11:38:01AM +0800, Pei Xiao wrote:
> idr_alloc() expects an inclusive start and an exclusive end, so passing
> port->number as both arguments produces an empty range. Because
> idr_alloc() only falls back to INT_MAX when end <= 0, the allocation
> succeeds solely for parport0 and returns -ENOSPC for every other port,
> which pata_parport_attach() silently ignores. As a result only
> parport0 gets probed and any higher-numbered parports are never
> attached.
> 
> Use port->number + 1 as the end so the range [port->number,
> port->number + 1) contains exactly the desired ID.
> 
> Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/ata/pata_parport/pata_parport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> index 046ab7e3adbc..6f4e3f47d63e 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
> @@ -727,7 +727,7 @@ static void pata_parport_attach(struct parport *port)
>  	int pr_num, id;
>  
>  	mutex_lock(&pi_mutex);
> -	id = idr_alloc(&parport_list, port, port->number, port->number,
> +	id = idr_alloc(&parport_list, port, port->number, port->number + 1,
>  		       GFP_KERNEL);

This patch looks correct to me.


Kind regards,
Niklas
