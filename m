From: Stefan Seyfried <seife@suse.de>
Subject: Re: [patch 1/2] libata: _GTF support
Date: Mon, 9 Oct 2006 13:41:50 +0200
Message-ID: <20061009114150.GA32716@suse.de>
References: <20060927223441.205181000@localhost.localdomain> <20060927153627.c931de2d.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932572AbWJILn7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060927153627.c931de2d.kristen.c.accardi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, rdunlap@xenotime.net, jgarzik@pobox.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Sep 27, 2006 at 03:36:27PM -0700, Kristen Carlson Accardi wrote=
:
> _GTF is an acpi method that is used to reinitialize the drive.  It re=
turns
> a task file containing ata commands that are sent back to the drive t=
o restore
> it to boot up defaults.
>=20
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
>=20
> ---
>  Documentation/kernel-parameters.txt |    5=20
=20
> --- 2.6-mm.orig/Documentation/kernel-parameters.txt
> +++ 2.6-mm/Documentation/kernel-parameters.txt
> @@ -48,6 +48,7 @@ parameter is applicable:
>  	ISAPNP	ISA PnP code is enabled.
>  	ISDN	Appropriate ISDN support is enabled.
>  	JOY	Appropriate joystick support is enabled.
> +	LIBATA  Libata driver is enabled
>  	LP	Printer support is enabled.
>  	LOOP	Loopback device support is enabled.
>  	M68k	M68k architecture is enabled.
> @@ -1013,6 +1014,10 @@ and is between 256 and 4096 characters.=20
>  			emulation library even if a 387 maths coprocessor
>  			is present.
> =20
> +	noacpi		[LIBATA] Disables use of ACPI in libata suspend/resume
> +			when set.
> +			Format: <int>

this will confuse users that already think they can disable ACPI with "=
noacpi"
(instead of "acpi=3Doff") and that already fight with "noapic". I have =
seen too
many confusions of this kind in bugreports.

Couldn't it be made "libata=3Dnoacpi" like we have "pci=3Dnoacpi" alrea=
dy?
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20
