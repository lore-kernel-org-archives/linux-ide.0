From: Tejun Heo <tj@kernel.org>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Fri, 20 Mar 2009 11:04:37 +0900
Message-ID: <49C2F9B5.90000@kernel.org>
References: <49C171D7.1080706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33292 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbZCTCEI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Mar 2009 22:04:08 -0400
In-Reply-To: <49C171D7.1080706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?= <vladimir.dashevsky@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

=F7=CC=C1=C4=C9=CD=C9=D2 =E4=C1=DB=C5=D7=D3=CB=C9=CA wrote:
> This log is strange for me. It seems that system missed the point tha=
t
> the drives was going out. First it tried to reinitialize the SATA lin=
k
> for three times.

That's the intended behavior.  Oh PHY event, libata EH tries to revive
the link at least for 15 secs so that transient PHY glitch doesn't
kill your root fs.

> Then, it tried to sync caches and stop the drive when it has
> actually lost connection with HBA.

That's SCSI sd driver shutting down.  As hot unplugging is
surprise-removal, sd's shutdown sequence arrives after the device is
actually gone and failed immediately.

> Then disk was returned to the slot and its softreset failed. Why? I
> suspect the drive did not fully start when the host tried to
> establish connection to it.

Yeah, it sometimes depends on the spin up time.  Sometimes some
controllers just can't get things working for the first trial and so
on.  The timeout mechanism is there to achieve acceptable delay even
when devices slightly malfunction, so the timeouts are a bit
aggressive.

> Another thing happened when I extracted the drive from one slot and
> pushed it back into its neigbor that was empty during linux boot up.
> Kernel desided this slot is dummy:
> ---
> ahci 0000:00:1f.2: version 3.0
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
> ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0xb impl SA=
TA
> mode
> ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pmp pio slum part
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> scsi0 : ahci
> scsi1 : ahci
> scsi2 : ahci
> scsi3 : ahci
> scsi4 : ahci
> scsi5 : ahci
> ata1: SATA max UDMA/133 abar m2048@0xd8601000 port 0xd8601100 irq 127=
5
> ata2: SATA max UDMA/133 abar m2048@0xd8601000 port 0xd8601180 irq 127=
5
> ata3: DUMMY
> ata4: SATA max UDMA/133 abar m2048@0xd8601000 port 0xd8601280 irq 127=
5
> ata5: DUMMY
> ata6: DUMMY

DUMMY ports are determined by the BIOS and dummy state is recorded in
an ahci register.  Does your board have all six ports exposed?

> So,  even if I put the drive as ata3 device kernel does nothing to st=
art
> it.
>=20
> Now my questions:
> 1. Is it possible to force all ports to be potentially populated duri=
ng
> startup. I would prefer that all ICH9 SATA ports will have their own
> fixed names, eg. /dev/sata0, ..., /dev/sata5. For now I have 3 drives
> and they allways get names /dev/sda /dev/sdb /dev/sdc even if there i=
s
> some empty port as shown above. This is not convenient because enclos=
ure
> management is linked to physical ports, not to only populated ones.

If you have exposed ports which are marked dummy by the ahci driver.
It's a BIOS bug.  It either needs to be quirked and reported to the
motherboard vendor.

> 2. How can I remove SATA drive safely? I mean the behavior similar to
> USB drives removing. I'd like to notify the system that i wish to rem=
ove
> the drive. Then it performs some actions as closing all current
> connections, stopping new connections, flushing caches etc. After all
> that it updates indicators on backplane showing me that the drive is
> ready to be removed. As I see, some portions of this procedure can be
> done using hdparm -f -F -Y, but not all.

echo 1 > /sys/block/sdX/device/delete

Thanks.

--=20
tejun
