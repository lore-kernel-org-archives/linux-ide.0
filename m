From: Paul Schilling <paul.s.schilling@gmail.com>
Subject: Re: [PATCH 02/15] ATA : vortex86 : fix vortex86dx/sx hardware CRC bug.
Date: Mon, 31 Oct 2011 14:07:45 -0500
Message-ID: <CAC=G6sz=PkDoODYh4beT_eRhkm+ZhUxtLnrBXPPuFJW3n+6Vcg@mail.gmail.com>
References: <1319602564-19162-1-git-send-email-paul.s.schilling@gmail.com>
	<20111027084310.2b7da753@pyx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111027084310.2b7da753@pyx>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

When I developed this patch for the Vortex86dx.  I recall trying many
combinations of udma and mwdma.  At the time I developed it, I came
to the conclusion that both udma and mwdma both failed with CRC
errors being reported.  I am not readily set-up to redo the testing to
see if mwdma is indeed also affected by the errata.  It will be a coupl=
e
of weeks before I can re-test this patch on the hardware with mwdma
turned on.

Thanks,
Paul

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
