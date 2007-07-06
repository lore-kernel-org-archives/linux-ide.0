From: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: RE: [PATCH 2.6.20-stable] sata_vsc: fix 2.6.19 to .20 regression whilerefactoring vsc_sata_interrupt
Date: Fri, 6 Jul 2007 12:45:35 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C066B5B2E@usa0300ms03.na.xerox.net>
References: <1183738437.10137.10.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wvmler1.mail.xerox.com ([13.8.138.216]:49686 "EHLO
	wvmler1.mail.xerox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694AbXGFQyy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jul 2007 12:54:54 -0400
Content-class: urn:content-classes:message
In-reply-to: <1183738437.10137.10.camel@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, stable@kernel.org
Cc: linux-ide@vger.kernel.org, "Lund, Nathan" <Nathan.Lund@xerox.com>

 I put in this patch and I get:
00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
[ 1416.680306]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x20 (host bus error)
[ 1416.723962] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1416.746129] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1416.768582] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1416.790738] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1416.812946] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1446.831480] ata1.00: qc timeout (cmd 0xec)
[ 1446.839662] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 1446.851797] ata1.00: revalidation failed (errno=-5)
[ 1446.861508] ata1: failed to recover some devices, retrying in 5 secs
[ 1459.187364] ata1: port is slow to respond, please be patient (Status
0xd0)
[ 1482.215332] ata1: port failed to respond (30 secs, Status 0xd0)
[ 1482.227146] ata1: soft resetting port
[ 1482.387350] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1482.411264] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1482.433434] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1482.455604] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1482.477759] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1482.499966] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1482.515381] ata1.00: revalidation failed (errno=-2)
[ 1482.525090] ata1: failed to recover some devices, retrying in 5 secs
[ 1487.539353] ata1: hard resetting port
[ 1487.863369] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1487.891790] ata1.00: configured for UDMA/133
[ 1487.900364] ata1: EH complete
[ 1517.903401] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1517.916286] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
cdb 0x0 data 4096 in
[ 1517.916298]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x20 (host bus error)
[ 1517.959964] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1517.982140] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1518.004311] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1518.026467] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1518.048676] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1548.055367] ata1.00: qc timeout (cmd 0xec)
[ 1548.063547] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 1548.075681] ata1.00: revalidation failed (errno=-5)
[ 1548.085390] ata1: failed to recover some devices, retrying in 5 secs
[ 1560.411363] ata1: port is slow to respond, please be patient (Status
0xd0)
[ 1583.439334] ata1: port failed to respond (30 secs, Status 0xd0)
[ 1583.451146] ata1: soft resetting port
[ 1583.611347] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1583.635257] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1583.657432] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1583.679602] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1583.701756] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1583.723962] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1583.755661] ata1.00: revalidation failed (errno=-2)
[ 1583.765373] ata1: failed to recover some devices, retrying in 5 secs
[ 1588.779357] ata1: hard resetting port
[ 1589.103368] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1589.131792] ata1.00: configured for UDMA/133
[ 1589.140368] ata1: EH complete
[ 1619.143401] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1619.156286] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
cdb 0x0 data 4096 in
[ 1619.156298]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x20 (host bus error)
[ 1619.199953] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1619.222128] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1619.244300] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1619.266458] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1619.288666] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1649.307479] ata1.00: qc timeout (cmd 0xec)
[ 1649.315663] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 1649.327796] ata1.00: revalidation failed (errno=-5)
[ 1649.337509] ata1: failed to recover some devices, retrying in 5 secs
[ 1661.663364] ata1: port is slow to respond, please be patient (Status
0xd0)
[ 1684.691331] ata1: port failed to respond (30 secs, Status 0xd0)
[ 1684.703143] ata1: soft resetting port
[ 1684.863349] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1684.887263] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1684.909433] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1684.931604] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1684.953759] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1684.975966] ATA: abnormal status 0xD0 on port 0xE100821C
[ 1685.007380] ata1.00: revalidation failed (errno=-2)
[ 1685.017089] ata1: failed to recover some devices, retrying in 5 secs
[ 1690.031356] ata1: hard resetting port
[ 1690.355368] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1690.383791] ata1.00: configured for UDMA/133
[ 1690.392371] sd 0:0:0:0: SCSI error: return code = 0x08000002
[ 1690.403642] sda: Current [descriptor]: sense key: Aborted Command
[ 1690.415762]     Additional sense: No additional sense information
[ 1690.427880] Descriptor sense data with sense descriptors (in hex):
[ 1690.440172]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 1690.452808]         00 00 00 00
[ 1690.459216] end_request: I/O error, dev sda, sector 0
[ 1690.469277] Buffer I/O error on device sda, logical block 0
[ 1690.480431] ata1: EH complete
[ 1690.486364]  unknown partition table
[ 1690.502907] sd 0:0:0:0: Attached scsi disk sda
[ 1690.529977] sd 0:0:0:0: Attached scsi generic sg0 type 0

When I just put in this patch:
@@ -258,6 +258,10 @@
                                        /* Clear interrupt status */
                                        ata_chk_status(ap);
                                        handled++;
+                               } else if(qc->tf.command ==
ATA_CMD_ID_ATA) {
+                                       /* 31244 interrupts on polled
IDENTIFY
+commands */
+                                       ata_chk_status(ap);
                                }
                        }
                }

it worked fine on an intel system, and allowed me to fdisk/dd on a ppc
(but didn't
let the kernel read the partition table).  On ppc, it also cycled
through the udma modes with the small
patch...

marty


> -----Original Message-----
> From: Dan Williams [mailto:dan.j.williams@intel.com] 
> Sent: Friday, July 06, 2007 12:14 PM
> To: stable@kernel.org
> Cc: linux-ide@vger.kernel.org; Leisner, Martin
> Subject: [PATCH 2.6.20-stable] sata_vsc: fix 2.6.19 to .20 
> regression whilerefactoring vsc_sata_interrupt
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Separate sata_vsc interrupt handling into a normal (per-port) 
> path and an
> error path with the addition of vsc_port_intr and vsc_error_intr
> respectively.  The error path handles interrupt based
> hotplug events which requires the definition of vsc_freeze 
> and vsc_thaw.
> 
> Note: vsc_port_intr has a workaround for unexpected 
> interrupts that occur
> during polled commands.  This fixes a regression between 
> 2.6.19 and 2.6.20.
> Caused by 800b399669ad495ad4361d134df87401ae36f44f.
> 
> Changes in take2:
> * removed definition of invalid fis bit
> * let standard ata-error-handling handle the serror register
> * clear all unhandled interrupts
> * revert changes to vsc_intr_mask_update (vsc_thaw enables 
> all interrupts)
> * use unlikely() for the pci-abort and not-our-interrupt 
> cases in vsc_sata_interrupt
> 
> Changes in take3:
> * Unify the "add" + "hook-up" patches into this single patch
> 
> [htejun@gmail.com: clean up comments and suggestions]
> Cc: Jeremy Higdon <jeremy@sgi.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  drivers/ata/sata_vsc.c |  123 
> +++++++++++++++++++++++++++++-------------------
>  1 files changed, 74 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
> index 0fa1b89..bcfca62 100644
> --- a/drivers/ata/sata_vsc.c
> +++ b/drivers/ata/sata_vsc.c
> @@ -96,11 +96,6 @@ enum {
>  			      VSC_SATA_INT_PHY_CHANGE),
>  };
>  
> -
> -#define is_vsc_sata_int_err(port_idx, int_status) \
> -	 (int_status & (VSC_SATA_INT_ERROR << (8 * port_idx)))
> -
> -
>  static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned 
> int sc_reg)
>  {
>  	if (sc_reg > SCR_CONTROL)
> @@ -118,6 +113,28 @@ static void vsc_sata_scr_write (struct 
> ata_port *ap, unsigned int sc_reg,
>  }
>  
>  
> +static void vsc_freeze(struct ata_port *ap)
> +{
> +	void __iomem *mask_addr;
> +
> +	mask_addr = ap->host->mmio_base +
> +		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
> +
> +	writeb(0, mask_addr);
> +}
> +
> +
> +static void vsc_thaw(struct ata_port *ap)
> +{
> +	void __iomem *mask_addr;
> +
> +	mask_addr = ap->host->mmio_base +
> +		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
> +
> +	writeb(0xff, mask_addr);
> +}
> +
> +
>  static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
>  {
>  	void __iomem *mask_addr;
> @@ -202,6 +219,36 @@ static void vsc_sata_tf_read(struct 
> ata_port *ap, struct ata_taskfile *tf)
>          }
>  }
>  
> +static inline void vsc_error_intr(u8 port_status, struct 
> ata_port *ap)
> +{
> +	if (port_status & (VSC_SATA_INT_PHY_CHANGE | 
> VSC_SATA_INT_ERROR_M))
> +		ata_port_freeze(ap);
> +	else
> +		ata_port_abort(ap);
> +}
> +
> +static void vsc_port_intr(u8 port_status, struct ata_port *ap)
> +{
> +	struct ata_queued_cmd *qc;
> +	int handled = 0;
> +
> +	if (unlikely(port_status & VSC_SATA_INT_ERROR)) {
> +		vsc_error_intr(port_status, ap);
> +		return;
> +	}
> +
> +	qc = ata_qc_from_tag(ap, ap->active_tag);
> +	if (qc && likely(!(qc->tf.flags & ATA_TFLAG_POLLING)))
> +		handled = ata_host_intr(ap, qc);
> +
> +	/* We received an interrupt during a polled command,
> +	 * or some other spurious condition.  Interrupt reporting
> +	 * with this hardware is fairly reliable so it is safe to
> +	 * simply clear the interrupt
> +	 */
> +	if (unlikely(!handled))
> +		ata_chk_status(ap);
> +}
>  
>  /*
>   * vsc_sata_interrupt
> @@ -213,58 +260,36 @@ static irqreturn_t vsc_sata_interrupt 
> (int irq, void *dev_instance)
>  	struct ata_host *host = dev_instance;
>  	unsigned int i;
>  	unsigned int handled = 0;
> -	u32 int_status;
> -
> -	spin_lock(&host->lock);
> +	u32 status;
>  
> -	int_status = readl(host->mmio_base + VSC_SATA_INT_STAT_OFFSET);
> +	status = readl(host->mmio_base + VSC_SATA_INT_STAT_OFFSET);
>  
> -	for (i = 0; i < host->n_ports; i++) {
> -		if (int_status & ((u32) 0xFF << (8 * i))) {
> -			struct ata_port *ap;
> +	if (unlikely(status == 0xffffffff || status == 0)) {
> +		if (status)
> +			dev_printk(KERN_ERR, host->dev,
> +				": IRQ status == 0xffffffff, "
> +				"PCI fault or device removal?\n");
> +		goto out;
> +	}
>  
> -			ap = host->ports[i];
> +	spin_lock(&host->lock);
>  
> -			if (is_vsc_sata_int_err(i, int_status)) {
> -				u32 err_status;
> -				printk(KERN_DEBUG "%s: ignoring 
> interrupt(s)\n", __FUNCTION__);
> -				err_status = ap ? 
> vsc_sata_scr_read(ap, SCR_ERROR) : 0;
> -				vsc_sata_scr_write(ap, 
> SCR_ERROR, err_status);
> -				handled++;
> -			}
> +	for (i = 0; i < host->n_ports; i++) {
> +		u8 port_status = (status >> (8 * i)) & 0xff;
> +		if (port_status) {
> +			struct ata_port *ap = host->ports[i];
>  
>  			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
> -				struct ata_queued_cmd *qc;
> -
> -				qc = ata_qc_from_tag(ap, 
> ap->active_tag);
> -				if (qc && (!(qc->tf.flags & 
> ATA_TFLAG_POLLING)))
> -					handled += 
> ata_host_intr(ap, qc);
> -				else if (is_vsc_sata_int_err(i, 
> int_status)) {
> -					/*
> -					 * On some chips (i.e. 
> Intel 31244), an error
> -					 * interrupt will sneak 
> in at initialization
> -					 * time (phy state 
> changes).  Clearing the SCR
> -					 * error register is 
> not required, but it prevents
> -					 * the phy state change 
> interrupts from recurring
> -					 * later.
> -					 */
> -					u32 err_status;
> -					err_status = 
> vsc_sata_scr_read(ap, SCR_ERROR);
> -					printk(KERN_DEBUG "%s: 
> clearing interrupt, "
> -					       "status %x; sata 
> err status %x\n",
> -					       __FUNCTION__,
> -					       int_status, err_status);
> -					vsc_sata_scr_write(ap, 
> SCR_ERROR, err_status);
> -					/* Clear interrupt status */
> -					ata_chk_status(ap);
> -					handled++;
> -				}
> -			}
> +				vsc_port_intr(port_status, ap);
> +				handled++;
> +			} else
> +				dev_printk(KERN_ERR, host->dev,
> +					": interrupt from 
> disabled port %d\n", i);
>  		}
>  	}
>  
>  	spin_unlock(&host->lock);
> -
> +out:
>  	return IRQ_RETVAL(handled);
>  }
>  
> @@ -302,8 +327,8 @@ static const struct ata_port_operations 
> vsc_sata_ops = {
>  	.qc_prep		= ata_qc_prep,
>  	.qc_issue		= ata_qc_issue_prot,
>  	.data_xfer		= ata_mmio_data_xfer,
> -	.freeze			= ata_bmdma_freeze,
> -	.thaw			= ata_bmdma_thaw,
> +	.freeze			= vsc_freeze,
> +	.thaw			= vsc_thaw,
>  	.error_handler		= ata_bmdma_error_handler,
>  	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
>  	.irq_handler		= vsc_sata_interrupt,
> 
