From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes v2] ahci: add device IDs for Ibex Peak
 ahci controllers
Date: Tue, 28 Jul 2009 21:10:11 -0400
Message-ID: <4A6FA173.4030905@garzik.org>
References: <20090722201556.GB10049@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59180 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460AbZG2BKM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 21:10:12 -0400
In-Reply-To: <20090722201556.GB10049@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

David Milburn wrote:
> Add device IDS for Ibex Peak SATA AHCI Controllers
> 
> Signed-off-by: Jaroslav Kysela <jkysela@redhat.com>
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>  drivers/ata/ahci.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 336eb1e..958c1fa 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -515,10 +515,14 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
>  	{ PCI_VDEVICE(INTEL, 0x3a22), board_ahci }, /* ICH10 */
>  	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
> +	{ PCI_VDEVICE(INTEL, 0x3b22), board_ahci }, /* PCH AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci }, /* PCH AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
>  
>  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,

applied


