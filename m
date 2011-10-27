From: Paul Schilling <paul.s.schilling@gmail.com>
Subject: Re: [PATCH 02/15] ATA : vortex86 : fix vortex86dx/sx hardware CRC bug.
Date: Thu, 27 Oct 2011 13:55:21 -0500
Message-ID: <CAC=G6sz9tpLnxWN7_Ts+rcNf-YQZw-4VQUNo6vKNeHOnOPOHVA@mail.gmail.com>
References: <1319602564-19162-1-git-send-email-paul.s.schilling@gmail.com>
	<20111027084310.2b7da753@pyx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20111027084310.2b7da753@pyx>
Sender: linux-pci-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The Vortex86dx uses RDC IDE peripheral integrated into the SOC.  The
CRC design is
broken in the Vortex86dx and sx.  The original reference can be found
in the Linux kernel itself.

The Vortex86sx uses the RDC D1010.
The Vortex86dx uses the RDC D1011.
Both of which have broken CRC hardware which breaks DMA.

The pata_821x.c had the following code in it to handle the RDC
hardware used in the Vortex86SX.

4fca377f (Jeff Garzik               2011-02-15 01:13:24 -0500 913)
963e4975 (Alan Cox                  2008-07-24 17:16:06 +0100 914)
 if (pdev->vendor =3D=3D PCI_VENDOR_ID_RDC) {
4a99d95f (Alan Cox                  2009-01-11 19:51:08 +0000 915)
         /* Deal with Vortex86SX */
4a99d95f (Alan Cox                  2009-01-11 19:51:08 +0000 916)
         if (pdev->revision =3D=3D 0x11)
4a99d95f (Alan Cox                  2009-01-11 19:51:08 +0000 917)
                 ppi[0] =3D &info_rdc_11;
4a99d95f (Alan Cox                  2009-01-11 19:51:08 +0000 918)
         else
4a99d95f (Alan Cox                  2009-01-11 19:51:08 +0000 919)
                 ppi[0] =3D &info_rdc;
963e4975 (Alan Cox                  2008-07-24 17:16:06 +0100 920)     =
 } else {
963e4975 (Alan Cox                  2008-07-24 17:16:06 +0100 921)
         /* Force the card into bypass mode if so requested */
963e4975 (Alan Cox                  2008-07-24 17:16:06 +0100 922)
         if (it8212_noraid) {
963e4975 (Alan Cox                  2008-07-24 17:16:06 +0100 923)
                 printk(KERN_INFO DRV_NAME ": forcing bypass
mode.\n");
963e4975 (Alan Cox                  2008-07-24 17:16:06 +0100 924)
                 it821x_disable_raid(pdev);

Thanks,
Paul Schilling

On Thu, Oct 27, 2011 at 2:43 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wr=
ote:
> On Tue, 25 Oct 2011 23:16:04 -0500
> Paul Schilling <paul.s.schilling@gmail.com> wrote:
>
>> This fixes a DMA issue related to a CRC bug on
>> the RDC pata peripherial found on the vortex86sx and vortex86dx.
>
> What is the RDC erratum reference for this ? Also it seems to make no
> sense
>
>
>> =A0 =A0 =A0 static const struct ata_port_info info_rdc_11 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D ATA_FLAG_SLAVE_POSS,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pio_mask =3D ATA_PIO4,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .mwdma_mask =3D ATA_MWDMA2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mwdma_mask =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .udma_mask =3D 0,
>
> MWDMA is not part of the CRC hardware anyway
>
> Are you sure these newer variants are simply not using a different se=
t of
> timing parameters thus showing bugs on your system ?
>
