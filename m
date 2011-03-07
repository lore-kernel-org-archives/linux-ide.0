From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Mon, 07 Mar 2011 14:49:08 +0300
Message-ID: <4D74C634.4060305@ru.mvista.com>
References: <1299470224-3399-1-git-send-email-prabhakar@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50585 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab1CGLu4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Mar 2011 06:50:56 -0500
Received: by fxm17 with SMTP id 17so3988631fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 07 Mar 2011 03:50:55 -0800 (PST)
In-Reply-To: <1299470224-3399-1-git-send-email-prabhakar@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, meet2prabhu@gmail.com, Ashish Kalra <B00888@freescale.com>

Hello.

On 07.03.2011 6:57, Prabhakar Kushwaha wrote:

> When a single device error is detected, the device under the error is indicated
> by the error bit set in the DER. There is a one to one mapping between register
> bit and devices on Port multiplier(PMP) i.e. bit 0 represents PMP device 0 and
> bit 1 represents PMP device 1 etc.

> Current implementation treats Device error register value as device number not
> set of bits representing multiple device on PMP. It is changed to consider bit
> level.
> No need to check for each set bit as all command is going to be aborted.

> Signed-off-by: Prabhakar Kushwaha<prabhakar@freescale.com>
> Signed-off-by: Ashish Kalra<B00888@freescale.com>
> ---
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)

>   This patch is already gone through review of linuxppc-dev mail list.

>   drivers/ata/sata_fsl.c |    6 ++++--
>   1 files changed, 4 insertions(+), 2 deletions(-)

> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index b0214d0..895771c 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1040,12 +1040,14 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>
>   		/* find out the offending link and qc */
>   		if (ap->nr_pmp_links) {
> +			unsigned int dev_num;

    Empty line wouldn't hurt here.

>   			dereg = ioread32(hcr_base + DE);
>   			iowrite32(dereg, hcr_base + DE);
>   			iowrite32(cereg, hcr_base + CE);
>
> -			if (dereg<  ap->nr_pmp_links) {
> -				link =&ap->pmp_link[dereg];
> +			dev_num = ffs(dereg)-1;

    What if no bit is set and ffs() return 0?
    Put spaces around - to keep the style consistent.

> +			if (dev_num < ap->nr_pmp_links) {
> +				link =&ap->pmp_link[dev_num];
>   				ehi =&link->eh_info;
>   				qc = ata_qc_from_tag(ap, link->active_tag);
>   				/*

WBR, Sergei
