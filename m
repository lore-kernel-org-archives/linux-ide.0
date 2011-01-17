From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
Date: Mon, 17 Jan 2011 14:47:58 +0300
Message-ID: <4D342C6E.6000608@ru.mvista.com>
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49769 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab1AQLtI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jan 2011 06:49:08 -0500
Received: by eye27 with SMTP id 27so2441263eye.19
        for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2011 03:49:07 -0800 (PST)
In-Reply-To: <1295248259-14752-1-git-send-email-B33228@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xulei <B33228@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, Roy Zang <tie-fei.zang@freescale.com>

Hello.

On 17-01-2011 10:10, Xulei wrote:

> In FSL sata v2 block, the snoop bit of PRDT Word3 description
> information is at bit28 instead of bit22.

> This patch adds FSL sata v2 probe and resolve this difference.

> Signed-off-by: Xulei <B33228@freescale.com>

    AFAIK, full name is required.

> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
[...]

> diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
> index 2bbecbb..9ad41dd 100644
> --- a/arch/powerpc/boot/dts/p1022ds.dts
> +++ b/arch/powerpc/boot/dts/p1022ds.dts
> @@ -475,14 +475,14 @@
>   		};
>
>   		sata@18000 {
> -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
> +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
>   			reg =<0x18000 0x1000>;
>   			cell-index =<1>;
>   			interrupts =<74 0x2>;
>   		};
>
>   		sata@19000 {
> -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
> +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
>   			reg =<0x19000 0x1000>;
>   			cell-index =<2>;
>   			interrupts =<41 0x2>;

    Please put this into the separate patch and push thru the PPC tree.

> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index b0214d0..a56399a 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
[...]
> @@ -417,7 +420,8 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
>
>   	if (qc->flags&  ATA_QCFLAG_DMAMAP)
>   		num_prde = sata_fsl_fill_sg(qc, (void *)cd,
> -					&ttl_dwords, cd_paddr);
> +					&ttl_dwords, cd_paddr,
> +					    host_priv->data_snoop);

    Please align these lines uniformly.

WBR, Sergei
