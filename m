From: David Brownell <david-b@pacbell.net>
Subject: Re: some minor issues with 2.6.25-rc6-git7-default
Date: Thu, 27 Mar 2008 12:22:41 -0700
Message-ID: <200803271222.41579.david-b@pacbell.net>
References: <212011377@web.de> <200803260010.25327.rjw@sisk.pl> <20080325164236.1061d403.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20080325164236.1061d403.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-mtd@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, devzero@web.de, linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Greg KH <greg@kroah.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

On Tuesday 25 March 2008, Andrew Morton wrote:
>=20
> > > Mar 23 09:17:02 opensuse103 kernel: physmap-flash: probe of physm=
ap-flash.0 failed with error -12
>=20
> There are many physmap-flashes in the tree. =A0Is this one
> drivers/mtd/maps/physmap.c?

And there's a regression in mtd/maps/phsymap.c which should
be resolved before 2.6.25 ships ... on some platforms it
newly likes to oops on reboot.

I don't have a URL for that patch, but ISTR it's been
posted both to LKML and to linux-MTD.  (That doesn't
include less-good versions I've seen too.)  If needed,
I can dig it up, but I've been thinking this should have
a signoff from MTD folk.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
