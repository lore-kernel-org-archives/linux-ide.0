From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] PXA DMA-capable PATA driver
Date: Sat, 15 May 2010 22:48:17 +0200
Message-ID: <877hn4ao32.fsf@free.fr>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com>
	<4BEDC8C1.30703@garzik.org> <201005150023.45336.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:49359 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab0EOUs0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 May 2010 16:48:26 -0400
In-Reply-To: <201005150023.45336.marek.vasut@gmail.com> (Marek Vasut's message of "Sat\, 15 May 2010 00\:23\:45 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-arm-kernel@lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> Dne So 15. kv=C4=9Btna 2010 00:03:45 Jeff Garzik napsal(a):
>> On 05/09/2010 11:02 PM, Marek Vasut wrote:
>> > This patch adds a driver for a harddrive attached to PXA address a=
nd data
>> > bus. Unlike pata_platform, this driver allows usage of PXA DMA
>> > controller, making the transmission speed 3x higher.
=2E..
zip
=2E..
>> > +static void pxa_bmdma_setup(struct ata_queued_cmd *qc)
>> > +{
>> > +	struct pata_pxa_data *pd =3D qc->ap->private_data;
>> > +	int si =3D 0;
>> > +	struct scatterlist *sg;
>> > +
>> > +	pd->dma_desc_id =3D 0;
>> > +
>> > +	DCSR(pd->dma_channel) =3D 0;
>> > +	DALGN&=3D ~(1<<  pd->dma_dreq);
>> > +
>> > +	for_each_sg(qc->sg, sg, qc->n_elem, si)
>> > +		pxa_load_dmac(sg, qc);
>> > +
>> > +	pd->dma_desc[pd->dma_desc_id - 1].ddadr =3D DDADR_STOP;
>> > +
>> > +	/* Fire IRQ only at the end of last block */
>> > +	pd->dma_desc[pd->dma_desc_id - 1].dcmd |=3D DCMD_ENDIRQEN;
>> > +
>> > +	DDADR(pd->dma_channel) =3D pd->dma_desc_addr;
>> > +	DRCMR(pd->dma_dreq) =3D DRCMR_MAPVLD | pd->dma_channel;
>> > +	qc->ap->ops->sff_exec_command(qc->ap,&qc->tf);
>> > +}

I don't know the ATA infrastructure well here, but I wonder how cache
consistency is handled here. Normally, once the sg is ready, you have t=
o call
dma_map_sg() to map the scatter/gather _and_ to flush any stale cache e=
ntry the
CPU(s) might have over the memory used for the transfer.

Once the transfer is over, you have to call dma_unmap_sg() to give back=
 the
memory (ie. ensure cache consistency once the peripheral has finished p=
ushing
data to the memory).

I didn't see that is this piece of code. Did I miss something ?

>
> BUG() doesn't happen here so the user won't come into any contact wit=
h it unless=20
> he sets the drive on fire or something. And in case user comes in con=
tact with=20
> it, this is all I need to know to help him. Or maybe dev_err() would =
be good=20
> here ?
>>=20
>> > + * Read DMA status. The bmdma_stop() will take care of properly
>> > finishing the + * DMA transfer so we always have DMA-complete inte=
rrupt
>> > here.
>> > + */
>> > +static unsigned char pxa_bmdma_status(struct ata_port *ap)
>> > +{
>> > +	return ATA_DMA_INTR;
>> > +}
>>=20
>> are you able to detect bus error?
>
> Sadly, no. Nor can I detect any other condition.
Wouldn't the DCSR_BUSERR bit of DCSR report a bus error ?

+/*
+ * DMA interrupt handler.
+ */
+static void pxa_ata_dma_irq(int dma, void *port)
+{
+	uint32_t dcsr;
+	struct ata_port *ap =3D port;
+	struct pata_pxa_data *pd =3D ap->private_data;
+
+	dcsr =3D DCSR(dma);
+	DCSR(dma) =3D dcsr;
+	if (dcsr & DCSR_STOPSTATE)
+		complete(&pd->dma_done);
+}

Cheers.

--
Robert
