From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Wed, 06 Aug 2008 15:34:48 +0400
Message-ID: <48998C58.20703@ru.mvista.com>
References: <20080802183253.GA2239@gollum.tnic> <200808022046.16990.bzolnier@gmail.com> <20080803073756.GA8762@gollum.tnic> <20080803125907.67676948@lxorguk.ukuu.org.uk> <20080803143837.GA26672@gollum.tnic> <20080803162214.394b13a1@lxorguk.ukuu.org.uk> <20080803165135.GA31977@gollum.tnic> <4898630C.7090403@ru.mvista.com> <9ea470500808050732s7be29360ge358790e955be06a@mail.gmail.com> <58cb370e0808050741v7ff3f20awb3d91a84486f8547@mail.gmail.com> <20080806061023.GA23773@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40212 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755244AbYHFLez (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Aug 2008 07:34:55 -0400
In-Reply-To: <20080806061023.GA23773@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.orglinux

Hello.

Borislav Petkov wrote:
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Sun, 3 Aug 2008 18:46:35 +0200
> Subject: [PATCH] ide-generic: handle probing of legacy io-ports v4
>
> Avoid probing the io-ports in case an IDE PCI controller is present and it uses
> the legacy iobases. If we still want to enforce the probing, we do
>
> ide_generic.probe_mask=0x3f
>
> on the kernel command line. The iobase checking code is adapted from
> drivers/ata/pata_legacy.c after converting hex pci ids into their corresponding
> macros in <linux/pci_ids.h>.
>
> CC: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
> index 8fe8b5b..efce159 100644
> --- a/drivers/ide/ide-generic.c
> +++ b/drivers/ide/ide-generic.c
>   
[...]
> @@ -100,19 +101,69 @@ static const u16 legacy_bases[] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
>  static const int legacy_irqs[]  = { 14, 15, 11, 10, 8, 12 };
>  #endif
>  
> +static void ide_generic_check_pci_legacy_iobases(int *primary, int *secondary)
> +{
> +	struct pci_dev *p = NULL;
> +	u16 val;
> +
> +	for_each_pci_dev(p) {
> +		int r;
> +
> +		for (r = 0; r < 6; r++) {
> +			if (pci_resource_start(p, r) == 0x1f0)
> +				*primary = 1;
> +			if (pci_resource_start(p, r) == 0x170)
> +				*secondary = 1;
> +		}
>   

   Would have been probably enough to test only BAR0/2, don't you think?

MBR, Sergei


