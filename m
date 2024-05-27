Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11347F5F
	for <linux-ide@vger.kernel.org>; Mon, 27 May 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798309; cv=none; b=c84kxQOPZ/W5GKebsdLC29lu/xeB78ZkJZIBjdNhgMZjDuOZ1VaoDgF2xgjD0egqcC1u7m0SkMxtHW3hZBZhqQyADWJdmmFgBjYqkc3kq5OnVZ4EbyiTTCqNhl71gxnFoJGR+7K1P8taQsIIFf4sbxecJcdISVxt4rfpHZ+/aRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798309; c=relaxed/simple;
	bh=ZUoAgBLjie4QAjUkFpVD3ghr/uKbqQMmZihpK/AanJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2+0lz4jaAvm6lJJfES+YFWebtl3cB/FYFJ6XFS4H88NqohNElZBSyM60Bm8HoEMNIA8EsCf0mxCtvhdoAfJdrNzye0QGaXIAxXzRccss68Kqta+Bm8BdUmWOIt6g3hiEg2VX9QJUejk+wWNspKekR5IiwNNd5/i3BhQazPvAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvJo6djl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvJo6djl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55083C2BBFC;
	Mon, 27 May 2024 08:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716798309;
	bh=ZUoAgBLjie4QAjUkFpVD3ghr/uKbqQMmZihpK/AanJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvJo6djldG4BqJqcdPCoPTnBK+1GMq61BtIJqymauwkkOBDkqd9qTwuYjZu8N/vWm
	 /yq8Glz5X/A0Ln0wWn3KheKad7W6gVtenEmkMFM6ALhduGEBo5jTMCQUi0PV6mRlSy
	 RYt0/mfcME7N/WiqbA0t2jJ27pdDbg5ZjGPo4VfsFTV7KRtnRtimQ/qivwUEVjeKTu
	 YIAfrzJBXKHHMEaMKUg7vPtYyOYawAGNInJycuiqsHTMcCt7LxQ++S5QHlgYEquVnC
	 k312RyucB+iZH5gqdAKntOZ00CeOG617UeNmmfUayjSC86M149GjKBjNoHbKnJZUv+
	 I5lp7xTMcQT1A==
Date: Mon, 27 May 2024 10:25:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: Kconfig: Update SATA_MOBILE_LPM_POLICY default to
 med_power_with_dipm
Message-ID: <ZlRDYUjYmFLoisgn@ryzen.lan>
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

Could you please give an explicit Acked-by / Reviewed-by ?


Kind regards,
Niklas
