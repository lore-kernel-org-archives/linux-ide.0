From: Konstantin Sobolev <kos@supportwizard.com>
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 14:40:23 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404151440.23858.kos@supportwizard.com>
References: <200404150236.05894.kos@supportwizard.com> <407E35E0.3080902@vision.ee>
Reply-To: kos@supportwizard.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.rol.ru ([194.67.21.9]:34558 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S261804AbUDOKhs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Apr 2004 06:37:48 -0400
Received: from 81.211.110.66.adsl-spb.net.rol.ru ([81.211.110.66]:7808 "EHLO
	81.211.110.66.adsl-spb.net.rol.ru" smtp-auth: <none> TLS-CIPHER: <none>
	TLS-PEER-CN1: <none>) by gnome03.net.rol.ru with ESMTP
	id S17474253AbUDOKhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Thu, 15 Apr 2004 14:37:42 +0400
In-Reply-To: <407E35E0.3080902@vision.ee>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 15 April 2004 11:12, Lenar L=F5hmus wrote:
> >for sata_sil:
> >
> >/dev/sda:
> > Timing buffer-cache reads:   1412 MB in  2.00 seconds =3D 705.05 MB=
/sec
> > Timing buffered disk reads:   84 MB in  3.06 seconds =3D  27.43 MB/=
sec
> >
> >So my old IDE HDD appears to be considerably faster. Expected result=
s were
> >55-70MB/s.
>
> With same hard drive connected to 3ware S-ATA controller I got
> 40-50MB/sec with hdparm on 2.6.4 and 2.6.5. Then
> tried to hdparm -a 8192 /dev/sda, and got this:
>
> /dev/sda:
>  Timing buffer-cache reads:   2056 MB in  2.00 seconds =3D 1027.13 MB=
/sec
>  Timing buffered disk reads:  266 MB in  3.00 seconds =3D  88.53 MB/s=
ec
>
> So you may try that switch, maybe helps.

unfortunately it doesn't:

/dev/sda:
 setting fs readahead to 8192
 readahead    =3D 8192 (on)
 Timing buffered disk reads:   84 MB in  3.06 seconds =3D  27.46 MB/sec
--=20
/KoS
* Searching for light in the darkness of insanity.		     =20
