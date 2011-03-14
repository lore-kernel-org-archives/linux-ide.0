From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Subject: RE: [PATCH][v3] driver/FSL SATA:Fix wrong Device Error Register
 usage
Date: Mon, 14 Mar 2011 04:12:17 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F874131E79@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1299655038-727-1-git-send-email-prabhakar@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:50991
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750796Ab1CNKSt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Mar 2011 06:18:49 -0400
In-Reply-To: <1299655038-727-1-git-send-email-prabhakar@freescale.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "meet2prabhu@gmail.com" <meet2prabhu@gmail.com>, Kalra Ashish-B00888 <B00888@freescale.com>

Hi Jeff,

I am not finding any new comments on this.

Could you please ACK this patch so that it can be applied on external list. 

--Prabhakar


> -----Original Message-----
> From: Kushwaha Prabhakar-B32579
> Sent: Wednesday, March 09, 2011 12:47 PM
> To: linux-ide@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org; jgarzik@pobox.com;
> meet2prabhu@gmail.com; Kushwaha Prabhakar-B32579; Kalra Ashish-B00888
> Subject: [PATCH][v3] driver/FSL SATA:Fix wrong Device Error Register
> usage
> 
> When a single device error is detected, the device under the error is
> indicated by the error bit set in the DER. There is a one to one mapping
> between register bit and devices on Port multiplier(PMP) i.e. bit 0
> represents PMP device 0 and bit 1 represents PMP device 1 etc.
> 
> Current implementation treats Device error register value as device
> number not set of bits representing multiple device on PMP. It is changed
> to consider bit level.
> No need to check for each set bit as all command is going to be aborted.
> 
> Signed-off-by: Ashish Kalra <B00888@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> (branch master)
> 
>  This patch is already gone through review of linuxppc-dev mail list.
>  Making CC linuxppc-dev@lists.ozlabs.org
> 
>  Changes for v2: Incorporated Sergei Shtylyov's comment
> 	- Put space after -
> 	- added a line
>  Changes for v3: Incorporated David Laight's comment
>  	- Condition check for dereg 0 for hardware error
> 
>  drivers/ata/sata_fsl.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c index
> b0214d0..ad84ddc 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1040,12 +1040,15 @@ static void sata_fsl_error_intr(struct ata_port
> *ap)
> 
>  		/* find out the offending link and qc */
>  		if (ap->nr_pmp_links) {
> +			unsigned int dev_num;
> +
>  			dereg = ioread32(hcr_base + DE);
>  			iowrite32(dereg, hcr_base + DE);
>  			iowrite32(cereg, hcr_base + CE);
> 
> -			if (dereg < ap->nr_pmp_links) {
> -				link = &ap->pmp_link[dereg];
> +			dev_num = ffs(dereg) - 1;
> +			if (dev_num < ap->nr_pmp_links && dereg != 0) {
> +				link = &ap->pmp_link[dev_num];
>  				ehi = &link->eh_info;
>  				qc = ata_qc_from_tag(ap, link->active_tag);
>  				/*
> --
> 1.7.3


