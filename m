Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691DE298C10
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313990; cv=none; b=Gl1O3h9G1I7z6hAoJS4uOzBhzef9ttQE7jtlwfszOcpFw+uGGq730Apyr65zxo3A4NF7OtbBdt4BHhh4wByefD8946Ox21WMxNVhieit+ZEWoIDbiYvYUo3idUKvv8iv8Aj2VteWZHiNmq3q9KNftp/hWnoajJCa6qRajQJPKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313990; c=relaxed/simple;
	bh=4FLrBKRo9xobILlhmDrys7Scn69sF6Wl0Cv2xdwPB2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szmijS4NLTaa02FblWaV7tcW6mtORGlLdTGCCa0VUzPUzzNIcU40jcfYJo+qkeY3haLVBLjkPseWQnjkJwY0Vp6NP4tbbIrF/Qdk8wHS1HCRDu2g/XBc8uFkSNKGiiwTsOUl28zIIMR5N6UaS/hvKPndDu0GfzzbiLOf55NMoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj72873j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj72873j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63C6C4CEF2;
	Thu, 15 May 2025 12:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313989;
	bh=4FLrBKRo9xobILlhmDrys7Scn69sF6Wl0Cv2xdwPB2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lj72873jFfn8uA7PgWAtf4tqc7RRuh6DMi6tTxS5o9BhmjeWeKuz7ydLTQuL6GRvU
	 5Ozhkvc7Rg0pQhzmNxvy4bm3LU+VI8Mhoj/yVIbWdll4jZrbtYOmiTDxr6GjaS6fCf
	 86F26ojKKQqsHYpNwg5fVjQP10sQpwYp/OH2Nq9t340RJ+2uO2CEL2IQFX47BdTNr0
	 TjjCh9arn3UXFBnPNVFWT1z4hdaSWe5ogXYhh+LbiSVHJlLT2yd0fi0CN/7RYMA4R3
	 CLEPyfc9z4FLBHmfYAPvF44zxIAYEiY3+q4BGftol1RJmr4BbyfYBuehnMkb+OemyG
	 bITNZ0hnx/d1w==
Date: Thu, 15 May 2025 14:59:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 7/7] ata: libata-eh: Always disable DIPM before calling
 set_lpm() callback
Message-ID: <aCXlQshOdNa96Js3@ryzen>
References: <20250514172210.383801-9-cassel@kernel.org>
 <20250514172210.383801-16-cassel@kernel.org>
 <840a1671-997f-45e4-af25-03f702bad237@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <840a1671-997f-45e4-af25-03f702bad237@kernel.org>

On Thu, May 15, 2025 at 02:42:17PM +0200, Damien Le Moal wrote:
> On 5/14/25 19:22, Niklas Cassel wrote:
> > The current code performs a SET FEATURES command to disable DIPM if
> > policy < ATA_LPM_MED_POWER_WITH_DIPM, this means that it will disable
> > DIPM for policies:
> > ATA_LPM_UNKNOWN, ATA_LPM_MAX_POWER, ATA_LPM_MED_POWER
> > (but not for policy ATA_LPM_MED_POWER_WITH_DIPM).
> 
> [...]
> 
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index 91d97d98eed1..1727248f135d 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -3473,7 +3473,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
> >  			hints &= ~ATA_LPM_HIPM;
> >  
> >  		/* disable DIPM before changing link config */
> > -		if (policy < ATA_LPM_MED_POWER_WITH_DIPM && dev_has_dipm) {
> > +		if (dev_has_dipm) {
> 
> This changes the same line that patch 6 changed... Can you squash these patches
> together ?

It is two separate logical changes, so squashing them seems wrong IMO.


Kind regards,
Niklas
