From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [git patches] libata build fix
Date: Fri, 9 Oct 2009 10:39:04 +0200
Message-ID: <20091009083903.GA20687@elte.hu>
References: <20091009043248.GA12304@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760286AbZJIIj5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091009043248.GA12304@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


* Jeff Garzik <jeff@garzik.org> wrote:

> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git up=
stream-linus
>=20
> to receive the following updates:
>=20
>  drivers/ata/ahci.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>=20
> Markus Trippelsdorf (1):
>       ahci: Add ifdef wrapper to ahci_gtf_filter_workaround
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 4edca6e..b1a2577 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -2884,6 +2884,7 @@ static bool ahci_broken_online(struct pci_dev *=
pdev)
>  	return pdev->bus->number =3D=3D (val >> 8) && pdev->devfn =3D=3D (v=
al & 0xff);
>  }
> =20
> +#ifdef CONFIG_ATA_ACPI
>  static void ahci_gtf_filter_workaround(struct ata_host *host)
>  {
>  	static const struct dmi_system_id sysids[] =3D {
> @@ -2927,6 +2928,10 @@ static void ahci_gtf_filter_workaround(struct =
ata_host *host)
>  				dev->gtf_filter |=3D filter;
>  	}
>  }
> +#else
> +static inline void ahci_gtf_filter_workaround(struct ata_host *host)
> +{}
> +#endif

btw., i made the slightly different fix below before i saw your fix on=20
lkml, and i think it's slightly cleaner to have a single definition of =
a=20
function instead of an
#else branch.

	Ingo

---------------------->
=46rom 1f4a08ff9647d24d9590a7e23349036dbeafbb1b Mon Sep 17 00:00:00 200=
1
=46rom: Ingo Molnar <mingo@elte.hu>
Date: Fri, 9 Oct 2009 10:13:56 +0200
Subject: [PATCH] ahci: Fix "filter FPDMA non-zero offset enable for Asp=
ire 3810T" on !CONFIG_ATA_ACPI
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Commit f80ae7e ("ahci: filter FPDMA non-zero offset enable for Aspire
3810T") introduced a new build breakage:

  drivers/ata/ahci.c: In function =E2=80=98ahci_gtf_filter_workaround=E2=
=80=99:
  drivers/ata/ahci.c:2927: error: =E2=80=98struct ata_device=E2=80=99 h=
as no member named =E2=80=98gtf_filter=E2=80=99
  make[2]: *** [drivers/ata/ahci.o] Error 1
  make[1]: *** [drivers/ata] Error 2
  make[1]: *** Waiting for unfinished jobs....

As the acpi taskfile command filter support is a property of
libata-acpi - so the ata_device::gtf_filter field only exists
under CONFIG_ATA_ACPI.

Add the trivial #ifdef to turn ahci_gtf_filter_workaround()
into a NOP on !CONFIG_ATA_ACPI.

Cc: Marcus Meissner <meissner@novell.com>
Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/ata/ahci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4edca6e..fc8d527 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2886,6 +2886,7 @@ static bool ahci_broken_online(struct pci_dev *pd=
ev)
=20
 static void ahci_gtf_filter_workaround(struct ata_host *host)
 {
+#ifdef CONFIG_ATA_ACPI
 	static const struct dmi_system_id sysids[] =3D {
 		/*
 		 * Aspire 3810T issues a bunch of SATA enable commands
@@ -2926,6 +2927,7 @@ static void ahci_gtf_filter_workaround(struct ata=
_host *host)
 			ata_for_each_dev(dev, link, ALL)
 				dev->gtf_filter |=3D filter;
 	}
+#endif
 }
=20
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device=
_id *ent)
