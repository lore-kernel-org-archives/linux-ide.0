From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: DMA timeouts with JM20330 based SATA<->IDE bridge
Date: Thu, 04 Mar 2010 14:36:36 +0100
Message-ID: <4B8FB764.5000108@metasoft.pl>
References: <20100304014558.GA8837@florz.florz.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:58638 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755832Ab0CDNnT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Mar 2010 08:43:19 -0500
In-Reply-To: <20100304014558.GA8837@florz.florz.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Zumbiehl <florz@florz.de>
Cc: linux-ide@vger.kernel.org

Hi,

I have similar problem with JM20330, but in my case it's connected
to arm board ide port (Cirrus Logic ep9315 SoC).
I'm using pata driver written long time ago by Alessandro Zumo
and Lennert Buytenhek, to which I added dma functionality (the driver
is not in mainline).

> At the other end, it's connected to a Seagate ST31500341AS
> SATA harddisk (well, that's kinda redundant ... ;-).
In my case, it's Seagate ST9120822AS.

>=20
> Now, reading from the disk seems to work perfectly, but writing
> (dding /dev/zero to the block device) causes DMA timeouts every
> few hundred megabytes - in between the timeouts, though,
> throughput seems to be ok (~ 20 MB/s).
I can observe dma timeouts only when reading from disk, never when
writing.

> In the kernel log, the errors look something like this, with
> small variations (at least to my eyes ;-):
>=20
> | ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> | ata2.00: failed command: WRITE DMA EXT
> | ata2.00: cmd 35/00:00:67:19:4f/00:04:00:00:00/e0 tag 0 dma 524288 o=
ut
> |          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout=
)
> | ata2.00: status: { DRDY }
> | ata2: link is slow to respond, please be patient (ready=3D0)
> | ata2: device not ready (errno=3D-16), forcing hardreset
> | ata2: soft resetting link
> | ata2.00: configured for UDMA/66
> | ata2.00: device reported invalid CHS sector 0
> | ata2: EH complete
>=20
> That's all happening with a vanilla 2.6.33 (plus tuxonice, in case th=
at
> could have any effect on this). The legacy IDE drivers behave similar=
ly.
>=20

My kernel log:

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: READ DMA
ata1.00: cmd c8/00:08:70:39:a3/00:00:00:00:00/e3 tag 0 dma 4096 in
         res 40/00:80:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: READ DMA EXT
ata1.00: cmd 25/00:00:d0:2e:27/00:02:04:00:00/e0 tag 0 dma 262144 in
         res 40/00:80:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: READ DMA EXT
ata1.00: cmd 25/00:00:d0:28:9b/00:02:04:00:00/e0 tag 0 dma 262144 in
         res 40/00:80:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }

Kernel version doesn't have any impact (it was first observed about
two years ago, and with 2.6.32.8 behaviour is the same, during this
time I've never had any problems with ide drives connected directly).
I also tested jm20330 connected to old Celeron box (with VIA VT82C596B)=
 and
it works reliably.

I think that the problem is with ep93xx ide controller (maybe working
too close to ide specs or so..), or maybe between drive and jm20330
(however I don't have any non-Seagate sata drive to test it).
Reading is probably much faster in my configuration (the green led
on converter board is constantly turned on during read, then suddenly
turns off and timeout occurs, during write I can only observe fast blin=
king,
maybe this is normal).

If there is any interest, I can post ep93xx pata driver to the list,
but it depends on ep93xx-dma-m2m patch, which is not in mainline too.

Rafa=B3


