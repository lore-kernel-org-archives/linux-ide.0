From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: s2disk hangs with kernel >=2.6.29, SATA, Gigabyte EG45M-DS2H (bisected)
Date: Mon, 18 May 2009 01:17:27 +0200
Message-ID: <200905180117.28413.bzolnier@gmail.com>
References: <20090516225153.GA7883@arbonne.lan>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:36803 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbZEQXOA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 19:14:00 -0400
In-Reply-To: <20090516225153.GA7883@arbonne.lan>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Atterer <richard@2009.atterer.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org


On Sunday 17 May 2009 00:51:53 Richard Atterer wrote:
> Hello,
>=20
> I have had problems using s2disk starting sometime before 2.6.29 (and=
=20
> continuing up until now, 2.6.30-rc6), but only got around to bisectin=
g the=20
> issue now.
>=20
> The symptom is as follows: When I start s2disk (by running the hibern=
ate=20
> command), the system switches to the console and prints "s2disk:=20
> Snapshotting system". The cursor freezes for a moment, I hear the noi=
se=20
> that my DVD writer makes when it is reset, the lights of my USB hub g=
o off=20
> and on again. Then the cursor continues to blink and nothing more hap=
pens,=20
> the system just hangs.
>=20
> I have a Gigabyte EG45M-DS2H motherboard with two disks attached: One=
 SATA=20
> disk containing Linux, and one older PATA disk with data. AHCI is ena=
bled=20
> in the BIOS.
>=20
> The patch that causes the hang is 295f00042aaf6b553b5f37348f89bab463d=
4a469:
> ide: don't execute the next queued command from the hard-IRQ context =
(v2)

Hmm, this should have been fixed by:

commit 2ea5521022ac8f4f528dcbae02668e02a3501a5a
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Wed Jan 14 19:19:04 2009 +0100

    ide: fix suspend regression

    On Monday 12 January 2009, Simon Holm Th=F8gersen wrote:
    > commit 295f000 ("ide: don't execute the next queued command from =
the
    > hard-IRQ context (v2)") breaks suspend to disk for me. On
    > 'echo disk > /sys/power/state' the systems hangs, letting me swit=
ch
    > virtual consoles, but not responding to Alt+SysRq

    Restart the request queue early for REQ_TYPE_PM_RESUME requests
    (though there is only one resume request for the whole resume
    sequence it stays in the queue until is fully completed and now
    depends on kblockd for processing consequential resume states).

    Reported-and-bisected-by: Simon Holm Th=F8gersen <odie@cs.aau.dk>
    Tested-by: Simon Holm Th=F8gersen <odie@cs.aau.dk>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

What was the last 'good' kernel that you've started bisection with?

Thanks,
Bart
