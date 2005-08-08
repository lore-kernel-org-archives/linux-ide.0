From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata and PATA devices
Date: Mon, 08 Aug 2005 10:43:41 +0900
Message-ID: <42F6B8CD.4050100@gmail.com>
References: <200508071949.03782.inform@tiker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:53164 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1753225AbVHHBnt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Aug 2005 21:43:49 -0400
Received: by wproxy.gmail.com with SMTP id i20so749327wra
        for <linux-ide@vger.kernel.org>; Sun, 07 Aug 2005 18:43:47 -0700 (PDT)
In-Reply-To: <200508071949.03782.inform@tiker.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Andreas_Kl=F6ckner?= <inform@tiker.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org


  Hello, Andreas.


Andreas Kl=F6ckner wrote:
> Hey Jeff, all,
>=20
> I was wondering why ATA_ENABLE_PATA and ATA_ENABLE_ATAPI are #undef'e=
d in=20
> include/linux/libata.h by default, since reverting them to #define's =
was the=20
> only way to make the ata-piix driver detect my CDROM on my new shiny =
ThinkPad=20
> (Intel Corp. 82801FBM (ICH6M) SATA Controller). I would assume that m=
ost=20
> people would want this. The drive worked out of the box on Ubuntu, so=
 I=20
> assume that their vendor patch includes this anyway.
>=20
> Is there a specific reason that these are disabled? Are there any bad=
=20
> consequences that I'm not aware of? Only reading the source really re=
vealed=20
> that this was the way to get my CD-ROM to work.

  SATA ATAPI support still has some issues, but as you can read from th=
e=20
following post, libata is almost there now.

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D112261379120567&w=3D=
2

  I don't know much about PATA support.  All I know is that ICH's seem=20
to generate a lot of noise in this mailing list w/ its legacy, combined=
,=20
ahci and whatever modes and no one setting seems to satisfy all.  (If=20
anyone knows more about it, please fill in here.)

--=20
tejun
