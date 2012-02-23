From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/2 v3] libata-pmp: add schedule timeout to support some
 PMP cards
Date: Thu, 23 Feb 2012 06:35:40 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C02C60A@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1324262157-13385-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:33892
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750705Ab2BWGfr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Feb 2012 01:35:47 -0500
In-Reply-To: <1324262157-13385-1-git-send-email-r66093@freescale.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: Huang Changming-R66093 <r66093@freescale.com>

Hi, Jeff
Could you have any comment about this patch?
There is no any feedback since 12/20/2011.

Thanks
Jerry Huang


> -----Original Message-----
> From: Huang Changming-R66093
> Sent: Monday, December 19, 2011 10:36 AM
> To: linux-ide@vger.kernel.org
> Cc: Huang Changming-R66093; Jeff Garzik
> Subject: [PATCH 1/2 v3] libata-pmp: add schedule timeout to support some
> PMP cards
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> With Freescale SATA controller, some PMP cards(e.g JMB393 PMP card)
> can't work on some platforms (e.g mpc837x, p1022):
> During PMP initialize, when reading the PMP SCR, we will observe the
> TIMEOUT
> error because PMP card SCR is not ready.
> Therefore, we need enough time to wait for the PMP card ready for SCR
> read.
> 
> below is the error log:
> fsl-sata e0018000.sata: Sata FSL Platform/CSB Driver init
> scsi0 : sata_fsl
> ata1: SATA max UDMA/133 irq 44
> ata1: Signature Update detected @ 504 msecs
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 15 ports, feat 0x5/0xf
> ata2.00: hard resetting link
> ata2.15: qc timeout (cmd 0xe4)
> ata2.00: failed to read SCR 0 (Emask=0x4)
> ata2.00: failed to read SCR 0 (Emask=0x40)
> ata2.00: failed to read SCR 0 (Emask=0x40)
> ata2: ATA_SRST issue failed
> ata2.00: failed to read SCR 0 (Emask=0x40)
> ata2.00: reset failed, giving up
> ata2.15: hard resetting link
> ata2: Hardreset failed, not off-lined 0
> ata2: No Signature Update
> ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: hard resetting link
> ata2.15: qc timeout (cmd 0xe4)
> ata2.00: failed to read SCR 0 (Emask=0x4)
> ata2.00: failed to read SCR 0 (Emask=0x40)
> ata2.00: failed to read SCR 0 (Emask=0x40)
> ata2: ATA_SRST issue failed
> ata2.00: failed to read SCR 0 (Emask=0x40)
> ata2.00: reset failed, giving up
> ata2.15: hard resetting link
> ata2: Hardreset failed, not off-lined 0
> ata2: No Signature Update
> ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: hard resetting link
> ata2.15: qc timeout (cmd 0xe4)
> ata2.00: failed to read SCR 0 (Emask=0x4)
> ata2.00: failed to read SCR 0 (Emask=0x40)
> ata2.00: failed to read SCR 0 (Emask=0x40)
> ata2: ATA_SRST issue failed
> ata2.00: failed to read SCR 0 (Emask=0x40)
> ata2.00: reset failed, giving up
> ata2.00: failed to recover link after 3 tries, disabling
> ata2.15: hard resetting link
> ata2: Hardreset failed, not off-lined 0
> ata2: No Signature Update
> ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.15: qc timeout (cmd 0xe4)
> ata2.00: failed to read SCR 0 (Emask=0x4)
> ata2.00: failed to write SCR 1 (Emask=0x40)
> ata2.00: failed to clear SError.N (errno=-5)
> ata2.15: hard resetting link
> ata2: Hardreset failed, not off-lined 0
> ata2: No Signature Update
> ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.01: hard resetting link
> ata2.01: failed to resume link (SControl 0)
> ata2.01: SATA link down (SStatus 0 SControl 0)
> ata2.02: hard resetting link
> ata2.02: failed to resume link (SControl 0)
> ata2.02: SATA link down (SStatus 0 SControl 0)
> ......
> ata2.14: hard resetting link
> ata2.14: failed to resume link (SControl 0)
> ata2.14: SATA link down (SStatus 0 SControl 0)
> ata2: EH complete
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Jeff Garzik <jgarzik@pobox.com>
> ---
> changes for v2:
> 	- use function msecs_to_jiffies to calculate the jiffies for 1ms
> 	- cleanup the code
> changes for v3:
> 	- add the quirks to support pmp card
> 	- add the CC
> 
>  drivers/ata/libata-pmp.c |   12 ++++++++++++
>  include/linux/libata.h   |    1 +
>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index 21b80c5..d7d4bb5 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -146,6 +146,13 @@ int sata_pmp_scr_read(struct ata_link *link, int reg,
> u32 *r_val)
>  	if (reg > SATA_PMP_PSCR_CONTROL)
>  		return -EINVAL;
> 
> +	/* For some PMP card, we need delay some time */
> +	if (link->flags & ATA_LFLAG_DELAY) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		/* sleep 50 msecond */
> +		schedule_timeout(msecs_to_jiffies(50));
> +	}
> +
>  	err_mask = sata_pmp_read(link, reg, r_val);
>  	if (err_mask) {
>  		ata_link_warn(link, "failed to read SCR %d (Emask=0x%x)\n",
> @@ -456,6 +463,11 @@ static void sata_pmp_quirks(struct ata_port *ap)
>  				       ATA_LFLAG_NO_SRST |
>  				       ATA_LFLAG_ASSUME_ATA;
>  		}
> +	} else if (vendor == 0x197b && devid == 0x0325) {
> +		/* For jmicron JMB393 card, need some time to ready the PMP
> */
> +		ata_for_each_link(link, ap, EDGE) {
> +			link->flags |= ATA_LFLAG_DELAY;
> +		}
>  	}
>  }
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index cafc09a..c23ddf9 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -182,6 +182,7 @@ enum {
>  	ATA_LFLAG_DISABLED	= (1 << 6), /* link is disabled */
>  	ATA_LFLAG_SW_ACTIVITY	= (1 << 7), /* keep activity stats */
>  	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
> +	ATA_LFLAG_DELAY		= (1 << 9), /* delay some time */
> 
>  	/* struct ata_port flags */
>  	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
> --
> 1.7.5.4


