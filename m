From: Grant Grundler <grundler@google.com>
Subject: Re: Problems with >3 drives on an eSATA portmultiplier
Date: Wed, 1 Apr 2009 09:45:09 -0700
Message-ID: <da824cf30904010945i5a33f049v15745c79293d22ad@mail.gmail.com>
References: <Pine.LNX.4.63.0904011454020.3947@buttercup.gerph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:5587 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764476AbZDAQpR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Apr 2009 12:45:17 -0400
Received: from spaceape10.eur.corp.google.com (spaceape10.eur.corp.google.com [172.28.16.144])
	by smtp-out.google.com with ESMTP id n31GjCNX010606
	for <linux-ide@vger.kernel.org>; Wed, 1 Apr 2009 17:45:12 +0100
Received: from yw-out-1718.google.com (ywq4.prod.google.com [10.192.17.4])
	by spaceape10.eur.corp.google.com with ESMTP id n31GjAXj022145
	for <linux-ide@vger.kernel.org>; Wed, 1 Apr 2009 09:45:10 -0700
Received: by yw-out-1718.google.com with SMTP id 4so87922ywq.8
        for <linux-ide@vger.kernel.org>; Wed, 01 Apr 2009 09:45:09 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0904011454020.3947@buttercup.gerph.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Fletcher <gerph@gerph.org>
Cc: linux-ide@vger.kernel.org

On Wed, Apr 1, 2009 at 6:54 AM, Justin Fletcher <gerph@gerph.org> wrote=
:
> Hiya,
>
> I've been having problems recently with my external eSATA drives fail=
ing to
> be recognised when there are more than 3 plugged in at one time.
>
> Summary of problem:
>
> When one drive is connected in the external box, everything is fine.
>
> When two are connected, everything is fine.
>
> When three are connected, it can sometimes take a while for them all =
to be
> detected and mounted.
>
> When four are connected, it almost never detects them properly or mou=
nts
> them. Occassionally I get all 4 mounted, and rarely I get just 1 or 2=
 of the
> drives mounted.
>
> When five are connected, it's not mounting the drives.
>
>
> More details:
>
> The kernel I'm using now is 2.6.29 with no patches applied.
>
> The system I'm using is a MSI motherboard, with a SiI eSATA controlle=
r (a
> 3132, specifically this one:
> http://www.span.com/catalog/product_info.php?products_id=3D15995 ) co=
nnected
> though the only PCI express card on the MB.

2.6.29 kernel + SII 3132 SATA controller should work fine with 3726 PMP=
=2E

I'm skeptical it's a driver problem. But I've not tested recent
kernels with that config.
I do know 2.6.26 does work with that config.

=2E..
> History:
>
> The full 5 drives were working and being mounted correctly in the pas=
t.
> However, due to many upgrades and confusing hardware problems at the =
same
> time, trying to identify when that was has become a problem for me - =
I can't
> say when it was working. When it was working I had a JMB362 PCIexpres=
s card
> (specifically this one:
> http://www.span.com/catalog/product_info.php?products_id=3D16361 ). T=
his has
> been replaced by the SiI card in order to determine if the card is a
> problem; the problems persist and have the same symptoms. (should it =
be
> necessary for diagnosis, I can put the JMB362 card back). I can say f=
or
> certain that the failures I'm seeing have happened at least on kernel=
s
> 2.6.28.3, 2.6.28.4 and 2.6.29.
>
> During testing combinations of drives have been changed, and the brid=
ge
> board ports that they are plugged in to. This has not appeared to mak=
e any
> difference - the factor in this equation is the number of drives that=
 are
> connected.

This suggests the power supply is now failing to provide adequate power
for drive spinup. The WD "Green" drives certainly use less power during
normal operation (IIRC, they are 5400 RPM and only 3 platter). But they
will need substantially more to spinup.

Happen to have another PSU that could provide power to the drives?
Ie build the same topology with 3132 + 3726 but power it with a
different (or multiple) PSU.

hth,
grant

>
>
> Typical failure:
>
> A typical reads something like this (taken from kern.log from message=
s
> collected during initialisation):
>
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: SATA link up 3.0 Gbps (S=
Status 123
> SControl 0)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: Port Multiplier 1.1,
> 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 320)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 300)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: failed to write SCR 1=
 (Emask=3D0x1)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: hardreset failed (por=
t not ready)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: reset failed, giving =
up
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: controller in dubious st=
ate,
> performing PORT_RST
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 0)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 320)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 300)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 300)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: failed to write SCR 2=
 (Emask=3D0x1)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: COMRESET failed (errn=
o=3D-5)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: reset failed, giving =
up
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: controller in dubious st=
ate,
> performing PORT_RST
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 0)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 320)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 300)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 300)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: failed to read SCR 2 =
(Emask=3D0x1)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: COMRESET failed (errn=
o=3D-5)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: reset failed, giving =
up
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: failed to recover lin=
k after 3
> tries, disabling
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: controller in dubious st=
ate,
> performing PORT_RST
>
> ... and so on until it tries detaching the port multiplier ...
>
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: controller in dubious st=
ate,
> performing PORT_RST
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 0)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 320)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: failed to read SCR 2 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: COMRESET failed (errn=
o=3D-5)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: reset failed, giving =
up
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: failed to recover lin=
k after 3
> tries, disabling
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 0)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.04: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.04: COMRESET failed (errn=
o=3D-5)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.04: failed to write SCR 1
> (Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.04: failed to clear SErro=
r.N
> (errno=3D-5)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: failed to recover PMP af=
ter 5 tries,
> giving up
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: Port Multiplier detac=
hing
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: disabled
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: exception Emask 0x13 SAc=
t 0x0 SErr
> 0x40d0000 action 0xe frozen t4
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: irq_stat 0x01100010, PHY=
 RDY changed
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: SError: { PHYRdyChg Comm=
Wake 10B8B
> DevExch }
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: SATA link up 3.0 Gbps (S=
Status 123
> SControl 0)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: Port Multiplier 1.1,
> 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 320)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 300)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 300)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: COMRESET failed (errn=
o=3D-5)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: reset failed, giving =
up
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 0)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 320)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 300)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: failed to read SCR 0 =
(Emask=3D0x1)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: COMRESET failed (errn=
o=3D-5)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: reset failed, giving =
up
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 0)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 320)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 300)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: failed to read SCR 0 =
(Emask=3D0x1)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: failed to read SCR 1 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.02: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: hardreset failed (por=
t not ready)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 =
(Emask=3D0x40)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.03: reset failed, giving =
up
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: controller in dubious st=
ate,
> performing PORT_RST
>
> ... and the sequence repeats until it gets fed up ...
>
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: controller in dubious st=
ate,
> performing PORT_RST
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 0)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 320)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.01: SATA link down (SStat=
us 221
> SControl 300)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.05: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.05: SATA link up 1.5 Gbps=
 (SStatus
> 113 SControl 320)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: ATA-8: WDC WD5000AAKS=
-00YGA0,
> 12.01C02, max UDMA/133
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: 976773168 sectors, mu=
lti 16:
> LBA48 NCQ (depth 31/32)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: configured for UDMA/1=
00
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.04: PHY status changed bu=
t maxed out
> on retries, giving up
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.04: Manully issue scan to=
 resume this
> link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: PMP SError.N set for som=
e ports,
> repeating recovery
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: hard resetting link
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps=
 (SStatus
> 123 SControl 320)
> Apr =C2=A01 11:43:23 buttercup kernel: ata1.00: configured for UDMA/1=
00
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: EH pending after 5 tries=
, giving up
> Apr =C2=A01 11:43:23 buttercup kernel: ata1: EH complete
>
>
> As can be seen, it got as far as identifying one of the drives in thi=
s
> configuration on the final attempt, but the other 3 were not detected
> properly.
>
>
> My gut feeling:
>
> There's some timing problem involved here - either the drives are bei=
ng sent
> commands when they're not ready, or they're being timed out before th=
ey have
> a chance to respond after a reset. As the problem gets worse (to the =
point
> of always failing) with more drives, I'm thinking of some overall tim=
eout
> that's being triggered but the individual drives are getting less and=
 less
> time to handle it. For example, drive 1 reset at 1s, drive 2 reset at=
 2s,
> drive 3 reset at 3s, etc, but an overall timeout of 8s, so by the tim=
e that
> drive 5 has been reset, it only has 3s to respond and its initialisat=
ion
> takes longer than that so it never does). Not knowing what is involve=
d here,
> this may be complete rubbish and is purely guesswork on my part.
>
>
> More details from kernel logs:
>
> Because I'm not sure what's useful, and I wanted to capture some timi=
ngs for
> the sequences of events, I've captured kernel logs of the a number of=
 drive
> combinations. In each case the PC was turned off, the box was turned =
off,
> the SATA leads were connected as required for the test, then the box =
turned
> on, a few seconds waited for the box to settle, then the PC turned on=
=2E The
> system booted into 2.6.29 and then waited until it had settled to a l=
ogin
> prompt. At this point, the drive box was turned off. The system then =
shut
> down whatever drives it had detected after determining that the PMP h=
ad gone
> away. The drive box was then turned on again. This second initialisat=
ion of
> the box should ensure that there are timings present in the kernel lo=
gs
> which determine how long it was between events.
>
> The numbering of the logs indicates which drives were connected - the=
se are
> drives numbers from 1-5, not the numbers used in the log messages whi=
ch are
> 0-4 (it just makes more sense for me to think of them as drives 1-5 n=
ot
> 0-4).
>
> Drives 1-3 are 500G, drives 4-5 are 1T.
>
> In the logs it can also be seen that there are two ATA drives connect=
ed to
> the MB, and two SATA drives connected to the MB. Neither of these app=
ear to
> exhibit any other problems.
>
> The logs can be found at:
>
> http://usenet.gerph.org/SATA/
>
>
> sata-15-kern.log:
> =C2=A0 2 drives connected.
> =C2=A0 All detected during initialisation.
> =C2=A0 All detected on restarting box.
>
> sata-45-kern.log:
> =C2=A0 2 drives connected.
> =C2=A0 All detected during initialisation.
> =C2=A0 All detected on restarting box, although it reset the port 3 t=
imes.
>
> sata-125-kern.log:
> =C2=A0 3 drives connected.
> =C2=A0 All detected during initialisation, but after doing so it then=
 tried
> =C2=A0 to re-detect later (which was successful)
> =C2=A0 All detected on restarting box, although it reset the port 2 t=
imes
> =C2=A0 and had SCSI errors reported which it recovered from.
>
> sata-345-kern.log:
> =C2=A0 3 drives connected.
> =C2=A0 1 detected during initialisation, only drive 4 was initialised
> =C2=A0 properly; during init 3 had been IDENTIFYd but the port was th=
en
> =C2=A0 reset and more attempts made.
> =C2=A0 All detected on restarting box, although it reset the port 2 t=
imes
> =C2=A0 and had other errors reported which it recovered from.
>
> sata-1235-kern.log:
> =C2=A0 4 drives connected.
> =C2=A0 1 detected during initialisation (drive 1), many attempts made=
=2E
> =C2=A0 None detected on restarting box, although it retried many time=
s.
>
> sata-12345-kern.log:
> =C2=A0 5 drives connected.
> =C2=A0 None detected during initialisation, many attempts made.
> =C2=A0 Ineffective - no output when the external box was turned off, =
nor
> =C2=A0 when it was turned on.
>
>
> Finally:
>
> I can provide more information, more combinations and try different k=
ernel
> configurations if it's found to be useful for this. I'm sorry if this
> information is too verbose, or if I've missed something out - please =
let me
> know and I'll try to do tests or fill in the blanks.
>
>
> Hope someone can help with this!
>
>
> --
> Gerph <http://gerph.org/>
> [ All information, speculation, opinion or data within, or attached t=
o,
> =C2=A0this email is private and confidential. Such content may not be
> =C2=A0disclosed to third parties, or a public forum, without explicit
> =C2=A0permission being granted. ]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
