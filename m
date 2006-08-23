From: "Wolstenholme, Daniel E" <daniel.e.wolstenholme@intel.com>
Subject: RE: [PATCH] Add MSI support to sata_vsc driver
Date: Wed, 23 Aug 2006 16:17:25 -0700
Message-ID: <87840E8EE8A8D240A13F8AA92CAB07D9024C14BF@azsmsx402>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6C70A.4B646255"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45623 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965299AbWHWXSt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Aug 2006 19:18:49 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jeremy Higdon <jeremy@sgi.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6C70A.4B646255
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ok, this patch should fix everything.

Thanks for the help!
Dan



-----Original Message-----
From: Jeff Garzik [mailto:jeff@garzik.org]=20
Sent: Thursday, August 17, 2006 4:44 PM
To: Wolstenholme, Daniel E
Cc: Jeremy Higdon; linux-ide@vger.kernel.org
Subject: Re: [PATCH] Add MSI support to sata_vsc driver

Wolstenholme, Daniel E wrote:
> Unfortunately, I'm stuck using Lookout for now.=20

That's OK, this one needs another iteration anyway :)


> --------------
> diff -Naur linux-2.6.18-rc1-original/drivers/scsi/sata_vsc.c
> linux-2.6.18-rc1/drivers/scsi/sata_vsc.c
> --- linux-2.6.18-rc1-original/drivers/scsi/sata_vsc.c   2006-08-15
> 17:13:53.000000000 -0700
> +++ linux-2.6.18-rc1/drivers/scsi/sata_vsc.c    2006-08-17
> 14:29:27.000000000 -0700
> @@ -406,13 +406,17 @@
>          */
>         pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
>=20
> +       if (pci_enable_msi && pci_enable_msi(pdev) =3D=3D 0)

pci_enable_msi is not a variable, don't test it.  Just call it.

The function will always exist, even if conditionally implemented as a=20
macro in the no-op case.


> +               probe_ent->irq_flags &=3D ~IRQF_SHARED;

We're doing an assignment (as you see below, from the code you=20
modified), and the entire struct is memset(3) to zero, so there's no=20
need to clear this flag.  Just assign it, for the non-MSI case.


> +               probe_ent->irq_flags =3D IRQF_SHARED;
> +
>         probe_ent->sht =3D &vsc_sata_sht;
>         probe_ent->host_flags =3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>                                 ATA_FLAG_MMIO;
>         probe_ent->port_ops =3D &vsc_sata_ops;
>         probe_ent->n_ports =3D 4;
>         probe_ent->irq =3D pdev->irq;
> -       probe_ent->irq_flags =3D IRQF_SHARED;
>         probe_ent->mmio_base =3D mmio_base;

------_=_NextPart_001_01C6C70A.4B646255
Content-Type: application/octet-stream;
	name="diff.sata_vsc"
Content-Transfer-Encoding: base64
Content-Description: diff.sata_vsc
Content-Disposition: attachment;
	filename="diff.sata_vsc"

ZGlmZiAtTmF1ciAteCAuZ2l0IGxpbnV4LTIuNi4xOC1yYzIvZHJpdmVycy9zY3NpL3NhdGFfdnNj
LmMgbGludXgtMi42LjE4LXJjMi1NU0kvZHJpdmVycy9zY3NpL3NhdGFfdnNjLmMKLS0tIGxpbnV4
LTIuNi4xOC1yYzIvZHJpdmVycy9zY3NpL3NhdGFfdnNjLmMJMjAwNi0wOC0xNSAxNzoxMzo1My4w
MDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi4xOC1yYzItTVNJL2RyaXZlcnMvc2NzaS9zYXRh
X3ZzYy5jCTIwMDYtMDgtMTggMTA6NDI6NTIuMDAwMDAwMDAwIC0wNzAwCkBAIC00MDYsMTMgKzQw
NiwxNyBAQAogCSAqLwogCXBjaV93cml0ZV9jb25maWdfYnl0ZShwZGV2LCBQQ0lfQ0FDSEVfTElO
RV9TSVpFLCAweDgwKTsKIAorCWlmIChwY2lfZW5hYmxlX21zaShwZGV2KSA9PSAwKQorCQlwcm9i
ZV9lbnQtPmlycV9mbGFncyA9IDA7CisJZWxzZQorCQlwcm9iZV9lbnQtPmlycV9mbGFncyA9IElS
UUZfU0hBUkVEOworCiAJcHJvYmVfZW50LT5zaHQgPSAmdnNjX3NhdGFfc2h0OwogCXByb2JlX2Vu
dC0+aG9zdF9mbGFncyA9IEFUQV9GTEFHX1NBVEEgfCBBVEFfRkxBR19OT19MRUdBQ1kgfAogCQkJ
CUFUQV9GTEFHX01NSU87CiAJcHJvYmVfZW50LT5wb3J0X29wcyA9ICZ2c2Nfc2F0YV9vcHM7CiAJ
cHJvYmVfZW50LT5uX3BvcnRzID0gNDsKIAlwcm9iZV9lbnQtPmlycSA9IHBkZXYtPmlycTsKLQlw
cm9iZV9lbnQtPmlycV9mbGFncyA9IElSUUZfU0hBUkVEOwogCXByb2JlX2VudC0+bW1pb19iYXNl
ID0gbW1pb19iYXNlOwogCiAJLyogV2UgZG9uJ3QgY2FyZSBtdWNoIGFib3V0IHRoZSBQSU8vVURN
QSBtYXNrcywgYnV0IHRoZSBjb3JlIHdvbid0IGxpa2UgdXMK

------_=_NextPart_001_01C6C70A.4B646255--
