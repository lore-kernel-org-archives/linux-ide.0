From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fix Trivial Warnining in drivers/ata/libata-scsi.c
Date: Mon, 27 Apr 2009 18:31:16 +0530
Message-ID: <1240837276.16080.9.camel@subratamodak.linux.ibm.com>
References: <20090427103124.6941.55106.sendpatchset@subratamodak.linux.ibm.com>
	 <49F59F12.3040904@pobox.com>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:52165 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbZD0NB3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Apr 2009 09:01:29 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3RCw51v027064
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2009 06:58:05 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n3RD1R56099590
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2009 07:01:28 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n3RD1Oqu011149
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2009 07:01:27 -0600
In-Reply-To: <49F59F12.3040904@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, linux-ide@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>

Hi Jeff,

On Mon, 2009-04-27 at 08:03 -0400, Jeff Garzik wrote:
> Subrata Modak wrote:
> > Hi Jeff,
> >=20
> > I observed the following warning for drivers/ata/libata-scsi.c:
> >=20
> > drivers/ata/libata-scsi.c: In function =C3=A2=E2=82=AC=CB=9Cata_scs=
i_scan_host=C3=A2=E2=82=AC=E2=84=A2:
> > drivers/ata/libata-scsi.c:3272: warning: =C3=A2=E2=82=AC=CB=9Cdev=C3=
=A2=E2=82=AC=E2=84=A2 may be used uninitialized in this function
> > ---
> >=20
> > In most instances=3D>
> > 	struct ata_device *dev
> > has been initialized except the above instance. My trivial patch be=
low fixes this.
> > Please include it if you like it.
> >=20
> > To: Jeff Garzik <jgarzik@pobox.com>
> > Cc: linux-ide@vger.kernel.org
> > Cc: Balbir Singh <balbir@linux.vnet.ibm.com>
> > Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>
> > Signed-Off-By: Subrata Modak <subrata@linux.vnet.ibm.com>
> > ---
> >=20
> > --- a/drivers/ata/libata-scsi.c	2009-04-27 11:39:27.000000000 +0530
> > +++ b/drivers/ata/libata-scsi.c	2009-04-27 15:52:17.000000000 +0530
> > @@ -3269,7 +3269,7 @@ void ata_scsi_scan_host(struct ata_port=20
> >  	int tries =3D 5;
> >  	struct ata_device *last_failed_dev =3D NULL;
> >  	struct ata_link *link;
> > -	struct ata_device *dev;
> > +	struct ata_device *dev =3D NULL;
> > =20
> >  	if (ap->flags & ATA_FLAG_DISABLED)
>=20
> What was the conclusion of the analysis?  :)
>=20
> Is this a kernel bug, or gcc bug?

Oops. I just wrote the patch to disable the build warning. As, i found
that in other instances of use of the same declaration, it has been
initialized, and the compiler was complaining for this instance alone.
Hence, thought of addressing through a small fix.

Regards--
Subrata

>=20
> 	Jeff
>=20
>=20
>=20
>=20

