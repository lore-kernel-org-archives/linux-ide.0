Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3319CD16
	for <linux-ide@vger.kernel.org>; Mon,  9 Jun 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483825; cv=none; b=qsQcuxKSme9/Lv/6ftaiCg/gGHjnCOB362CXDz18jTyjDelgIEkk63qLw/KYYbbqtTSftoHD1Hoy5ehVzLY9NaTs/DM3047gEVcP/lWKMYAHJeln1/ks/GLZv5UXsTNu0lrk615SWC9gMxamFugrpZkAmiRKZD6pt7d1X1v9tco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483825; c=relaxed/simple;
	bh=SPYUU/FAcF4/kJDjBI4E7oXouhdHA30mYcI+YTl4+ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJXnuedeeSCAJwkujm69ChsvCbRXh/tpCA8V4Ew2q8Px0c50yAg9fpMDqsoKo+Tu/3F9XJG61bKb93rnuMkhkWbxlncqYjrd6w0n/50eW3oQ71qd3Nows7f/QJ6CkZF2IX6r93HOBXRDIwHuulKCt8TZfloeNPIiYb0daReLJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNVJQugo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNVJQugo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CEFC4CEEB;
	Mon,  9 Jun 2025 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749483824;
	bh=SPYUU/FAcF4/kJDjBI4E7oXouhdHA30mYcI+YTl4+ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNVJQugo3Vaxc8Z9LKndztH/XQylgx3aw4S3jeYClx37IspmAPYSFDoOqZ74WAuY2
	 zy9UixjdOMEQbezxS0yXIxFQ+TTWLXHokk0K/N57fwS1iA6UwEkCjIQSmCepQmrlXJ
	 iPGOp5QgUVaXQbVXYyTwerXtzE9k6IPhgiW/Y+17fsInxbeNRMOUxrYfDjUSGU/v0S
	 79PlrUdKWlaSqJ2uKdn6JDH/YxKnu0xTvb2rVBXswHS8gScsqUTiiANll0zWgP9RIl
	 R4Nr0DNU8OAuv/WrdyO48b7gJPBNfb9nSQjDdfwMugB1B1tJ/qWuAbA3cqFFSacKMv
	 TsQtZAFJ2787w==
Date: Mon, 9 Jun 2025 17:43:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, kernel-dev@rsta79.anonaddy.me,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] ata: ahci: Refactor ahci_broken_lpm()
Message-ID: <aEcBLKZ91sZXTBzd@ryzen>
References: <20250609134539.943587-3-cassel@kernel.org>
 <6ea509c8-b38d-4941-8a29-c1117ff3dd5b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ea509c8-b38d-4941-8a29-c1117ff3dd5b@redhat.com>

Hello Hans,

On Mon, Jun 09, 2025 at 04:49:17PM +0200, Hans de Goede wrote:
> On 9-Jun-25 3:45 PM, Niklas Cassel wrote:
> > Currently, the match table in ahci_broken_lpm() contains DMI BIOS dates
> > of BIOSes that are known to be working.
> > 
> > Having a list of known to be working versions is usually the wrong way to
> > do things (as this list could theoretically be infinite).
> > 
> > Refactor this match table to contain DMI BIOS dates of BIOSes that are
> > known to not be working, such that this list can be extended with BIOS
> > versions (for other boards) that are known to not be working, where there
> > is no good BIOS version (because all released versions are broken).
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/ata/ahci.c | 34 ++++++++++++++++++++++++----------
> >  1 file changed, 24 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index 163ac909bd06..a6ce172fa928 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -1411,27 +1411,39 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
> >  static bool ahci_broken_lpm(struct pci_dev *pdev)
> >  {
> >  	static const struct dmi_system_id sysids[] = {
> > -		/* Various Lenovo 50 series have LPM issues with older BIOSen */
> > +		/* Table contains DMI BIOS dates of BIOSes with broken LPM. */
> >  		{
> >  			.matches = {
> >  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X250"),
> >  			},
> > -			.driver_data = "20180406", /* 1.31 */
> > +			/*
> > +			 * 1.31, released 20180406, has working LPM, mark any
> > +			 * DMI BIOS date before that as broken.
> > +			 */
> 
> Note the DMI_BIOS_DATE field is the data the BIOS was build, I would avoid
> the word "released" here since release-notes doucments often contain different
> dates then the actual build date (e.g. see below).

Hm... the command to get this date is:
$ dmidecode -s bios-release-date

So in one way, I think this is the correct term.

But indeed, the "release date" in the release notes is usually different
from the "dmidecode -s bios-release-date" date, so perhaps just to avoid
confusion, using "build date" rather than "released"/"release date" is a
good idea.


> 
> > +			.driver_data = "20180405",
> >  		},
> >  		{
> >  			.matches = {
> >  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L450"),
> >  			},
> > -			.driver_data = "20180420", /* 1.28 */
> > +			/*
> > +			 * 1.28, released 20180420, has working LPM, mark any
> > +			 * DMI BIOS date before that as broken.
> > +			 */
> > +			.driver_data = "20180419",
> >  		},
> >  		{
> >  			.matches = {
> >  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T450s"),
> >  			},
> > -			.driver_data = "20180315", /* 1.33 */
> > +			/*
> > +			 * 1.33, released 20180315, has working LPM, mark any
> > +			 * DMI BIOS date before that as broken.
> > +			 */
> > +			.driver_data = "20180314",
> >  		},
> >  		{
> >  			.matches = {
> > @@ -1439,12 +1451,14 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
> >  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W541"),
> >  			},
> >  			/*
> > -			 * Note date based on release notes, 2.35 has been
> > -			 * reported to be good, but I've been unable to get
> > -			 * a hold of the reporter to get the DMI BIOS date.
> > -			 * TODO: fix this.
> > +			 * Note: according to release notes, version 2.35 has
> > +			 * working LPM, but we do not have the DMI BIOS date for
> > +			 * this version, so the date, 20180310, is based on the
> > +			 * release notes. Mark any DMI BIOS date before that as
> > +			 * broken.
> > +			 * TODO: find with date with DMI BIOS date.
> >  			 */
> > -			.driver_data = "20180310", /* 2.35 */
> > +			.driver_data = "20180309",
> 
> This reminds me that I did eventually got the actual BIOS date from
> the reporter. After some digging I managed to find the email.
> 
> The first known working BIOS has a BIOS date of 04/09/2018 so that
> would become "20180409" before your patch / "20180408" after your patch.
> 
> I guess you may want to add a prep patch before the rest of this
> series before this patch to make things a bit cleaner.

Thank you!

I will send a V2 with the proper date as a patch 1/3.


Kind regards,
Niklas
