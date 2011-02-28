From: Richard Aplin <drtune@gmail.com>
Subject: Re: Supporting SATA Target mode (or any data transfer w/crossover
 cable) on AHCI
Date: Sun, 27 Feb 2011 16:55:30 -0800
Message-ID: <AANLkTikaYHLinw0KbGJ3Rzcg6AZ4VfeQLeHQDt9za5Fh@mail.gmail.com>
References: <AANLkTi=mPAjKk0kZTuP-3fyQB8Rm0=mo5GDx9BOC073S@mail.gmail.com>
	<4D6A5B72.6040600@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62756 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab1B1Azd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Feb 2011 19:55:33 -0500
Received: by iwn34 with SMTP id 34so2666376iwn.19
        for <linux-ide@vger.kernel.org>; Sun, 27 Feb 2011 16:55:32 -0800 (PST)
In-Reply-To: <4D6A5B72.6040600@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

>
> It does require specific support in the chipset, though.

=2E.That was my guess from page 93 of the SATA 1 specs
http://www.sata-io.org/documents/serialata10a.zip
=2E.the diagram shows the COMRESET protocol sequence which I notice is
not symmetrical (boo!!) hence if you cross-connect two SATA masters it
looks like you'd (at least) get an error when the slave device fails
to enter 'Device Calibrate' and 'Device COMWAKE' states. =A0It's a sham=
e
that they didn't design it to sync symmetrically, but then the
protocol gets a bit more complicated and I expect everyone wanted to
be home by teatime.
Looks like we're in a similar situation to the wifi hackers, who have
to find specific chipsets that they can hack to support raw packets,
promiscuous mode, etc. =A0 Doh. Well, anyway, let's see how far we get.
I'm new to this scene, but it appears there aren't _that_ many SATA
chipsets in mass-mass-production; most widespread I am assuming are
the big vendor integrated IO chips; the Intel ICH family, NVidia MCP,
etc. =A0Somewhere down the popularity list after that you've got the
dedicated silicon from SIL, Marvell, etc.


=3D=3D Marvell target mode
I don't have one of these controllers=A0but it's a useful discussion
point at least.
I also assume that Marvell reuse basically the same SATA macro block
in all their chips, which seems like a fair assumption nowadays.
Ok I'm looking at the (NDA'd? ;-) =A0Marvell =A0"88F6180, 88F6190,
88F6192, and 88F6281=A0Integrated Controller=A0Functional Specification=
s"
which google found here
http://www.embeddedarm.com/documentation/third-party/MV88F5182-usermanu=
al.pdf
on page 94 there is some talk about Target, and on page 397 there are
the relevant register bits
On paper it _looks_ pretty straightforwards; you set two bits on the
Target board and presumably it switches the chip to use an alternate
state machine for the handshake protocol so it connects properly with
a master. =A0However, I don't doubt that Things Are Not That Simple in
real life.
Mark, I assume that when you ran a Marvell board in target mode you
got at least successful connect (i.e. no COMRESET error)

=3D=3D My experiments
I don't have a Marvell controller; =A0I have a few others in various
boxes; Intel IC7M, an IC8M, a Silicon Image Sil3531 in a windows box,
but the current victim in the test rig is an Nvidia MCP79 in a cheap
Atom/ION HTPC.
The MCP79 runs in ATA emulation or SATA AHCI mode depending on a BIOS
setting; I'm running it in AHCI mode of course.

-- Off the shelf performance of Nvidia MCP79 SATA (w/1.6Ghz Atom 330,
single channel DDR2-800 RAM)

Kingston 16GB SSD for testing, and using stock Debian 10.10 I
repeatedly get 218MBytes/sec with hdparm, so it's definitely running
at 3GBPS SATA II.

I built a crossover cable - very carefully peeled open a spare
SATA-eSATA mobo cable I had and swapped the tx/rx pairs (retaining
correct +/-)

--Test 1 - mobo loopback via crossover

Then we just plug in a regular eSATA cable to loopback to the mobo's
port, and dmesg spits out...
ata2: exception Emask 0x10 SAct 0x0 SErr 0x4000000 action 0xe frozen
ata2: irq_stat 0x00000040, connection status changed
ata2: SError: { DevExch }
ata2: hard resetting link
ata2: COMRESET failed (errno=3D-32)
ata2: reset failed (errno=3D-32), retrying in 8 secs
Basically, "yay" but "boo" at the same time - something happened, but
it's what we thought might happen - =A0the COMRESET fails. (thanks for
the nice clear error messages there btw)

-- Test 2 - between two machines via crossover

Plugging into two physically separate (windows) machines via eSATA
yields no dmesg output (silence from both ends), although I'm hopeful
that will resolve if I fix up the grounding on my homemade cable - I'd
expect it to yield same error on the linux box as I got with loopback,
if things are electrically adequate.

Ok so things I'll try...

a) See if the chips will _actually_ TX/RX FISs even if the COMRESET
failed. This is wildly optimistic. By the look of things (e.g. Marvell
chip) these controllers typically incorporate a full CPU to do stuff
like connection handshaking (rather than using a minimal state machine
or exposing the registers to the kernel driver). =A0I am guessing if
this CPU doesn't like the SATA link state, it's going to be a real wet
blanket about sending FISs. However, hope springs eternal.

b) I'm trying to get this to work on the major mobos, so ask Intel and
Nvidia =A0nicely if they have any ideas. =A0This "loopback connect" mod=
e
is so useful and so zero-cost to do in the chip it's hard to believe
they didn't squirrel away a bit somewhere that lets you do this.

c) Try randomly banging unknown bits in the AHCI register space of my
MCP79 and see if it affects things

d) Your suggestion here, free as in beer

Cheers,
Rich Aplin
