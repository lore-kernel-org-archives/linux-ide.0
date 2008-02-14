From: Tejun Heo <htejun@gmail.com>
Subject: Re: Regression: kernel 2.6.24{,.1} ahci problem, does not boot (resend)
Date: Fri, 15 Feb 2008 08:35:10 +0900
Message-ID: <47B4D02E.9030101@gmail.com>
References: <20080214184700.0bd3837d@highlander.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:29279 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758870AbYBNXfQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 18:35:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so847275wah.23
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 15:35:16 -0800 (PST)
In-Reply-To: <20080214184700.0bd3837d@highlander.home.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Malte_Schr=F6der?= <maltesch@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Malte Schr=F6der wrote:
> Hello,
> on one of my machines neither 2.6.24 nor 2.6.24.1 work.
> The system is 64bit on Athlon X2 and ATI-Chipset (SB600).
>=20
> Extract from the kernel messages during boot:
>=20
> [   66.943103] ahci 0000:00:12.0: controller can't do 64bit DMA, forc=
ing 32bit
> [   66.950374] ahci 0000:00:12.0: controller can't do PMP, turning of=
f CAP_PMP
> [   67.956470] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 G=
bps 0xf impl SATA mode
> [   67.964996] ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio=
 slum part
> [   67.972820] scsi0 : ahci
> [   67.975699] scsi1 : ahci
> [   67.978445] scsi2 : ahci
> [   67.981178] scsi3 : ahci
> [   67.983949] ata1: SATA max UDMA/133 abar m1024@0xfadffc00 port 0xf=
adffd00 irq 509
> [   67.991825] ata2: SATA max UDMA/133 abar m1024@0xfadffc00 port 0xf=
adffd80 irq 509
> [   67.999729] ata3: SATA max UDMA/133 abar m1024@0xfadffc00 port 0xf=
adffe00 irq 509
> [   68.007619] ata4: SATA max UDMA/133 abar m1024@0xfadffc00 port 0xf=
adffe80 irq 509
> [   68.470669] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   98.431945] ata1.00: qc timeout (cmd 0xec)
> [   98.454907] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4=
)
> [   98.461296] ata1: failed to recover some devices, retrying in 5 se=
cs
> [  103.916773] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  133.878045] ata1.00: qc timeout (cmd 0xec)
> [  133.882371] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4=
)
> [  133.888797] ata1: failed to recover some devices, retrying in 5 se=
cs
> [  139.343901] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  169.305174] ata1.00: qc timeout (cmd 0xec)
> [  169.309534] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4=
)
> [  169.315926] ata1: failed to recover some devices, retrying in 5 se=
cs
> [  174.771030] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>=20
> The complete boot-log (captured via serial console), lspci output,
> output of hdparm -I and the kernel config are attached.
>=20
> The PC has one IDE-drive and four SATA-drives (see hdparm.txt).
> If I wait long enough, the IDE-drive get's recognized and I can
> continue the boot process, but the SATA-drives are never recognized.
> The system work's fine with kernel 2.6.23.11 (later kernels not teste=
d).

Does irqpoll kernel parameter help?

--=20
tejun
