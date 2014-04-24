From: Phillip Susi <psusi@ubuntu.com>
Subject: Performance issue with port multiplier
Date: Wed, 23 Apr 2014 22:42:34 -0400
Message-ID: <53587A1A.2060904@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:37841 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751269AbaDXCmf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2014 22:42:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I recently picked up a Thermaltake BlacX Duet dual drive esata dock
and I am having some performance problems trying to use both drives
concurrently.  The link is running at 3 Gbps both to the PMP and from
there to each drive.  An individual drive pulls ~175 MB/s, but trying
to use both drops to ~60 MB/s each.  This is with a simple sequential
dd to /dev/null with a 1 MiB block size.  Oddly, disabling NCQ results
in an increase to ~80 MB/s per drive.  I wouldn't think that NCQ would
really help for a sequential read, but it certainly shouldn't hurt.

Now it does seem that my intel ahci chipset does not support fis based
switching, but it doesn't seem like that should make a whole lot of
difference for sequential IO since while you are busy sending commands
to one drive, the other should still be performing its own readahead
into its cache and be ready to satisfy the request quickly once the
first drive finishes.

How can this behavior make sense?  Any ideas on other things I could try?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJTWHoaAAoJEI5FoCIzSKrwgY4H/jIJw7EC8Oh6eXqNma67tVfn
eNYgjKOKv1qsn4QDAva1F6TyUdmTzeKVoym4yxOgu51hPzcnPCoeOyOg0ZNNbOSa
QSUxWHfgeGVHQvn5j30AZDqbfyIXd062mAjwDndFl4QSYRmAsZmijRavR33bZ8LP
S81myeHoRSSIJNJDkRAXtiJckUxjU8HdDkLzvowGCcvgn6MNi6uMtaNepdCOGD5V
9u91uUB7HcsrfBCPutSW3Yv1GoSn4wEPL0/lIzqfP0q81qErsWjXkjqi8VEYXPys
FcNT4lSGH0isjSCBtatDYMaWolLsOdkeZW4gwx07WyvsOP4H5fKFpVNrkFoAjoE=
=X8IN
-----END PGP SIGNATURE-----
