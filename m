Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4042E8FF
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857141; cv=none; b=FHWpQvs2RT9sFZiXsCO+aQHLZi6EAF+IpBOWy6vaAqRuw37TI/c2ujZoc0dHzRQdVHkBxs1GpVEjhowNG8icD0zghrA4XA3zNrSQquimpumBKmzA66GCgMP1s2v5Hy1I5cwzbbppROCXnJGTcNdscwx9i+Tv0faK+KwxchS/XwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857141; c=relaxed/simple;
	bh=hsjIKUAGcmlp6aAkkuYz6N1Ty8K4YuUFvPcRAo2bznY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQMqxxApy63T3cazQ6zSCzXhl03IkK+CoJbzpHk6tDsm3pCIpwy1Yq8EgUY2XcHDUXphukRTmxHrDcYANAuR9b6UtsALAGhjUUwnmG3Yqh24yq+MNyy61/vPARDJTQ8okNS40+GdCygwTIB87DlDXpUVXYEPYfwn+k7pRUFTOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ysj3oIU7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ysj3oIU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DD01F00A3A;
	Tue,  8 Sep 2026 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857139;
	bh=awLf0NLAJGBidAzsl3RF5a4gIkFhbfOBObElI8HPIg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ysj3oIU7q4UNqhNvB5K5bUcbI57dQqRxUokIHHfqhz+NG/lMyxn5NyqpDIvtStqn7
	 kPlcYHId4chwRhm2pUbxxBLn82eCC7fkT0KB4vj5pM3IX9QpcvxY6TORPPnHxV5Iqb
	 sWk5IczizL8WMV6xS2VRay0XusXC77qt2/HJAeA2/+fsnuQ621JvWWEHMqHkttXp9f
	 VMuPJv7750UErCPdXvKt0CsXb1rUR09DyxPKzYYzO0q/1oY1O3kYJiyqxCdOSJ5ffJ
	 vNsiR6BqTn8fr0hol9DOm9Je6OXlAG1qbPvqcr1LDTADUsXAUpz+3xTDxXQHjlMmrN
	 gIcyZl7vXVdbg==
Date: Tue, 8 Sep 2026 10:45:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Li Jun <lijun01@kylinos.cn>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v3] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
Message-ID: <ap_LL-EaGZUmCaaq@ryzen>
References: <20260908061025.3580261-1-lijun01@kylinos.cn>
 <e0412d20-6503-4737-8c9c-94f44f2c397a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0412d20-6503-4737-8c9c-94f44f2c397a@kernel.org>

On Tue, Sep 08, 2026 at 03:13:49PM +0900, Damien Le Moal wrote:
> On 9/8/26 15:10, Li Jun wrote:
> > Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
> > DEFINE_SIMPLE_DEV_PM_OPS. Use pm_ptr(&ahci_da850_pm_ops) to complete
> > the API migration and allow the structure to be correctly dropped
> > when CONFIG_PM=n.
> > 
> > Signed-off-by: Li Jun <lijun01@kylinos.cn>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > ---
> > changelogs:
> > -add pm_ptr for ahci_da850_pm_ops in ahci_da850_driver.
> > -revise grammar and alignment issues.
> > ---
> >  drivers/ata/ahci_da850.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> > index 4e53ff96d712..469cf015bbf0 100644
> > --- a/drivers/ata/ahci_da850.c
> > +++ b/drivers/ata/ahci_da850.c
> > @@ -218,8 +218,8 @@ static int ahci_da850_probe(struct platform_device *pdev)
> >  	return rc;
> >  }
> >  
> > -static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> > -			 ahci_platform_resume);
> > +static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> > +								ahci_platform_resume);
> 
> You resent the same v3... Did you mean to send a fixed v4? Or is it me for some
> reason getting the same patch email twice?

I just received a single v2 and a single v3.

The commit log is different from v2 and v3, and your Review-tag was picked
up. However, the indentation still looks wrong. It seems to have 8 tabs
instead of 4.


Kind regards,
Niklas
