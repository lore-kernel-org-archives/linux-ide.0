From: Alejandro Riveira =?UTF-8?B?RmVybsOhbmRleg==?=
	<ariveira@gmail.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Wed, 6 Apr 2011 23:00:21 +0200
Message-ID: <20110406230021.2ab54966@varda>
References: <C1438B59050E1B4C9482FF3266AD6BA32C7493557A@gretna.indigovision.com>
	<C1438B59050E1B4C9482FF3266AD6BA32C7493559F@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33423 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab1DFVAl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Apr 2011 17:00:41 -0400
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32C7493559F@gretna.indigovision.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

El Wed, 6 Apr 2011 15:57:06 +0100
Bruce Stenning <b.stenning@indigovision.com> escribi=C3=B3:


 Just CCing linux-ide

> Please accept my most humble apologies for the lack of line breaks in
> my previous email.  Here it is again, this time in a more readable
> format:
>=20
> Hello,
>=20
> We have a bespoke platform utilising a Marvell MV88SX6041 SATA contro=
ller
> on which we have been running Linux 2.6.26 and using the sata_mv driv=
er.
>=20
> We have noticed problems with SATA ports occasionally locking up (on
> hotplug events) and remaining unresponsive.  The normal kernel loggin=
g
> that occurs on hotplug events is no longer emitted for the locked por=
ts
> (but will be emitted for the other sata ports that have not exhibited
> the problem.)  The disks attached to the locked ports are completely
> unresponsive.  The condition can be cleared by removing the sata_mv
> kernel module from memory and reloading it, after which the kernel
> logging becomes active (and the disks are usable) for all ports.
>=20
> The following changeset was seen as a strong candidate for addressing
> this problem:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D933cb8e5fcdebd4b666165e3f039f814d62b0e52
>=20
> We are now in the process of upgrading to the stable 2.6.38.2 kernel
> release, but initial testing of this on our platform exhibits the sam=
e
> hotplug behaviour.  Hotplug is possible, but occasionally the ports
> will lock up and not be responsive until sata_mv is removed and
> reinstalled.  Other than this, the new kernel and driver seem to be
> operating normally.
>=20
> Has this problem been observed elsewhere with kernels that include th=
e
> above patch?  Please CC me in replies.
>=20
> Kind Regards,
>=20
> Bruce Stenning,
> IndigoVision,
> b <dot> stenning <at> indigovision <dot> com
>=20
>=20
> Latest News at: http://www.indigovision.com/news2011.php
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
