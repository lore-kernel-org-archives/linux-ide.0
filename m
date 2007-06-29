From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash PATA on libata failure to attach
Date: Fri, 29 Jun 2007 10:35:50 +1000
Message-ID: <468453f8.13578c0a.3c99.ffffa514@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca> <4680d387.24528c0a.3634.69bd@mx.google.com> <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca> <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com> <4683F1C9.2060505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:60991 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762489AbXF2AgK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 20:36:10 -0400
Received: by nz-out-0506.google.com with SMTP id s18so285915nze
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 17:36:09 -0700 (PDT)
In-Reply-To: <4683F1C9.2060505@rtr.ca>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

> 
> I'm betting that the SATA/PATA converter is getting confused with
> the ata_piix driver's attempt to use MDMA2 on it.
> 
> PIO appears to be working fine -- the BIOS uses it to boot,
> and libata uses it to do the IDENTIFY operation.
> 
> So, try this hack, which should force ata_piix to use only PIO
> for the ICH8 chipset. So long as you don't have any real SATA
> drives, this might do the trick.
> 
> Cheers
> 
> --- linux/drivers/ata/ata_piix.c.orig 2007-06-27 11:20:51.000000000 -
> 0400
> +++ linux/drivers/ata/ata_piix.c 2007-06-28 13:32:27.000000000 -0400
> @@ -526,8 +526,8 @@
> .flags = PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
> PIIX_FLAG_AHCI,
> .pio_mask = 0x1f, /* pio0-4 */
> - .mwdma_mask = 0x07, /* mwdma0-2 */
> - .udma_mask = 0x7f, /* udma0-6 */
> + .mwdma_mask = 0x00, /* mwdma0-2 */
> + .udma_mask = 0x00, /* udma0-6 */
> .port_ops = &piix_sata_ops,
> },
> 
> @@ -537,8 +537,8 @@
> .flags = PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
> PIIX_FLAG_AHCI,
> .pio_mask = 0x1f, /* pio0-4 */
> - .mwdma_mask = 0x07, /* mwdma0-2 */
> - .udma_mask = 0x7f, /* udma0-6 */
> + .mwdma_mask = 0x00, /* mwdma0-2 */
> + .udma_mask = 0x00, /* udma0-6 */
> .port_ops = &piix_sata_ops,
> },

Yes!! It worked.. which means you were right - forcing the channel to PIO4
and the drive was happy. The problem I have now is that we do in fact also
have a SATA HDD connected to the same controller used for database and
logging data - this now also is forced to use PIO4. How can I force the
first channel to only use PIO and the remainder to use MWDMA2? 

Thanks for your help..



