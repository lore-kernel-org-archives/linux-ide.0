From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_sis: SCR accessors should return
 -EINVAL when the requested SCR isn't available
Date: Fri, 25 Apr 2008 00:47:21 -0400
Message-ID: <48116259.7010101@garzik.org>
References: <480FE7EC.4030002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46519 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757013AbYDYEr1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 00:47:27 -0400
In-Reply-To: <480FE7EC.4030002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: kaber@trash.net, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> sis_scr_cfg_read() can't access SError and was incorrectly returning
> -1 instead of -EINVAL.  This went unnoticed because SError used to be
> cleared in @postreset() and it didn't care about how scr_read() failed
> but commit ac371987 moved SError clearing into sata_link_resume() and
> SCR access failure other than -EINVAL is considered an error condition
> and exposes the incorrect return value bug as detection failure.  Fix
> it.
> 
> Also, scsi_scr_cfg_write() was incorrectly returning 0 after it
> ignored the request to write to SError.  Make it also return -EINVAL.
> 
> This was bisected and reported by Patrick McHardy.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Patrick McHardy <kaber@trash.net>
> ---
> drivers/ata/sata_sis.c |   12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
> index 6b8e45b..1010b30 100644
> --- a/drivers/ata/sata_sis.c
> +++ b/drivers/ata/sata_sis.c
> @@ -142,7 +142,7 @@ static u32 sis_scr_cfg_read(struct ata_port *ap, 
> unsigned int sc_reg, u32 *val)
>     u8 pmr;
> 
>     if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
> -        return 0xffffffff;
> +        return -EINVAL;
> 
>     pci_read_config_byte(pdev, SIS_PMR, &pmr);
> 
> @@ -158,14 +158,14 @@ static u32 sis_scr_cfg_read(struct ata_port *ap, 
> unsigned int sc_reg, u32 *val)
>     return 0;
> }
> 
> -static void sis_scr_cfg_write(struct ata_port *ap, unsigned int sc_reg, 
> u32 val)
> +static int sis_scr_cfg_write(struct ata_port *ap, unsigned int sc_reg, 
> u32 val)
> {
>     struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>     unsigned int cfg_addr = get_scr_cfg_addr(ap, sc_reg);
>     u8 pmr;
> 
>     if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
> -        return;
> +        return -EINVAL;
> 
>     pci_read_config_byte(pdev, SIS_PMR, &pmr);
> 
> @@ -174,6 +174,8 @@ static void sis_scr_cfg_write(struct ata_port *ap, 
> unsigned int sc_reg, u32 val)
>     if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
>         (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
>         pci_write_config_dword(pdev, cfg_addr+0x10, val);
> +
> +    return 0;
> }
> 
> static int sis_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
> @@ -211,14 +213,14 @@ static int sis_scr_write(struct ata_port *ap, 
> unsigned int sc_reg, u32 val)
>     pci_read_config_byte(pdev, SIS_PMR, &pmr);
> 
>     if (ap->flags & SIS_FLAG_CFGSCR)
> -        sis_scr_cfg_write(ap, sc_reg, val);
> +        return sis_scr_cfg_write(ap, sc_reg, val);
>     else {
>         iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4));
>         if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
>             (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
>             iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
> +        return 0;
>     }
> -    return 0;
> }
> 

applied


