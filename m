From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 16:49:12 -0500
Message-ID: <4B05BD58.8040008@pobox.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <4B0590A2.9050306@ru.mvista.com> <200911192003.09675.bzolnier@gmail.com> <200911192031.31613.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757367AbZKSVtR@vger.kernel.org>
In-Reply-To: <200911192031.31613.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 11/19/2009 02:31 PM, Bartlomiej Zolnierkiewicz wrote:
> Subject: [PATCH] pata_hpt{37x,3x2n}: add debounce delay to cable detection methods
>
> Alan Cox reported that cable detection sometimes works unreliably
> for HPT3xxN and that the issue is fixed by adding debounce delay
> as used by the vendor driver.
>
> Sergei Shtylyov also noticed that debounce delay is needed for all
> HPT37x and HPT3xxN chipsets according to vendor drivers.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
> In comparison to original patch the conversion from PCI access to
> io has been dropped as it is not required for the bugfix and makes
> patch easier for back-porting into -stable kernels.
>
>   drivers/ata/pata_hpt37x.c  |    3 +++
>   drivers/ata/pata_hpt3x2n.c |    3 +++
>   2 files changed, 6 insertions(+)
>
> Index: b/drivers/ata/pata_hpt37x.c
> ===================================================================
> --- a/drivers/ata/pata_hpt37x.c
> +++ b/drivers/ata/pata_hpt37x.c
> @@ -324,6 +324,9 @@ static int hpt37x_pre_reset(struct ata_l
>
>   	pci_read_config_byte(pdev, 0x5B,&scr2);
>   	pci_write_config_byte(pdev, 0x5B, scr2&  ~0x01);
> +
> +	udelay(10); /* debounce */
> +
>   	/* Cable register now active */
>   	pci_read_config_byte(pdev, 0x5A,&ata66);
>   	/* Restore state */
> Index: b/drivers/ata/pata_hpt3x2n.c
> ===================================================================
> --- a/drivers/ata/pata_hpt3x2n.c
> +++ b/drivers/ata/pata_hpt3x2n.c
> @@ -128,6 +128,9 @@ static int hpt3x2n_cable_detect(struct a
>
>   	pci_read_config_byte(pdev, 0x5B,&scr2);
>   	pci_write_config_byte(pdev, 0x5B, scr2&  ~0x01);
> +
> +	udelay(10); /* debounce */
> +
>   	/* Cable register now active */
>   	pci_read_config_byte(pdev, 0x5A,&ata66);
>   	/* Restore state */


applied -- same comment as last email, regarding hpt3x2n_cable_detect() fix
