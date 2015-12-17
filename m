From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/3] ata: sata_dwc_460ex: get rid of global data
Date: Thu, 17 Dec 2015 17:06:05 +0200
Message-ID: <1450364765.30729.139.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	 <1450221935-6034-3-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12964 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966983AbbLQPGT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Dec 2015 10:06:19 -0500
In-Reply-To: <1450221935-6034-3-git-send-email-mans@mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2015-12-15 at 23:25 +0000, Mans Rullgard wrote:
> This moves all global data into the driver private struct, thus
> permitting multiple devices of this type to be used.
>=20

Nice!

Btw, last time Linus complained about new warnings. Most of them I have
fixed when moved to external DMA driver. Leftovers IIRC are related to
address space. Are you going to fix them? Otherwise it might be a
headache for him again with strong wording to our address I suppose.

> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> =C2=A0drivers/ata/sata_dwc_460ex.c | 80 ++++++++++++++++++++---------=
---
> ------------
> =C2=A01 file changed, 36 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/ata/sata_dwc_460ex.c
> b/drivers/ata/sata_dwc_460ex.c
> index d07aae1..919f870 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -146,6 +146,8 @@ struct sata_dwc_device {
> =C2=A0	struct ata_host		*host;
> =C2=A0	u8 __iomem		*reg_base;
> =C2=A0	struct sata_dwc_regs	*sata_dwc_regs;	/* DW
> Synopsys SATA specific */
> +	u32			sactive_issued;
> +	u32			sactive_queued;
> =C2=A0	struct phy		*phy;
> =C2=A0#ifdef CONFIG_SATA_DWC_OLD_DMA
> =C2=A0	struct dw_dma_chip	*dma;
> @@ -190,14 +192,6 @@ enum {
> =C2=A0	SATA_DWC_DMA_PENDING_RX		=3D 2,
> =C2=A0};
> =C2=A0
> -struct sata_dwc_host_priv {
> -	void	__iomem	=C2=A0*scr_addr_sstatus;
> -	u32	sata_dwc_sactive_issued ;
> -	u32	sata_dwc_sactive_queued ;
> -};
> -
> -static struct sata_dwc_host_priv host_pvt;
> -
> =C2=A0/*
> =C2=A0 * Prototypes
> =C2=A0 */
> @@ -448,21 +442,22 @@ static int sata_dwc_scr_write(struct ata_link
> *link, unsigned int scr, u32 val)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static u32 core_scr_read(unsigned int scr)
> +static u32 core_scr_read(struct sata_dwc_device *hsdev, unsigned int
> scr)
> =C2=A0{
> -	return in_le32(host_pvt.scr_addr_sstatus + (scr * 4));
> +	return in_le32(hsdev->reg_base + SATA_DWC_SCR_OFFSET + (scr
> * 4));
> =C2=A0}
> =C2=A0
> -static void core_scr_write(unsigned int scr, u32 val)
> +static void core_scr_write(struct sata_dwc_device *hsdev, unsigned
> int scr,
> +			=C2=A0=C2=A0=C2=A0u32 val)
> =C2=A0{
> -	out_le32(host_pvt.scr_addr_sstatus + (scr * 4), val);
> +	out_le32(hsdev->reg_base + SATA_DWC_SCR_OFFSET + (scr * 4),
> val);
> =C2=A0}
> =C2=A0
> -static void clear_serror(void)
> +static void clear_serror(struct sata_dwc_device *hsdev)
> =C2=A0{
> =C2=A0	u32 val;
> -	val =3D core_scr_read(SCR_ERROR);
> -	core_scr_write(SCR_ERROR, val);
> +	val =3D core_scr_read(hsdev, SCR_ERROR);
> +	core_scr_write(hsdev, SCR_ERROR, val);
> =C2=A0}
> =C2=A0
> =C2=A0static void clear_interrupt_bit(struct sata_dwc_device *hsdev, =
u32
> bit)
> @@ -489,7 +484,7 @@ static void sata_dwc_error_intr(struct ata_port
> *ap,
> =C2=A0
> =C2=A0	ata_ehi_clear_desc(ehi);
> =C2=A0
> -	serror =3D core_scr_read(SCR_ERROR);
> +	serror =3D core_scr_read(hsdev, SCR_ERROR);
> =C2=A0	status =3D ap->ops->sff_check_status(ap);
> =C2=A0
> =C2=A0	tag =3D ap->link.active_tag;
> @@ -500,7 +495,7 @@ static void sata_dwc_error_intr(struct ata_port
> *ap,
> =C2=A0		hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag]);
> =C2=A0
> =C2=A0	/* Clear error register and interrupt bit */
> -	clear_serror();
> +	clear_serror(hsdev);
> =C2=A0	clear_interrupt_bit(hsdev, SATA_DWC_INTPR_ERR);
> =C2=A0
> =C2=A0	/* This is the only error happening now.=C2=A0=C2=A0TODO check=
 for
> exact error */
> @@ -539,7 +534,7 @@ static irqreturn_t sata_dwc_isr(int irq, void
> *dev_instance)
> =C2=A0	int handled, num_processed, port =3D 0;
> =C2=A0	uint intpr, sactive, sactive2, tag_mask;
> =C2=A0	struct sata_dwc_device_port *hsdevp;
> -	host_pvt.sata_dwc_sactive_issued =3D 0;
> +	hsdev->sactive_issued =3D 0;
> =C2=A0
> =C2=A0	spin_lock_irqsave(&host->lock, flags);
> =C2=A0
> @@ -568,7 +563,7 @@ static irqreturn_t sata_dwc_isr(int irq, void
> *dev_instance)
> =C2=A0		if (hsdevp->cmd_issued[tag] !=3D
> SATA_DWC_CMD_ISSUED_PEND)
> =C2=A0			dev_warn(ap->dev, "CMD tag=3D%d not
> pending?\n", tag);
> =C2=A0
> -		host_pvt.sata_dwc_sactive_issued |=3D
> qcmd_tag_to_mask(tag);
> +		hsdev->sactive_issued |=3D qcmd_tag_to_mask(tag);
> =C2=A0
> =C2=A0		qc =3D ata_qc_from_tag(ap, tag);
> =C2=A0		/*
> @@ -582,11 +577,11 @@ static irqreturn_t sata_dwc_isr(int irq, void
> *dev_instance)
> =C2=A0		handled =3D 1;
> =C2=A0		goto DONE;
> =C2=A0	}
> -	sactive =3D core_scr_read(SCR_ACTIVE);
> -	tag_mask =3D (host_pvt.sata_dwc_sactive_issued | sactive) ^
> sactive;
> +	sactive =3D core_scr_read(hsdev, SCR_ACTIVE);
> +	tag_mask =3D (hsdev->sactive_issued | sactive) ^ sactive;
> =C2=A0
> =C2=A0	/* If no sactive issued and tag_mask is zero then this is
> not NCQ */
> -	if (host_pvt.sata_dwc_sactive_issued =3D=3D 0 && tag_mask =3D=3D 0)
> {
> +	if (hsdev->sactive_issued =3D=3D 0 && tag_mask =3D=3D 0) {
> =C2=A0		if (ap->link.active_tag =3D=3D ATA_TAG_POISON)
> =C2=A0			tag =3D 0;
> =C2=A0		else
> @@ -656,22 +651,19 @@ DRVSTILLBUSY:
> =C2=A0	=C2=A0*/
> =C2=A0
> =C2=A0	=C2=A0/* process completed commands */
> -	sactive =3D core_scr_read(SCR_ACTIVE);
> -	tag_mask =3D (host_pvt.sata_dwc_sactive_issued | sactive) ^
> sactive;
> +	sactive =3D core_scr_read(hsdev, SCR_ACTIVE);
> +	tag_mask =3D (hsdev->sactive_issued | sactive) ^ sactive;
> =C2=A0
> -	if (sactive !=3D 0 || (host_pvt.sata_dwc_sactive_issued) > 1
> || \
> -							tag_mask >
> 1) {
> +	if (sactive !=3D 0 || hsdev->sactive_issued > 1 ||=C2=A0=C2=A0tag_m=
ask >
> 1) {
> =C2=A0		dev_dbg(ap->dev,
> =C2=A0			"%s
> NCQ:sactive=3D0x%08x=C2=A0=C2=A0sactive_issued=3D0x%08x tag_mask=3D0x=
%08x\n",
> -			__func__, sactive,
> host_pvt.sata_dwc_sactive_issued,
> -			tag_mask);
> +			__func__, sactive, hsdev->sactive_issued,
> tag_mask);
> =C2=A0	}
> =C2=A0
> -	if ((tag_mask | (host_pvt.sata_dwc_sactive_issued)) !=3D \
> -					(host_pvt.sata_dwc_sactive_i
> ssued)) {
> +	if ((tag_mask | hsdev->sactive_issued) !=3D hsdev-
> >sactive_issued) {
> =C2=A0		dev_warn(ap->dev,
> -			=C2=A0"Bad tag mask?=C2=A0=C2=A0sactive=3D0x%08x
> (host_pvt.sata_dwc_sactive_issued)=3D0x%08x=C2=A0=C2=A0tag_mask=3D0x%=
08x\n",
> -			=C2=A0sactive, host_pvt.sata_dwc_sactive_issued,
> tag_mask);
> +			=C2=A0"Bad tag mask?=C2=A0=C2=A0sactive=3D0x%08x
> sactive_issued=3D0x%08x=C2=A0=C2=A0tag_mask=3D0x%08x\n",
> +			=C2=A0sactive, hsdev->sactive_issued, tag_mask);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* read just to clear ... not bad if currently still busy */
> @@ -733,7 +725,7 @@ STILLBUSY:
> =C2=A0	=C2=A0* we were processing --we read status as part of process=
ing
> a completed
> =C2=A0	=C2=A0* command).
> =C2=A0	=C2=A0*/
> -	sactive2 =3D core_scr_read(SCR_ACTIVE);
> +	sactive2 =3D core_scr_read(hsdev, SCR_ACTIVE);
> =C2=A0	if (sactive2 !=3D sactive) {
> =C2=A0		dev_dbg(ap->dev,
> =C2=A0			"More completed - sactive=3D0x%x
> sactive2=3D0x%x\n",
> @@ -819,8 +811,9 @@ static int sata_dwc_qc_complete(struct ata_port
> *ap, struct ata_queued_cmd *qc,
> =C2=A0	u8 status =3D 0;
> =C2=A0	u32 mask =3D 0x0;
> =C2=A0	u8 tag =3D qc->tag;
> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
> =C2=A0	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
> -	host_pvt.sata_dwc_sactive_queued =3D 0;
> +	hsdev->sactive_queued =3D 0;
> =C2=A0	dev_dbg(ap->dev, "%s checkstatus? %x\n", __func__,
> check_status);
> =C2=A0
> =C2=A0	if (hsdevp->dma_pending[tag] =3D=3D SATA_DWC_DMA_PENDING_TX)
> @@ -833,10 +826,8 @@ static int sata_dwc_qc_complete(struct ata_port
> *ap, struct ata_queued_cmd *qc,
> =C2=A0
> =C2=A0	/* clear active bit */
> =C2=A0	mask =3D (~(qcmd_tag_to_mask(tag)));
> -	host_pvt.sata_dwc_sactive_queued =3D
> (host_pvt.sata_dwc_sactive_queued) \
> -						& mask;
> -	host_pvt.sata_dwc_sactive_issued =3D
> (host_pvt.sata_dwc_sactive_issued) \
> -						& mask;
> +	hsdev->sactive_queued =3D hsdev->sactive_queued & mask;
> +	hsdev->sactive_issued =3D hsdev->sactive_issued & mask;
> =C2=A0	ata_qc_complete(qc);
> =C2=A0	return 0;
> =C2=A0}
> @@ -961,7 +952,7 @@ static int sata_dwc_port_start(struct ata_port
> *ap)
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Clear any error bits before libata starts issuing
> commands */
> -	clear_serror();
> +	clear_serror(hsdev);
> =C2=A0	ap->private_data =3D hsdevp;
> =C2=A0	dev_dbg(ap->dev, "%s: done\n", __func__);
> =C2=A0	return 0;
> @@ -999,6 +990,7 @@ static void sata_dwc_exec_command_by_tag(struct
> ata_port *ap,
> =C2=A0{
> =C2=A0	unsigned long flags;
> =C2=A0	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
> =C2=A0
> =C2=A0	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=3D%d\n", __func__,
> tf->command,
> =C2=A0		ata_get_cmd_descript(tf->command), tag);
> @@ -1012,7 +1004,7 @@ static void sata_dwc_exec_command_by_tag(struct
> ata_port *ap,
> =C2=A0	=C2=A0* managed SError register for the disk needs to be done
> before the
> =C2=A0	=C2=A0* task file is loaded.
> =C2=A0	=C2=A0*/
> -	clear_serror();
> +	clear_serror(hsdev);
> =C2=A0	ata_sff_exec_command(ap, tf);
> =C2=A0}
> =C2=A0
> @@ -1065,7 +1057,7 @@ static void sata_dwc_bmdma_start_by_tag(struct
> ata_queued_cmd *qc, u8 tag)
> =C2=A0	sata_dwc_tf_dump(ap, &qc->tf);
> =C2=A0
> =C2=A0	if (start_dma) {
> -		reg =3D core_scr_read(SCR_ERROR);
> +		reg =3D core_scr_read(hsdev, SCR_ERROR);
> =C2=A0		if (reg & SATA_DWC_SERROR_ERR_BITS) {
> =C2=A0			dev_err(ap->dev, "%s: ****** SError=3D0x%08x
> ******\n",
> =C2=A0				__func__, reg);
> @@ -1128,6 +1120,7 @@ static unsigned int sata_dwc_qc_issue(struct
> ata_queued_cmd *qc)
> =C2=A0	u32 sactive;
> =C2=A0	u8 tag =3D qc->tag;
> =C2=A0	struct ata_port *ap =3D qc->ap;
> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
> =C2=A0
> =C2=A0#ifdef DEBUG_NCQ
> =C2=A0	if (qc->tag > 0 || ap->link.sactive > 1)
> @@ -1144,9 +1137,9 @@ static unsigned int sata_dwc_qc_issue(struct
> ata_queued_cmd *qc)
> =C2=A0	sata_dwc_qc_prep_by_tag(qc, tag);
> =C2=A0
> =C2=A0	if (ata_is_ncq(qc->tf.protocol)) {
> -		sactive =3D core_scr_read(SCR_ACTIVE);
> +		sactive =3D core_scr_read(hsdev, SCR_ACTIVE);
> =C2=A0		sactive |=3D (0x00000001 << tag);
> -		core_scr_write(SCR_ACTIVE, sactive);
> +		core_scr_write(hsdev, SCR_ACTIVE, sactive);
> =C2=A0
> =C2=A0		dev_dbg(qc->ap->dev,
> =C2=A0			"%s: tag=3D%d ap->link.sactive =3D 0x%08x
> sactive=3D0x%08x\n",
> @@ -1289,7 +1282,6 @@ static int sata_dwc_probe(struct
> platform_device *ofdev)
> =C2=A0	/* Setup port */
> =C2=A0	host->ports[0]->ioaddr.cmd_addr =3D base;
> =C2=A0	host->ports[0]->ioaddr.scr_addr =3D base +
> SATA_DWC_SCR_OFFSET;
> -	host_pvt.scr_addr_sstatus =3D base + SATA_DWC_SCR_OFFSET;
> =C2=A0	sata_dwc_setup_port(&host->ports[0]->ioaddr, (unsigned
> long)base);
> =C2=A0
> =C2=A0	/* Read the ID and Version Registers */

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

