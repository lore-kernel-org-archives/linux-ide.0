From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 03/03] sata_mv implement IRQ coalescing
Date: Wed, 11 Mar 2009 00:06:29 +0100
Message-ID: <da824cf30903101606h7420a86apb84e489a90e1b3ae@mail.gmail.com>
References: <49B6EE95.1010808@rtr.ca> <49B6EED8.8060205@rtr.ca>
	 <49B6EF18.8050000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:54069 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbZCJXGd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Mar 2009 19:06:33 -0400
Received: from zps18.corp.google.com (zps18.corp.google.com [172.25.146.18])
	by smtp-out.google.com with ESMTP id n2AN6UM2025361
	for <linux-ide@vger.kernel.org>; Tue, 10 Mar 2009 16:06:31 -0700
Received: from wf-out-1314.google.com (wff28.prod.google.com [10.142.6.28])
	by zps18.corp.google.com with ESMTP id n2AN6TUS032655
	for <linux-ide@vger.kernel.org>; Tue, 10 Mar 2009 16:06:29 -0700
Received: by wf-out-1314.google.com with SMTP id 28so2882938wff.3
        for <linux-ide@vger.kernel.org>; Tue, 10 Mar 2009 16:06:29 -0700 (PDT)
In-Reply-To: <49B6EF18.8050000@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Mar 10, 2009 at 11:52 PM, Mark Lord <liml@rtr.ca> wrote:
> Add IRQ coalescing to sata_mv (off by default).

Excellent!

> This feature can reduce total interrupt overhead for RAID setups

Just to be clear, this is referring to SW RAID (e.g. md or dm) and not
some feature in this SATA controller. I'll point out even without SW RA=
ID,
this feature can helps reduce interrupts even if only one port is in us=
e.

(NCQ allows many commands outstanding and it's possible to defer
generating an interrupt until several commands have completed. Very
similar to how NICs operate by default).

> in some situations, by deferring the interrupt signal until one or bo=
th of:
>
> a) a specified io_count (completed SATA commands) is achieved, or
> b) a specified time interval elapses after an IO completion.
>
> For now, module parameters are used to set the irq_coalescing_io_coun=
t
> and irq_coalescing_usecs (timeout) globally. =C2=A0These may eventual=
ly
> be supplemented with sysfs attributes, so that thresholds can be set
> on-the-fly and on a per-chip (or even per-host_controller) basis.
>
> Signed-off-by: Mark Lord <mlord@pobox.com>

Reviewed-by: Grant Grundler <grundler@google.com>

thanks,
grant

> ---
>
> This is for #upstream libata-dev #upstream
>
> --- old/drivers/ata/sata_mv.c =C2=A0 2009-03-10 18:28:30.000000000 -0=
400
> +++ new/drivers/ata/sata_mv.c =C2=A0 2009-03-10 18:48:07.000000000 -0=
400
> @@ -34,10 +34,7 @@
> =C2=A0*
> =C2=A0* --> Develop a low-power-consumption strategy, and implement i=
t.
> =C2=A0*
> - * --> [Experiment, low priority] Investigate interrupt coalescing.
> - * =C2=A0 =C2=A0 =C2=A0 Quite often, especially with PCI Message Sig=
nalled Interrupts
> (MSI),
> - * =C2=A0 =C2=A0 =C2=A0 the overhead reduced by interrupt mitigation=
 is quite often not
> - * =C2=A0 =C2=A0 =C2=A0 worth the latency cost.
> + * --> Add sysfs attributes for per-chip / per-HC IRQ coalescing
> thresholds.
> =C2=A0*
> =C2=A0* --> [Experiment, Marvell value added] Is it possible to use t=
arget
> =C2=A0* =C2=A0 =C2=A0 =C2=A0 mode to cross-connect two Linux boxes wi=
th Marvell cards? =C2=A0If so,
> @@ -67,7 +64,7 @@
> #include <linux/libata.h>
>
> #define DRV_NAME =C2=A0 =C2=A0 =C2=A0 =C2=A0"sata_mv"
> -#define DRV_VERSION =C2=A0 =C2=A0"1.26"
> +#define DRV_VERSION =C2=A0 =C2=A0"1.27"
>
> /*
> =C2=A0* module options
> @@ -79,6 +76,16 @@
> MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=3Doff, 1=3Don)");
> #endif
>
> +static int irq_coalescing_io_count;
> +module_param(irq_coalescing_io_count, int, S_IRUGO);
> +MODULE_PARM_DESC(irq_coalescing_io_count,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"IRQ coalesc=
ing I/O count threshold (0..255)");
> +
> +static int irq_coalescing_usecs;
> +module_param(irq_coalescing_usecs, int, S_IRUGO);
> +MODULE_PARM_DESC(irq_coalescing_usecs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"IRQ coalesc=
ing time threshold in usecs");
> +
> enum {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* BAR's are enumerated in terms of pci_re=
source_start() terms */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MV_PRIMARY_BAR =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D 0, =C2=A0 =C2=A0/* offset 0x10: memory space */
> @@ -88,8 +95,33 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MV_MAJOR_REG_AREA_SZ =C2=A0 =C2=A0=3D 0x10=
000, =C2=A0 =C2=A0 =C2=A0/* 64KB */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MV_MINOR_REG_AREA_SZ =C2=A0 =C2=A0=3D 0x20=
00, =C2=A0 =C2=A0 =C2=A0 /* 8KB */
>
> + =C2=A0 =C2=A0 =C2=A0 /* For use with both IRQ coalescing methods ("=
all ports" or "per-HC"
> */
> + =C2=A0 =C2=A0 =C2=A0 COAL_CLOCKS_PER_USEC =C2=A0 =C2=A0=3D 150, =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* for calculating
> COAL_TIMEs */
> + =C2=A0 =C2=A0 =C2=A0 MAX_COAL_TIME_THRESHOLD =3D ((1 << 24) - 1), /=
* internal clocks count
> */
> + =C2=A0 =C2=A0 =C2=A0 MAX_COAL_IO_COUNT =C2=A0 =C2=A0 =C2=A0 =3D 255=
, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* completed I/O count */
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MV_PCI_REG_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D 0,
>
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Per-chip ("all ports") interrupt coale=
scing feature.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* This is only for GEN_II / GEN_IIE hard=
ware.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Coalescing defers the interrupt until =
either the IO_THRESHOLD
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* (count of completed I/Os) is met, or t=
he TIME_THRESHOLD is met.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 MV_COAL_REG_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 0x18000,
> + =C2=A0 =C2=A0 =C2=A0 MV_IRQ_COAL_CAUSE =C2=A0 =C2=A0 =C2=A0 =3D (MV=
_COAL_REG_BASE + 0x08),
> + =C2=A0 =C2=A0 =C2=A0 ALL_PORTS_IRQ_COAL_IRQ =C2=A0=3D (1 << 4), =C2=
=A0 =C2=A0 /* all ports irq event */
> +
> + =C2=A0 =C2=A0 =C2=A0 MV_IRQ_COAL_IO_THRESHOLD =C2=A0 =3D (MV_COAL_R=
EG_BASE + 0xcc),
> + =C2=A0 =C2=A0 =C2=A0 MV_IRQ_COAL_TIME_THRESHOLD =3D (MV_COAL_REG_BA=
SE + 0xd0),
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Registers for the (unused here) transa=
ction coalescing feature:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 MV_TRAN_COAL_CAUSE_LO =C2=A0 =3D (MV_COAL_REG_=
BASE + 0x88),
> + =C2=A0 =C2=A0 =C2=A0 MV_TRAN_COAL_CAUSE_HI =C2=A0 =3D (MV_COAL_REG_=
BASE + 0x8c),
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MV_SATAHC0_REG_BASE =C2=A0 =C2=A0 =3D 0x20=
000,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MV_FLASH_CTL_OFS =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0x1046c,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MV_GPIO_PORT_CTL_OFS =C2=A0 =C2=A0=3D 0x10=
4f0,
> @@ -186,6 +218,8 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DONE_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D (1 << 1), =C2=A0 =C2=A0 /* shift by (2 * port =
#) */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HC0_IRQ_PEND =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 0x1ff, =C2=A0 =C2=A0 =C2=A0 =C2=A0/* bits 0-8 =3D HC0's p=
orts */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HC_SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D 9, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 bits 9-17 =3D HC1's ports */
> + =C2=A0 =C2=A0 =C2=A0 DONE_IRQ_0_3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D 0x000000aa, =C2=A0 /* DONE_IRQ ports 0,1,2,3 */
> + =C2=A0 =C2=A0 =C2=A0 DONE_IRQ_4_7 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D (DONE_IRQ_0_3 << HC_SHIFT), =C2=A0/* 4,5,6,7 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_ERR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D (1 << 18),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0TRAN_COAL_LO_DONE =C2=A0 =C2=A0 =C2=A0 =3D=
 (1 << 19), =C2=A0 =C2=A0/* transaction coalescing */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0TRAN_COAL_HI_DONE =C2=A0 =C2=A0 =C2=A0 =3D=
 (1 << 20), =C2=A0 =C2=A0/* transaction coalescing */
> @@ -207,6 +241,16 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HC_COAL_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D (1 << 4), =C2=A0 =C2=A0 /* IRQ coalescing */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DEV_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D (1 << 8), =C2=A0 =C2=A0 /* shift by port # */
>
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Per-HC (Host-Controller) interrupt coa=
lescing feature.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* This is present on all chip generation=
s.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Coalescing defers the interrupt until =
either the IO_THRESHOLD
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* (count of completed I/Os) is met, or t=
he TIME_THRESHOLD is met.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 HC_IRQ_COAL_IO_THRESHOLD_OFS =C2=A0 =C2=A0=3D =
0x000c,
> + =C2=A0 =C2=A0 =C2=A0 HC_IRQ_COAL_TIME_THRESHOLD_OFS =C2=A0=3D 0x001=
0,
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Shadow block registers */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SHD_BLK_OFS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D 0x100,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SHD_CTL_AST_OFS =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D 0x20, =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ofs from SHD_BLK_OFS */
> @@ -897,6 +941,20 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_mmio + E=
DMA_RSP_Q_OUT_PTR_OFS);
> }
>
> +static void mv_write_main_irq_mask(u32 mask, struct mv_host_priv *hp=
riv)
> +{
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* When writing to the main_irq_mask in h=
ardware,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* we must ensure exclusivity between the=
 interrupt coalescing bits
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* and the corresponding individual port =
DONE_IRQ bits.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (mask & (ALL_PORTS_COAL_DONE | PORTS_0_3_CO=
AL_DONE))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask &=3D ~DONE_IR=
Q_0_3;
> + =C2=A0 =C2=A0 =C2=A0 if (mask & (ALL_PORTS_COAL_DONE | PORTS_4_7_CO=
AL_DONE))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask &=3D ~DONE_IR=
Q_4_7;
> + =C2=A0 =C2=A0 =C2=A0 writelfl(mask, hpriv->main_irq_mask_addr);
> +}
> +
> static void mv_set_main_irq_mask(struct ata_host *host,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 disable_bits, u32 enable=
_bits)
> {
> @@ -907,7 +965,7 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0new_mask =3D (old_mask & ~disable_bits) | =
enable_bits;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (new_mask !=3D old_mask) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hpriv->main_ir=
q_mask =3D new_mask;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writelfl(new_mask,=
 hpriv->main_irq_mask_addr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mv_write_main_irq_=
mask(new_mask, hpriv);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> }
>
> @@ -948,6 +1006,55 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mv_enable_port_irqs(ap, port_irqs);
> }
>
> +static void mv_set_irq_coalescing(struct ata_host *host,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int count, unsigned=
 int usecs)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct mv_host_priv *hpriv =3D host->private_d=
ata;
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *mmio =3D hpriv->base;
> + =C2=A0 =C2=A0 =C2=A0 u32 coal_bits;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int time =3D (usecs * COAL_CLOCKS_PER=
_USEC);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Disable IRQ coalescing if the time threshol=
d is zero */
> + =C2=A0 =C2=A0 =C2=A0 if (!time)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Respect maximum limits of the hardware */
> + =C2=A0 =C2=A0 =C2=A0 if (count > MAX_COAL_IO_COUNT)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D MAX_COAL=
_IO_COUNT;
> + =C2=A0 =C2=A0 =C2=A0 if (time > MAX_COAL_TIME_THRESHOLD)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time =3D MAX_COAL_=
TIME_THRESHOLD;
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&host->lock, flags);
> + =C2=A0 =C2=A0 =C2=A0 if (IS_GEN_I(hpriv)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* GEN_I: ind=
ependent thresholds for each HC on the chip.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *hc_m=
mio =3D mv_hc_base_from_port(mmio, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(time, =C2=A0=
hc_mmio + HC_IRQ_COAL_TIME_THRESHOLD_OFS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(count, hc_m=
mio + HC_IRQ_COAL_IO_THRESHOLD_OFS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 coal_bits =3D PORT=
S_0_3_COAL_DONE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hpriv->n_ports=
 > 4) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 hc_mmio =3D mv_hc_base_from_port(mmio,
> MV_PORTS_PER_HC);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 writel(time, =C2=A0hc_mmio +
> HC_IRQ_COAL_TIME_THRESHOLD_OFS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 writel(count, hc_mmio +
> HC_IRQ_COAL_IO_THRESHOLD_OFS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 coal_bits |=3D PORTS_4_7_COAL_DONE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* GEN_II/GEN=
_IIE: global thresholds for the entire chip.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(time, =C2=A0=
mmio + MV_IRQ_COAL_TIME_THRESHOLD);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(count, mmio=
 + MV_IRQ_COAL_IO_THRESHOLD);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 coal_bits =3D ALL_=
PORTS_COAL_DONE;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (time)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mv_set_main_irq_ma=
sk(host, 0, coal_bits); /* unmask coal
> irqs */
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mv_set_main_irq_ma=
sk(host, coal_bits, 0); /* mask coal irqs
> */
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> /**
> =C2=A0* =C2=A0 =C2=A0 =C2=A0mv_start_edma - Enable eDMA engine
> =C2=A0* =C2=A0 =C2=A0 =C2=A0@base: port base address
> @@ -2500,6 +2607,10 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *mmio =3D hpriv->base, *hc_mm=
io;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int handled =3D 0, port;
>
> + =C2=A0 =C2=A0 =C2=A0 /* If asserted, clear the "all ports" IRQ coal=
escing bit */
> + =C2=A0 =C2=A0 =C2=A0 if (main_irq_cause & ALL_PORTS_COAL_DONE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(ALL_PORTS_I=
RQ_COAL_IRQ, mmio + MV_IRQ_COAL_CAUSE);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (port =3D 0; port < hpriv->n_ports; po=
rt++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ata_por=
t *ap =3D host->ports[port];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int p=
, shift, hardport, port_cause;
> @@ -2531,7 +2642,7 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 * ports which interrupted us, and use that bitmap
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 * to ack (only) those ports via hc_irq_cause.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ack_irqs =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ack_irqs =3D (hc_cause & HC_COAL_IRQ);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0for (p =3D 0; p < MV_PORTS_PER_HC; ++p) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((port + p) >=3D hpriv->n_=
ports)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
reak;
> @@ -2620,7 +2731,7 @@
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* for MSI: =C2=A0block new interrupts whi=
le in here */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (using_msi)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(0, hpriv->m=
ain_irq_mask_addr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mv_write_main_irq_=
mask(0, hpriv);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0main_irq_cause =3D readl(hpriv->main_irq_c=
ause_addr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pending_irqs =C2=A0 =3D main_irq_cause & h=
priv->main_irq_mask;
> @@ -2637,9 +2748,9 @@
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* for MSI: unmask; interrupt cause bits w=
ill retrigger now */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (using_msi)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(hpriv->main=
_irq_mask, hpriv->main_irq_mask_addr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mv_write_main_irq_=
mask(hpriv->main_irq_mask, hpriv);
>
> - =C2=A0 =C2=A0 =C2=A0 spin_unlock(&host->lock);
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock(&host->lock); =C2=A0 =C2=A0 =C2=A0=
 /* FIXME: broken in Linus tree? */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_RETVAL(handled);
> }
> @@ -3546,6 +3657,8 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The per-port interrupts get done later =
as ports are set up.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mv_set_main_irq_mask(host, 0, PCI_ERR);
> + =C2=A0 =C2=A0 =C2=A0 mv_set_irq_coalescing(host, irq_coalescing_io_=
count,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq_coalescing_usecs)=
;
> done:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;
> }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
