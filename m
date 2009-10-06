From: Bernie Innocenti <bernie@codewiz.org>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Tue, 06 Oct 2009 00:16:25 -0400
Message-ID: <1254802585.1471.21.camel@giskard>
References: <1254546642.1438.135.camel@giskard>  <4ACA6904.1060509@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751346AbZJFERK@vger.kernel.org>
In-Reply-To: <4ACA6904.1060509@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>
List-Id: linux-ide@vger.kernel.org

El Mon, 05-10-2009 a las 17:45 -0400, Mark Lord escribi=F3:
>   0x30000040 here means "MRdPerr":
>     "bad data parity detected during PCI master read".
>=20
> Which means there that a data parity error happened
> during outgoing data transfer on the PCI-X bus.
> This could happen due to noise on the bus,
> dying capacitors, or (?) bad RAM (not sure about the last one).

Oddly, we see this on two different machines.  And only on specific
ports of the second controller card.

On one of these machines, we've also found a bunch of MCEs related to
ECC errors, but we were unable to reproduce them by exercising the CPU
and the bus with tools like cpuburn or md5sum of entire drives.

The other one has been running for 2 days with no errors whatsoever.
Bother have successfully completed a 24h cycle of memtest86+.


> The expected behaviour here is for sata_mv to then perform
> perform a full SATA reset, after which the I/O will be reattempted.
>
> But it appears to lock up before that happens.
> The code does try and clear the PCI error interrupt,
> but perhaps it needs clearing in more than the one register
> where it currently does so.

I've got a few of these recoverable errors overnight (perhaps along wit=
h
the MCE errors I described above).  The bus was reset as you describe.

The PCI errors seem to cause a system freeze only during RAID
reconstruction. Perhaps the bus reset logic is not sufficiently locked
against re-entrance?


> Looking over the code and the documentation I have (NDA),
> nothing obvious springs to view.  There are some extra registers
> we could be dumping out, to show exactly what PCI phase and address
> caused the error, but reading those won't cause or prevent a lockup.
>=20
> Best bet would be to try replacing the RAM in that box,
> and see if the problem goes away.

We'll try this tomorrow, thank you very much for providing these clues.

--=20
   // Bernie Innocenti - http://codewiz.org/
 \X/  Sugar Labs       - http://sugarlabs.org/
