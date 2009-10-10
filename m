From: - <d.stussy@yahoo.com>
Subject: Re: [PATCH 0/2] two ide fixes for -rc4
Date: Sat, 10 Oct 2009 10:54:45 -0700 (PDT)
Message-ID: <538060.73944.qm@web84205.mail.re3.yahoo.com>
References: <200910070246.05283.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762058AbZJJRz1@vger.kernel.org>
In-Reply-To: <200910070246.05283.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Joao Ramos <joao.ramos@inov.pt>, David Fries <david@fries.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This latest patch (modifying only the SIS 5513 driver) WORKS FOR ME.  :=
-)
   - D. Stussy.

--- On Tue, 10/6/09, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wro=
te:
> ...
> --- a/drivers/ide/sis5513.c
> +++ b/drivers/ide/sis5513.c
> @@ -281,11 +281,13 @@ static void config_drive_art_rwp(ide_dri
> =20
>  =A0=A0=A0 pci_read_config_byte(dev, 0x4b, &reg4bh);
> =20
> +=A0=A0=A0 rw_prefetch =3D reg4bh & ~(0x11 << drive->dn);
> +
>  =A0=A0=A0 if (drive->media =3D=3D ide_disk)
> -=A0=A0=A0 =A0=A0=A0 rw_prefetch =3D 0x11 << drive->dn;
> +=A0=A0=A0 =A0=A0=A0 rw_prefetch |=3D 0x11 << drive->dn;
> =20
> -=A0=A0=A0 if ((reg4bh & (0x11 << drive->dn)) !=3D rw_prefetch)
> -=A0=A0=A0 =A0=A0=A0 pci_write_config_byte(dev, 0x4b, reg4bh|rw_prefe=
tch);
> +=A0=A0=A0 if (reg4bh !=3D rw_prefetch)
> +=A0=A0=A0 =A0=A0=A0 pci_write_config_byte(dev, 0x4b, rw_prefetch);
>  }
> =20
>  static void sis_set_pio_mode(ide_drive_t *drive, const u8 pio)
>=20
