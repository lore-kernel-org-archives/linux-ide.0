From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Sat, 26 Apr 2008 20:46:14 +0400
Message-ID: <48135C56.507@ru.mvista.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3592 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759564AbYDZQqz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Apr 2008 12:46:55 -0400
In-Reply-To: <20080426140007.63cfeede@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello.

Alek Du wrote:

> Seems I need to post the patch here instead of LKML

    Your patch is whitespace damaged -- all tabs converted to spaces.

> [PATCH] ata: Add Intel SCH PATA support

> This patch adds Intel SCH chipsets (US15W, US15L, UL11L) PATA controller
> support.

> Signed-off-by: Alek Du <alek.du@intel.com>

> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index b7c38ee..7f95a9a 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -214,6 +214,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
>         /* ICH7/7-R (i945, i975) UDMA 100*/
>         { 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
>         { 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> +       /* INTEL SCH UDMA 100 */
> +       { 0x8086, 0x811A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
>         /* ICH8 Mobile PATA Controller */
>         { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> 
> @@ -561,6 +563,10 @@ struct ich_laptop {
>         u16 subdevice;
>  };
> 
> +struct sch_80 {
> +       u16 device;
> +};
> +

    Why create a structure which has only single field?

MBR, Sergei
