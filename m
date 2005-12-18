From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH 2.6.14.3] Necessary evil to get sata_vsc to initialize with Intel iq3124h hba
Date: Sun, 18 Dec 2005 01:19:04 -0800
Message-ID: <20051218091904.GA39033@sgi.com>
References: <20051214201049.GA20640@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:12164 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932511AbVLRJTL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 04:19:11 -0500
Content-Disposition: inline
In-Reply-To: <20051214201049.GA20640@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

On Wed, Dec 14, 2005 at 01:10:49PM -0700, Dan Williams wrote:
> * libata does not care about error interrupts, so handle them locally
> * the interrupts that are ignored only appear to happen at init time
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Okay, I finally had some time to look at this.  A few comments . . . .

> ---
> 
>  drivers/scsi/sata_vsc.c |   30 +++++++++++++++++++++++++++++-
>  1 files changed, 29 insertions(+), 1 deletions(-)
> 
> applies-to: 90d8277c8775f3c09655df3b48c37fe07504d162
> 710b992dc354832bb854b9fb05c8fc73c15664d8
> diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
> index cf94e01..7dcc486 100644
> --- a/drivers/scsi/sata_vsc.c
> +++ b/drivers/scsi/sata_vsc.c
> @@ -81,6 +81,19 @@
>  /* Port stride */
>  #define VSC_SATA_PORT_OFFSET		0x200
>  
> +/* Error interrupt status bit offsets */
> +#define VSC_SATA_INT_ERROR_E_OFFSET	2
> +#define VSC_SATA_INT_ERROR_P_OFFSET	4
> +#define VSC_SATA_INT_ERROR_T_OFFSET	5
> +#define VSC_SATA_INT_ERROR_M_OFFSET	1
> +#define is_vsc_sata_int_err(port_idx, int_status) \
> +	 (int_status & ((1 << (VSC_SATA_INT_ERROR_E_OFFSET + (8 * port_idx))) | \
> +		        (1 << (VSC_SATA_INT_ERROR_P_OFFSET + (8 * port_idx))) | \
> +		        (1 << (VSC_SATA_INT_ERROR_T_OFFSET + (8 * port_idx))) | \
> +		        (1 << (VSC_SATA_INT_ERROR_M_OFFSET + (8 * port_idx)))   \
> +		       )\
> + 	 )
> +

I just want to be sure I'm getting this right.
Here you're specifying an interest in the "Data Integrity", "Unrecognized FIS
Reception", "FIFO" errors, and "PHY went from Not-Ready to Ready" bits (text
is using names in VSC7174 manual).  Are these the four bits that have caused
you trouble, and you haven't had problems with the "CRC Error" and "RERR Received",
and "PHY Ready Change-Of-State" bits?

>  static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
>  {
> @@ -193,13 +206,28 @@ static irqreturn_t vsc_sata_interrupt (i
>  			struct ata_port *ap;
>  
>  			ap = host_set->ports[i];
> +
> +			if (is_vsc_sata_int_err(i, int_status)) {
> +				u32 err_status;
> +				printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
> +				err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
> +				vsc_sata_scr_write(ap, SCR_ERROR, err_status);
> +				handled++;
> +			}
> +

This is short circuiting the normal LIBATA interrupt handling, right?
Later, if LIBATA becomes interested in these bits, they'll already be
cleared.

Also, if ap actually is NULL, the vsc_sata_scr_write() call will fail
when it tries to dereference ap.


>  			if (ap && !(ap->flags &
>  				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
>  				struct ata_queued_cmd *qc;
>  
>  				qc = ata_qc_from_tag(ap, ap->active_tag);
> -				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
> +				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
>  					handled += ata_host_intr(ap, qc);
> +				} else {
> +					printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
> +					ata_chk_status(ap);
> +					handled++;
> +				}
> +

I don't think I fully understand the problem you're trying to solve, but
the gist seems to be that you're taking endless interrupts even when
ATA_NIEN is set.  So you add the dummy ata_chk_status call to clear
interrupts that the libata core isn't interested in.  But ata_chk_status
doesn't actually clear it unless you first write to the SCR_ERROR
register above?

FWIW, on my Vitesse chip, the int_status and SCR_ERROR bits that are set and
when this code is called this code are 0x83 and 0x50002, respectively.  But
not clearing them doesn't seem to cause a problem . . . this must be different
behavior in your chip (presumably the Intel branch).

Can you try this redo of your patch?  I get this printed with it:

vsc_sata_interrupt: clearing interrupt,status 8300; sata err status 50002

jeremy

--- linux-2.6.15-rc5/drivers/scsi/sata_vsc.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-new/drivers/scsi/sata_vsc.c	2005-12-18 00:41:29.000000000 -0800
@@ -81,6 +81,19 @@
 /* Port stride */
 #define VSC_SATA_PORT_OFFSET		0x200
 
+/* Error interrupt status bit offsets */
+#define VSC_SATA_INT_ERROR_E_OFFSET	2
+#define VSC_SATA_INT_ERROR_P_OFFSET	4
+#define VSC_SATA_INT_ERROR_T_OFFSET	5
+#define VSC_SATA_INT_ERROR_M_OFFSET	1
+#define is_vsc_sata_int_err(port_idx, int_status) \
+	 (int_status & ((1 << (VSC_SATA_INT_ERROR_E_OFFSET + (8 * port_idx))) | \
+		        (1 << (VSC_SATA_INT_ERROR_P_OFFSET + (8 * port_idx))) | \
+		        (1 << (VSC_SATA_INT_ERROR_T_OFFSET + (8 * port_idx))) | \
+		        (1 << (VSC_SATA_INT_ERROR_M_OFFSET + (8 * port_idx)))   \
+		       )\
+ 	 )
+
 
 static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
@@ -206,8 +219,25 @@
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 					handled += ata_host_intr(ap, qc);
+				} else if (is_vsc_sata_int_err(i, int_status)) {
+					/*
+					 * On some chips, there will be an endless
+					 * interrupt loop if the SCR_ERROR interrupts
+					 * are not cleared.
+					 */
+					u32 err_status;
+					err_status = vsc_sata_scr_read(ap, SCR_ERROR);
+					printk(KERN_DEBUG "%s: clearing interrupt,"
+					       "status %x; sata err status %x\n",
+					       __FUNCTION__,
+					       int_status, err_status);
+					vsc_sata_scr_write(ap, SCR_ERROR, err_status);
+					/* Clear interrupt status */
+					ata_chk_status(ap);
+					handled++;
+				}
 			}
 		}
 	}
