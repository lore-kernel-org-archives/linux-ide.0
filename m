From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Q on SATA/AHCI - AHCI driver changes for device reset and testing
Date: Fri, 20 Mar 2009 23:51:07 -0400
Message-ID: <49C4642B.1070104@pobox.com>
References: <4D48560FCC5CEA4C8A337994ED7C762BB13AEBC2@rrsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53298 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759501AbZCUDvP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Mar 2009 23:51:15 -0400
In-Reply-To: <4D48560FCC5CEA4C8A337994ED7C762BB13AEBC2@rrsmsx505.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Konkle, Timothy A" <timothy.a.konkle@intel.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Konkle, Timothy A wrote:
> Jeff,
>=20
> =20
>=20
> Hopefully this is an easy, quick question=85
>=20
> =20
>=20
> I am trying to write code to stress test/diagnose SATA SSD drives und=
er=20
> AHCI (on Linux obviously).
>=20
> It seems for speed and certain types of info (physical link, HBA=20
> settings and such), that I want to switch user level code from=20
> sg3_util/sg.ko down to changes directly in the ahci.ko module.  Does=20
> this seem correct?
>=20
> =20
>=20
> Basically, I am trying to first issue COMReset to particular drives f=
or=20
> instance (from a python script->shared lib C code), then reset bus an=
d=20
> adjust speed and more=85  Pointers on locations to make code=20
> modifications?  I was expecting to find an ioctl() like mechanism in=20
> ahci.c much like the scsi/sg modules=85  I am using kernel 2.6.24, th=
ough=20
> I can use later kernels too.  Basically I am trying to build up a tes=
t=20
> and validation shared library that will be call able from python code=
=20
> and see controllers, devices, command lists, FIS data and build out a=
=20
> test library with data collection and COMReset as first stop.
>=20
> =20
>=20
> =20
>=20
> I=92m just starting through device driver development with books such=
 as=20
> Linux Device Drivers 3^rd ed, Essential Linux Device Drivers (can=92t=
 find=20
> that book=92s code) and many others.  So it seems that I have most da=
ta=20
> I=92d need to reset a device in ahci.ko and just add in a /proc inter=
face=20
> for user control to request a device reset via it=92s HBA controller.=
  Is=20
> ahci.c a poor choice as it is controller/used by higher level drivers=
=20
> such as libata, sd or other modules?
>=20
> =20
>=20
> Is there already source code in Linux that shows how to do this sort =
of=20
> thing?  Everything I=92ve seen so far uses slower and a bit higher le=
vel SG.

Support for online diagnostics and testing within libata is quite=20
limited, since that is not needed by the majority of our users.

The SG_IO ioctl and SCSI-specified ATA(12) and ATA(16) commands specify=
=20
various types of resets.  Changes to libata to support these resets=20
would probably be the easiest initial change, and least amount of work.

Dumping full internals is probably not something we would want in the=20
kernel driver -- too much code space for too little user value -- but=20
something like networking's ETHTOOL_GREGS would be reasonable for SATA=20
drivers.  Userspace could handle things from there.

Other controls like per-port SATA phy controls we have wanted for a=20
while; the appropriate place to put those is in sysfs, not procfs.

	Jeff



