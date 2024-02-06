Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088E1BF3B
	for <linux-ide@vger.kernel.org>; Tue,  6 Feb 2024 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255978; cv=none; b=W3zfRvuHzdFurnSb8KolZMFNOLCx7mgQBCLNjKYAbGSUagvqaOPEdb/+wvDri1o21JfHs3UwscPgHTqkXm09q8BqccQhBo3wZZw1Qv/x2/sCuxHLNEt81jOx80KGJF/kTMt0mmwZX9MZlNyb4wl/Xj4kYWrSWraRyU/HL/e44SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255978; c=relaxed/simple;
	bh=cmylb/eYAokLZlvsYFfn4CZoKW9DTuzpopMJVvGm9sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRxrn/6QR2sUSWblh4zpe/fKWGZ84RwCTWiPNSgM4Lrr7u9A35UKHCicpOSgwDbjQlQ5Mwaa0BtlClgRt5gtVBGAOycdfI6EUSLhJmw9nLaYSzLKCOG5x01ShoNOtQymbLZ56qxeC2N8ebZAmpIHUyhVRxMt9UG/6+wEYxIsav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl6js1IG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl6js1IG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F85C433F1;
	Tue,  6 Feb 2024 21:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707255977;
	bh=cmylb/eYAokLZlvsYFfn4CZoKW9DTuzpopMJVvGm9sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bl6js1IG5mosa4xRwZelHVGcmsZL92sWk4+nCIeyCSSuBpWIfu2sn45ddGlcG2Tvn
	 /VePUHWS4V4tJz42hRUNGzX9uDoM8nnDRfRqaBECJA6KLmPy+EBGwXpwBK/bboqRrO
	 YwY1QZImknHmJIvGcfIbVJof9ZtNORd32Ik1DZVmXRWZT5SdHw6D1sLjmPgqfDrLBn
	 MFv/ijctSUNk+tSEnhRsoN0prSzGoujQ3We8ZrabZccdOiIlXDxTicf2QonTbg2sOJ
	 mMw1Y9TGbDpbzmNuJG6Dx/RvEDNyaQ1WGZ2smSmrI96TUMi3bEI4qwXXoMIJfgqSvG
	 PBhIqFaCukWUQ==
Date: Tue, 6 Feb 2024 22:46:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dieter Mummenschanz <dmummenschanz@web.de>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: Re: Re: Re:  Re: Re: [PATCH 0/2] Power management fixes
Message-ID: <ZcKopITjwjKYNM9C@x1-carbon>
References: <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
 <ZboztvrqKKdLQ1mt@x1-carbon>
 <trinity-61f604a0-1db3-4b6e-a316-fc7e609f38f4-1706771411065@3c-app-webde-bs18>
 <Zbt3qD8dMSqGYl8Q@x1-carbon>
 <trinity-78c294c6-cd07-4a27-befa-3f3fc9bd79da-1706885616508@3c-app-webde-bs04>
 <ZcEwa4fOzMif8lCd@x1-carbon>
 <trinity-0bc8e6ea-7808-4508-af3a-be22281abf24-1707231996854@3c-app-webde-bs42>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-0bc8e6ea-7808-4508-af3a-be22281abf24-1707231996854@3c-app-webde-bs42>

Hello Dieter,

On Tue, Feb 06, 2024 at 04:06:36PM +0100, Dieter Mummenschanz wrote:
> Hello Niklas,
> 
> > That is a good suggestion.
> > However, I'm hoping that this series:
> > https://lore.kernel.org/linux-ide/3e50681d-7a68-4c4a-91f6-278a3cfe23f8@amd.com/T/[https://lore.kernel.org/linux-> ide/3e50681d-7a68-4c4a-91f6-278a3cfe23f8@amd.com/T/]
> 
> > Will avoid the need for that, as it would kill the
> > "board_ahci_low_power" board type completely.
> 
> Very nice. If there is anything "baked" enough to test, please let me know.

It should be ready for testing:
https://github.com/floatious/linux/tree/external-port-v2

With this, you should no longer need:
for foo in /sys/class/scsi_host/host*/link_power_management_policy;
  do echo med_power_with_dipm > $foo;
done

(Assuming you have compiled your kernel with CONFIG_SATA_MOBILE_LPM_POLICY=3).


> 
> > After talking with Damien, we are still completely lost.
> > commit fd3a6837d8e1 ("ata: libata-core: Fix ata_pci_shutdown_one()")
> > only modifies the ata_pci_shutdown_one(), which is only called on shutdown.
> 
> > It is not called in the system suspend / system resume path,
> > so it should not be possible for this commit to have an impact.
> 
> I don't understand it either. For what it's worth, this morning after resuming, my system was stuck at pc2 for 10+ Minutes. After issuing hdparm -Y /dev/sdb I saw lower transitions down to pc8 right away without(!) issuing the same command for sda. So maybe fd3a6837d8e1 isn't the culprit after all. I'll keep testing.

You shouldn't need to do:
$ hdparm -Y

As that bypasses some of the internal logic in libata.

I assume that you didn't need this on v6.6 and older?

(Instead libata should put the device to standby or sleep itself,
it shouldn't need to be done explicitly by the user.)


> 
> 
> > Reading all the emails and bugzilla again, what you are seeing is that:
> 
> > On a fresh boot, and leaving the computer untouched for a few minutes,
> > and looking at e.g. turbostat, some of your CPUs have spent time in
> > the lower-power C-states, e.g. C8/C9/C10.
> 
> Correct! Btw. I'm looking at powertop and also have a daemon that feeds the current c-states to conky for display so I have an eye on the c-states at all times.
> 
> > However, if you do a system suspend + system resume, and then leave
> > the computer untouched for a few minutes, and look at e.g. turbotstat,
> > _none_ of your CPUs have spend time in the lower-power C-states.
> 
> > Is this correct?
> 
> Yes! The system spends ~90% in pc2 no lower c-states.
> 
> > If so, it seems that suspend/resume must have messed up some setting...
> 
> > The commit that added the code to ata_pci_shutdown_one()
> > was added in:
> > 5b6fba546da2 ("ata: libata-core: Detach a port devices on shutdown")
> > This was first added in v6.7-rc1.
> > (So this commit was never included in v6.6.)
> 
> > The code added in 5b6fba546da2 was later removed in:
> > commit fd3a6837d8e1 ("ata: libata-core: Fix ata_pci_shutdown_one()")
> > which was first added in v6.7-rc1.
> 
> > Are you certain that v6.6 works and v6.7 is bad?
> 
> Yes, absolutely!

How certain are you that v6.6 works?

Could it be the same problem there, that it works sometimes and doesn't
work sometimes?

The reason why I'm asking is that Damien's major changes got included
in v6.6-rc4:
https://lore.kernel.org/linux-ide/20230929133324.164211-1-dlemoal@kernel.org/

So I would be less surprised if you said that you can enter pc8 on every
boot on v6.5, but on v6.6 it only works occasionally.

But if you can enter pc8 on every boot on v6.6, but not on v6.7,
then it is probably easier to figure out which commit that broke
things, as there were not that many suspend/resume related changes
added in v6.7.


Kind regards,
Niklas
