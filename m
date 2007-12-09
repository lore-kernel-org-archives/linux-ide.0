From: Zan Lynx <zlynx@acm.org>
Subject: Re: 2.6.24-rc4-mm1 and Very Slow PCMCIA Compact Flash
Date: Sat, 08 Dec 2007 20:02:54 -0700
Message-ID: <1197169375.7352.4.camel@localhost>
References: <1197059904.15428.15.camel@localhost>
	 <20071207150251.a0dbae23.akpm@linux-foundation.org>
	 <1197068983.15428.29.camel@localhost>
	 <20071207152249.360af326.akpm@linux-foundation.org>
	 <1197090093.7157.2.camel@localhost>
	 <20071208020722.9c7d91d0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-00f9FNs4S+O8bXYPfJrx"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754237AbXLIDDS@vger.kernel.org>
In-Reply-To: <20071208020722.9c7d91d0.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org


--=-00f9FNs4S+O8bXYPfJrx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Sat, 2007-12-08 at 02:07 -0800, Andrew Morton wrote:
> On Fri, 07 Dec 2007 22:01:33 -0700 Zan Lynx <zlynx@acm.org> wrote:
>=20
> >=20
> > On Fri, 2007-12-07 at 15:22 -0800, Andrew Morton wrote:
> > > On Fri, 07 Dec 2007 23:09:43 +0000
> > > Zan Lynx <zlynx@acm.org> wrote:
> > [cut]=20
> > > > > > Now with MM kernels 2.6.24 rc1-4 the PCMCIA adapter works again=
, but I
> > > > > > only get read rates of 1.6 MB/s.  When it used to work in 2.6.2=
0 I got
> > > > > > at least 16 MB/s.  The card itself is capable of 30+ in the USB=
-2
> > > > > > reader.
[cut]
> argh.  OK.  And Linus's current tree is OK, yes?
>=20
> In which case we should be OK for 2.6.24 and I guess we can hope like hec=
k
> that the dud patch doesn't leak into mainline.  Hopefully Alan will get
> some time to look into it before 2.6.25 opens.

Linus' tree is also broken.

I tried a Linus 2.6.24-rc4 and it acts the same way, with a very slow
transfer rate. =20

I also tried 2.6.24-rc4 with the older not-libata PATA drivers and it is
broken.  dmesg had a line about the CF card detected as hda,
but /sys/block did not have hda and /dev/hda did not function.

I will try the patches you mentioned, but I think I may also have to
work backward through kernel versions until I find the last one where
the PCMCIA hd{a,b,c,d,e} drivers worked.
--=20
Zan Lynx <zlynx@acm.org>

--=-00f9FNs4S+O8bXYPfJrx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBHW1reG8fHaOLTWwgRApdMAJ40DD7rBfGI683F32oRMr2JjtlFsQCeP2Vs
iIlnID95w9z9u7mrRMMoUjk=
=Ruya
-----END PGP SIGNATURE-----

--=-00f9FNs4S+O8bXYPfJrx--

