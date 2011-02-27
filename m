From: Richard Aplin <drtune@gmail.com>
Subject: Supporting SATA Target mode (or any data transfer w/crossover cable)
 on AHCI
Date: Sat, 26 Feb 2011 19:30:56 -0800
Message-ID: <AANLkTi=mPAjKk0kZTuP-3fyQB8Rm0=mo5GDx9BOC073S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50988 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab1B0Da5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Feb 2011 22:30:57 -0500
Received: by iwn34 with SMTP id 34so2171774iwn.19
        for <linux-ide@vger.kernel.org>; Sat, 26 Feb 2011 19:30:56 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dear wise people,

I'm interested in trying to get generic mobo SATA controllers to run
in Target mode; there are a few entertaining projects that become
possible if this can be done.

Two obvious uses are SATA drive emulation and ultra-high-speed
motherboard interconnect using bonded SATA3 channels.

I'm interested in getting a controller to fully emulate a real drive,
but any form of bidirectional data transfer over SATA would be good.
An obvious "hello world" is a working loopback onto another port.
Obviously you need a crossover cable for all this stuff, but I can
hack one together for now.

Target mode has come up on this list a few times over the years and
there are a smattering of comments in the libata Marvell driver about
it (see references)

Also I understand that the SCST project is the natural place for this
to live as they have extensive support for drive emulation - but their
hardware target support appears to be entirely SCSI oriented.

I know there is a Marvell driver with some code in (see footnotes),
but that's all I have so far.

Ok so, questions.

=3D1=3D Does anyone have experience of doing this with SATA that they'd
like to share? Seems like fertile ground.

Mark Lord said on this list back in 2007 "Everybody I've dealt with
thus far uses it as a high-speed local comms interface,which would
suggest that it might be done as a network interface (ethernet
emulation)."
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg12342.html


=3D2=3D Suitability for AHCI devices -
I've been reading the AHCI and SATA specs but am not deep enough yet
to see if there is any hope of doing this with generic AHCI
controllers (which seems like best choice nowadays).=A0 Jeff G said
"some ahci chips" support this (see refs). Would love to know which
ones, and how this is done.
 These would be vendor-specific registers or does AHCI 1.x allow for
it in any way?

=3D3=3D In the Libata Marvell driver appears
"[Experiment, Marvell value added] Is it possible to use target mode
to cross-connect two Linux boxes with Marvell cards? If so, creating
LibATA target mode support would be very interesting."
http://tomoyo.sourceforge.jp/cgi-bin/lxr/source/drivers/ata/sata_mv.c

Yes, it would! ;-)

Back In The Day of simpler hardware you'd have been almost certainly
able to do this sort of hackery by getting jiggy with the chip
registers, but it appears that AHCI is a (relatively) high-level
register spec where there is significant state-machine (or even CPU)
silicon on the chip-side to implement things. This is good for the
intended purpose (fast, generic interface) but I can imagine it is
less hackable.


I don't see this fitting into libata - I'd expect it to feed into SCST
and possibly a separate IP-over-SATA driver - possibly all that libata
would do is agree to leave one or more SATA ports alone so another
(new) kernel driver can play with them.

I believe there are a number of really neat-o things that could happen
if this can be made to work on commodity chips.

Thanks for any info or discussion on this.=A0 It's great to be able to
ask the true subject experts.
Richard Aplin




=3D=3D=A0 Research so far =3D=3D=3D

-=A0 a kind soul contributed a patched Marvell chipset driver supportin=
g
Target mode (in mvSata.c marked with MV_SATA_C2C_COMM)

-=A0 Jeff G mentioned this elsewhere=A0 ("Cool. I'm looking forward to
figuring out how to enable ATA target mode=A0 in a similar manner...
sata_mv and some ahci chips support ATA target mode." -
http://www.gossamer-threads.com/lists/linux/kernel/943943 )


- There was a brief discussion of the subject back in 2007
http://www.spinics.net/lists/linux-ide/msg16348.html

- a recent question (may2010)
http://www.spinics.net/lists/linux-ide/msg37775.html didn't really go
anyhere
