From: bl0 <bl0-052@playker.info>
Subject: Re: sata_sil data corruption, possible workarounds
Date: Tue, 18 Dec 2012 16:23:02 +0100
Message-ID: <kaq1n6$hqa$1@ger.gmane.org>
References: <kahap3$mur$1@ger.gmane.org> <50CCF1E0.9070804@gmail.com> <kakea2$dh1$1@ger.gmane.org> <50CEB13B.9010100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54108 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067Ab2LRPWf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2012 10:22:35 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1Tkz0H-0006px-M5
	for linux-ide@vger.kernel.org; Tue, 18 Dec 2012 16:22:45 +0100
Received: from 91.150.147.9.internetia.net.pl ([91.150.147.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 18 Dec 2012 16:22:45 +0100
Received: from bl0-052 by 91.150.147.9.internetia.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 18 Dec 2012 16:22:45 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-pci@vger.kernel.org

On Monday 17 December 2012 06:44, Robert Hancock wrote:

> Hmm, looks like I was looking at the wrong register. The CLS itself i=
s
> described by what I posted, so changing that does affect things (i.e.
> the threshold for Memory Read Multiple). The other value being writte=
n
> into fifo_cfg is the FIFO Write Request Control and FIFO Read Request
> Control field (that's why it's written to bits 0-2 and 8-10).
>=20
> "The FIFO Write Request Control and FIFO Read Request Control fields =
in
> these registers provide threshold settings for establishing when PCI
> requests are made to the Arbiter. The Arbiter arbitrates among the fo=
ur
> requests using fixed priority with masking. The fixed priority is, fr=
om
> highest to lowest: channel 0; channel 1; channel 2; and channel 3. If
> multiple requests are present, the arbiter grants PCI bus access to t=
he
> highest priority channel that is not masked. That channel=E2=80=99s r=
equest is
> then masked as long as any unmasked requests are present.
>=20
> ..
>=20
> FIFO Read Request Control.  This bit field defines the FIFO threshold=
 to
> assign priority when requesting a PCI bus read operation. A value of =
00H
> indicates that read request priority is set whenever the FIFO has
> greater than 32 bytes available space, while a value of 07H indicates
> that read request priority is set whenever the FIFO has greater than
> 7x32 bytes (=3D224 bytes) available space.=20

A fencepost error? They probably mean 8x32 bytes...

> This bit field is useful when=20
> multiple DMA channels are competing for accessing the PCI bus.
>=20
>=20
> FIFO Write Request Control. This bit field defines the FIFO threshold=
 to
> assign priority when requesting a PCI bus write operation. A value of
> 00H indicates that write request priority is set whenever the FIFO
> contains greater than 32 bytes, while a value of 07H indicates that
> write request priority is set whenever the FIFO contains greater than
> 7x32 bytes (=3D224 bytes). This bit field is useful when multiple DMA
> channels are competing for the PCI bus."
>=20
> The value apparently being written to the register according to the c=
ode
> (and given that the value in the CLS register is in units of 32-bit
> words) is (cache line size >> 3) + 1.
>=20
>  From looking at the history of this code (which dates from the pre-g=
it
> days in 2005) it comes from:
>=20
>
https://git.kernel.org/?p=3Dlinux/kernel/git/tglx/history.git;a=3Dcommi=
t;h=3Dfceff08ed7660f9bbe96ee659acb02841a3f1f39
>=20
> which refers to an issue with DMA FIFO thresholds which could cause d=
ata
> corruption. The description is pretty much hand-waving and doesn't=20
> really describe what is going on.=20

=46rom the description: "The patch is to setup the DMA fifo threshold s=
o that
there is no chance for the DMA engine to change protocol." Is there a w=
ay to
check (or add debugging messages) if/when this change of protocol is
happening?

> But it seems quite likely that=20
> whatever magic numbers this code is picking don't work on your system
> for some reason. It appears the root cause is likely a bug in the SiI
> chip. There shouldn't be any region why messing around with these val=
ues
> should cause data corruption other than that.

Do you think something should be done about it in the linux sata_sil dr=
iver?
=46or a lack of a better solution, here is my suggestion. There is alre=
ady
one option 'slow_down' for problematic disks. Another option, for
example 'cache_line_workaround', could be added for problematic
motherboards. If enabled, the most straightforward way is to set cache =
line
size to 0 and not worry about the fifo_cfg register. If someone else
confirms that it solves the problem for them, this option could be enab=
led
automatically if certain motherboard chipset is detected.

A comment in the source of another Silicon Image driver, siimage.c: "If=
 you
have strange problems with nVidia chipset systems please see the SI sup=
port
documentation and update your system BIOS if necessary". Do you (or any=
one
else) know what support documentation it's refering to?


