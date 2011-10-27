From: Paul Schilling <paul.s.schilling@gmail.com>
Subject: Re: [PATCH 02/15] ATA : vortex86 : fix vortex86dx/sx hardware CRC bug.
Date: Thu, 27 Oct 2011 14:03:41 -0500
Message-ID: <CAC=G6sydfsBGYKcmvxzXQ=qam_Qz9wwABD_EEnrHUiW2RZM6Bw@mail.gmail.com>
References: <1319602564-19162-1-git-send-email-paul.s.schilling@gmail.com>
	<20111027084310.2b7da753@pyx>
	<CAC=G6sz9tpLnxWN7_Ts+rcNf-YQZw-4VQUNo6vKNeHOnOPOHVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35677 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1J0TDm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2011 15:03:42 -0400
In-Reply-To: <CAC=G6sz9tpLnxWN7_Ts+rcNf-YQZw-4VQUNo6vKNeHOnOPOHVA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

The Gmail web client wrapped the text on me.

Look at line 914 in drivers/ata/pata_it821x.c for references to the
Vortex86sx bug.

Thanks,
Paul

On Thu, Oct 27, 2011 at 1:55 PM, Paul Schilling
<paul.s.schilling@gmail.com> wrote:
> The Vortex86dx uses RDC IDE peripheral integrated into the SOC. =A0Th=
e
> CRC design is
> broken in the Vortex86dx and sx. =A0The original reference can be fou=
nd
> in the Linux kernel itself.
>
> The Vortex86sx uses the RDC D1010.
> The Vortex86dx uses the RDC D1011.
> Both of which have broken CRC hardware which breaks DMA.
>
> The pata_821x.c had the following code in it to handle the RDC
> hardware used in the Vortex86SX.
>
> 4fca377f (Jeff Garzik =A0 =A0 =A0 =A0 =A0 =A0 =A0 2011-02-15 01:13:24=
 -0500 913)
> 963e4975 (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02008-07-24 17:1=
6:06 +0100 914)
> =A0if (pdev->vendor =3D=3D PCI_VENDOR_ID_RDC) {
> 4a99d95f (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02009-01-11 19:5=
1:08 +0000 915)
> =A0 =A0 =A0 =A0 /* Deal with Vortex86SX */
> 4a99d95f (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02009-01-11 19:5=
1:08 +0000 916)
> =A0 =A0 =A0 =A0 if (pdev->revision =3D=3D 0x11)
> 4a99d95f (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02009-01-11 19:5=
1:08 +0000 917)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppi[0] =3D &info_rdc_11;
> 4a99d95f (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02009-01-11 19:5=
1:08 +0000 918)
> =A0 =A0 =A0 =A0 else
> 4a99d95f (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02009-01-11 19:5=
1:08 +0000 919)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppi[0] =3D &info_rdc;
> 963e4975 (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02008-07-24 17:1=
6:06 +0100 920) =A0 =A0 =A0} else {
> 963e4975 (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02008-07-24 17:1=
6:06 +0100 921)
> =A0 =A0 =A0 =A0 /* Force the card into bypass mode if so requested */
> 963e4975 (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02008-07-24 17:1=
6:06 +0100 922)
> =A0 =A0 =A0 =A0 if (it8212_noraid) {
> 963e4975 (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02008-07-24 17:1=
6:06 +0100 923)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO DRV_NAME ": forcing =
bypass
> mode.\n");
> 963e4975 (Alan Cox =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02008-07-24 17:1=
6:06 +0100 924)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 it821x_disable_raid(pdev);
>
> Thanks,
> Paul Schilling
>
> On Thu, Oct 27, 2011 at 2:43 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> =
wrote:
>> On Tue, 25 Oct 2011 23:16:04 -0500
>> Paul Schilling <paul.s.schilling@gmail.com> wrote:
>>
>>> This fixes a DMA issue related to a CRC bug on
>>> the RDC pata peripherial found on the vortex86sx and vortex86dx.
>>
>> What is the RDC erratum reference for this ? Also it seems to make n=
o
>> sense
>>
>>
>>> =A0 =A0 =A0 static const struct ata_port_info info_rdc_11 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D ATA_FLAG_SLAVE_POSS,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pio_mask =3D ATA_PIO4,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 .mwdma_mask =3D ATA_MWDMA2,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .mwdma_mask =3D 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .udma_mask =3D 0,
>>
>> MWDMA is not part of the CRC hardware anyway
>>
>> Are you sure these newer variants are simply not using a different s=
et of
>> timing parameters thus showing bugs on your system ?
>>
>
