Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598AE205ABA;
	Fri, 10 Jan 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508207; cv=none; b=jAihDZE6HpkP4S2vD37wsY47L1gjeNhS90LMEV7PjPVLad+4kkq2TAyGH8Ba2+IjYeyDHioVQ/ULk6mcK6JWeofDg3QJQw7wO7pKbpJqxIGCAN2RHV2xMl76/cNyF59WnarqtlTjpvFuvEJivlesvSw5z414qPqc/Q6BnSiB/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508207; c=relaxed/simple;
	bh=KlB2n0papsrbB6sk08QJS5YN5JfXu+H+SiMqh9K6uaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjHYIIuWolFtHlkBWiB9qXNDnyNj2DzOAhNFCGUYyFdsEG3+2uN8jPYi/t1gPdQJv+V4WHqzvIb2V8dkLjeITF2/R8xaVQ7rXnE/A9Ox2dEevEBybqLg9hEWA1O2Z6knQnb3NlwYC86dsE/qFLm5V4pxjDU4bZi7yicRcGwUsTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH8Bhyjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH8Bhyjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FD1C4CEDF;
	Fri, 10 Jan 2025 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736508206;
	bh=KlB2n0papsrbB6sk08QJS5YN5JfXu+H+SiMqh9K6uaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kH8BhyjyWMOOHTum/u+jv1OvOU5fWSm16S0HR+JgOUY2zCRkVADB/VAtU9d5gKaIW
	 kr1gHQ7dUAO5efeUJ7XyUeRG49IOiAHVpwsI/vBx6pqHmxcjlyajejpmX4yIgy6Pos
	 7lHsuslEauShd8KHM23jpgWasLPJxdhoVDnt6iqoQ9oPhbd+Qn76T68tlYNwG4DFXc
	 4oWathpCDWTfilwHpBfZUAcHYLsi2dPi/t7e+jC1cOhhyZ0kQN+RNnk9SvKWIKRq8T
	 TnFV4w2s3GJCzlS1Lq134ZxMU4zAaybrJGM+n3JxUV1GYZpJtfwjy2DYvf9evpdhGB
	 cj2x6rzgKKgEw==
Date: Fri, 10 Jan 2025 12:23:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ahci: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Message-ID: <Z4EDKUb+hO0ovV2i@x1-carbon>
References: <20250109175427.64384-1-rgallaispou@gmail.com>
 <07a7177d-7705-4eb5-a11e-02a9429ffac2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a7177d-7705-4eb5-a11e-02a9429ffac2@kernel.org>

On Fri, Jan 10, 2025 at 02:19:06PM +0900, Damien Le Moal wrote:
> On 1/10/25 02:54, Raphael Gallais-Pou wrote:
> > Letting the compiler remove these functions when the kernel is built
> > without CONFIG_PM_SLEEP support is simpler and less error prone than the
> > use of #ifdef based kernel configuration guards.
> > 
> > Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> > ---
> > Changes in v2:
> >   - Split serie in single patches
> >   - Remove irrelevant 'Link:' from commit log
> >   - Link to v1: https://lore.kernel.org/r/20241229-update_pm_macro-v1-4-c7d4c4856336@gmail.com
> > ---
> >  drivers/ata/ahci_st.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> > index 6b9b4a1dfa15..4336c8a6e208 100644
> > --- a/drivers/ata/ahci_st.c
> > +++ b/drivers/ata/ahci_st.c
> > @@ -176,7 +176,6 @@ static int st_ahci_probe(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > -#ifdef CONFIG_PM_SLEEP
> >  static int st_ahci_suspend(struct device *dev)
> >  {
> >  	struct ata_host *host = dev_get_drvdata(dev);
> > @@ -221,9 +220,8 @@ static int st_ahci_resume(struct device *dev)
> >  
> >  	return ahci_platform_resume_host(dev);
> >  }
> > -#endif
> 
> I do not think you can remove the ifdef here. Otherwise, there is going to be a
> compilation warning when CONFIG_PM_SLEEP is not enabled. No ?

Look at the pm_sleep_ptr macro:
include/linux/pm.h:#define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))

I would expect the function should be optimized out by the compiler
using dead code elimination.

Raphael, perhaps you could show the before and after output
using ./scripts/bloat-o-meter ?
(When the config is not enabled: before and after your patch.)


> 
> >  
> > -static SIMPLE_DEV_PM_OPS(st_ahci_pm_ops, st_ahci_suspend, st_ahci_resume);
> > +static DEFINE_SIMPLE_DEV_PM_OPS(st_ahci_pm_ops, st_ahci_suspend, st_ahci_resume);
> >  
> >  static const struct of_device_id st_ahci_match[] = {
> >  	{ .compatible = "st,ahci", },
> > @@ -234,7 +232,7 @@ MODULE_DEVICE_TABLE(of, st_ahci_match);
> >  static struct platform_driver st_ahci_driver = {
> >  	.driver = {
> >  		.name = DRV_NAME,
> > -		.pm = &st_ahci_pm_ops,
> > +		.pm = pm_sleep_ptr(&st_ahci_pm_ops),
> >  		.of_match_table = st_ahci_match,
> >  	},
> >  	.probe = st_ahci_probe,
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
