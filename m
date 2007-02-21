From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: Re: [git patches] libata ACPI support
Date: Wed, 21 Feb 2007 12:39:23 +0100
Message-ID: <20070221113923.GA5143@mail.muni.cz>
References: <20070220214716.GA3690@mail.muni.cz> <45DB74D9.206@garzik.org> <20070220232633.GA3598@mail.muni.cz> <45DB88FD.5020509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751208AbXBULjK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45DB88FD.5020509@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Feb 20, 2007 at 06:49:17PM -0500, Jeff Garzik wrote:
> Can you narrow down the -gitX release further?  i.e. does 2.6.20-git1=
3=20
> perform at full speed?  -git13 includes several libata changes, but d=
oes=20
> not include the ACPI additions.
>=20
> Since this is an ACPI execution error in the bug, that would tend to=20
> point to bad BIOS tables.  But since there is a performance drop that=
=20
> does not disappear with acpi=3Doff, there might also be another facto=
r,=20
> unrelated to ACPI, at play here.

I have found that the issue is between git12 and git13.

I have also found another issue, not sure whether it is also presented =
by
git13, however in git15, IDE interrupts are no more unmasked.=20

--=20
Luk=E1=B9 Hejtm=E1nek
