From: Jim Paris <jim@jtan.com>
Subject: Re: Warnings on shutdown (Debian Etch and Kernel 2.6.22.9)
Date: Thu, 25 Oct 2007 15:45:51 -0400
Message-ID: <20071025194551.GA8566@jim.sh>
References: <471DC728.60705@mandic.com.br> <471DC8F1.9090501@gmail.com> <471DCA74.503@mandic.com.br> <471DCB33.5070108@gmail.com> <471DD288.7010902@mandic.com.br> <471DE866.7040908@gmail.com> <20071023234732.GA23598@jim.sh> <471F493C.8050804@mandic.com.br> <471F4B11.9030206@gmail.com> <47208144.9080602@mandic.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:33230 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbXJYTqZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 15:46:25 -0400
Content-Disposition: inline
In-Reply-To: <47208144.9080602@mandic.com.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, debian-devel@lists.debian.org, linux-ide@vger.kernel.org, miquels@cistron.nl

Renato S. Yamane wrote:
> Tejun Heo wrote:
> >Renato S. Yamane wrote:
> >>Jim Paris wrote:
> >>>For Debian, I don't think there are any complete solutions yet.
> >>>The related bug is  =20
> >>>http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D426224
> >>
> >>I think that we can fix this if someone can answer this:
> >>
> >>$ man halt
> >>"-h flag: This is important for IDE drives, since the kernel doesn=E2=
=80=99t=20
> >>flush the write cache itself before power-off.."
> >>
> >>How can I know if kernel write cache itself? :-)
> >
> >Kernel has been flushing write cache for many many years now.  Man p=
age=20
> >needs update.  Also, flushing cache from halt is okay.  What's hurti=
ng=20
> >is spinning down the drive from halt.
>=20
> So, I think that halt script need know:
>=20
> - How many and who is IDE drives and SCSI/SATA drives.
> - Devices with manage_start_stop as "0" or without manage_start_stop=20
> need "halt -h".
> - Devices with manage_start_stop as "1" need only "halt".
>=20
> This is correct?

The real changes need to be made in the shutdown utility,
as described here:
  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D426224#10

-jim
