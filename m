Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA83153814
	for <linux-ide@vger.kernel.org>; Mon,  6 May 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011893; cv=none; b=sKgqiZPC0a7ctZWIG44QFUIyZvjvRVUzqEvvDBjQqYxxPVGtmwsj5404Wte2VInFdVovwq2hh8T93WRT7iLijeBp8rcxSOpy00V5ToFS4NO8Ai1G+6B8UJSDPuB+UZvQvTXeeo8AVhmxtNdGIe2CM3IazuChDfT7DcLByeY4EBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011893; c=relaxed/simple;
	bh=U6UBu8TIBTbqCM6j7g+IAB9odGRHsKkqLwfG2k+Dj/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKPzvqh/CbWnl9/xv+znYp5NibGmtyFqZy8dPx0UXiubb7Guy2bX3ZdlhC4ZR9Lq/GTtFIwspaYDYJHtsOFg/SUj9M86sQ0W5zoDTeH/DjFRi96MhxAmfKuCENdhqm+oZUgi6fGdRSSWt0nsdxCYAkvH5mFE3taG2+WZNlZzsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irzwGMkC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irzwGMkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D4BC116B1;
	Mon,  6 May 2024 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715011893;
	bh=U6UBu8TIBTbqCM6j7g+IAB9odGRHsKkqLwfG2k+Dj/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=irzwGMkCV1Jd3vkYfTEyfi2+eSS1M1BmpME2nR+lcQPDD06fkSDk67gewI6vrtS0B
	 gZGCZiw/kM8CyeXuzUaYqe8z90JhNH9JYfsGZ0dnxj/FY98BLuw2qa7QeDtLJ+AXG6
	 getQ9iOfqvFkVRr+y+1k6QKc3rargEIrLHXIa5CKeF4L5a4oxAei+DTjF5coMzQTuR
	 QF4Ee0f9ZcnEqGeewgLfljHqSVH27hoB3ShxzdJqyGi0yEofbpQtWXAebi+v0hJQ5M
	 ZIOLhHhfcDDbEwFltsVoiPg6kJBivySxRvdR1IhkqStR76HPJbgbi4+n1h34gY9v9r
	 vFHnH0zTyzMJQ==
Date: Mon, 6 May 2024 18:11:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: Kconfig: Update SATA_MOBILE_LPM_POLICY default to
 med_power_with_dipm
Message-ID: <ZjkBMED6zXGk9B4v@ryzen.lan>
References: <20240502092652.450831-2-cassel@kernel.org>
 <40e63d1c-09d8-48b8-b08d-6f4be64013ff@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40e63d1c-09d8-48b8-b08d-6f4be64013ff@kernel.org>

On Thu, May 02, 2024 at 06:40:11PM +0900, Damien Le Moal wrote:
> On 5/2/24 18:26, Niklas Cassel wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> > 
> > Historically this was set to "keep_firmware_settings" to prevent problems
> > with power management on very old drives. However it's been observed that
> > almost all modern Linux distributions either set the policy to
> > "med_power_with_dipm" in the kernel configuration or update it to this via
> > userspace policy changes. Update the policy default in the kernel to
> > "med_power_with_dipm" to match that behavior as well.
> > 
> > Changing the default was previously not a good idea, because LPM disables
> > detection of hot plug removals, however, since commit ae1f3db006b7 ("ata:
> > ahci: do not enable LPM on external ports"), a port marked as external
> > will always be initialized to "keep_firmware_settings", regardless of the
> > SATA_MOBILE_LPM_POLICY Kconfig value. Therefore, changing the default is
> > now considered safe (external ports included).
> > 
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > [cassel: rebased and reworded commit message]
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/ata/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index b595494ab9b4..e00536b49552 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -118,7 +118,7 @@ config SATA_AHCI
> >  config SATA_MOBILE_LPM_POLICY
> >  	int "Default SATA Link Power Management policy"
> >  	range 0 4
> > -	default 0
> > +	default 3
> >  	depends on SATA_AHCI
> >  	help
> >  	  Select the Default SATA Link Power Management (LPM) policy to use
> 
> I am OK with this change. However, for this one, given that we already are at
> mid-rc6, I really would prefer waiting for next cycle to have this spend more
> time in for-next testing. So let's apply this once 6.10-rc1 is out.

Sounds good to me.


Kind regards,
Niklas
