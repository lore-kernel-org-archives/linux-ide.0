From: Valdis.Kletnieks@vt.edu
Subject: Re: support for drives larger than 2TiB
Date: Sat, 24 Jul 2010 09:49:08 -0400
Message-ID: <92061.1279979348@localhost>
References: <4C4AB952.9030705@kernel.org>
            <1279974966.11927.26.camel@lithium.local.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1279979347_3953P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:47968 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab0GXNvP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jul 2010 09:51:15 -0400
In-Reply-To: Your message of "Sat, 24 Jul 2010 13:36:06 BST."
             <1279974966.11927.26.camel@lithium.local.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alex.buell@munted.org.uk
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, ben.collins@ubuntu.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, hmh@debian.org

--==_Exmh_1279979347_3953P
Content-Type: text/plain; charset=us-ascii

On Sat, 24 Jul 2010 13:36:06 BST, Alex Buell said:

> The only thing that would please me no end with newer replacements for
> BIOS is the ability to have 4k boot sectors. Imagine what we can do with
> 4k what we can't do with 512 bytes. 

Are you saying that 4K sectors have some special nice implications for the boot
process, or that the boot process is the last major hangup to fully supporting
a device with 4K sectors, which would give us an 8X boost in capacity on all
the codepaths that work via sector humbers?  I suspect you mean the latter, but
it's early in the morning  still.. ;)

As a side consideration - moving from 512 to 4K moves the associated limit from
2 TiB to 16 TiB.  Given the current rate of device density increase, how much
time will that buy us, and what do we do then?


--==_Exmh_1279979347_3953P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMSu9TcC3lWbTT17ARAohfAKC1UNls2S+Bvk4ETFMDzo205hFmqQCg2nAV
SsOYPPal+8EbmXl7twTbG9Y=
=2oah
-----END PGP SIGNATURE-----

--==_Exmh_1279979347_3953P--

