From: Scott James Remnant <scott@ubuntu.com>
Subject: Re: Serial ATA (SATA) shutdown info
Date: Tue, 15 May 2007 16:46:32 +0100
Message-ID: <1179243992.16527.56.camel@quest.netsplit.com>
References: <1179232945.16527.25.camel@quest.netsplit.com>
	 <711b967b0705150834sdd14538x459119386c19a7ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3XBsGlOSAXzWXhxJDQDi"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from paperboy.netsplit.com ([82.108.80.242]:56347 "EHLO
	paperboy.netsplit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757428AbXEOPqX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 11:46:23 -0400
In-Reply-To: <711b967b0705150834sdd14538x459119386c19a7ac@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, 114683@bugs.launchpad.net


--=-3XBsGlOSAXzWXhxJDQDi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-15 at 17:34 +0200, Tejun Heo wrote:

> Hello, Scott.
>=20
Hi, Thanks for your quick reply!

> > Secondly, we've never attempted any workarounds for libata.  Our
> > halt/reboot only iterates /proc/ide, which should be empty for
> > libata-based systems - therefore we've never issued FLUSH CACHE or
> > STANDBYNOW on libata drives from userspace.
> >
> > In this case, how should we proceed?
> >
> >  * Check whether /sys/modules/libata/parameters/spindown_compat exists.
> >    If it does, write 0 to it.
> >
> > Since we've never been broken, can we not arrange for this to be always
> > zero?  Perhaps just writing to it on boot?
>=20
> Yes, you can clear that node anytime you want and if your shutdown
> utilities don't issues FLUSH and STANDBY for libata disks on shutdown,
> that's the only thing you'll need to do.  This is still in discussion
> but you might not have to do even that.  Please read the following
> thread.
>=20
>   http://article.gmane.org/gmane.linux.ide/18846
>=20
> I'll update you when things are determined.  It might be that you
> don't have to do anything.  Sorry about the fuss.
>=20
That's no problem, it's good to finally get this stuff cleaned up a
little.  We have an inherent preference for the cleanest and simplest
implementation, obviously :-)  If that means no userspace code, and just
call reboot(), WIN!

> > For each libata harddisk
> >
> >       * Check whether /sys/class/scsi_disk/h:c:i:l/manage_start_stop
> >         exists. If it doesn't, synchronize cache and spin the disk down
> >         as before. If it does, do nothing and continue to the next disk=
.
> >         The file is also accessible
> >         as /sys/block/sdX/device/scsi_disk:*/manage_start_stop.
> >
> > What's the reason for needing to flush the cache and standby the disk b=
y
> > hand?  What are the circumstances where the manage_start_stop will not
> > exist?
>=20
> On all kernels upto 2.6.21, libata doesn't issue STANDBYNOW on
> shutdown, so some distros including Debian do it during userland
> shutdown.  This isn't a complete solution but most disks don't spin up
> on the following kernel FLUSH, so it's better than not doing anything
> which results in emergency unload for all disks.
>=20
Since we've been running with 2.6.x and libata for a while, without
bothering to do this, is there any harm in continuing to not do this?

It's obviously not a regression for us, and we can answer "upgrade to
7.10" quite cheerfully if it turns out there are people with bugs (which
they will have always had).


I'll keep an eye on the thread you linked to, if we don't even need to
write any zeros, we're definitely happy people :-)

Scott
--=20
Scott James Remnant
Ubuntu Development Manager
scott@ubuntu.com

--=-3XBsGlOSAXzWXhxJDQDi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGSdXYSnQiFMl4yK4RAlwBAJwJQ4jVa7lg94zvnXIR/z2UNr8mgQCfSNle
QEfd4prBpuWbumb1nvKRNw4=
=KdAS
-----END PGP SIGNATURE-----

--=-3XBsGlOSAXzWXhxJDQDi--

