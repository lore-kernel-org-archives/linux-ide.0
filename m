Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051C41D659;
	Tue, 28 Jul 2026 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240995; cv=none; b=IzaLNCtcI9B0lj44gi8nktJPrDyzpI/AdrO3Nb4elVuv8tHyx9QU/6FUfsvh7kWFCgeXUpFUeqEppY6Zw/bEzi5YCr4Rj/TK6/4PDeiDHRXmAWU+69vj9affK30P8YItDYS2yV/V+7u/6SaF6y2Zijcxo49GfygCEMCpjTaEusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240995; c=relaxed/simple;
	bh=PBX+t+ETDdnWhw8cgSie+4r4sEkRAa0OjlzODL+0DTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riNzu4NwNTr2HMDJcaNpXOv/PF+1J2cinPkv0hg+Y+ua7szPZgwiUyD3SqWFXNIOlVH/SdPOSMuE5Nr4nFmt8komtIP0YBXdxe16f1+fG+QEg2hOgEGERwBkF3x1ea9RktDBdoNLV5zUdbgb6UiV1YV5tnQxtouKEsoKm9knMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyrWQv3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyrWQv3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689591F000E9;
	Tue, 28 Jul 2026 12:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240994;
	bh=sCpVF3SmGcSjqHowpdgiYHbQTO+UhVEKagl7dXUAdeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LyrWQv3gDpdB0nVXc48lDQ+/Qc8d/OUg44VaOhZJWNGdt6MMNVeaHIKvQCv3jTRM/
	 hzMEjJnNkiM9uIfj7xgUOQ4O7N9RFogRSdD4mRFqdECMRjjxZcXzstxd8YDTOujyb9
	 HoABXAMADA9RR93zMceD6BQJDo5FnN0wLS03H5ppEQEHIT2+dFGDnl0WLJRwVNBjpb
	 GA8IRTV4ISsaCykcE3UQjVGqIplfbYZeu2vNWJFSJcZWhFKrQl9tL2SmXZkV+Pz5tx
	 iMQGTskCE1McrS/tlYXiBIVKqphuRbdbTe3d6wxjB1/K/kmYh354yVZ1Z3BfsvYPcZ
	 Ee6qO4CPE5TNg==
Date: Tue, 28 Jul 2026 14:16:30 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-sata: fix ata_scsi_lpm_supported() iteration
Message-ID: <amidnlBAeJOks4cw@ryzen>
References: <20260728113841.727256-2-cassel@kernel.org>
 <20260728115336.9B4861F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728115336.9B4861F00A3D@smtp.kernel.org>

On Tue, Jul 28, 2026 at 11:53:36AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] ata_scsi_lpm_supported() skips checking devices on the slave link because it uses the ATA_LITER_EDGE iterator. This allows userspace to enable Link Power Management (LPM) on a port where the slave device does not support it (has ATA_QUIRK_NOLPM).
> --
> 
> --- Patch [1]: [PATCH] ata: libata-sata: fix ata_scsi_lpm_supported() iteration ---
> commit 32bd728de2e1b6025504205f3ade16813231e703
> Author: Niklas Cassel <cassel@kernel.org>
> 
> ata: libata-sata: fix ata_scsi_lpm_supported() iteration
> 
> This commit fixes the inner loop of ata_scsi_lpm_supported() to iterate
> over the specific link being evaluated rather than always using the host
> link. This prevents the LPM policy from being incorrectly applied or denied.
> 
> Link: https://lore.kernel.org/linux-ide/20260728112200.B99F21F000E9@smtp.kernel.org/
> 
> > diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> > index b0706c30da052..ad40f516c6d43 100644
> > --- a/drivers/ata/libata-sata.c
> > +++ b/drivers/ata/libata-sata.c
> > @@ -913,7 +913,7 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
> >  		return false;
> >  
> >  	ata_for_each_link(link, ap, EDGE) {
> > -		ata_for_each_dev(dev, &ap->link, ENABLED) {
> > +		ata_for_each_dev(dev, link, ENABLED) {
> 
> [Severity: High]
> This is a pre-existing issue, but does using the ATA_LITER_EDGE iterator
> here in ata_scsi_lpm_supported() skip checking devices on the slave link?
> 
> Since the EDGE iterator skips ap->slave_link, it appears this loop misses
> devices on the slave link that might have the ATA_QUIRK_NOLPM quirk.

Well,

1) slave_link is only for PATA.

Yes, I know that two sata drivers abuse this:
drivers/ata/sata_sis.c:                 rc = ata_slave_link_init(ap);
drivers/ata/sata_via.c:         ata_slave_link_init(host->ports[i]);


2) The call to ata_eh_link_set_lpm() is protected by:

libata-eh.c:ata_eh_recover()

if (link->lpm_policy != ap->target_lpm_policy) {
	rc = ata_eh_link_set_lpm(link, ap->target_lpm_policy, &dev);
}

And the only driver that sets ap->target_lpm_policy is AHCI.

So, I don't think we need to care about the slave link in this case.


Kind regards,
Niklas
