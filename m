Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB93B5821;
	Tue, 28 Jul 2026 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242272; cv=none; b=ZstPP0UsZns7zu9HUvT83mQ+03f8ONesSBv3UDKpnB5b98nPXlfCu5Ud5odzGkg7k2A/t6+unsVprEI5c3QHiQWshWPeR+DHGCfw3ES6taIbkTWKsrUzfilHZH82GY4XYSSkqykd1KStXcFof1ofNqDRNP0QpiDrjwmXOD4+oUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242272; c=relaxed/simple;
	bh=DX637y4KDCFEN1cOsV5Z70OhhhXzj8mo0h3cR/A3V+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnYWUw1GBizJFhM46lh5PmK4zUkemBDnTpXP5XrRGvZFLHVKa9Pc/toz4DyhJQK4T/btlONSlMQjOsK64UmGuPl+ghaWP6kwiXOE05OMMRVU0FFUJS3yHWUOVgHqxjffqEHMgte0CsQOWwng2FVWUYAeHt9Jg6YnDRc35lS489c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVoRoJ2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVoRoJ2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987531F000E9;
	Tue, 28 Jul 2026 12:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785242270;
	bh=UiXW4rbegDHRy0YBZonSLv4tj6oDq4B0rezonfp4rvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FVoRoJ2zxneGsNJhQOI9ChRmxvo95TsmmH+bvQm4EGCNs8wSOvYSXSUcKQu/xgwVj
	 3TS2gOPVGbZjAsqJeH5QHR2wNVEAonmDKHL1qhLYJPyELsxa+9MDxDpM5ISZqCE6Sy
	 yYGrZGY+b5IZsqJrer5VLPgjCKJQAlK/dfOr2YSKAxRohzwKxJPTQIGkss4OOiPhlt
	 3MWDiTiqCUEyDnxR95DAeLfoBlPh/w4m+mPHCSfJlGMSQyvelbUivp2VhWII5rbSPS
	 5A9ntbDk1oYQtCYsaeFXEOijiZFwZTs1CQ0zWTVBNBG1ga1KLW47RpHQQvDkzsVDyL
	 ZNBkN4ctIB6Ew==
Date: Tue, 28 Jul 2026 14:37:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-sata: fix ata_scsi_lpm_supported() iteration
Message-ID: <amiim2eAvrpsTAvp@ryzen>
References: <20260728113841.727256-2-cassel@kernel.org>
 <20260728115336.9B4861F00A3D@smtp.kernel.org>
 <amidnlBAeJOks4cw@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amidnlBAeJOks4cw@ryzen>

On Tue, Jul 28, 2026 at 02:16:30PM +0200, Niklas Cassel wrote:
> On Tue, Jul 28, 2026 at 11:53:36AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] ata_scsi_lpm_supported() skips checking devices on the slave link because it uses the ATA_LITER_EDGE iterator. This allows userspace to enable Link Power Management (LPM) on a port where the slave device does not support it (has ATA_QUIRK_NOLPM).
> > --
> > 
> > --- Patch [1]: [PATCH] ata: libata-sata: fix ata_scsi_lpm_supported() iteration ---
> > commit 32bd728de2e1b6025504205f3ade16813231e703
> > Author: Niklas Cassel <cassel@kernel.org>
> > 
> > ata: libata-sata: fix ata_scsi_lpm_supported() iteration
> > 
> > This commit fixes the inner loop of ata_scsi_lpm_supported() to iterate
> > over the specific link being evaluated rather than always using the host
> > link. This prevents the LPM policy from being incorrectly applied or denied.
> > 
> > Link: https://lore.kernel.org/linux-ide/20260728112200.B99F21F000E9@smtp.kernel.org/
> > 
> > > diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> > > index b0706c30da052..ad40f516c6d43 100644
> > > --- a/drivers/ata/libata-sata.c
> > > +++ b/drivers/ata/libata-sata.c
> > > @@ -913,7 +913,7 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
> > >  		return false;
> > >  
> > >  	ata_for_each_link(link, ap, EDGE) {
> > > -		ata_for_each_dev(dev, &ap->link, ENABLED) {
> > > +		ata_for_each_dev(dev, link, ENABLED) {
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does using the ATA_LITER_EDGE iterator
> > here in ata_scsi_lpm_supported() skip checking devices on the slave link?
> > 
> > Since the EDGE iterator skips ap->slave_link, it appears this loop misses
> > devices on the slave link that might have the ATA_QUIRK_NOLPM quirk.
> 
> Well,
> 
> 1) slave_link is only for PATA.
> 
> Yes, I know that two sata drivers abuse this:
> drivers/ata/sata_sis.c:                 rc = ata_slave_link_init(ap);
> drivers/ata/sata_via.c:         ata_slave_link_init(host->ports[i]);
> 
> 
> 2) The call to ata_eh_link_set_lpm() is protected by:
> 
> libata-eh.c:ata_eh_recover()
> 
> if (link->lpm_policy != ap->target_lpm_policy) {
> 	rc = ata_eh_link_set_lpm(link, ap->target_lpm_policy, &dev);
> }
> 
> And the only driver that sets ap->target_lpm_policy is AHCI.
> 
> So, I don't think we need to care about the slave link in this case.

I guess theoretically, if someone uses a:

sata_sis or sata_via, and forces LPM enabled via sysfs, even though it is
not supported/initialized by any driver other than AHCI... I guess the
drive might become unresponsive.

But, looking at these drivers, they don't provide a .set_lpm() callback,
so I don't see how that could actually happen.


There is another driver however, that does have a slave_link:
drivers/ata/ata_piix.c:                 rc = ata_slave_link_init(ap);

And which does have a .set_lpm() callback:
drivers/ata/ata_piix.c: .set_lpm                = piix_sidpr_set_lpm,


So I guess perhaps this problem could happen on ata_piix - which seems to
be a driver for Intel PATA/SATA controllers.

From a quick look, it seems like
ata_piix.c calls ata_slave_link_init() only if:

if (ap->flags & ATA_FLAG_SLAVE_POSS) {
	rc = ata_slave_link_init(ap);
}



And:
PIIX_PATA_FLAGS         = ATA_FLAG_SLAVE_POSS,
PIIX_SATA_FLAGS         = ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,


And all board definitions using PIIX_PATA_FLAGS seems to have pata_* in
their name, so I still think we can ignore this Sashiko comment.


Kind regards,
Niklas
