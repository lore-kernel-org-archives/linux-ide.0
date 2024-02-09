Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BB3771E
	for <linux-ide@vger.kernel.org>; Fri,  9 Feb 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485176; cv=none; b=bUYpQ/tb3pMn/4jrx9ZUp3LX5ShpGqWkxo2L1y+qJYVco8qBxwir2aa0xYHD3thqX1VYj9OFLvbCmvLhnAV852q7pMWf3sUaP5ItoaIcWM4MfegPOlXPUnU0uwiz6gVqhXR6J82uyjf7eHmhYWiysl1O4wdae3EqMcvfynTWwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485176; c=relaxed/simple;
	bh=tiXxkEPbqNJpqM3jlbbysrnKqhDkHRmskamnYR0wRT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsSOqlecENutj1w2UsguEJPhaxeAq09Yrrhi5PFjoi4C+Xwl8m4hiwDiVi8ce8QDwi2lc6hfs+b5UfeOfcESiqBzl673ldFqdnYCoW1h19g9kSL0adggpWD4dkZbq5qGs8gncCO858Pc20EbV+qztiyDfhguy1UstNRIXq0+Lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbgdT7gp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbgdT7gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A19C433C7;
	Fri,  9 Feb 2024 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707485176;
	bh=tiXxkEPbqNJpqM3jlbbysrnKqhDkHRmskamnYR0wRT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbgdT7gpa2gBp52+/0uqSe+MTNiLSy7oRYOJ0pWFGlyAtqZIYPBl+dx39/ExApZ0J
	 cbHq/VuSRVhouuNuBZ01daZnsSwOpRJMdfdnLBTRkbuce8A+4bZfRwRNfLAGt/sMGB
	 SuTR8qpxxsTpkn4W4ILJTFtdmMbwriouuPIqhXXnq2WNkw1Y+40FthBQiuH4jFj9+5
	 /m87BbwcBV+zuubVKHmSxKy2JJwpFV7jC4EnH1ww/3UPu58tmh8AqitOw/B+bnhGAm
	 24uTwg+vwnhDVf7bnOswM1qjYKqKJmt488QPUz7Xk31d7NJvB0OzF2IJBBh71ySYct
	 GPhCZRURzT5tw==
Date: Fri, 9 Feb 2024 14:26:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: document and clarify unconventional intel quirk
Message-ID: <ZcYn8y5GYMJ+7tLF@x1-carbon>
References: <20240207091054.1697236-1-cassel@kernel.org>
 <65c578b054868_5a7f294a5@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65c578b054868_5a7f294a5@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Feb 08, 2024 at 04:58:24PM -0800, Dan Williams wrote:
> Niklas Cassel wrote:
> > The ahci_intel_pcs_quirk is unconventional in several ways:
> > First of all because it has a board ID for which the quirk should NOT be
> > applied (board_ahci_pcs7), instead of the usual way where we have a board
> > ID for which the quirk should be applied.
> > 
> > The second reason is that other than only excluding board_ahci_pcs7 from
> > the quirk, PCI devices that make use of the generic entry in ahci_pci_tbl
> > (which matches on AHCI class code) are also excluded.
> > 
> > This can of course lead to very subtle breakage, and did indeed do so in:
> > commit 104ff59af73a ("ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"),
> > which added an explicit entry with board_ahci_low_power to ahci_pci_tbl.
> > 
> > This caused many users to complain that their SATA drives disappeared.
> > The logical assumption was of course that the issue was related to LPM,
> > and was therefore reverted in commit 6210038aeaf4 ("ata: ahci: Revert
> > "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"").
> > 
> > It took a lot of time to figure out that this was all completely unrelated
> > to LPM, and was instead caused by an unconventional Intel quirk.
> 
> Ugh, sorry about that.

Out of most bad things come something good :)

I've been reading up on LPM in SATA + AHCI specs because of this,
so some of the patches related to LPM probably wouldn't have been
submitted if it wasn't for this :)


> 
> > 
> > While this quirk should definitely be cleaned up to be implemented like
> > all other quirks, for now, at least document the behavior of this quirk.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217114
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/ata/ahci.c | 27 +++++++++++++++++++++++----
> >  1 file changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index da2e74fce2d9..122278438092 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -69,8 +69,8 @@ enum board_ids {
> >  	board_ahci_vt8251,
> >  
> >  	/*
> > -	 * board IDs for Intel chipsets that support more than 6 ports
> > -	 * *and* end up needing the PCS quirk.
> > +	 * board IDs for Intel chipsets that should NOT have the
> > +	 * ahci_intel_pcs_quirk applied. Yes, this is not a typo.
> 
> I am not sure if this wording helps the next person without the context
> of this patch. How about this?
> 
> /*
>  * NOTE NOTE NOTE this board id is identifying a point in history where
>  * the "PCS Quirk" from 2007 should *stop* being applied to more modern
>  * platforms. So this is a "stop-quirk" point and board_ids >= to this
>  * value do not run the quirk, see ahci_intel_pcs_quirk() for details.
>  */

The amout of comments needed to describe how "out of the ordinary"
something is, is probably a sign that you should just do a proper
cleanup instead, so that is what I decided to do:
https://lore.kernel.org/linux-ide/20240209130307.39113-1-cassel@kernel.org/

So feel free to review that one instead :)


Kind regards,
Niklas
