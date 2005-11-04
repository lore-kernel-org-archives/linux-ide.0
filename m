From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: sata_sil.c, firmware information
Date: Fri, 4 Nov 2005 12:26:30 +0100
Message-ID: <58cb370e0511040326y68b9ee2ek399693d7ed30f101@mail.gmail.com>
References: <200511041150.46666.virginiogl_web@ono.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.206]:19073 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161145AbVKDL0c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2005 06:26:32 -0500
Received: by nproxy.gmail.com with SMTP id q29so86067nfc
        for <linux-ide@vger.kernel.org>; Fri, 04 Nov 2005 03:26:31 -0800 (PST)
In-Reply-To: <200511041150.46666.virginiogl_web@ono.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Virginio GL <virginiogl_web@ono.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

Upgrade your kernel, in newer ones SIL_QUIRK_MOD15WRITE
quirk is not applied for sil3114 controllers.

Bartlomiej

On 11/4/05, Virginio GL <virginiogl_web@ono.com> wrote:
> Hello.
>
> Tree weeks ago I've read in my /usr/src/linux/drivers/scsi/sata_sil.c=
 file
> that my hard disk is backlisted.
>
> I comment the line:
> { "ST3200822AS",      SIL_QUIRK_MOD15WRITE }
> and it works fine (and faster) !!!
>
> My chipset is sil3114, and the firmware version of the hard disk is 3=
=2E01.
>
> Info in dmesg:
>
> **
> scsi3 : sata_sil
>   Vendor: ATA       Model: ST3200822AS       Rev: 3.01
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: ST3200822AS       Rev: 3.01
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> **
>
> I have two hard disk, using dmraid and my motherboard is "ASUS A8N SL=
I
> Deluxe".
>
>
>
>
>
> Doing "hdparam -I /dev/sda":
>
> **
> Capabilities:
>         LBA, IORDY(can be disabled)
>         bytes avail on r/w long: 4      Queue depth: 1
>         Standby timer values: spec'd by Standard, no device specific =
minimum
>         R/W multiple sector transfer: Max =3D 16  Current =3D 16
>         Recommended acoustic management value: 254, current value: 0
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 u=
dma6
>              Cycle time: min=3D120ns recommended=3D120ns
> **
>
> =BFwhy is not configured in udma6 by default? ("hdparm -X70 /dev/sda"=
 not work).
>
> Best regards.
>
> Virginio Garc=EDa L=F3pez
