From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] Intel device IDs SATA
Date: Fri, 6 Nov 2015 20:42:34 +0200
Message-ID: <CAHp75VfMHS7nRGUtS=rDeviH9CRR43+nhMjU5O6VbC9NL3ZeUw@mail.gmail.com>
References: <1446577791-3087-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35829 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbKFSmf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Nov 2015 13:42:35 -0500
In-Reply-To: <1446577791-3087-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Nov 3, 2015 at 9:09 PM, Alexandra Yates
<alexandra.yates@linux.intel.com> wrote:
> Adding Intel codename Lewisburg platform device IDs for SATA.
>
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> ---
>  drivers/ata/ahci.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index a466602..8c7a04a 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -68,6 +68,7 @@ enum board_ids {
>         board_ahci_yes_fbs,
>
>         /* board IDs for specific chipsets in alphabetical order */
> +       board_ahci_lbg,
>         board_ahci_avn,
>         board_ahci_mcp65,
>         board_ahci_mcp77,
> @@ -161,6 +162,13 @@ static const struct ata_port_info ahci_port_info[] = {
>                 .port_ops       = &ahci_ops,
>         },
>         /* by chipsets */
> +       [board_ahci_lbg] = {
> +               .flags          = AHCI_FLAG_COMMON,
> +               .pio_mask       = ATA_PIO4,
> +               .udma_mask      = ATA_UDMA6,
> +               .port_ops       = &ahci_ops,
> +       },
> +
>         [board_ahci_avn] = {
>                 .flags          = AHCI_FLAG_COMMON,
>                 .pio_mask       = ATA_PIO4,
> @@ -314,6 +322,16 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>         { PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
>         { PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
>         { PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
> +       { PCI_VDEVICE(INTEL, 0xa182), board_ahci_lbg }, /* Lewisburg AHCI*/
> +       { PCI_VDEVICE(INTEL, 0xa202), board_ahci_lbg }, /* Lewisburg AHCI*/
> +       { PCI_VDEVICE(INTEL, 0xa184), board_ahci_lbg }, /* Lewisburg RAID*/
> +       { PCI_VDEVICE(INTEL, 0xa204), board_ahci_lbg }, /* Lewisburg RAID*/
> +       { PCI_VDEVICE(INTEL, 0xa186), board_ahci_lbg }, /* Lewisburg RAID*/

I think it makes sense to keep IDs ordered at least in range of one group

> +       { PCI_VDEVICE(INTEL, 0xa206), board_ahci_lbg }, /* Lewisburg RAID*/
> +       { PCI_VDEVICE(INTEL, 0x2822), board_ahci_lbg }, /* Lewisburg RAID*/
> +       { PCI_VDEVICE(INTEL, 0x2826), board_ahci_lbg }, /* Lewisburg RAID*/
> +       { PCI_VDEVICE(INTEL, 0xa18e), board_ahci_lbg }, /* Lewisburg RAID*/
> +       { PCI_VDEVICE(INTEL, 0xa20e), board_ahci_lbg }, /* Lewisburg RAID*/
>         { PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
>         { PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
>         { PCI_VDEVICE(INTEL, 0x8d02), board_ahci }, /* Wellsburg AHCI */
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
