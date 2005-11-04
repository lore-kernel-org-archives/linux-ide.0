From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: sata_sil.c, firmware information
Date: Fri, 4 Nov 2005 14:35:23 +0100
Message-ID: <58cb370e0511040535o5a3e41dcl701c8ff60d5b704f@mail.gmail.com>
References: <200511041150.46666.virginiogl_web@ono.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_16590_18107947.1131111323048"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.201]:60612 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751435AbVKDNfY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Nov 2005 08:35:24 -0500
Received: by nproxy.gmail.com with SMTP id q29so94310nfc
        for <linux-ide@vger.kernel.org>; Fri, 04 Nov 2005 05:35:23 -0800 (PST)
In-Reply-To: <200511041150.46666.virginiogl_web@ono.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Virginio GL <virginiogl_web@ono.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

------=_Part_16590_18107947.1131111323048
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/4/05, Virginio GL <virginiogl_web@ono.com> wrote:

> Doing "hdparam -I /dev/sda":
>
> **
> Capabilities:
>         LBA, IORDY(can be disabled)
>         bytes avail on r/w long: 4      Queue depth: 1
>         Standby timer values: spec'd by Standard, no device specific mini=
mum
>         R/W multiple sector transfer: Max =3D 16  Current =3D 16
>         Recommended acoustic management value: 254, current value: 0
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
>              Cycle time: min=3D120ns recommended=3D120ns
> **
>
> =BFwhy is not configured in udma6 by default? ("hdparm -X70 /dev/sda" not=
 work).

Does attached patch work for you?

Bartlomiej

------=_Part_16590_18107947.1131111323048
Content-Type: application/octet-stream; name="sata_sil-udma6-fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sata_sil-udma6-fix.patch"

W1BBVENIXSBzYXRhX3NpbDogZml4IFVETUEgbWFza3MKCk1heGltdW0gYXZhaWxhYmxlIFVETUEg
bW9kZSBpcyBVRE1BNiBub3QgVURNQTUuCgpTaWduZWQtb2ZmLWJ5OiBCYXJ0bG9taWVqIFpvbG5p
ZXJraWV3aWN6IDxiem9sbmllckBnbWFpbC5jb20+CgotLS0gYS9kcml2ZXJzL3Njc2kvc2F0YV9z
aWwuYwkyMDA1LTExLTAxIDEwOjAxOjEyLjAwMDAwMDAwMCArMDEwMAorKysgYi9kcml2ZXJzL3Nj
c2kvc2F0YV9zaWwuYwkyMDA1LTExLTA0IDE0OjI0OjAxLjAwMDAwMDAwMCArMDEwMApAQCAtMTg1
LDcgKzE4NSw3IEBACiAJCQkJICBBVEFfRkxBR19TUlNUIHwgQVRBX0ZMQUdfTU1JTywKIAkJLnBp
b19tYXNrCT0gMHgxZiwJCQkvKiBwaW8wLTQgKi8KIAkJLm13ZG1hX21hc2sJPSAweDA3LAkJCS8q
IG13ZG1hMC0yICovCi0JCS51ZG1hX21hc2sJPSAweDNmLAkJCS8qIHVkbWEwLTUgKi8KKwkJLnVk
bWFfbWFzawk9IDB4N2YsCQkJLyogdWRtYTAtNiAqLwogCQkucG9ydF9vcHMJPSAmc2lsX29wcywK
IAl9LCAvKiBzaWxfMzExMl8xNXcgLSBrZWVwIGl0IHN5bmMnZCB3LyBzaWxfMzExMiAqLwogCXsK
QEAgLTE5NSw3ICsxOTUsNyBAQAogCQkJCSAgU0lMX0ZMQUdfTU9EMTVXUklURSwKIAkJLnBpb19t
YXNrCT0gMHgxZiwJCQkvKiBwaW8wLTQgKi8KIAkJLm13ZG1hX21hc2sJPSAweDA3LAkJCS8qIG13
ZG1hMC0yICovCi0JCS51ZG1hX21hc2sJPSAweDNmLAkJCS8qIHVkbWEwLTUgKi8KKwkJLnVkbWFf
bWFzawk9IDB4N2YsCQkJLyogdWRtYTAtNiAqLwogCQkucG9ydF9vcHMJPSAmc2lsX29wcywKIAl9
LCAvKiBzaWxfMzExNCAqLwogCXsKQEAgLTIwNCw3ICsyMDQsNyBAQAogCQkJCSAgQVRBX0ZMQUdf
U1JTVCB8IEFUQV9GTEFHX01NSU8sCiAJCS5waW9fbWFzawk9IDB4MWYsCQkJLyogcGlvMC00ICov
CiAJCS5td2RtYV9tYXNrCT0gMHgwNywJCQkvKiBtd2RtYTAtMiAqLwotCQkudWRtYV9tYXNrCT0g
MHgzZiwJCQkvKiB1ZG1hMC01ICovCisJCS51ZG1hX21hc2sJPSAweDdmLAkJCS8qIHVkbWEwLTYg
Ki8KIAkJLnBvcnRfb3BzCT0gJnNpbF9vcHMsCiAJfSwKIH07Cg==
------=_Part_16590_18107947.1131111323048--
