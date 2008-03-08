From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: Problem with ahci and a external sata disk
Date: Sat, 8 Mar 2008 11:03:09 +0100
Message-ID: <200803081103.09542.jareguero@telefonica.net>
References: <200802191646.39277.jareguero@telefonica.net> <200803072333.12877.jareguero@telefonica.net> <47D1E106.2020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmailhost.telefonica.net ([213.4.149.242]:55129 "EHLO
	ctsmtpout4.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751583AbYCHKDN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Mar 2008 05:03:13 -0500
In-Reply-To: <47D1E106.2020501@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

El S=E1bado, 8 de Marzo de 2008, Tejun Heo escribi=F3:
> Jose Alberto Reguero wrote:
> >> I noticed that :
> >>   R/W multiple sector transfer: Max =3D 1   Current =3D 0
> >>
> >> It is important?
>
> Nope, it's just for PIOs.
>
> > I did more tests. I put:
> >
> > options libata force=3D4:1.5g,udma0
> >
> > and the ICRC errors still appear. But only writing. I try with the =
device
> > at top speed(3G) and reading the errors don't appear.
>
> UDMA mode shouldn't affect anything unless the drive is actually PATA
> bridged over SATA and configuring lower UDMA mode makes it transfer d=
ata
> slower and changes transfer pattern on the link.
>
> > Another thing is that when limiting the speed to 1.5G, the real rea=
d
> > speed don't seem to change and is about 2 times the read speed that=
 I
> > have with a SATA-I device. Is like limiting the speed to 1.5G don't=
 do
> > nothing.
>
> 1.5Gbps means 150Mbytes/s and harddrives are yet to reach such
> performance level, so 1.5 or 3.0 doesn't really make any difference
> performance-wise yet.
>
> > I will try the disk in a SATA-I port.
>
> Can you also give a shot at shorter cable?
>
> Thanks.

I have a esata 1m cable. I don't have a shorter cable.
I think I go to use only in usb mode, that appears to work well.

Thanks.
Jose Alberto
