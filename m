From: Paul Schilling <paul.s.schilling@gmail.com>
Subject: Re: [PATCH 02/15] ATA : vortex86 : fix vortex86dx/sx hardware CRC bug.
Date: Sun, 23 Oct 2011 11:26:04 -0500
Message-ID: <CAC=G6szPCgSDB_1te3wZx2GGBiHMXMuQBQznSfjy2n1GtfCPxA@mail.gmail.com>
References: <1319346300-18151-1-git-send-email-paul.s.schilling@gmail.com>
	<1732355.g0uNX7XlKI@donald.sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1732355.g0uNX7XlKI@donald.sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Thanks, That was a good catch.  I had that extra struct for another
revision of the RDC peripheral integrated into the
Vortex86DX.  I removed it when I moved it to the pata_rdc.c driver but
forgot the struct.  The it821x driver works
for the RDC drivers when DMA is turned off.  But the RDC driver is the
more logical choice.

I will make the fix and send out the new patch.

I accidentally sent this through the gmail interface with html on,
Some of you may get this email twice.

Thanks,
Paul Schilling

On Sun, Oct 23, 2011 at 3:20 AM, Rolf Eike Beer <eike-kernel@sf-tec.de>=
 wrote:
>
> Paul Schilling wrote:
> > This fixes a DMA issue related to a CRC bug on
> > the RDC pata peripherial found on the vortex86sx and vortex86dx.
> >
> > Signed-off-by: Paul Schilling <paul.s.schilling@gmail.com>
> > ---
> > =A0drivers/ata/pata_it821x.c | =A0 22 ++++++++++++++++++----
> > =A0drivers/ata/pata_rdc.c =A0 =A0| =A0 29 ++++++++++++++++++++++++-=
----
> > =A0drivers/ide/it821x.c =A0 =A0 =A0| =A0 =A09 +++++++--
> > =A0include/linux/pci_ids.h =A0 | =A0 =A02 ++
> > =A04 files changed, 51 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
> > index c5532b9..5f8a54a 100644
> > --- a/drivers/ata/pata_it821x.c
> > +++ b/drivers/ata/pata_it821x.c
> > @@ -897,7 +897,16 @@ static int it821x_init_one(struct pci_dev *pde=
v, const
> > struct pci_device_id *id) static const struct ata_port_info info_rd=
c_11 =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D ATA_FLAG_SLAVE_POSS,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pio_mask =3D ATA_PIO4,
> > - =A0 =A0 =A0 =A0 =A0 =A0 .mwdma_mask =3D ATA_MWDMA2,
> > + =A0 =A0 =A0 =A0 =A0 =A0 .mwdma_mask =3D 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 .udma_mask =3D 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 /* No UDMA */
> > + =A0 =A0 =A0 =A0 =A0 =A0 .port_ops =3D &it821x_rdc_port_ops
> > + =A0 =A0 };
> > + =A0 =A0 static const struct ata_port_info info_rdc_01 =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D ATA_FLAG_SLAVE_POSS,
> > + =A0 =A0 =A0 =A0 =A0 =A0 .pio_mask =3D ATA_PIO4,
> > + =A0 =A0 =A0 =A0 =A0 =A0 .mwdma_mask =3D 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 .udma_mask =3D 0,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No UDMA */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 .port_ops =3D &it821x_rdc_port_ops
> > =A0 =A0 =A0 };
>
> Why do you define this if it is never used?
>
> Eike
