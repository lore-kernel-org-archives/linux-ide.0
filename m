From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH #upstream-fixes] ahci add device ID for Ibex Peak ahci controller
Date: Wed, 22 Jul 2009 15:30:32 -0500
Message-ID: <20090722203031.GA5998@dhcp-210.hsv.redhat.com>
References: <20090721175759.GA5929@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:49567 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbZGVUcL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jul 2009 16:32:11 -0400
Content-Disposition: inline
In-Reply-To: <20090721175759.GA5929@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

On Tue, Jul 21, 2009 at 12:57:59PM -0500, David Milburn wrote:
> From: Jaroslav Kysela <jkysela@redhat.com>
> 
> Add device ID for Ibex Peak 6 port SATA AHCI Controller
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>  drivers/ata/ahci.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 336eb1e..c342551 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -515,6 +515,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
>  	{ PCI_VDEVICE(INTEL, 0x3a22), board_ahci }, /* ICH10 */
>  	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
> +	{ PCI_VDEVICE(INTEL, 0x3b22), board_ahci }, /* PCH AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */

Jeff,

Please drop this patch for version 2

http://marc.info/?l=linux-ide&m=124829386632494&w=2

Thanks,
David

> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
