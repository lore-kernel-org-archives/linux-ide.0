From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-tj-stable success report, with minor patch
Date: Mon, 12 Jun 2006 12:39:21 +0900
Message-ID: <448CE1E9.5000502@gmail.com>
References: <20060612022358.GA29164@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:40667 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751246AbWFLDj1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jun 2006 23:39:27 -0400
Received: by py-out-1112.google.com with SMTP id x31so1556880pye
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 20:39:26 -0700 (PDT)
In-Reply-To: <20060612022358.GA29164@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: linux-ide@vger.kernel.org

Jim Paris wrote:
> Hello Tejun,
>=20
> I recently purchased a Norco DS-1220[1] 12-bay SATA enclosure from
> Newegg[2].  It comes with a sil3124-based PCI/X card and uses sil3726
> port multipliers.  Ater unsuccesfully wrestling with buggy proprietry
> drivers included in the box, I found your libata-tj-stable[3] patches
> and applied them to 2.6.16.19.  With the minor fix below, it seems to
> be working wonderfully.  Thank you!!
>=20
> The enclosure takes 4 SATA connections.  Bays appear connected like t=
his:
>   ata1.00    =3D bay 5
>   ata1.01-04 =3D bay 1-4
>   ata2.00    =3D bay 10
>   ata2.01-04 =3D bay 6-9
>   ata3.00    =3D bay 11
>   ata4.00    =3D bay 12
>=20
> Your patches only detected the first 4 out of 5 ports on each PM.
> To fix this, I made this (admittedly na=EFve) change:
>=20
> --- drivers/scsi/libata-pm.orig	2006-06-11 21:01:28.000000000 -0400
> +++ drivers/scsi/libata-pm.c	2006-06-11 21:03:57.000000000 -0400
> @@ -324,7 +324,7 @@
>  	 * it requires hardreset to resume PM links.
>  	 */
>  	if (vendor =3D=3D 0x1095 && devid =3D=3D 0x4726) {
> -		*nr_ports -=3D 2;
> +		*nr_ports -=3D 1;
>  		*link_flags |=3D ATA_LFLAG_HRST_TO_RESUME;
>  	}
>  }
>=20
> The patch is also available here[4], along with dmesg and lspci outpu=
t.
> With this, all 12 bays are working fine.  I also did some limited
> hotplug testing and ran into no problems at all.  Again, thank you!

Hmmm... sil3726 and 4726 report different number of ports depending on=20
configuration.  I'll try to get it right in the next round.  That is a=20
pretty cool enclosure you have there.  How's the performance?

--=20
tejun
