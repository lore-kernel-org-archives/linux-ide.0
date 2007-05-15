From: Scott James Remnant <scott@ubuntu.com>
Subject: Serial ATA (SATA) shutdown info
Date: Tue, 15 May 2007 13:42:25 +0100
Message-ID: <1179232945.16527.25.camel@quest.netsplit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ewMQFDMubBBw1Wi7u5a1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from paperboy.netsplit.com ([82.108.80.242]:44504 "EHLO
	paperboy.netsplit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758990AbXEOMs4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 08:48:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: 114683@bugs.launchpad.net


--=-ewMQFDMubBBw1Wi7u5a1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi there,

I'm the author of Upstart (the init system used by Ubuntu, and other
distributions) and was directed to the following page in order to update
compatibility with newer kernels and libata:

	http://linux-ata.org/shutdown.html


Unfortunately after reading this, things still aren't entirely clear to
me.  Right now, Upstart is using roughly the same halt/reboot code as
sysvinit -- this has rather a lot of baggage, so I've been trying to
slim it down recently, and thus reading the same code paths you seem to
have been.

If you could help me through my confusion, that would be greatly
appreciated.


  "In ATA, this is achieved by issuing FLUSH CACHE followed by
   STANDBYNOW and the IDE drivers (drivers/ide/*) have always issued the
   sequence prior to powering off."

This is the code path I've been looking through, and I concur with your
assessment.  IDE drives using the IDE subsystem are powered down (by
generic_ide_suspend() called by ide_device_shutdown)


The sysvinit in Debian (and Upstart in Ubuntu) use the following
procedure during shutdown:

 * sync()
 * Open /proc/ide, iterate all hd* devices found there
 * Check /proc/ide/*/media is "disk"
 * Open the device in /dev
 * Issue WIN_STANDBYNOW1
 * Issue WIN_STANDBYNOW2

No attempt is made to flush the disk cache, other than calling sync().


Firstly, since it appears that the kernel already takes care of flushing
the cache and standbying the disk, it would appear that this code in our
halt/reboot binary is entirely useless.  In some cases this would mean
that the drive was placed into standby, before the kernel flushes its
caches, bringing the drive out of standby with the clicking sound.  (For
the *IDE* subsystem, not libata).

Can we simply drop this code entirely? (I've been of the opinion we can,
but it's nice to get expert confirmation).


Secondly, we've never attempted any workarounds for libata.  Our
halt/reboot only iterates /proc/ide, which should be empty for
libata-based systems - therefore we've never issued FLUSH CACHE or
STANDBYNOW on libata drives from userspace.

In this case, how should we proceed?

 * Check whether /sys/modules/libata/parameters/spindown_compat exists.
   If it does, write 0 to it.

Since we've never been broken, can we not arrange for this to be always
zero?  Perhaps just writing to it on boot?


For each libata harddisk

      * Check whether /sys/class/scsi_disk/h:c:i:l/manage_start_stop
        exists. If it doesn't, synchronize cache and spin the disk down
        as before. If it does, do nothing and continue to the next disk.
        The file is also accessible
        as /sys/block/sdX/device/scsi_disk:*/manage_start_stop.
       =20
What's the reason for needing to flush the cache and standby the disk by
hand?  What are the circumstances where the manage_start_stop will not
exist?

Obviously I'd rather our halt/reboot binary was literally a thin wrapper
around the reboot() system call, without special logic.  Since we're
going to have to code the above logic, I'd like to make sure it's going
in the right place.

Also what's the canon way to synchronise the cache and spin the disk
down?  How do we iterate libata harddisks, and map to the correct name
in /dev ?

Scott
--=20
Scott James Remnant
Ubuntu Development Manager
scott@ubuntu.com

--=-ewMQFDMubBBw1Wi7u5a1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGSaqxSnQiFMl4yK4RApcqAKClBVnCjnP70jOfLoXHXYyakOh2dgCfWKre
LXfzYeXRlKvf39hFaydgigM=
=AX31
-----END PGP SIGNATURE-----

--=-ewMQFDMubBBw1Wi7u5a1--

