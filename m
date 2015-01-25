From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: 64 bit kernel won't mount /
Date: Sun, 25 Jan 2015 16:18:27 -0500
Message-ID: <54C55DA3.4050400@ubuntu.com>
References: <201501191145.41492.gheskett@wdtv.com>	<20150121172326.040dd702@lxorguk.ukuu.org.uk>	<201501211421.35532.gheskett@wdtv.com> <20150122153458.6493d3fd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:13099 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754495AbbAYVSb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jan 2015 16:18:31 -0500
In-Reply-To: <20150122153458.6493d3fd@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Gene Heskett <gheskett@wdtv.com>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 01/22/2015 10:34 AM, One Thousand Gnomes wrote:
> Unlikely. Apart from fdisk the setup is basically invisible. The
> drive reports a block size and an offset. The firmware offset is
> chosen so that the chassic DOS alignments in fdisk happen to just
> fall nicely on 4K boundaries for partition starts.
> 
> There is nothing special the OS does to deal with ATA/SATA 4K
> sectors.

Incorrect: the kernel bogus/synthetic "geometry" is the maximum
allowed of 63 sectors per track, and the old dos default alignment for
the first partition on the disk places its start at sector 63, which
is not 4k aligned.  The special thing that partitioning tools have to
do is to align the partition start to a 4k boundary.  For several
years now, parted has defaulted to 1 MiB alignment, like Windows has
done, which gives a 4k alignment.  I don't recall if Ubuntu 10.04 is
old enough to predate this change.  You certainly do NOT want to use
the cylinder alignment option in gparted.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJUxV2jAAoJENRVrw2cjl5RjZIH/ijuJw1bfOxqHDi5PsfOjZqi
yiH9wGiwJukiwTkfqXoR3hRLemP3WO7vMxf/Ub/+DhmLQR7F3iGlHwfDq/8wQzpQ
2MucBJDT0ARt/I9z/xhPK3bUVdj9ooSUJfHGklhyhijdceAi7M/HwYh9Hftx5Mrn
5qw0N0E6TLNLaNYraJEEqc2aATfXRFcfLrqI5pmRhoT+KCs6IFrggyj4F7uwiaNb
QmrvUPzdAN5jmbVxm+sActWdDG/UDxIXeqLXxJ+N/OwYd4iPh6QNlsPv0/U1R71W
i+ZEoNNH729N1JMQUN/qD7Ut4oNj2nqLzrsVh5K8Z5fRkIXYLIuUMgKn0KJJQDk=
=3PnL
-----END PGP SIGNATURE-----
