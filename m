From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata build fix
Date: Fri, 09 Oct 2009 17:53:13 -0400
Message-ID: <4ACFB0C9.605@garzik.org>
References: <20091009043248.GA12304@havoc.gtf.org> <20091009083903.GA20687@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [207.36.208.214] ([207.36.208.214]:42783 "EHLO mail.dvmed.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S934514AbZJIVyE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Oct 2009 17:54:04 -0400
In-Reply-To: <20091009083903.GA20687@elte.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 10/09/2009 04:39 AM, Ingo Molnar wrote:
> From: Ingo Molnar<mingo@elte.hu>
> Date: Fri, 9 Oct 2009 10:13:56 +0200
> Subject: [PATCH] ahci: Fix "filter FPDMA non-zero offset enable for A=
spire 3810T" on !CONFIG_ATA_ACPI
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: 8bit
>
> Commit f80ae7e ("ahci: filter FPDMA non-zero offset enable for Aspire
> 3810T") introduced a new build breakage:
>
>    drivers/ata/ahci.c: In function =E2=80=98ahci_gtf_filter_workaroun=
d=E2=80=99:
>    drivers/ata/ahci.c:2927: error: =E2=80=98struct ata_device=E2=80=99=
 has no member named =E2=80=98gtf_filter=E2=80=99
>    make[2]: *** [drivers/ata/ahci.o] Error 1
>    make[1]: *** [drivers/ata] Error 2
>    make[1]: *** Waiting for unfinished jobs....
>
> As the acpi taskfile command filter support is a property of
> libata-acpi - so the ata_device::gtf_filter field only exists
> under CONFIG_ATA_ACPI.
>
> Add the trivial #ifdef to turn ahci_gtf_filter_workaround()
> into a NOP on !CONFIG_ATA_ACPI.
>
> Cc: Marcus Meissner<meissner@novell.com>
> Cc: Jeff Garzik<jgarzik@redhat.com>
> Signed-off-by: Ingo Molnar<mingo@elte.hu>
> ---
>   drivers/ata/ahci.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 4edca6e..fc8d527 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -2886,6 +2886,7 @@ static bool ahci_broken_online(struct pci_dev *=
pdev)
>
>   static void ahci_gtf_filter_workaround(struct ata_host *host)
>   {
> +#ifdef CONFIG_ATA_ACPI
>   	static const struct dmi_system_id sysids[] =3D {
>   		/*
>   		 * Aspire 3810T issues a bunch of SATA enable commands
> @@ -2926,6 +2927,7 @@ static void ahci_gtf_filter_workaround(struct a=
ta_host *host)
>   			ata_for_each_dev(dev, link, ALL)
>   				dev->gtf_filter |=3D filter;
>   	}
> +#endif
>   }


Either way is fine with me.  I tend to prefer conditional compilation t=
o=20
be outside a function, but it's not a big deal.  Linus can pull my=20
submit, or add
	Acked-by: Jeff Garzik <jgarzik@redhat.com>
to this Ingo patch.

Same end result; whichever makes people happier, and fixes builds the=20
most rapidly...

	Jeff



