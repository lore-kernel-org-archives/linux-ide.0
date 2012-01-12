From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH v2] ata: pata_bf54x: Support sg list in bmdma transfer.
Date: Thu, 12 Jan 2012 14:50:51 +0800
Message-ID: <CAJxxZ0NyoK+H7Y5TDhFL7hgPa7iRktUVSC4kQd-ehz+N90eg8w@mail.gmail.com>
References: <1325657211-21904-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64300 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab2ALGux convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jan 2012 01:50:53 -0500
Received: by bkvi17 with SMTP id i17so1026861bkv.19
        for <linux-ide@vger.kernel.org>; Wed, 11 Jan 2012 22:50:52 -0800 (PST)
In-Reply-To: <1325657211-21904-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>, sshtylyov@mvista.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

PING

Sonic

On Wed, Jan 4, 2012 at 2:06 PM, Sonic Zhang <sonic.adi@gmail.com> wrote=
:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> BF54x on-chip ATAPI controller allows maximum 0x1fffe bytes to be tra=
nsfered
> in one ATAPI transfer. So, set the max sg_tablesize to 4.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
> =A0drivers/ata/pata_bf54x.c | =A0167 ++++++++++++++++++++++++--------=
--------------
> =A01 files changed, 88 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
> index 9711c2a..d2ecae4 100644
> --- a/drivers/ata/pata_bf54x.c
> +++ b/drivers/ata/pata_bf54x.c
> @@ -251,6 +251,8 @@ static const u32 udma_tenvmin =3D 20;
> =A0static const u32 udma_tackmin =3D 20;
> =A0static const u32 udma_tssmin =3D 50;
>
> +#define BFIN_MAX_SG_SEGMENTS 4
> +
> =A0/**
> =A0*
> =A0* =A0 =A0 Function: =A0 =A0 =A0 num_clocks_min
> @@ -829,79 +831,61 @@ static void bfin_set_devctl(struct ata_port *ap=
, u8 ctl)
>
> =A0static void bfin_bmdma_setup(struct ata_queued_cmd *qc)
> =A0{
> - =A0 =A0 =A0 unsigned short config =3D WDSIZE_16;
> + =A0 =A0 =A0 struct ata_port *ap =3D qc->ap;
> + =A0 =A0 =A0 struct dma_desc_array *dma_desc_cpu =3D (struct dma_des=
c_array *)ap->bmdma_prd;
> + =A0 =A0 =A0 void __iomem *base =3D (void __iomem *)ap->ioaddr.ctl_a=
ddr;
> + =A0 =A0 =A0 unsigned short config =3D DMAFLOW_ARRAY | NDSIZE_5 | RE=
START | WDSIZE_16 | DMAEN;
> =A0 =A0 =A0 =A0struct scatterlist *sg;
> =A0 =A0 =A0 =A0unsigned int si;
> + =A0 =A0 =A0 unsigned int channel;
> + =A0 =A0 =A0 unsigned int dir;
> + =A0 =A0 =A0 unsigned int size =3D 0;
>
> =A0 =A0 =A0 =A0dev_dbg(qc->ap->dev, "in atapi dma setup\n");
> =A0 =A0 =A0 =A0/* Program the ATA_CTRL register with dir */
> =A0 =A0 =A0 =A0if (qc->tf.flags & ATA_TFLAG_WRITE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fill the ATAPI DMA controller */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dma_config(CH_ATAPI_TX, config);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dma_x_modify(CH_ATAPI_TX, 2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sg(qc->sg, sg, qc->n_elem, si)=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dma_start_addr(CH_A=
TAPI_TX, sg_dma_address(sg));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dma_x_count(CH_ATAP=
I_TX, sg_dma_len(sg) >> 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 channel =3D CH_ATAPI_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dir =3D DMA_TO_DEVICE;
> =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 channel =3D CH_ATAPI_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dir =3D DMA_FROM_DEVICE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0config |=3D WNR;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fill the ATAPI DMA controller */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dma_config(CH_ATAPI_RX, config);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dma_x_modify(CH_ATAPI_RX, 2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sg(qc->sg, sg, qc->n_elem, si)=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dma_start_addr(CH_A=
TAPI_RX, sg_dma_address(sg));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dma_x_count(CH_ATAP=
I_RX, sg_dma_len(sg) >> 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> -}
>
> -/**
> - * =A0 =A0 bfin_bmdma_start - Start an IDE DMA transaction
> - * =A0 =A0 @qc: Info associated with this ATA transaction.
> - *
> - * =A0 =A0 Note: Original code is ata_bmdma_start().
> - */
> + =A0 =A0 =A0 dma_map_sg(ap->dev, qc->sg, qc->n_elem, dir);
>
> -static void bfin_bmdma_start(struct ata_queued_cmd *qc)
> -{
> - =A0 =A0 =A0 struct ata_port *ap =3D qc->ap;
> - =A0 =A0 =A0 void __iomem *base =3D (void __iomem *)ap->ioaddr.ctl_a=
ddr;
> - =A0 =A0 =A0 struct scatterlist *sg;
> - =A0 =A0 =A0 unsigned int si;
> + =A0 =A0 =A0 /* fill the ATAPI DMA controller */
> + =A0 =A0 =A0 for_each_sg(qc->sg, sg, qc->n_elem, si) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_desc_cpu[si].start_addr =3D sg_dma_=
address(sg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_desc_cpu[si].cfg =3D config;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_desc_cpu[si].x_count =3D sg_dma_len=
(sg) >> 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_desc_cpu[si].x_modify =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size +=3D sg_dma_len(sg);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 dev_dbg(qc->ap->dev, "in atapi dma start\n");
> - =A0 =A0 =A0 if (!(ap->udma_mask || ap->mwdma_mask))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 /* Set the last descriptor to stop mode */
> + =A0 =A0 =A0 dma_desc_cpu[qc->n_elem - 1].cfg &=3D ~(DMAFLOW | NDSIZ=
E);
>
> - =A0 =A0 =A0 /* start ATAPI DMA controller*/
> - =A0 =A0 =A0 if (qc->tf.flags & ATA_TFLAG_WRITE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* On blackfin arch, uncacheable memo=
ry is not
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* allocated with flag GFP_DMA. DMA b=
uffer from
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* common kenel code should be flushe=
d if WB
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* data cache is enabled. Otherwise, =
this loop
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is an empty loop and optimized out=
=2E
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sg(qc->sg, sg, qc->n_elem, si)=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_dcache_range(sg_d=
ma_address(sg),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_dma_=
address(sg) + sg_dma_len(sg));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_dma(CH_ATAPI_TX);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(qc->ap->dev, "enable udma write=
\n");
> + =A0 =A0 =A0 flush_dcache_range((unsigned int)dma_desc_cpu,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned int)dma_desc_cpu +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qc->n_elem * sizeof(str=
uct dma_desc_array));
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Send ATA DMA write command */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bfin_exec_command(ap, &qc->tf);
> + =A0 =A0 =A0 /* Enable ATA DMA operation*/
> + =A0 =A0 =A0 set_dma_curr_desc_addr(channel, (unsigned long *)ap->bm=
dma_prd_dma);
> + =A0 =A0 =A0 set_dma_x_count(channel, 0);
> + =A0 =A0 =A0 set_dma_x_modify(channel, 0);
> + =A0 =A0 =A0 set_dma_config(channel, config);
> +
> + =A0 =A0 =A0 SSYNC();
> +
> + =A0 =A0 =A0 /* Send ATA DMA command */
> + =A0 =A0 =A0 bfin_exec_command(ap, &qc->tf);
>
> + =A0 =A0 =A0 if (qc->tf.flags & ATA_TFLAG_WRITE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* set ATA DMA write direction */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ATAPI_SET_CONTROL(base, (ATAPI_GET_CON=
TROL(base)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| XFER_DIR));
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_dma(CH_ATAPI_RX);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(qc->ap->dev, "enable udma read\=
n");
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Send ATA DMA read command */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bfin_exec_command(ap, &qc->tf);
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* set ATA DMA read direction */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ATAPI_SET_CONTROL(base, (ATAPI_GET_CON=
TROL(base)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& ~XFER_DIR));
> @@ -913,12 +897,28 @@ static void bfin_bmdma_start(struct ata_queued_=
cmd *qc)
> =A0 =A0 =A0 =A0/* Set ATAPI state machine contorl in terminate sequen=
ce */
> =A0 =A0 =A0 =A0ATAPI_SET_CONTROL(base, ATAPI_GET_CONTROL(base) | END_=
ON_TERM);
>
> - =A0 =A0 =A0 /* Set transfer length to buffer len */
> - =A0 =A0 =A0 for_each_sg(qc->sg, sg, qc->n_elem, si) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATAPI_SET_XFER_LEN(base, (sg_dma_len(sg=
) >> 1));
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Set transfer length to the total size of sg buffers =
*/
> + =A0 =A0 =A0 ATAPI_SET_XFER_LEN(base, size >> 1);
> +}
>
> - =A0 =A0 =A0 /* Enable ATA DMA operation*/
> +/**
> + * =A0 =A0 bfin_bmdma_start - Start an IDE DMA transaction
> + * =A0 =A0 @qc: Info associated with this ATA transaction.
> + *
> + * =A0 =A0 Note: Original code is ata_bmdma_start().
> + */
> +
> +static void bfin_bmdma_start(struct ata_queued_cmd *qc)
> +{
> + =A0 =A0 =A0 struct ata_port *ap =3D qc->ap;
> + =A0 =A0 =A0 void __iomem *base =3D (void __iomem *)ap->ioaddr.ctl_a=
ddr;
> +
> + =A0 =A0 =A0 dev_dbg(qc->ap->dev, "in atapi dma start\n");
> +
> + =A0 =A0 =A0 if (!(ap->udma_mask || ap->mwdma_mask))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 /* start ATAPI transfer*/
> =A0 =A0 =A0 =A0if (ap->udma_mask)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ATAPI_SET_CONTROL(base, ATAPI_GET_CONT=
ROL(base)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| ULTRA_START);
> @@ -935,34 +935,23 @@ static void bfin_bmdma_start(struct ata_queued_=
cmd *qc)
> =A0static void bfin_bmdma_stop(struct ata_queued_cmd *qc)
> =A0{
> =A0 =A0 =A0 =A0struct ata_port *ap =3D qc->ap;
> - =A0 =A0 =A0 struct scatterlist *sg;
> - =A0 =A0 =A0 unsigned int si;
> + =A0 =A0 =A0 unsigned int dir;
>
> =A0 =A0 =A0 =A0dev_dbg(qc->ap->dev, "in atapi dma stop\n");
> +
> =A0 =A0 =A0 =A0if (!(ap->udma_mask || ap->mwdma_mask))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0/* stop ATAPI DMA controller*/
> - =A0 =A0 =A0 if (qc->tf.flags & ATA_TFLAG_WRITE)
> + =A0 =A0 =A0 if (qc->tf.flags & ATA_TFLAG_WRITE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dir =3D DMA_TO_DEVICE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_dma(CH_ATAPI_TX);
> - =A0 =A0 =A0 else {
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dir =3D DMA_FROM_DEVICE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_dma(CH_ATAPI_RX);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ap->hsm_task_state & HSM_ST_LAST) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* On blackfin arch, =
uncacheable memory is not
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* allocated with fla=
g GFP_DMA. DMA buffer from
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* common kenel code =
should be invalidated if
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* data cache is enab=
led. Otherwise, this loop
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is an empty loop a=
nd optimized out.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sg(qc->sg, sg,=
 qc->n_elem, si) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 invalid=
ate_dcache_range(
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 sg_dma_address(sg),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 sg_dma_address(sg)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 + sg_dma_len(sg));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 dma_unmap_sg(ap->dev, qc->sg, qc->n_elem, dir);
> =A0}
>
> =A0/**
> @@ -1261,6 +1250,11 @@ static void bfin_port_stop(struct ata_port *ap=
)
> =A0{
> =A0 =A0 =A0 =A0dev_dbg(ap->dev, "in atapi port stop\n");
> =A0 =A0 =A0 =A0if (ap->udma_mask !=3D 0 || ap->mwdma_mask !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(ap->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BFIN_MAX_SG_SEGMENTS * =
sizeof(struct dma_desc_array),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ap->bmdma_prd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ap->bmdma_prd_dma);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_dma(CH_ATAPI_RX);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_dma(CH_ATAPI_TX);
> =A0 =A0 =A0 =A0}
> @@ -1272,14 +1266,29 @@ static int bfin_port_start(struct ata_port *a=
p)
> =A0 =A0 =A0 =A0if (!(ap->udma_mask || ap->mwdma_mask))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> + =A0 =A0 =A0 ap->bmdma_prd =3D dma_alloc_coherent(ap->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BFIN_MA=
X_SG_SEGMENTS * sizeof(struct dma_desc_array),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &ap->bm=
dma_prd_dma,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KER=
NEL);
> +
> + =A0 =A0 =A0 if (ap->bmdma_prd =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(ap->dev, "Unable to allocate D=
MA descriptor array.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (request_dma(CH_ATAPI_RX, "BFIN ATAPI RX DMA") >=3D=
 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (request_dma(CH_ATAPI_TX,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"BFIN ATAPI TX DMA") >=
=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_dma(CH_ATAPI_RX);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(ap->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BFIN_MAX_SG_SEGMENTS * =
sizeof(struct dma_desc_array),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ap->bmdma_prd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ap->bmdma_prd_dma);
> =A0 =A0 =A0 =A0}
>
> +out:
> =A0 =A0 =A0 =A0ap->udma_mask =3D 0;
> =A0 =A0 =A0 =A0ap->mwdma_mask =3D 0;
> =A0 =A0 =A0 =A0dev_err(ap->dev, "Unable to request ATAPI DMA!"
> @@ -1401,7 +1410,7 @@ static irqreturn_t bfin_ata_interrupt(int irq, =
void *dev_instance)
>
> =A0static struct scsi_host_template bfin_sht =3D {
> =A0 =A0 =A0 =A0ATA_BASE_SHT(DRV_NAME),
> - =A0 =A0 =A0 .sg_tablesize =A0 =A0 =A0 =A0 =A0 =3D SG_NONE,
> + =A0 =A0 =A0 .sg_tablesize =A0 =A0 =A0 =A0 =A0 =3D BFIN_MAX_SG_SEGME=
NTS,
> =A0 =A0 =A0 =A0.dma_boundary =A0 =A0 =A0 =A0 =A0 =3D ATA_DMA_BOUNDARY=
,
> =A0};
>
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
