From: Phil Dibowitz <phil@ipom.com>
Subject: Re: IDE kernel traces in 2.6.9 - Bad IRQ ?
Date: Mon, 01 Nov 2004 09:46:01 -0800
Message-ID: <41867659.9000603@ipom.com>
References: <20041101142847.41837.qmail@web88005.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enigE2A584E291760FE0E652F51A
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from msg-mx4.usc.edu ([128.125.137.9]:53911 "EHLO msg-mx4.usc.edu")
	by vger.kernel.org with ESMTP id S263148AbUKARqE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Nov 2004 12:46:04 -0500
Received: from [10.1.1.2] ([128.125.81.146])
 by msg-mx4.usc.edu (Sun Java System Messaging Server 6.1 HotFix 0.02 (built
 Aug 25 2004)) with ESMTPSA id <0I6I001NJHCP0G90@msg-mx4.usc.edu> for
 linux-ide@vger.kernel.org; Mon, 01 Nov 2004 09:46:01 -0800 (PST)
In-reply-to: <20041101142847.41837.qmail@web88005.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ericisko <linux2@rogers.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2A584E291760FE0E652F51A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ericisko wrote:
> Hi,
> 
> I have similar problem. I have MSI Neo2-FIS2R board
> with 865PE chipset. I have 1 PATA hard drive connected
> to ICH5, IDE channel 1 and DVD and CD-RW connected to
> IDE channel 2. I use IDE driver piix, not libata. When
> IDE is in legacy mode (BIOS setup), everything works
> fine - each channel has its own IRQ. When I change
> mode to native, I get the message "Disabling IRQ" with
> trace stack showing 2 ide_intr handlers for IRQ (1 for
> each channel?) and both channels share the same IRQ.
> It looks like interrupt is not handled and it's level
> triggered so /proc/interrupts shows huge number of
> interrupts and soon IRQ is disabled.
> If ide-cd is compiled as module, everything works fine
> unless I load ide-cd module. Than I get the same
> errors.
> As that particular interrupt was shared also by USB
> and eth0, I built the minimal kernel so ide0 and ide1
> were the only devices using the interrupt - the same
> problem.
> I'm not at my computer right now so I can't send any
> additional info at the moment.

So I played with this a little more. And I think I understand better. 
With this BIOS there's a few possible combinations:

Enhanced: S-ATA
           P-ATA+S-ATA
           P-ATA

or

Compatability: Primary P-ATA+S-ATA
                Secondary P-ATA+S-ATA
                P-ATA Only

Basically, there are way more ATA chains on this mobo than others. Yuo 
have your SATA controller (1 chain, 2 drives), your PATA controller (2 
chains, 4 drives), and your RAID PATA controller (1 chain, 2 drives).

So here's what happens:

- I chose Enhanced P-ATA+S-ATA which meant that SATA drives came first, 
then PATA. This caused the kernel some confusion... not exactly sure 
why, but something to the effect of /dev/hda was first, but wasn't first 
(that chainw as listed as the 2nd chain in bios with nothing on the 
first). This causes traces
- I was able to fix it with Compatibilty P-ATA only which puts things in 
the right order
- I was *also* able to fix it, it turns out, with Enhanced S-ATA. Now 
that seems counter intuitive until you break down and read the manual 
that comes with the board. This basically says "if you have SATA, we 
ignore all PATA and just use SATA. If you don't have SATA, we ignore all 
SATA and just use PATA" -- that thus puts things in the right order 
since I don't have any SATA at this time.

Ther other compatiblity modes mix which Primaries you want to use and 
which you want to throw away and replace with SATA. The other enhances 
modes are exactly what they say.

So that's some more information based on expiramentation, reading the 
fine manual, and a bit of speculating... doesn't solve everything, but I 
hope it helps.

-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
  - Benjamin Franklin, 1759


--------------enigE2A584E291760FE0E652F51A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhnZZN5XoxaHnMrsRAnYoAJ9cJySkXw0i6GpdHv1XdjcqIAtoMgCbBkKy
VNe0cpklAB84c9jNisIt7ic=
=n8Q/
-----END PGP SIGNATURE-----

--------------enigE2A584E291760FE0E652F51A--
