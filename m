Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C894F30D4;
	Fri,  4 Sep 2026 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539397; cv=none; b=jsMVzvpy3reDTBYw7lugvqyG2r2H0Edd2ZsQz+lvGDHn93VMIOj4km+xEc37+H010MvXVvkKksIhg+dqVR/b0b4uvTjVpU18O3KpldF/RU482tcdHX4a72rij/3X/Hyu/zJS4m1JvjYbbj8BIAMvJcBlfx7Ee2syWBxtccJEaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539397; c=relaxed/simple;
	bh=k1B8UXAgapvTDV8T0WvOO0lL1nTqcNGnnZZjN7Xe1mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj0wZgowcLU8m4Q3pL5jxaZc0qZk8q8ZsyzyUvuJlI369c9V7dQRddTO+Ozy91EWbqe3oKIIIvl2Qt9rG5tjcgRdUNbL7J4iGfvceLGsG2a+PXZ5tgsMG33J2YHVtcieep943T8WhXA1z0JDsk5mhpJ1kKA/IEFXN3X6qA8uxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4MI10pG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4MI10pG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9127F1F00A3D;
	Fri,  4 Sep 2026 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788539395;
	bh=OxSCp00AQ506yhifJn1FGJ6okthNEQZcVFpBsKtw3XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V4MI10pGuBuNAXbnIfV6XIzEXSq9xXM+66tCBO9W2TWoZs9nvLsuTyzszuTQDewxM
	 SoM9VjRD/V2M2LpMJUmrOReVFOsWh3dMS4zvkAzNTvGxcEQ8Y1vWTRBtyuPTEN3sfl
	 aXB4FdMPViUy9Z4UNtA8L2QAZU/0IpZrYxJ1bOLrvfASYfR7hZwhwKDyq106/juycx
	 PbZq9vGrn+AjJ5yLfxwrKEWSzTEw3JhaNP2fXu6v8zotFSwpL5n5rEqQHqxyYNeNC0
	 lWKtSDhg/+5JOqZcG432kzzxeRHL6DD77R5Ru95G/YEU16OizhyR0wTpwrGsvxES5R
	 vWQjcvZ82/mwQ==
Date: Fri, 4 Sep 2026 18:29:52 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Pei Xiao <xiaopei01@kylinos.cn>, linux-ide@vger.kernel.org,
	dlemoal@kernel.org
Subject: Re: [PATCH 1/2] ata: pata_parport: pin the protocol module before
 device_register()
Message-ID: <apryADzYkvYwj358@ryzen>
References: <cover.1788349317.git.xiaopei01@kylinos.cn>
 <eae63a4231a9d669f3dc140f34c7b90c860cad72.1788349317.git.xiaopei01@kylinos.cn>
 <20260902120609.635581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902120609.635581F000E9@smtp.kernel.org>

On Wed, Sep 02, 2026 at 12:06:08PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Unused label `out_unreg_dev` causes compiler warning.
> --
> 
> commit 99f7607699410f6446da6e37e3bed84251a51bd8
> Author: Pei Xiao <xiaopei01@kylinos.cn>
> 
> ata: pata_parport: pin the protocol module before device_register()
> 
> Take the module reference before registering the device to prevent a race
> condition where the device is visible but the protocol module is not yet
> pinned. Also ensure the reference is dropped on the device_register()
> failure path.
> 
> > diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> > index cf81a6128f552..7462f9b1acc57 100644
> > --- a/drivers/ata/pata_parport/pata_parport.c
> > +++ b/drivers/ata/pata_parport/pata_parport.c
> 
> [ ... ]
> 
> > @@ -517,15 +525,12 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
> >  	pi->dev.id = id;
> >  	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
> >  	if (device_register(&pi->dev)) {
> > +		module_put(pi->proto->owner);
> >  		put_device(&pi->dev);
> >  		/* pata_parport_dev_release will do ida_free(dev->id) and kfree(pi) */
> >  		return NULL;
> >  	}
> >  
> > -	pi->proto = pr;
> > -
> > -	if (!try_module_get(pi->proto->owner))
> > -		goto out_unreg_dev;
> 
> [Severity: Low]
> Does removing this goto leave the out_unreg_dev label unused at the bottom
> of pi_init_one()?
> 
> If the label is no longer referenced, compiling the kernel will emit a
> -Wunused-label warning. This can cause build failures in configurations
> that enforce -Werror.

We don't want to introduce any new build warnings.

W=1 builds are important too, even if not default.


Kind regards,
Niklas
