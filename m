From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Fix Trivial Warnining in drivers/ata/libata-scsi.c
Date: Mon, 27 Apr 2009 08:03:30 -0400
Message-ID: <49F59F12.3040904@pobox.com>
References: <20090427103124.6941.55106.sendpatchset@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52210 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615AbZD0MDg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Apr 2009 08:03:36 -0400
In-Reply-To: <20090427103124.6941.55106.sendpatchset@subratamodak.linux.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, linux-ide@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>

Subrata Modak wrote:
> Hi Jeff,
>=20
> I observed the following warning for drivers/ata/libata-scsi.c:
>=20
> drivers/ata/libata-scsi.c: In function =E2=80=98ata_scsi_scan_host=E2=
=80=99:
> drivers/ata/libata-scsi.c:3272: warning: =E2=80=98dev=E2=80=99 may be=
 used uninitialized in this function
> ---
>=20
> In most instances=3D>
> 	struct ata_device *dev
> has been initialized except the above instance. My trivial patch belo=
w fixes this.
> Please include it if you like it.
>=20
> To: Jeff Garzik <jgarzik@pobox.com>
> Cc: linux-ide@vger.kernel.org
> Cc: Balbir Singh <balbir@linux.vnet.ibm.com>
> Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>
> Signed-Off-By: Subrata Modak <subrata@linux.vnet.ibm.com>
> ---
>=20
> --- a/drivers/ata/libata-scsi.c	2009-04-27 11:39:27.000000000 +0530
> +++ b/drivers/ata/libata-scsi.c	2009-04-27 15:52:17.000000000 +0530
> @@ -3269,7 +3269,7 @@ void ata_scsi_scan_host(struct ata_port=20
>  	int tries =3D 5;
>  	struct ata_device *last_failed_dev =3D NULL;
>  	struct ata_link *link;
> -	struct ata_device *dev;
> +	struct ata_device *dev =3D NULL;
> =20
>  	if (ap->flags & ATA_FLAG_DISABLED)

What was the conclusion of the analysis?  :)

Is this a kernel bug, or gcc bug?

	Jeff




