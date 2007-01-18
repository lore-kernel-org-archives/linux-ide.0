From: "Dailey, Nate" <Nate.Dailey@stratus.com>
Subject: RE: sata_vsc.c cache line size question
Date: Thu, 18 Jan 2007 09:42:44 -0500
Message-ID: <92952AEF1F064042B6EF2522E0EEF43703EE318A@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C73B0E.E9C3E351"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.stratus.com ([134.111.1.18]:35658 "EHLO
	mailhub5.stratus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbXAROmp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jan 2007 09:42:45 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73B0E.E9C3E351
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Okay, trying again as an attachment...

Nate

=20

-----Original Message-----
From: Jeremy Higdon [mailto:jeremy@sgi.com]=20
Sent: Thursday, January 18, 2007 2:12 AM
To: Dailey, Nate
Cc: linux-ide@vger.kernel.org
Subject: Re: sata_vsc.c cache line size question

On Mon, Jan 15, 2007 at 11:26:59AM -0500, Dailey, Nate wrote:
> Here's a patch that does what you suggest.
>=20
> Because the default cache line size on my system is 0x10, I tested the
> patch by checking against this value rather than 0... it worked as
> expected.
>=20
> This patch is against 2.6.19.2 that I just downloaded from kernel.org.
I
> actually tested on RHEL4 update 4, a 2.6.9 kernel, but I'll try
building
> the 2.6.19.2 on my system to make sure it works in that version as
well.
>=20
> Nate

Hi Nate,

The patch looks fine, except that your mailer wrapped the lines.
Try sending it as a text attachment instead.

Thanks

jeremy

>=20
> --- sata_vsc.c.orig     2007-01-15 11:06:17.000000000 -0500
> +++ sata_vsc.c  2007-01-15 11:10:29.000000000 -0500
> @@ -340,6 +340,7 @@ static int __devinit vsc_sata_init_one (
>         int pci_dev_busy =3D 0;
>         void __iomem *mmio_base;
>         int rc;
> +       u8 cls;
>=20
>         if (!printed_version++)
>                 dev_printk(KERN_DEBUG, &pdev->dev, "version "
> DRV_VERSION "\n");
> @@ -389,9 +390,13 @@ static int __devinit vsc_sata_init_one (
>         base =3D (unsigned long) mmio_base;
>=20
>         /*
> -        * Due to a bug in the chip, the default cache line size can't
> be used
> +        * Due to a bug in the chip, the default cache line size can't
> be
> +        * used (unless the default is non-zero).
>          */
> -       pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
> +       pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cls);
> +       if (cls =3D=3D 0x00) {
> +               pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE,
0x80);
> +       }
>=20
>         probe_ent->sht =3D &vsc_sata_sht;
>         probe_ent->port_flags =3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |

------_=_NextPart_001_01C73B0E.E9C3E351
Content-Type: application/octet-stream;
	name="sata_vsc_cls.patch"
Content-Transfer-Encoding: base64
Content-Description: sata_vsc_cls.patch
Content-Disposition: attachment;
	filename="sata_vsc_cls.patch"

LS0tIHNhdGFfdnNjLmMub3JpZwkyMDA3LTAxLTE4IDA5OjE3OjAwLjAwMDAwMDAwMCAtMDUwMAor
Kysgc2F0YV92c2MuYwkyMDA3LTAxLTE4IDA5OjMxOjQ4LjAwMDAwMDAwMCAtMDUwMApAQCAtMzQw
LDYgKzM0MCw3IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHZzY19zYXRhX2luaXRfb25lICgKIAlp
bnQgcGNpX2Rldl9idXN5ID0gMDsKIAl2b2lkIF9faW9tZW0gKm1taW9fYmFzZTsKIAlpbnQgcmM7
CisJdTggY2xzOwogCiAJaWYgKCFwcmludGVkX3ZlcnNpb24rKykKIAkJZGV2X3ByaW50ayhLRVJO
X0RFQlVHLCAmcGRldi0+ZGV2LCAidmVyc2lvbiAiIERSVl9WRVJTSU9OICJcbiIpOwpAQCAtMzg5
LDkgKzM5MCwxMyBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCB2c2Nfc2F0YV9pbml0X29uZSAoCiAJ
YmFzZSA9ICh1bnNpZ25lZCBsb25nKSBtbWlvX2Jhc2U7CiAKIAkvKgotCSAqIER1ZSB0byBhIGJ1
ZyBpbiB0aGUgY2hpcCwgdGhlIGRlZmF1bHQgY2FjaGUgbGluZSBzaXplIGNhbid0IGJlIHVzZWQK
KwkgKiBEdWUgdG8gYSBidWcgaW4gdGhlIGNoaXAsIHRoZSBkZWZhdWx0IGNhY2hlIGxpbmUgc2l6
ZSBjYW4ndCBiZQorCSAqIHVzZWQgKHVubGVzcyB0aGUgZGVmYXVsdCBpcyBub24temVybykuCiAJ
ICovCi0JcGNpX3dyaXRlX2NvbmZpZ19ieXRlKHBkZXYsIFBDSV9DQUNIRV9MSU5FX1NJWkUsIDB4
ODApOworCXBjaV9yZWFkX2NvbmZpZ19ieXRlKHBkZXYsIFBDSV9DQUNIRV9MSU5FX1NJWkUsICZj
bHMpOworCWlmIChjbHMgPT0gMHgwMCkgeworCQlwY2lfd3JpdGVfY29uZmlnX2J5dGUocGRldiwg
UENJX0NBQ0hFX0xJTkVfU0laRSwgMHg4MCk7CisJfQogCiAJcHJvYmVfZW50LT5zaHQgPSAmdnNj
X3NhdGFfc2h0OwogCXByb2JlX2VudC0+cG9ydF9mbGFncyA9IEFUQV9GTEFHX1NBVEEgfCBBVEFf
RkxBR19OT19MRUdBQ1kgfAo=

------_=_NextPart_001_01C73B0E.E9C3E351--
