From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] ahci: add HFLAG_YES_FBS and apply it to 88SE9128
Date: Tue, 17 Aug 2010 17:54:30 -0400
Message-ID: <4C6B0516.6080506@garzik.org>
References: <4C4AFE7C.5070506@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43359 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab0HQVye (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2010 17:54:34 -0400
Received: by vws3 with SMTP id 3so5044186vws.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Aug 2010 14:54:33 -0700 (PDT)
In-Reply-To: <4C4AFE7C.5070506@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 07/24/2010 10:53 AM, Tejun Heo wrote:
> 88SE9128 can do FBS and sets it in HOST_CAP but forgets to set FBSCP
> in PORT_CMD.  Implement AHCI_HFLAG_YES_FBS and apply it to 88SE9128.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> --
>   drivers/ata/ahci.c    |   11 +++++++++++
>   drivers/ata/ahci.h    |    1 +
>   drivers/ata/libahci.c |   16 ++++++++++++++--
>   3 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index f252253..41fa0a3 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -60,6 +60,7 @@ enum board_ids {
>   	board_ahci,
>   	board_ahci_ign_iferr,
>   	board_ahci_nosntf,
> +	board_ahci_yes_fbs,
>
>   	/* board IDs for specific chipsets in alphabetical order */
>   	board_ahci_mcp65,
> @@ -132,6 +133,14 @@ static const struct ata_port_info ahci_port_info[] = {
>   		.udma_mask	= ATA_UDMA6,
>   		.port_ops	=&ahci_ops,
>   	},
> +	[board_ahci_yes_fbs] =
> +	{
> +		AHCI_HFLAGS	(AHCI_HFLAG_YES_FBS),
> +		.flags		= AHCI_FLAG_COMMON,
> +		.pio_mask	= ATA_PIO4,
> +		.udma_mask	= ATA_UDMA6,
> +		.port_ops	=&ahci_ops,
> +	},
>   	/* by chipsets */
>   	[board_ahci_mcp65] =
>   	{
> @@ -362,6 +371,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>   	/* Marvell */
>   	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
>   	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
> +	{ PCI_DEVICE(0x1b4b, 0x9123),
> +	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */
>
>   	/* Promise */
>   	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 7113c57..474427b 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -209,6 +209,7 @@ enum {
>   							link offline */
>   	AHCI_HFLAG_NO_SNTF		= (1<<  12), /* no sntf */
>   	AHCI_HFLAG_NO_FPDMA_AA		= (1<<  13), /* no FPDMA AA */
> +	AHCI_HFLAG_YES_FBS		= (1<<  14), /* force FBS cap on */
>
>   	/* ap->flags bits */

applied


