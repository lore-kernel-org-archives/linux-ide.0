From: Phil Dibowitz <phil@ipom.com>
Subject: Re: IDE kernel traces in 2.6.9 - Bad IRQ ?
Date: Sun, 31 Oct 2004 03:01:32 -0800
Message-ID: <4184C60C.9010407@ipom.com>
References: <418421E9.6000809@ipom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enigEBEC754D3139968ECAA0B44D
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from msg-mx5.usc.edu ([128.125.137.10]:2511 "EHLO msg-mx5.usc.edu")
	by vger.kernel.org with ESMTP id S261590AbUJaLBm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Oct 2004 06:01:42 -0500
Received: from [10.1.1.2] ([128.125.81.146])
 by msg-mx5.usc.edu (Sun Java System Messaging Server 6.1 HotFix 0.02 (built
 Aug 25 2004)) with ESMTPSA id <0I6G00KES3YNOV60@msg-mx5.usc.edu> for
 linux-ide@vger.kernel.org; Sun, 31 Oct 2004 03:01:37 -0800 (PST)
In-reply-to: <418421E9.6000809@ipom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEBEC754D3139968ECAA0B44D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Phil Dibowitz wrote:
> I just upgraded my computer, compiled a new kernel appropriately, and 
> I'm getting a ton of kernel issues surrounding the IDE driver. I tried a 
> generic debian kernel as well, but same issue. Here are the tracebacks I 
> get during boot:
> 
> Oct 30 15:56:19 rider kernel: ide0 at 0xefe0-0xefe7,0xefae on irq 5
> Oct 30 15:56:19 rider kernel: hda: max request size: 128KiB

So, it turns out if I change the IDE Configuration in my BIOS to be 
"Compatible mode" instead of "Enhanced Mode", this is fixed completely. 
All my drives work flawelessly.

Any idea what, if any, features I'm missing, or how to make linux work 
with "enhanced mode" ?

-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
  - Benjamin Franklin, 1759


--------------enigEBEC754D3139968ECAA0B44D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhMYON5XoxaHnMrsRAn1gAKCF9ySGUj68ezwiSuCHyP4wk3536ACfehGF
Tae/3uCi2qaNvYREO+upEl0=
=f96x
-----END PGP SIGNATURE-----

--------------enigEBEC754D3139968ECAA0B44D--
