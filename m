From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_sil: update device hotplug handling
Date: Mon, 12 Jun 2006 16:42:15 +0900
Message-ID: <448D1AD7.3000807@gmail.com>
References: <20060612051822.GE9166@htj.dyndns.org> <448D04C5.9030603@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:60307 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750809AbWFLHmV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 03:42:21 -0400
Received: by py-out-1112.google.com with SMTP id x31so1603477pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 00:42:21 -0700 (PDT)
In-Reply-To: <448D04C5.9030603@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Some flavors of 3112 cannot mask SATA_IRQ reliably and ends up
>> scheduling hotplug event during hardreset.
>=20
> Can you give more detail?  This sounds like a software bug?  I don't =
see=20
> SError clearing the pre-patched code path, the lack of which may crea=
te=20
> the conditions you describe.

This is from a sil3112 PCMCIA card.

# lspci -nvvv -s 07:00
0000:07:00.0 0180: 1095:3112 (rev 02)
         Subsystem: 1095:3112
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at 2410 [size=3D8]
         Region 1: I/O ports at 2420 [size=3D4]
         Region 2: I/O ports at 2418 [size=3D8]
         Region 3: I/O ports at 2424 [size=3D4]
         Region 4: I/O ports at 2400 [size=3D16]
         Region 5: Memory at 34000000 (32-bit, non-prefetchable) [size=3D=
512]
         Expansion ROM at 30000000 [disabled] [size=3D512K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

I have sil3114 and sil3112 PCI cards and both don't need SError clearin=
g=20
to stop raising SATA IRQs.  Masking & acking are enough.  They never=20
raise the interrupt again until unmasked.  Which is the correct behavio=
r=20
considering the following description about SATA IRQs in the datasheet.

"N =96 This bit enables an interrupt upon the assertion of the N bit in=
=20
the DIAG field of the SError register"

On this PCMCIA card, SATA IRQ mask doesn't seem to work.  Hardreset=20
causes SATA IRQs and thus rescheduling of hotplug event - eventually=20
libata gives up on it.  It seems like this PCMCIA controller continues=20
to raise SATA IRQ as long as corresponding SError bits are set.  Callin=
g=20
ata_bmdma_irq_clear() makes it slow and gives cpu more time to proceed.

Hmmm... On further testing, clearing SError does a much better job.  Th=
e=20
controller still raises spurious interrupts but only a few times.  Will=
=20
re-spin the patch w/ SError clearing.

--=20
tejun
