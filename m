Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24A52B1C3;
	Wed,  9 Sep 2026 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950893; cv=none; b=FgaSlmIAudy+awsrUXIzoFBQnZNJmkX7J+IgAKP3VE7MKfjaMq6xusnYShAxVXKFUFDeHo0r2gxffMSwadPiv9rm82zt4YaI+ysmv5NGqLJBIWp4t8vqV6NnmogkZQNjkmd6LB68/9feD1E7Nqn7xDHO+LOUk6Nqk0fyTBkfJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950893; c=relaxed/simple;
	bh=QtouZiOUKb0ozFu4BDZF1soCO71y36i2mcwtTBzs2dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfOav0EJ/e+MGmGj83idnWiG01AsawK0sYCNpzxCq17eJRxSis5iSkfl7OgPl/Zw9gcawmZRLHK609yHK7tMRAjarxKh8RJ28wNrxNP7s4Tp7dZj3ECQ1zy/AZmw4i9y7gKLzyZENPeTdi2VwQlH4biXao7nq1jodQbn+G03D1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVqmQPPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVqmQPPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB141F00A3A;
	Wed,  9 Sep 2026 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950891;
	bh=Iy6dP5b8+Bh9G6nbIp9+iLnn1c9NBsAK7MYaEpGt9oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SVqmQPPygM6EnWGa/TrORFMJ6dGwl4h0blpzcxL/ueSj9uaDLWEFmlFSBEU79cdAJ
	 xJNYr3h88RK8YwK3NCgFvvs0nQU6zsotvD3JKfdm1X8DSUngoc4d76urXCQR1qnK/v
	 EyfO+w145mwPhRrOZRQsZSt/YjGVkOsCGD1+Kiska96sAnSnabGkhJwMGoGvUNFTcj
	 uwLPCXrTQ556hkf0UY6c/7OnWMw+NLCJo1/sjF6KuTucfbFCoPDp+IO6e4dT2c+9UY
	 rpfezvCGAMkvYmYpcOsBvS2dHCeSMvuINlRjeXqQGs5JJHOoLvu0dQjwRlf8pOeApN
	 Fc+cKz+zn2KFw==
Date: Wed, 9 Sep 2026 12:48:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Pei Xiao <xiaopei01@kylinos.cn>, linux-ide@vger.kernel.org,
	dlemoal@kernel.org, Ondrej Zary <linux@zary.sk>
Subject: Re: [PATCH v2 2/2] ata: pata_parport: unregister devices on protocol
 unregister
Message-ID: <aqE5Z00G5h4XmtHA@ryzen>
References: <cover.1788867690.git.xiaopei01@kylinos.cn>
 <cec58ea83362df88f516ba7a5b895cf07edd7728.1788867690.git.xiaopei01@kylinos.cn>
 <20260908120855.9F34F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908120855.9F34F1F00A3A@smtp.kernel.org>

On Tue, Sep 08, 2026 at 12:08:55PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] pata_parport_attach fails for all parports except port 0
> --
> 
> commit b043c5b13721ce815e34642853318549a000ffd3
> Author: Pei Xiao <xiaopei01@kylinos.cn>
> 
> ata: pata_parport: unregister devices on protocol unregister
> 
> When a protocol module registers multiple protocols and a later
> registration fails, the rollback path unregisters the protocol but leaves
> dynamically created devices untouched. Later removal of these dangling
> devices dereferences freed module memory, crashing the kernel. This commit
> tears down all pi_adapters using the protocol before unregistering the
> driver.
> 
> > diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> > index 046ab7e3adbcf..712209882ab75 100644
> > --- a/drivers/ata/pata_parport/pata_parport.c
> > +++ b/drivers/ata/pata_parport/pata_parport.c
> [ ... ]
> 
> While reviewing this, I noticed a pre-existing issue in pata_parport_attach():
> 
> drivers/ata/pata_parport/pata_parport.c:pata_parport_attach() {
>     ...
> 	mutex_lock(&pi_mutex);
> 	id = idr_alloc(&parport_list, port, port->number, port->number,
> 		       GFP_KERNEL);
> 	if (id < 0) {
>     ...
> }

> 
> [Severity: High]
> This is a pre-existing issue, but does this idr_alloc() call fail for all
> parports except port 0?
> 
> Since the end parameter of idr_alloc() is exclusive, when port->number > 0,
> it computes max = end - 1. Because start is equal to port->number, the
> condition start > max evaluates to true, causing it to return -ENOSPC.
> 
> Would this cause attaching any parport with a number greater than 0 to
> silently fail and completely break functionality for those ports?

Looking at idr_alloc(), this looks like a legit pre-existing issue.

There is another call to idr_alloc() i pata_parport_register_driver(),
but it does:
error = idr_alloc(&protocols, pr, 0, 0, GFP_KERNEL);

0,0 is start,end

if @end is <= 0, it is treated as one larger than %INT_MAX

So this is only a problem in pata_parport_attach().



Kind regards,
Niklas
