From: Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Wed, 24 Oct 2012 10:28:42 +0100
Message-ID: <5087B4CA.1030502@talktalk.net>
References: <bug-49151-11633@https.bugzilla.kernel.org/> <20121020120047.GC17563@liondog.tnic> <50841CFC.2030802@talktalk.net> <20121021165756.GA20642@liondog.tnic> <50856AA8.1000607@talktalk.net> <20121022202734.GA16169@liondog.tnic> <20121023110549.06f9c2e8@pyramind.ukuu.org.uk> <20121023101751.GA24656@liondog.tnic>
Reply-To: phillip.wood@dunelm.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:25019 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756152Ab2JXJ2r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2012 05:28:47 -0400
In-Reply-To: <20121023101751.GA24656@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, phillip.wood@dunelm.org.uk, "Anton V. Boyarshinov" <boyarsh@altlinux.org>, bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On 10/23/2012 11:17 AM, Borislav Petkov wrote:
> ---
> diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
> index 09723b76beac..80d594d6e7c8 100644
> --- a/drivers/ata/pata_acpi.c
> +++ b/drivers/ata/pata_acpi.c
> @@ -144,6 +144,13 @@ static void pacpi_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>
>   	/* Now stuff the nS values into the structure */
>   	t = ata_timing_find_mode(adev->dma_mode);
> +	if (!t) {
> +		pr_err("%s: ata_timing_find_mode gives NULL; adev->dma_mode: 0x%x\n",
> +		       __func__, adev->dma_mode);
> +
> +		return;
> +	}
> +
>   	if (adev->dma_mode >= XFER_UDMA_0) {
>   		acpi->gtm.drive[unit].dma = t->udma;
>   		acpi->gtm.flags |= (1 << (2 * unit));
> --

pacpi_set_dmamode: ata_timing_find_mode gives NULL; adev->dma_mode: 0x0

as well here if I build pata_acpi as a module, if I build it into the 
kernel I don't get any message.
