From: David Brownell <david-b@pacbell.net>
Subject: Re: some minor issues with 2.6.25-rc6-git7-default
Date: Thu, 27 Mar 2008 14:18:44 -0700
Message-ID: <200803271418.44944.david-b@pacbell.net>
References: <212011377@web.de> <200803271222.41579.david-b@pacbell.net> <20080327134150.5f79dc0b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20080327134150.5f79dc0b.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, rjw@sisk.pl, devzero@web.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, greg@kroah.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-Id: linux-ide@vger.kernel.org

On Thursday 27 March 2008, Andrew Morton wrote:
>=20
> > And there's a regression in mtd/maps/phsymap.c which should
> > be resolved before 2.6.25 ships ... on some platforms it
> > newly likes to oops on reboot.
>=20
> I don't appear to have anything which touches physmap.c here.
>=20
> > I don't have a URL for that patch, but ISTR it's been
> > posted both to LKML and to linux-MTD. =A0(That doesn't
> > include less-good versions I've seen too.) =A0If needed,
> > I can dig it up, but I've been thinking this should have
> > a signoff from MTD folk.
>=20
> Yes, please dig it out and let's look at it.

Posted 13-March, but it wasn't quite new then:

  http://marc.info/?l=3Dlinux-kernel&m=3D120542496625709&w=3D2

I'll forward it again.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
