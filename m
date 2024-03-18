Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5102D7B8
	for <linux-ide@vger.kernel.org>; Mon, 18 Mar 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761554; cv=none; b=TxDB1Ya8G8xrWO67bgXabcwp0SuhfKt1MQpPixzpjjzP5RL6xuWm8lDKqE1NTVHlLDkbwW+Yc24gPmdivsNwdV/PLdzyBXnPl6q/7TyLW++49JGwRx0oupJtOyqIh0qLyEK8XVxo53NurE+nrob/okBkX8VJbej8R6poTgGijpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761554; c=relaxed/simple;
	bh=qJOkkt4z+AKnKlYA5yFMbrqlTKu2WiOLftNlfaUzvyY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=it6YI9SrJhsKS/7yYhOMdLZ1zJBXVY2ZDqoYHj5paWTQkJnoKzbCi5hchBfAM2cu9cSAc6Sd6kazxtF/Jo9IEYPyeBu4ZCaUX9sr/GyLqX7nc1zvWu0xvuxsxzaY8/KtpIcLIBNPwoZSafdHoI4L/lwhQ0lD/HN6OqZDKqJYXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Y16y86; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Y16y86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E69CC43390;
	Mon, 18 Mar 2024 11:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710761554;
	bh=qJOkkt4z+AKnKlYA5yFMbrqlTKu2WiOLftNlfaUzvyY=;
	h=Date:From:To:Cc:Subject:From;
	b=O4Y16y86dWBZBpajz8IJsYbsVAE8CmxwSJpbhy1bN5NczhscGQHCJZIgtg2/ObMmI
	 C4WHm/PgaMycmeB2AJkLlq57Fd/KynbGOlawgeecxGiOf+kWIoEYWCewTTYIBsWhuS
	 yIVOpVNSIRzTGuDhlp3o0MPJ1oKBMwIl6yMWKjgNsrln5+VjX+nVEocQkv38TsmXq3
	 q/nsK0xOgHNDZuSYd1k1KuHIRRl5HpS2BNAScC8985rc977OKu2xqptVdKfjC5yiLE
	 575eJqfl+f5s+zjfeBOm1s/yVERJXCU1O+ie+2ABYc4esRrna8P0WPBnx5BDT/Cz9i
	 iWfZNfVZbkphg==
Date: Mon, 18 Mar 2024 12:32:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Szuying Chen <chensiying21@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
	Chloe_Chen@asmedia.com.tw, conikost@gentoo.org,
	cryptearth@googlemail.com, temnota.am@gmail.com,
	hdegoede@redhat.com, Ioannis Barkas <jnyb.de@gmail.com>
Subject: ASMedia PMP inquiry
Message-ID: <ZfgmTDWgAq8UiX04@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello ASMedia developers,


We are facing some issues with some of your HBAs, e.g. ASM1166 and ASM1064.

The first problem was that e.g. ASM1064 reports more ports than the physical
number of ports, see:
https://bugzilla.kernel.org/show_bug.cgi?id=211873
https://bugzilla.kernel.org/show_bug.cgi?id=218346

This was fixed in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata?id=0077a504e1a4468669fd2e011108db49133db56e
and
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata?id=9815e39617541ef52d0dfac4be274ad378c6dc09


For some PCIe cards with ASM1064, like the Delock 90073 16 port sata controller.
(It contains 4x ASM1064, each connected to one PCIe lane.)

So the port map went from:
0xffff0f	: 1111 1111 1111 1111 0000 1111
to
0xf		:                          1111

These virtual ports, which are not backed by a physical port,
causes the boot time to be significantly increased (by 3-4 minutes),
waiting for timeouts on these virtual ports.

From reading the ASM1064 datasheet, it only seems to support 4 ports,
so it seems like a AHCI spec violation to define more ports than what
is physically provided by the HBA silicon.

For other PCIe cards with ASM1064, e.g.
https://www.ebay.com/itm/204230341609

There are 4x JMicron JMB575 Port Multipliers (PMP) embedded on the PCIe
card itself (presumably one for each physical port on the ASM1064).
For this card, the virtual ports do not seem to cause an increased boot
time.

Both of these cards have the same PCIe device and vendor IDs (the ASMedia one),
so it is not trivial to quirk them based on that.


Looking at the boot logs for ASM1064 (the one with the JMB575 PMPs) on
kernel v6.8:
ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst

We can see that the HBA does not advertise PMP support.
CAP.SPM (Supports Port Multiplier)) is not set.

According to the ASM1064 datasheet, the HBA is supposed to support PMP,
so this seems to be another instance where the AHCI specification
is not followed.

If we quirk the ASM1064, to set the CAP.SPM bit in CAP, we still
can not detect a PMP on port0-port3:

ahci 0000:04:00.0: ASM1064 has only four ports
ahci 0000:04:00.0: controller can do PMP, turning on CAP_PMP
ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pmp pio sxs deso sadm sds apst

ata7: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80100 irq 41 lpm-pol 0
ata8: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80180 irq 41 lpm-pol 0
ata9: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80200 irq 41 lpm-pol 0
ata10: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80280 irq 41 lpm-pol 0

[    0.919020] ata7: SATA link down (SStatus 0 SControl 330)
[    2.787201] ata8: SATA link down (SStatus 0 SControl 330)
[    3.100522] ata9: SATA link down (SStatus 0 SControl 330)
[    3.413890] ata10: SATA link down (SStatus 0 SControl 330)

I was expecting link up and PMP class code detected on port0-port3.
On which ports are the PMPs connected then?
How are you supposed to talk to the PMP (i.e. send PMP read and PMP write
commands).

We need to be able to read out the PMP device and vendor ID of the PMP, and
to enumerate the devices behind the PMP according to AHCI and SATA-IO specs.


It appears that ASM1064 is violating these specifications, and instead being
able to enumerate the devices behind a PMP according to the specs, ASM1064
firmware tries to hide the fact that a PMP is connected to one of the ports.

A third example is here:
https://lore.kernel.org/linux-ide/CADUzMVaFcD26QiBK_eKCbtC5Ot-+hAruNbUx+2pQNTKtMhDGRA@mail.gmail.com/

A user plugging in an external PMP (so not a PMP embedded on the PCIe card).
We need to be able to read the PMP device and vendor ID, in order to apply
the correct PMP quirks, see sata_pmp_quirks(). So trying to hide which PMP
that is connected is bad, not only because it violates the specs, but also
because it stops us from providing the proper quirks for the connected PMP.

Could you please tell us how we can communicate with the PMPs directly?
(Regardless if they are external PMPs or PMPs embedded on the PCIe card.)


Kind regards,
Niklas
