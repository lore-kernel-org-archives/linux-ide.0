From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Subject: RE: [PATCH] driver/FSL SATA: Update RX_WATER_MARK for TRANSCFG
Date: Fri, 11 Mar 2011 03:12:55 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F87412FC9C@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1299472170-3580-1-git-send-email-prabhakar@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.186]:4394
	"EHLO CH1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751077Ab1CKDM7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Mar 2011 22:12:59 -0500
In-Reply-To: <1299472170-3580-1-git-send-email-prabhakar@freescale.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "jgarzik@pobox.com" <jgarzik@pobox.com>
Cc: "meet2prabhu@gmail.com" <meet2prabhu@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Jeff,

I am not finding any comments on this.

Could you please ACK this patch so that it can be applied in external list. 

--Prabhakar

> -----Original Message-----
> From: Kushwaha Prabhakar-B32579
> Sent: Monday, March 07, 2011 10:00 AM
> To: linux-ide@vger.kernel.org
> Cc: jgarzik@pobox.com; meet2prabhu@gmail.com; linuxppc-
> dev@lists.ozlabs.org; Kushwaha Prabhakar-B32579
> Subject: [PATCH] driver/FSL SATA: Update RX_WATER_MARK for TRANSCFG
> 
> RX_WATER_MARK sets the number of locations in Rx FIFO that can be used
> before the transport layer instructs the link layer to transmit HOLDS.
> Note that it can take some time for the HOLDs to get to the other end,
> and that in the interim there must be enough room in the FIFO to absorb
> all data that could arrive.
> 
> Update the new recommended value to 16.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
>  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> (branch master)
> 
>  This patch is already gone through review of linuxppc-dev mail list.
>  Making CC linuxppc-dev@lists.ozlabs.org
> 
>  drivers/ata/sata_fsl.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c index
> 895771c..29d2f29 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -186,6 +186,11 @@ enum {
>  	COMMANDSTAT = 0x20,
>  };
> 
> +/* TRANSCFG (transport-layer) configuration control */ enum {
> +	TRANSCFG_RX_WATER_MARK = (1 << 4),
> +};
> +
>  /* PHY (link-layer) configuration control */  enum {
>  	PHY_BIST_ENABLE = 0x01,
> @@ -1305,6 +1310,7 @@ static int sata_fsl_probe(struct platform_device
> *ofdev,
>  	struct sata_fsl_host_priv *host_priv = NULL;
>  	int irq;
>  	struct ata_host *host;
> +	u32 temp;
> 
>  	struct ata_port_info pi = sata_fsl_port_info[0];
>  	const struct ata_port_info *ppi[] = { &pi, NULL }; @@ -1319,6
> +1325,12 @@ static int sata_fsl_probe(struct platform_device *ofdev,
>  	ssr_base = hcr_base + 0x100;
>  	csr_base = hcr_base + 0x140;
> 
> +	if (!of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc8315-
> sata")) {
> +		temp = ioread32(csr_base + TRANSCFG);
> +		temp = temp & 0xffffffe0;
> +		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base +
> TRANSCFG);
> +	}
> +
>  	DPRINTK("@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
>  	DPRINTK("sizeof(cmd_desc) = %d\n", sizeof(struct command_desc));
>  	DPRINTK("sizeof(#define cmd_desc) = %d\n", SATA_FSL_CMD_DESC_SIZE);
> --
> 1.7.3


