Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC04C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 14 Jan 2022 23:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiANXhW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Jan 2022 18:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiANXhW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2022 18:37:22 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD4C061574
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2022 15:37:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JbHlH02Bfz4y4c;
        Sat, 15 Jan 2022 10:37:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642203435;
        bh=FR5xlVLrRKMBDzKgq6EwHnYvhufh29qeQHgEMqP90i8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dOHvsbvIBTaikai6XtVoPqOBGG0kbH2IYukJ4OtAkApbDVhC4jPGCqeAWWBonl9mK
         X56N/CSmnNQcdpZgwSjfS9MwqupoCCznTFHItgr1kSBppN+I/gQFcRa/8jG5h+9So/
         lQHx1zdjcbEgsXONdQZcIxB4n22zJHvYqYbSoVBVvb5IEq2rzi2umnxcIdE8lDNEOF
         FzUW85THjVgNdiKNY7HQERs5NW0Gh14X869/NbjfrUP1Qr64zfbS7+rMmYuKZ05V9q
         VXnh5OWop+CO9CnawYkhubxLY+s566L0C55ZG90iqBvqxv7XlX3DMpGP9zRUSgHPWx
         Prqrei5EUGr/A==
Date:   Sat, 15 Jan 2022 10:37:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: Re: [GIT PULL] ata changes for 5.17-rc1
Message-ID: <20220115103713.69719bda@canb.auug.org.au>
In-Reply-To: <c365e182-d531-9854-1ff7-9c97d5af9544@opensource.wdc.com>
References: <20220114065906.622181-1-damien.lemoal@opensource.wdc.com>
        <CAHk-=wggW9TzY90pB-1Rfpqm0erxbKO++BR7AOMh_E7_o7cdwA@mail.gmail.com>
        <c365e182-d531-9854-1ff7-9c97d5af9544@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GMExQ6WTpq0H_gyvTNck1Bo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

--Sig_/GMExQ6WTpq0H_gyvTNck1Bo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Damien,

On Sat, 15 Jan 2022 08:27:12 +0900 Damien Le Moal <damien.lemoal@opensource=
.wdc.com> wrote:
>
> On 1/14/22 22:54, Linus Torvalds wrote:
> > On Fri, Jan 14, 2022 at 7:59 AM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote: =20
> >>
> >> ATA changes for 5.17-rc1 =20
> >=20
> > A number of these commits are not in linux-next. Why? =20
>=20
> That is strange. I have kept my for-next branch in sync with for-5.17
> all the time and got several built-bot warnings that I addressed.
>=20
> > It looks like you have rebased things very recently (and looks like
> > you did it a week ago too). Or maybe some patch-queue system, or
> > whatever. Why? If it hasn't been in linux-next, you should explain
> > what's up. =20
>=20
> The last intentional rebase on 5.16-rc8 of the for-5.17 branch was to
> check that there were no conflicts nor any problems with the fixes in
> 5.16. I did that because Hannes series touched a lot of drivers (if not
> most of them).

That check van be done by doing a test merge and if there is nothing
major, then don't bother doing the rebase.

> I am not sure why the patches do not show up in linux-next. As mentioned
> above, since I got several build-bot warnings, I am confident that this
> went through build tests and passes. Or am I missing something in the
> workflow ?
>=20
> Stephen,
>=20
> I am almost certain that you are pulling patches from libata for-next
> branch since I got build bot reports and you also pinged me directly
> about these. Is there something I am missing about linux-next ? Is there
> some other request I need to send to someone to get patches pulled there
> too ? I was under the assumption that your pulls end up creating
> linux-next...

I do fetch your for-next branch every day, but here is the "git
range-diff" between your branch in yesterday's linux-next and the
branch I fetched today:

$ git range-diff e928da321f0bd51f9cf211eab0a7b2fc089685a7...libata/for-next=
=20
 1:  bd7300988b26 <  -:  ------------ ata: ahci_st: add compile test support
 2:  e3e44274998d =3D  1:  28a53d3160ac ata: ahci_mtk: add compile test sup=
port
 3:  eec6634ee717 =3D  2:  368c7edc15e5 ata: ahci_mvebu: add compile test s=
upport
 4:  003785331487 =3D  3:  c05b911afffa ata: ahci_sunxi: add compile test s=
upport
 5:  a4dd1e0f6542 =3D  4:  3d98cbf7096e ata: ahci_tegra: add compile test s=
upport
 6:  9ec8eadac3a4 =3D  5:  b7c9b00fb050 ata: ahci_xgene: add compile test s=
upport
 7:  9fc38794e9b2 =3D  6:  a33a348d0aca ata: ahci_seattle: add compile test=
 support
 8:  e9123b1cef47 =3D  7:  a3d11c275b64 ata: pata_bk3710: add compile test =
support
 9:  4c8bbbba007c =3D  8:  e5b48ee30aec ata: sata_fsl: fix scsi host initia=
lization
10:  04ed3c17408e =3D  9:  f8bc938ee6c6 ata: sata_fsl: fix cmdhdr_tbl_entry=
 and prde struct definitions
11:  d64f9dbf0ae5 =3D 10:  2bce69072a0d ata: ahci_xgene: use correct type f=
or port mmio address
12:  75d7ef1d0409 =3D 11:  0561e514c944 ata: fix read_id() ata port operati=
on interface
13:  953e5fc04f30 =3D 12:  9c2fd3fb43bd ata: pata_octeon_cf: remove redunda=
nt val variable
14:  b76fc153e3d4 =3D 13:  dc5d7b3cfd78 ata: pata_cs5535: add compile test =
support
15:  148f7ed51e8f =3D 14:  2aa566716f43 ata: pata_ftide010: add compile tes=
t support
16:  6aef8c23f268 =3D 15:  7dc3c053bddf ata: pata_imx: add compile test sup=
port
17:  017253b5a7fa =3D 16:  7767c73a3565 ata: pata_pxa: add compile test sup=
port
18:  f4c8787686a4 =3D 17:  b6a64a860e13 ata: pata_samsung_cf: add compile t=
est support
19:  e790a4f79933 =3D 18:  db6a3f47cecc ata: pata_of_platform: Use platform=
_get_irq_optional() to get the interrupt
20:  cadac042d432 =3D 19:  84eac327af54 ata: libata-scsi: simplify __ata_sc=
si_queuecmd()
21:  a49c0c3fc253 =3D 20:  b9ba367c513d ata: libata: Rename link flag ATA_L=
FLAG_NO_DB_DELAY
22:  6977409c421b =3D 21:  a17ab7aba5df ata: ahci: Add support for AMD A85 =
FCH (Hudson D4)
23:  e928da321f0b =3D 22:  237fe8885a3f ata: pata_ali: remove redundant ret=
urn statement

So, you removed a commit and the rest is the same.

--=20
Cheers,
Stephen Rothwell

--Sig_/GMExQ6WTpq0H_gyvTNck1Bo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHiCSkACgkQAVBC80lX
0GxYgwf/W4OAI4kjYv0C+moKkVRpI9AtEqnNEmhoUf2Urgt0OyK/Zp0tQwGf9Z+W
55xA1U20bveL/B2MlRYgT+WbsNZACAfi5NsyPsP/3Xy9T0fpLQTgmJ9wFuGtsbOt
8rwYsNZ4eFpVcBAMiA84T/VpZsVjPPKo3VYXfKMja9qhxEM5VHRMd7vvOJDTJY5g
dhhTqFoRDJKAXq9E5cpjPx1zLFz/jtY8kF/4ZQcoNvFLQ788y4gcnjnffcjtJlln
5QYXYtTAWZuvaOgy2biyVrMOegaXPusZHwTXCnO5Ny1G0OGW2Ex48CjwXOs9Bcf4
ArVzo26yn+a/cMWgxcwlt/xVlLB6PA==
=fnea
-----END PGP SIGNATURE-----

--Sig_/GMExQ6WTpq0H_gyvTNck1Bo--
