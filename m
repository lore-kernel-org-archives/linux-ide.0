Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B0233553;
	Mon, 13 Jan 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785585; cv=none; b=kSEdwk5ZKdE+JJJO0cIi+ttLqeADYzs+iy/wZdmonO4FQz/DJVeO+8rDyjwZb/mrHv2//DwkIyWe1S95++YSxRsbUdy0FwDDKn5ta7AggjcfzxNo+1J0fCRYV65/zR+xsDX24LEU0iWZ/qyJJj1ZPeocueRZHk5w6YUgwYRqN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785585; c=relaxed/simple;
	bh=n4Ou/HGzldrHf7/Sh2XbEmHCCnI/uvqRjmOMAegbAz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOO7LQLc9Xcrr4yvZQy6nMSWeGfq5NCsBtbKJNKKhCdD04VJEX+3YhizfJZ5f7neCJLZjkQIvG6iTSj2xf2l8Y3KV1zHk8Of6c2/g2+mLddWOBtrslfOBBCj090l9W3ZmcfjZduBOGwhmqW5UGmNw712lBMeiOMeghKq0CRlIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me+A1onU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me+A1onU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D909C4CED6;
	Mon, 13 Jan 2025 16:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736785585;
	bh=n4Ou/HGzldrHf7/Sh2XbEmHCCnI/uvqRjmOMAegbAz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Me+A1onUzpHb4DIAar7XqtdxTiqT737waPBBZ94VF+PYZCFsCbbtxLdqj5kps7wmk
	 zmgF1J7+Xr+AKy7Gaaiv5n6vDKRZ7D/uaEyRmdL70e+Ax8Wj8ctq7IMw/klZdanjrY
	 Wzmft+zeSZVT2nJKIOzMOai4/m91FEnZ+B5PTo7HFkpi4R6LkmX2LzlQ2HP4jhi62N
	 2ykbrB1w0zIQyQXBSPEllC1Ev/aR55o5wvUl6YvPeb1nK0N4NIWDNZiTPlKbvsielj
	 4IxR5H0NG09J04U5Oiy52JfFq6/+Bx3sN+t2Xl1YAZNOGPce0Kv1+iO/qk3AT9mXdA
	 ALD0mMRU8uKrA==
Date: Mon, 13 Jan 2025 17:26:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
Message-ID: <Z4U-rc3VUeegHGAg@ryzen>
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
 <Z4EDf4ecHyfTq3Hp@x1-carbon>
 <69589dad-c0c8-4a72-9f3d-c1b0c29c96c1@heusel.eu>
 <e167b28c-94a2-45bf-8330-2487baf7199b@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e167b28c-94a2-45bf-8330-2487baf7199b@heusel.eu>

Hello Christian,

On Sat, Jan 11, 2025 at 05:41:10PM +0100, Christian Heusel wrote:
> On 25/01/10 05:21PM, Christian Heusel wrote:
> > On 25/01/10 12:24PM, Niklas Cassel wrote:
> > > On Fri, Jan 10, 2025 at 10:04:46AM +0100, Christian Heusel wrote:
> > >
> > > > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > > > index c085dd8..ef01ccd 100644
> > > > --- a/drivers/ata/libata-core.c
> > > > +++ b/drivers/ata/libata-core.c
> > > > @@ -4118,6 +4118,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
> > > >  	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_QUIRK_NOLPM },
> > > >  	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_QUIRK_NOLPM },
> > > >  
> > > > +	/* Hitachi-LG Data Storage models with LPM issues */
> > > > +	{ "HL-DT-ST BD-RE BU40N", NULL, ATA_QUIRK_NOLPM },
> > > > +
> > > >  	/* devices that don't properly handle queued TRIM commands */
> > > >  	{ "Micron_M500IT_*",		"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
> > > >  						ATA_QUIRK_ZERO_AFTER_TRIM },
> > > > 
> > > > So if anyone has feedback on why the patch does not work or any
> > > > alternative ideas for a solution that would be highly appreciated!
> 
> So weirdly the quirk from the patch for the same kernel _does work_ when
> the user passes the kernel parameter "ahci.mobile_lpm_policy=1":
> 
> [   24.035361] ata4.00: Model 'HL-DT-ST BD-RE BU40N', rev '1.03', applying quirks: nolpm
> 
> Any idea why that could be? Is it maybe not the device itself but the
> controller that it connects to that is borked and in need of the quirk?

So from the 6.6.69-1-lts log, which you claim is working, we see this:
[    0.447942] ata3: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a200 irq 126
[    0.447945] ata4: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a280 irq 126
[    0.447948] ata5: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a300 irq 126
[    0.447950] ata6: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a380 irq 126
[    0.756553] ata6: SATA link down (SStatus 4 SControl 300)
[    0.759958] ata4: SATA link down (SStatus 0 SControl 300)
[    0.760021] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.760084] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

Since this is running AHCI, default reset is ahci_do_hardreset() (COMRESET).

The SATA link up/link down messages are printed after resetting each port.
We can see that we get link up on ata3 and ata5, but link is down on ata6
and ata4.

Seeing link down after a reset is not correct, and I think we should first
focus on seeing link up for ata4, before knowing if we also need a quirk or
not.


[    0.762876] ata5.00: LPM support broken, forcing max_power
[    0.763000] ata5.00: supports DRM functions and may not be fully accessible
[    0.763007] ata5.00: ATA-9: SAMSUNG MZ7TD256HAFV-000L9, DXT04L6Q, max UDMA/133
[    0.763242] ata5.00: NCQ Send/Recv Log not supported
[    0.763248] ata5.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    0.765038] ata5.00: Features: Trust Dev-Sleep
[    0.765349] ata5.00: LPM support broken, forcing max_power
[    0.765471] ata5.00: supports DRM functions and may not be fully accessible
[    0.765714] ata5.00: NCQ Send/Recv Log not supported
[    0.766391] ata3.00: ATA-8: WDC WD20EARX-00PASB0, 51.0AB51, max UDMA/133
[    0.766999] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    0.767029] ata5.00: configured for UDMA/133
[    0.773655] ata3.00: configured for UDMA/133
[   81.230713] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   81.235708] ata4.00: ATAPI: HL-DT-ST BD-RE BU40N, 1.03, max UDMA/133
[   81.240789] ata4.00: configured for UDMA/133

After 81 seconds! we see link up on ata4...

Looking at your dmesg-6.13-rc6-mainline.log, we see similar result,
link down at initial scan, and then link up way, way later.

Right now I don't know why your device actually manages to get link up after
so long. Most likely this is from a suprious hotplug event, which can happen
when LPM is enabled in the device, but not masked in the controller.
(Linux only masks the interrupt if a LPM policy other than Max Power is set,
so it will have been enabled on v6.6.)

But like I said, we should first focus on getting link up after a reset.


I think the problem might be one out of two things:

1) The device is already in DevSleep state before the reset.
While resetting the port will bring the device out of DevSleep,
I found the following in AHCI 1.3.1 specification:

"""
Note: It is recommended that software explicitly set PxCMD.ICC to ‘1h’
and wait PxDEVSLP.DETO + PxDEVSLP.MDAT + 1ms before initiating a COMRESET.
If software initiates a COMRESET to exit from the DevSleep interface state,
PxSCTL.DET shall be set to ‘1h’ (at a minimum) for the amount of time
specified by PxDEVSLP.DETO + PxDEVSLP.MDAT + 1ms.
"""

Right now, Linux does neither set PxCMD.ICC to 1 before the COMRESET,
nor do we wait for PxDEVSLP.DETO + PxDEVSLP.MDAT + 1ms, while PxSCTL.DET in
set to 1. (We currently only hold it for 1ms.)


Could you please try this patch?

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 9c76fb1ad2ec..b0bff5fe3e03 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -660,7 +660,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned int *timing,
        /* Couldn't find anything in SATA I/II specs, but AHCI-1.1
         * 10.4.2 says at least 1 ms.
         */
-       ata_msleep(link->ap, 1);
+       ata_msleep(link->ap, 20 + 10 + 1);
 
        /* bring link back */
        rc = sata_link_resume(link, timing, deadline);



If that works to get link up after reset, you can continue to see if the
LPM quirk is needed or not. (And I will need to write a proper fix so
that we sleep the correct amount of time while holding PxSCTL.DET in 1).


Kind regards,
Niklas
