Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1C50257
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL8bdEJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B56DC433F1;
	Thu, 11 Jan 2024 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704989562;
	bh=P2sGelNEfm6cD0Mh2B7UNo3j4YvmGx7jWYxxWVzIxz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fL8bdEJ0MAwfFb8//FUVDMxiwIsCEhGoFecgGBnFk4eCwfcUWRSHrW2x4xNYvdjIu
	 HGXAH7n436EnNRSZGYp0NoN16XDVa8rD6UjssE2dtnbhgzIAhb8ycuEqvEUXWNZbyk
	 CGaHYg5yo3KmJ8CLkKSNqAfQKDPS8mYmj9eInR+1q0PbCoqJY2Z8mpBCGtMNmj0qCy
	 LpLjz9IGQXy6Uu2nGl2yMudpsH+BxQLEJFBXPzbCMYj7OP2zEdWAJpt/s3ExeyhVQC
	 mboE5TBKBLc0DnXpg8+N2ES0yGJoq5WQP9aiqqmvrD+XxCSrqV8ya1vGLqolebz707
	 AtJbedm/I4tvA==
Date: Thu, 11 Jan 2024 17:12:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dieter Mummenschanz <dmummenschanz@web.de>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Wang Zhihao <wangzhihao9@hotmail.com>
Subject: Suspend/Resume Regression with attached ATA devices
Message-ID: <ZaATdGDOo5jiBqCR@x1-carbon>
References: <bug-218198-11613@https.bugzilla.kernel.org/>
 <bug-218198-11613-72JcrIjRZb@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-218198-11613-72JcrIjRZb@https.bugzilla.kernel.org/>

Hello Dieter,

On Mon, Dec 18, 2023 at 10:18:43AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=218198
> 
> --- Comment #19 from Dieter Mummenschanz (dmummenschanz@web.de) ---
> Hallo Niklas,
> 
> thanks for getting back to me on that.
> 
> > Please consider writing to the libata mailing list instead of using
> > bugzilla, I'm quite sure that you will get more eyes on your problem
> > that way.
> 
> Could point me to that mailing list please. I can't seem to find it. Do you
> want me to repost the issue there or is it okay to just copy & past the
> messages from this bug?

I'm truly sorry for not replying to you sooner.
For some reason my corporate email managed to put all emails from bugzilla in
the spam folder.

The proper mailing list is:
linux-ide@vger.kernel.org

I've added it to this email. You can just reply all to this email, no need to
describe your problem again.

For what it is worth, Damien has sent out a series that reverts
the commit that you managed to bisect your regression to:
https://lore.kernel.org/linux-ide/20240111115123.1258422-1-dlemoal@kernel.org/T/#t

Your help testing the series would be much appreciated.


> 
> 
> > It appears that you have built your kernel with:
> > CONFIG_SATA_MOBILE_LPM_POLICY=0
> 
> 
> Definately not! I've attached my kernel config. LPM policy is definately set tp
> "3" CONFIG_SATA_MOBILE_LPM_POLICY=3. Thats puzzles me because after booting the 
> link_power_management_policy is set to performance. Somehow the kernel
> overrides the config or uses parameters suggested by the BIOS I don't know.
> I've also tried to to switch the ASPM polity to Powersave instead of BIOS
> default. Didn't help.

I see. You have built your kernel with CONFIG_SATA_MOBILE_LPM_POLICY=3,
however we still see:
ata5: SATA max UDMA/133 abar m2048@0x42233000 port 0x42233300 irq 124 lpm-pol 0

lpm-pol 0 at boot.

The reason for this can only be that your AHCI controller is not marked to
support LPM:
https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L1629-L1631

Perhaps you could show the output of:
$ lspci -nn | grep AHCI

I guess one option could be to either add (or modify if there already is an
entry) your AHCI controller's PCI device and vendor id to the list of supported
AHCI controllers:
https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L278

And use "board_ahci_low_power" instead of "board_ahci".

See e.g.:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata/ahci.c?id=b8b8b4e0c052b2c06e1c4820a8001f4e0f77900f


That way, you should not need to do any:

for foo in /sys/class/scsi_host/host*/link_power_management_policy;
  do echo med_power_with_dipm > $foo;
done

in order for your system to enter lower power states.

In fact, it would be interesting to know if that alone solves your problem,
or if you still need the revert/Damien's recent patch series as well.


> > In your v6.7-rcX dmesg, we don't see any:
> > "port does not support device sleep" or
> > "setting devsleep to %d" (from my debug patch)
> > prints in your dmesg from v6.7-rcX, so set_lpm() is never called at all,
> > most likely because you have built with CONFIG_SATA_MOBILE_LPM_POLICY=0,
> > so DevSleep could be enabled if platform firmware enabled it.
> 
> The print is not called, right but not because of
> CONFIG_SATA_MOBILE_LPM_POLICY=0 since It is set to "3". However when I force 
> link_power_management_policy to "echo med_power_with_dipm" the message appears
> in dmesg:
> 
> [    9.434663] ahci 0000:00:17.0: setting devsleep to: 0 port support 0
> [    9.434668] ahci 0000:00:17.0: port does not support device sleep
> [    9.434674] ahci 0000:00:17.0: setting devsleep to: 0 port support 0
> [    9.434678] ahci 0000:00:17.0: port does not support device sleep

I see, so your AHCI port does not support DevSleep.


> > But you say that, for these logs, v6.6 can enter low CPU power states,
> > but v6.7-rcX can not?
> 
> Not quite. In 6.6 the PC8 transition worked only when forcing
> link_power_management_policy to "echo med_power_with_dipm". The policy was
> still performance after bootup like it is in 6.7-rc. The only difference I see
> is that after resume my laptop won't enter PC8 again. For 6.7-rc I have to call
> hdparm -Y for sda and sdb after resume to enable the transition.

I see.
You shouldn't need "echo med_power_with_dipm",
you should have an entry in ahci.c with "board_ahci_low_power" instead.


You also shouldn't need to do
$ hdparm -Y

It would be interesting to know if it is enough to only apply only
the first patch in Damien's series:
https://lore.kernel.org/linux-ide/20240111115123.1258422-2-dlemoal@kernel.org/
or if you need to apply both.


> 
> 
> > You can run:
> > hdparm -I /dev/<your_device>
> > to see if DEVSLP is enabled in your device (hdparm prints a * in front
> > of the feature if the feature is enabled).
> 
> Attached to this bug for both (identical) drives.

Ok, this shows us that DevSleep is not enabled in the devices,
so it appears that your system does not need DevSleep to enter
lower power states, but it probably needs some other LPM feature
that is enabled by ata_eh_set_lpm() (since when lpm-pol is 0,
ata_eh_set_lpm() is never called, and this is when it doesn't work,
yet when you force a different lpm-pol using sysfs, ata_eh_set_lpm()
will get called and you appear to be able to enter lower power states.


> > Perhaps your platform actually does NOT support devsleep and
> > simply requires the device to enter slumber or partial in order
> > to enter the lower CPU power states?
> 
> How can I tell?

It seems quite clear right now that the ports on your AHCI controller
does not support DevSleep, yet your system still appears to be able to
enter lower power states anyway (if ata_eh_set_lpm() is allowed to
run to enable partial/slumber and DIPM).


> 
> > We could test this by you disabling devslp on the device via hdparm,
> > and see if you can still enter the lower CPU power states.
> 
> Okay and how do I so that?

There doesn't appear to be an option to disable/enable an arbitrary
feature using hdparm.

Anyway, there is no need, as you have already shown that DevSleep feature
is not enabled on your devices.


Kind regards,
Niklas
