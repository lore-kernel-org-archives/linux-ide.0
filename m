Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC271922F9;
	Wed, 15 Jan 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966122; cv=none; b=KBQykQAsWKDMnQNdgjCpDWSFsYjrRMgFJJuJOHcTcG67SW6VLW0lQixivoXekUWZ9yXaz8KNB+K0wtQD+lF7nun1wX8IHYUoKzJBIx4O08EUpgA28WUZJvixKhlNO7HIgUhmp6YZo2jaFy8fxFvEXndwvSmleYhkjUEe0mIPES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966122; c=relaxed/simple;
	bh=S6tzmQE1ZAVO52pimezl/35d5AV8ilM+LBCng+gq5aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkro5//oMUQKpDF7edlL+NA2Nd/xbT9utTEZ9BynCSonsOf1I+IZ9494Pqnxtt2zD0fcpjEfla8QmMLC/gVgcFu1SEhlAIG/qx7LjsNt7ScZrty2sQ5LdoVzywbiqoXewgX0GojGEbqAY8mLI6syuAw9egySnGWZmqaeAiKXDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHW76ZYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHW76ZYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2A1C4CED1;
	Wed, 15 Jan 2025 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736966121;
	bh=S6tzmQE1ZAVO52pimezl/35d5AV8ilM+LBCng+gq5aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHW76ZYyU0pQEHMv3s588MddxpeqZ1qOd52PdcCKWZIgnAbZmc397pMJmSqVhJtKw
	 vJtQrQGV8uT9gLB36+qh9a9FqYkdY+sDSokoTfUNDO8mRh33UB6nW9CdeePjQSee2v
	 0QnVEC+uCvPqx3Y+wNe9KdeaxfLKFQjEw6FwYLiPMNcW16Co8W8gl91Wv7e24dGI8F
	 NQmFkeeyD9c7FktIIvoFnZLlE3UtKR3Cqg9IS5CDI9GhClcAL78lkfc4HyMI8v/A9V
	 J+cHi0x7crPjtgtT2JSRVt/HDO0kOSq70+sX4myrhxYKpxvL2mZ2AtRzQx+L3g6YQo
	 cLsIln/KaSvvA==
Date: Wed, 15 Jan 2025 19:35:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
Message-ID: <Z4f_5YgMH3lC8ppL@ryzen>
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
 <Z4EDf4ecHyfTq3Hp@x1-carbon>
 <69589dad-c0c8-4a72-9f3d-c1b0c29c96c1@heusel.eu>
 <e167b28c-94a2-45bf-8330-2487baf7199b@heusel.eu>
 <Z4U-rc3VUeegHGAg@ryzen>
 <Z4aLWmt1Y2jL1-pD@ryzen>
 <5232263d-5836-402d-9c5e-e3c601181080@heusel.eu>
 <f7583d39-890f-4a7f-a5fb-63379e0c9304@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7583d39-890f-4a7f-a5fb-63379e0c9304@heusel.eu>

Hello Christian,

On Tue, Jan 14, 2025 at 06:51:19PM +0100, Christian Heusel wrote:
> > > Looking at the Arch Linux thread, it seems that the person reporting the
> > > problem says that even on a working kernel, you only see the device the
> > > user presses the open button on the Blu-Ray player.
> > > 
> > > This suggests to me that it sends a hotplug/PhyRdy event when the user
> > > presses the open button.
> > > 
> > > In Linux, if we don't detect anything connected to the port during initial
> > > boot, and if the port is not marked (by firmware) as either Hotplug Capable,
> > > or External, then we mask the PhyRdy interrupt.
> > > 
> > > We could reconsider this, and leave the PhyRdy interrupt enabled even for a
> > > port that is not Hotplug Capable or External, if there is no devices detected
> > > on the port.

Short story:
I was thinking about this a lot, and unfortunately I came to the conclusion
that we cannot with good conscience write such a workaround.

The reason is that we would increase the power usage on all SATA ports that
have no devices connected to them at boot, not just for his controller, but
for all SATA controller all around the world, just to have a workaround for
this non-spec compliant SATA Blu-Ray player.
(The reason is that would not be able to offline the port, which will shut
down the PHY).

I suggest that your user simply does:
# echo max_performance > /sys/class/scsi_host/host3/link_power_management_policy
or
$ sudo sh -c "echo max_performance > /sys/class/scsi_host/host3/link_power_management_policy"



Long story:
Each port can be marked External or Hotplug capable by firmware, if so,
ahci_update_initial_lpm_policy() will override the configured
CONFIG_SATA_MOBILE_LPM_POLICY and set it to 0.
(This is because hotplug and LPM are mutually exclusive.)

In this case, the lpm-pol is printed as 3 for all ports, this means that
CONFIG_SATA_MOBILE_LPM_POLICY was set to 3, and that none of the ports
were marked as external or hotplug capable by firmware.

Note that even though the target LPM policy is printed early in the boot,
the actual enablement of LPM is not done now, that is done _after_ all
devices have been detected.

> [    0.594488] ata3: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a200 irq 126 lpm-pol 3
> [    0.594491] ata4: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a280 irq 126 lpm-pol 3
> [    0.594494] ata5: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a300 irq 126 lpm-pol 3
> [    0.594497] ata6: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a380 irq 126 lpm-pol 3


Note that when the AHCI driver is loaded, it will call ahci_reset_controller(),
which does a HBA reset, which will implicitly send a COMRESET to all ports.

Thus, when we dump PxSSTS (SStatus), all ports have already been reset once,
and we can see that:

0h No device detected and Phy communication not established
1h Device presence detected but Phy communication not established
3h Device presence detected and Phy communication established
4h Phy in offline mode as a result of the interface being disabled
   or running in a BIST loopback mode


> [    0.594618] ata3: before wakeup PxSSTS 0x133 PxSCTL 0x0 PxCMD 0x4016 PxDEVSLP 0x0
> [    0.594675] ata5: before wakeup PxSSTS 0x133 PxSCTL 0x0 PxCMD 0x4016 PxDEVSLP 0x0
> [    0.594717] ata6: before wakeup PxSSTS 0x4 PxSCTL 0x0 PxCMD 0x4016 PxDEVSLP 0x0
> [    0.595698] ata4: before wakeup PxSSTS 0x0 PxSCTL 0x0 PxCMD 0x4016 PxDEVSLP 0x0

This is stored in the lowest hex value, so:
ata3: 0x3
ata5: 0x3
ata6: 0x4
ata4: 0x0


> [    1.113233] ata4: before reset PxSSTS 0x0 PxSCTL 0x0 PxCMD 0x4016 PxDEVSLP 0x0
> [    1.113363] ata6: before reset PxSSTS 0x4 PxSCTL 0x0 PxCMD 0x4016 PxDEVSLP 0x0
> [    1.113481] ata5: before reset PxSSTS 0x133 PxSCTL 0x0 PxCMD 0x4016 PxDEVSLP 0x0
> [    1.113603] ata3: before reset PxSSTS 0x133 PxSCTL 0x0 PxCMD 0x4016 PxDEVSLP 0x0

After sending a wakeup to force all devices to active mode,
there was no change (this was extra test code added by me).


> [    1.926827] ata3: after reset PxSSTS 0x133 PxSCTL 0x300 PxCMD 0x4016 PxDEVSLP 0x0
> [    1.927224] ata6: after reset PxSSTS 0x4 PxSCTL 0x300 PxCMD 0x4016 PxDEVSLP 0x0
> [    1.927707] ata4: after reset PxSSTS 0x0 PxSCTL 0x300 PxCMD 0x4016 PxDEVSLP 0x0
> [    1.928128] ata5: after reset PxSSTS 0x133 PxSCTL 0x300 PxCMD 0x4016 PxDEVSLP 0x0

After reset, we still don't see ata4 moving to 0x3.
From the controller perspective, there is nothing plugged in.


> [    1.926827] ata3: after reset PxSSTS 0x133 PxSCTL 0x300 PxCMD 0x4016 PxDEVSLP 0x0
> [    1.934957] ata3.00: ATA-8: WDC WD20EARX-00PASB0, 51.0AB51, max UDMA/133
> [    1.935576] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA

On ata3, which did detect a device presence, we see a WDC drive.
After this, we will call set_lpm() for port ata3. Since the LPM policy is 0x3,
we will disable hotplug IRQ (since low power modes are and hotplug are mutually
exclusive).


> [    1.927224] ata6: after reset PxSSTS 0x4 PxSCTL 0x300 PxCMD 0x4016 PxDEVSLP 0x0
> [    1.927365] ata6: before offline PxSSTS 0x4 PxSCTL 0x300 PxCMD 0xc017 PxDEVSLP 0x0

On ata6, we don't detect any device.
After this, we will call set_lpm() for port ata6. Since the LPM policy is 0x3,
we will disable hotplug IRQ (since low power modes are and hotplug are mutually
exclusive). Because there is no device detected, we will also offline the port,
to save even more power. (Since the port is not external or hotplug capable,
we know that there can never come a device later.)


> [    1.927707] ata4: after reset PxSSTS 0x0 PxSCTL 0x300 PxCMD 0x4016 PxDEVSLP 0x0
> [    1.927851] ata4: before offline PxSSTS 0x0 PxSCTL 0x300 PxCMD 0xc017 PxDEVSLP 0x0

On ata4, we don't detect any device.
After this, we will call set_lpm() for port ata4. Since the LPM policy is 0x3,
we will disable hotplug IRQ (since low power modes are and hotplug are mutually
exclusive). Because there is no device detected, we will also offline the port,
to save even more power (since the port is not external or hotplug capable,
we know that there can never come a device later).


> [    1.928128] ata5: after reset PxSSTS 0x133 PxSCTL 0x300 PxCMD 0x4016 PxDEVSLP 0x0
> [    1.931381] ata5.00: ATA-9: SAMSUNG MZ7TD256HAFV-000L9, DXT04L6Q, max UDMA/133
> [    1.931684] ata5.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    1.931212] ata5.00: Model 'SAMSUNG MZ7TD256HAFV-000L9', rev 'DXT04L6Q', applying quirks: nolpm
> [    1.931224] ata5.00: LPM support broken, forcing max_power

On ata5, which did detect a device presence, we see a Samsung drive.
Looking up at this device string in our list of quirks, wee see that this
device does not handle low power states very well, we therefore override
the LPM policy for the port that this device is connected to to max_power 0x0).
After this, we will call set_lpm() for port ata5. Since the LPM policy is 0x0,
we will not disable the hotplug IRQ.



This seem to be in line with AHCI "10.1.1 Firmware Specific Initialization",
step 5.

"""
Wait for a positive indication that a device is attached to the port (the
maximum amount of time to wait for presence indication is specified in the
Serial ATA Revision 2.6 specification). This is done by polling PxSSTS.DET.
If PxSSTS.DET returns a value of 1h or 3h when read, then system software
shall continue to the next step, otherwise if the polling process times out
system software moves to the next implemented port and returns to step 1.
"""



Note that the Samsung drive is not well behaved, as it does not handle low
power modes very well, that is why we quirk it.
But in order to be able to quirk a device, you need to actually have a
working communication with the device. (And a COMRESET is supposed to
re-initialize communication).

We can not quirk the Blu-Ray device, since it does not seem to reply to
a COMRESET.

Perhaps there is a firmware update for this device?

Feel free to write to LG or whoever creates this device and we will be
happy help out as best as we can.



Kind regards,
Niklas
