From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 15:37:38 +0300
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200404151537.38739.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200404150236.05894.kos@supportwizard.com> <407E35E0.3080902@vision.ee> <200404151440.23858.kos@supportwizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200404151440.23858.kos@supportwizard.com>
To: kos@supportwizard.com, Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 15 April 2004 13:40, Konstantin Sobolev wrote:
> On Thursday 15 April 2004 11:12, Lenar L=F5hmus wrote:
> > >for sata_sil:
> > >
> > >/dev/sda:
> > > Timing buffer-cache reads:   1412 MB in  2.00 seconds =3D 705.05 =
MB/sec
> > > Timing buffered disk reads:   84 MB in  3.06 seconds =3D  27.43 M=
B/sec
> > >
> > >So my old IDE HDD appears to be considerably faster. Expected resu=
lts
> > > were 55-70MB/s.
> >
> > With same hard drive connected to 3ware S-ATA controller I got
> > 40-50MB/sec with hdparm on 2.6.4 and 2.6.5. Then
> > tried to hdparm -a 8192 /dev/sda, and got this:
> >
> > /dev/sda:
> >  Timing buffer-cache reads:   2056 MB in  2.00 seconds =3D 1027.13 =
MB/sec
> >  Timing buffered disk reads:  266 MB in  3.00 seconds =3D  88.53 MB=
/sec
> >
> > So you may try that switch, maybe helps.
>
> unfortunately it doesn't:
>
> /dev/sda:
>  setting fs readahead to 8192
>  readahead    =3D 8192 (on)
>  Timing buffered disk reads:   84 MB in  3.06 seconds =3D  27.46 MB/s=
ec

27 Mb/s is not 'very' bad for 80Gb drive.

Can you verify that drive indeed is able to do better
(quick test under Windows is in order)? It would be silly
to try to hunt down problem which do not exist.

If problem does exist, try 2.4 kernels.
--=20
vda
