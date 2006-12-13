From: Patrik Jonsson <patrik@ucolick.org>
Subject: Frequent SATA errors / port timeouts in 2.6.18.3?
Date: Wed, 13 Dec 2006 15:45:01 -0800
Message-ID: <4580907D.1020407@ucolick.org>
References: <4578F5D4.8080205@moniker.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig04FEAC0060D98E41272AF05F"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zilan.ucolick.org ([128.114.23.234]:52820 "EHLO
	smtp.ucolick.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbWLNAJu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Dec 2006 19:09:50 -0500
Received: from smtp.ucolick.org (localhost [127.0.0.1])
	by smtp.ucolick.org (Postfix) with ESMTP id D8D6D3FC4
	for <linux-ide@vger.kernel.org>; Wed, 13 Dec 2006 15:44:33 -0800 (PST)
Received: from [128.114.22.77] (dhcp-22-77.ucolick.org [128.114.22.77])
	by smtp.ucolick.org (Postfix) with ESMTP id C480E2AC4
	for <linux-ide@vger.kernel.org>; Wed, 13 Dec 2006 15:44:33 -0800 (PST)
In-Reply-To: <4578F5D4.8080205@moniker.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04FEAC0060D98E41272AF05F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

Hopefully someone here will know what's up with my machine. It's an
nforce4 ultra box that's running a 10-drive RAID5 array. I upgraded from
2.6.17-rc4 to 2.6.18.3 about a week ago, and I've since had 3 drives
kicked out. Previously, I had no kicks over almost a year. The kernel
message is:

ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata7.00: (BMDMA stat 0x20)
ata7.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x41 err 0x4 (device error)
ata7: EH complete
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: (BMDMA stat 0x20)
ata7.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
ata7: port is slow to respond, please be patient
ata7: port failed to respond (30 secs)
ata7: soft resetting port
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7.00: failed to IDENTIFY (I/O error, err_mask=3D0x2)
ata7.00: revalidation failed (errno=3D-5)
ata7: failed to recover some devices, retrying in 5 secs
ata7: hard resetting port
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7.00: failed to IDENTIFY (I/O error, err_mask=3D0x2)
ata7.00: revalidation failed (errno=3D-5)
ata7: failed to recover some devices, retrying in 5 secs
ata7: hard resetting port
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7.00: failed to IDENTIFY (I/O error, err_mask=3D0x2)
ata7.00: revalidation failed (errno=3D-5)
ata7.00: disabled
ata7: EH complete


First I thought it was a cabling or card issue, because the same drive
got kicked twice. That drive was connected to a 2-port SIG sata_sil24
card. However, I just had another drive kicked that's connected to the
onboard sata_nv, which leads me to suspect that the upgraded kernel
might have something to do with it. A quick googling seems to indicate
that others are seeing this with 2.6.18, too, so I was wondering if
anyone knows more. The drives contain science data for analysis, so it
would be a pain (though not a disaster) to lose it. Would it be
advisable to revert to the previous 2.6.17 that I was running before or
is this a problem that's fixed in a later kernel than the one I'm
running now?

I did at the same time also install an Areca ARC1260 controller and
connected a bunch of drives to it, so another idea I had was cable
interference or something (there are now 18 drives in the machine).

Any ideas or thought would be appreciated,

/Patrik




--------------enig04FEAC0060D98E41272AF05F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgJB9T+KvsdUW5p8RAow6AJ0aa0cF7G9zs7MX44L7blYje3g3CwCfRmui
4mTBNWVXYbyOEpzkNMwlAZE=
=zGpf
-----END PGP SIGNATURE-----

--------------enig04FEAC0060D98E41272AF05F--
