From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_artop: use defines from pci.h
Date: Sat, 28 Apr 2012 19:46:13 -0400
Message-ID: <4F9C8145.50007@pobox.com>
References: <1335650229-5930-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41844 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab2D1XqQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2012 19:46:16 -0400
Received: by vbbff1 with SMTP id ff1so1372289vbb.19
        for <linux-ide@vger.kernel.org>; Sat, 28 Apr 2012 16:46:15 -0700 (PDT)
In-Reply-To: <1335650229-5930-1-git-send-email-vapier@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-ide@vger.kernel.org

On 04/28/2012 05:57 PM, Mike Frysinger wrote:
> Signed-off-by: Mike Frysinger<vapier@gentoo.org>
> ---
>   drivers/ata/pata_artop.c |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index 4b8b22e..553a3b3 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -414,11 +414,11 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
>   }
>
>   static const struct pci_device_id artop_pci_tbl[] = {
> -	{ PCI_VDEVICE(ARTOP, 0x0005), 0 },
> -	{ PCI_VDEVICE(ARTOP, 0x0006), 1 },
> -	{ PCI_VDEVICE(ARTOP, 0x0007), 1 },
> -	{ PCI_VDEVICE(ARTOP, 0x0008), 2 },
> -	{ PCI_VDEVICE(ARTOP, 0x0009), 2 },
> +	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF), 0 },
> +	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP860),   1 },
> +	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP860R),  1 },
> +	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP865),   2 },
> +	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP865R),  2 },

This is going in the reverse direction of where we want to go.  The 
device IDs are largely arbitrary even at the vendor level, and these PCI 
symbols are often only used in a single location (the driver itself).

Better to delete these PCI_DEVICE_ID_ARTOP_xxx symbols instead.

	Jeff




