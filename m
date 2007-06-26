From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/5] piix: backport short cables support from ata_piix.c
Date: Tue, 26 Jun 2007 22:30:28 +0400
Message-ID: <46815B44.1040609@ru.mvista.com>
References: <200706101558.14511.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:41287 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757286AbXFZS2n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 14:28:43 -0400
In-Reply-To: <200706101558.14511.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Backport short cables support from ata_piix.c.

> This patch should allow UDMA > 2 modes on:
> - Acer 5602WLMi
> - Acer 3682WLMi
> - Asus W5F
> - Acer Aspire 2023WLMi

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Minor nit here:

> Index: b/drivers/ide/pci/piix.c
> ===================================================================
> --- a/drivers/ide/pci/piix.c
> +++ b/drivers/ide/pci/piix.c
> @@ -394,12 +394,43 @@ static void piix_dma_clear_irq(ide_drive
[...]
>  static u8 __devinit piix_cable_detect(ide_hwif_t *hwif)
>  {
> -	struct pci_dev *dev = hwif->pci_dev;
> +	struct pci_dev *pdev = hwif->pci_dev;

    Unnecessary rename.

> +	const struct ich_laptop *lap = &ich_laptop[0];

    ... and & and [0] are superfluous with arrays -- they behave like pointers 
in expression.

MBR, Sergei
