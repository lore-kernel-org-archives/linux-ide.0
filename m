From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/2] FSL SATA: fix the controller operating mode
Date: Mon, 19 Dec 2011 16:15:17 +0400
Message-ID: <4EEF2AD5.4050807@mvista.com>
References: <1324262157-13385-1-git-send-email-r66093@freescale.com> <1324262157-13385-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:65133 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab1LSMQS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2011 07:16:18 -0500
Received: by wibhm6 with SMTP id hm6so915689wib.19
        for <linux-ide@vger.kernel.org>; Mon, 19 Dec 2011 04:16:17 -0800 (PST)
In-Reply-To: <1324262157-13385-2-git-send-email-r66093@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: r66093@freescale.com
Cc: linux-ide@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Yutaka Ando <r46913@freescale.com>, Jeff Garzik <jgarzik@pobox.com>

Hello.

On 19-12-2011 6:35, r66093@freescale.com wrote:

> From: Jerry Huang<Chang-Ming.Huang@freescale.com>

> Configure the FSL SATA controller to the enterprise mode

> Signed-off-by: Yutaka Ando<r46913@freescale.com>
> Signed-off-by: Jerry Huang<Chang-Ming.Huang@freescale.com>
> CC: Jeff Garzik<jgarzik@pobox.com>
> ---
>   drivers/ata/sata_fsl.c |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)

> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 78ae7b6..48c9978 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
[...]
> @@ -1223,6 +1224,10 @@ static int sata_fsl_init_controller(struct ata_host *host)
>   	 * part of the port_start() callback
>   	 */
>
> +	/* sata controller to operate in enterprise mode */
> +	temp = ioread32(hcr_base + HCONTROL);
> +	iowrite32((temp & ~HCONTROL_LEGACY), hcr_base + HCONTROL);

    Parens around & not needed.

> @@ -1421,6 +1426,12 @@ static int sata_fsl_resume(struct platform_device *op)
>   	/* Recovery the CHBA register in host controller cmd register set */
>   	iowrite32(pp->cmdslot_paddr&  0xffffffff, hcr_base + CHBA);
>
> +	iowrite32((ioread32(hcr_base + HCONTROL)
> +				| HCONTROL_ONLINE_PHY_RST
> +				| HCONTROL_SNOOP_ENABLE
> +				| HCONTROL_PMP_ATTACHED),
> +			hcr_base+HCONTROL);

    Spaces around +, please.

MBR, Sergei
