From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 0/3] AHCI updates: Marvell AHCI PATA works;
	pata_marvell fate?
Date: Fri, 17 Apr 2009 21:03:16 +0300
Message-ID: <20090417180316.GA7134@sci.fi>
References: <20090417023949.GA14469@havoc.gtf.org> <20090417105031.607a771e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762345AbZDQSDa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090417105031.607a771e@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Apr 17, 2009 at 10:50:31AM +0100, Alan Cox wrote:
> > Marvell PATA on 6121 and similar chips should also work, but that h=
asn't
> > yet been tested.  Here's the full list of what still needs testing:
> >=20
> > - master + slave devices
> > - ATAPI
> > - 6121 (6123? others?)
>=20
> LBA48
>=20
>=20
> >=20
> > Also, there is the open question of how to deal with pata_marvell
> > co-existence
>=20
> I think for the moment make PATA support by AHCI a config option and =
as
> soon as we trust it we can get rid of the option and of pata_marvell.

How does this relate to 6101 which is a PATA only controller? Would tha=
t
continue to use pata_marvell or does this new stuff support such things
too?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
