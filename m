From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH RESEND v3.7.0] Add AHCI support for Enmotus Bobcat device.
Date: Thu, 03 Jan 2013 22:51:47 +0300
Message-ID: <50E5E153.9040801@mvista.com>
References: <1357238107-4630-1-git-send-email-hugh.daschbach@enmotus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:60849 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab3ACSxP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2013 13:53:15 -0500
Received: by mail-la0-f41.google.com with SMTP id em20so8493715lab.28
        for <linux-ide@vger.kernel.org>; Thu, 03 Jan 2013 10:53:13 -0800 (PST)
In-Reply-To: <1357238107-4630-1-git-send-email-hugh.daschbach@enmotus.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hugh Daschbach <hugh.daschbach@enmotus.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 01/03/2013 09:35 PM, Hugh Daschbach wrote:

> Silicon does not support standard AHCI BAR assignment.  Add
> vendor/device exception to force BAR 2.

> Signed-off-by: Hugh Daschbach <hugh.daschbach@enmotus.com>
> ---
> Previously sent 14 Dec 2012.  Any feedback?
> Thanks,
> Hugh

>  drivers/ata/ahci.c | 6 ++++++
>  1 file changed, 6 insertions(+)

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 7862d17..3cb008f 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
[...]
> @@ -1101,6 +1105,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	/* The Connext uses non-standard BAR */

   This comment probably needs updating now to include your device.

>  	if (pdev->vendor == PCI_VENDOR_ID_STMICRO && pdev->device == 0xCC06)
>  		ahci_pci_bar = AHCI_PCI_BAR_STA2X11;
> +	else if (pdev->vendor == 0x1c44 && pdev->device == 0x8000)
> +		ahci_pci_bar = AHCI_PCI_BAR_ENMOTUS;
>  
>  	/* acquire resources */
>  	rc = pcim_enable_device(pdev);
> 

MBR, Sergei

