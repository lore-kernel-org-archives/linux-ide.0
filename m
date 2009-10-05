From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Mon, 05 Oct 2009 17:45:40 -0400
Message-ID: <4ACA6904.1060509@rtr.ca>
References: <1254546642.1438.135.camel@giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754759AbZJEVqU@vger.kernel.org>
In-Reply-To: <1254546642.1438.135.camel@giskard>
Sender: linux-kernel-owner@vger.kernel.org
To: Bernie Innocenti <bernie@codewiz.org>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>
List-Id: linux-ide@vger.kernel.org

Bernie Innocenti wrote:
> The error in the subject appears in the console immediately followed bv
> a hard freeze of the machine.  The error occurs reproducibly on two
> identical Opteron servers, each one equipped with two identical
> controller cards:
> 
> 03:04.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
> 03:06.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
> 
> We can trigger the problem within a few seconds by starting a
> reconstruction on a drive hooked to port 4 (counting from 0) of the
> second controller.  Oddly, every other drive works reliably and the
> faulty drive works if we connect it to, for example, port 4 of the first
> controller.
> 
> I'd like to stress that the problem occurs systematically, on two
> completely distinct machines.  We swapped drives, cables and controllers
> to exclude other possibilities.
> 
> Tested with Debian kernels 2.6.26-19 and 2.6.30-8.  Let me know if
> further details are needed.
..
> 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040..
..

  0x30000040 here means "MRdPerr":
    "bad data parity detected during PCI master read".

Which means there that a data parity error happened
during outgoing data transfer on the PCI-X bus.
This could happen due to noise on the bus,
dying capacitors, or (?) bad RAM (not sure about the last one).

The expected behaviour here is for sata_mv to then perform
perform a full SATA reset, after which the I/O will be reattempted.

But it appears to lock up before that happens.
The code does try and clear the PCI error interrupt,
but perhaps it needs clearing in more than the one register
where it currently does so.

Looking over the code and the documentation I have (NDA),
nothing obvious springs to view.  There are some extra registers
we could be dumping out, to show exactly what PCI phase and address
caused the error, but reading those won't cause or prevent a lockup.

Best bet would be to try replacing the RAM in that box,
and see if the problem goes away.

Cheers
