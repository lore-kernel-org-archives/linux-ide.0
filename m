From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: ALPM on devices not supporting HIPM?
Date: Tue, 26 Jun 2007 16:08:25 -0700
Message-ID: <20070626160825.79f7b004.kristen.c.accardi@intel.com>
References: <4354d3270706230423p1a1a87bcv34ce1312619f9b7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64890 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760232AbXFZXLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jun 2007 19:11:50 -0400
In-Reply-To: <4354d3270706230423p1a1a87bcv34ce1312619f9b7a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?B?IlT2cvZrIEVkdmluIg==?= <edwintorok@gmail.com>
Cc: power@bughost.org, linux-ide@vger.kernel.org, jeff@garzik.org

On Sat, 23 Jun 2007 14:23:12 +0300
"T=F6r=F6k Edvin" <edwintorok@gmail.com> wrote:

> Hi,
>=20
> With the ALPM patches I get: Unable to set link PM policy.
> [until now I've tested only the combination of your, and Tejun's
> port-stopping patch, as I already reported in a past thread]
> It looks like my device doesn't support hipm, however it supports dip=
m.
> If I make the change below, the ALPM patches work (i.e. no errors,
> ~0.5W and power savings).
> Do you see any problems with enabling alpm on devices supporting dipm
> but not hipm?
>=20
> Thanks,
> Edwin

Hi Edwin - thanks for your email.  I've gotten some clarification on th=
e
spec, and your patch appears to be perfectly legitimate.  Either HIPM
or DIPM support will work for ALPM, and you don't neccessarily need bot=
h.
I will incorportate this into the next round of ALPM patches.

Kristen

>=20
> diff -u 2.6-git/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> --- 2.6-git/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2021,7 +2021,7 @@
>         if (dev->flags & ATA_DFLAG_LBA48)
>                 dev->max_sectors =3D ATA_MAX_SECTORS_LBA48;
>=20
> -       if (ata_id_has_hipm(dev->id))
> +       if (ata_id_has_hipm(dev->id) || ata_id_has_dipm(dev->id))
>                 dev->flags |=3D ATA_DFLAG_IPM;
>         if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
>=20
