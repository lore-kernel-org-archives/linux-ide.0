From: Aris Basic <aris.basic@silencesoftware.com>
Subject: sata_sil.c fix
Date: Sun, 12 Dec 2004 08:50:28 -0500
Message-ID: <41BC4CA4.50602@silencesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from electron.myhostdns.com ([147.202.33.71]:2700 "EHLO
	electron.myhostdns.com") by vger.kernel.org with ESMTP
	id S262080AbULLNub (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Dec 2004 08:50:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi
my box needs this harddrive added to sata_sil.c in order to make it work
(otherwise it crashes after some time)

{ "ST3120026AS",        SIL_QUIRK_MOD15WRITE },

thx
aris
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBvEykSxHd9YgswYMRAkcxAJwIGV/H21PVMmJotQtYFe1TQa8GmwCggWkl
aS5z2c6ti+ADrO44cG2qq6Y=
=Rt9F
-----END PGP SIGNATURE-----
