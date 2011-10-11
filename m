From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend SSD
Date: Tue, 11 Oct 2011 19:12:01 +0200
Message-ID: <201110111912.01574.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com> <20091117.043002.224755438.davem@davemloft.net> <Pine.LNX.4.64.0911181151140.5068@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44287 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212Ab1JKROh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Oct 2011 13:14:37 -0400
Received: by bkbzt4 with SMTP id zt4so10051505bkb.19
        for <linux-ide@vger.kernel.org>; Tue, 11 Oct 2011 10:14:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0911181151140.5068@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Mikulas Patocka wrote:

> On Tue, 17 Nov 2009, David Miller wrote:
> 
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > Date: Wed, 4 Nov 2009 20:25:21 -0500 (EST)
> > 
> > > Don't use UDMA on VIA UDMA33 controller with Transcend SSD
> > > 
> > > The computer locks up if Transcend SSD runs in any of UDMA modes.
> > > It doesn't lockup with different brand SSD, so this is specific to Transcend.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > Mikulas, I'm happy to apply this if you match on the full
> > ID string, not just "TS".
> > 
> > Please update your patch and I'll push it upstream.
> > 
> > Thank you.
> 
> Transcend makes various versions of their SSDs and all begin with TS. You 
> can assume that Transcend SSDs with different capacity or format won't 
> work too because they likely use the same controller. The naming is this:
> 
> TS64GSSD25-M
> TS: Transcend
> 64G: capacity
> SSD25: 2.5" format
> -M: MLC
> 
> So the problem is that if you match against the full string, you are going 
> to miss the other Transcend devices and the patch becomes quite useless.
> 
> If you want to harden it against false negatives, you can grep the string 
> for "SSD", as in the patch below, but there is not anything better to do 
> --- if you include "64G" in the string, you fail on non-64G devices, if 
> you include "SSD25", you fail on 1.8" devices, if you include "-M", you 
> fail on SLC.
> 
> Mikulas
> 
> ---
> 
> Don't use UDMA on VIA UDMA33 controller with Transcend SSD
> 
> The computer locks up after if Transcend SSD runs in any of UDMA modes.
> It doesn't lockup with different brand SSD, so this is specific to Transcend.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Still valid for 3.1.  Dave, ping?

> ---
>  drivers/ide/via82cxxx.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> Index: linux-2.6.31.6-fast/drivers/ide/via82cxxx.c
> ===================================================================
> --- linux-2.6.31.6-fast.orig/drivers/ide/via82cxxx.c	2009-11-16 13:08:04.000000000 +0100
> +++ linux-2.6.31.6-fast/drivers/ide/via82cxxx.c	2009-11-18 17:57:22.000000000 +0100
> @@ -195,6 +195,22 @@ static void via_set_pio_mode(ide_drive_t
>  	via_set_drive(drive, XFER_PIO_0 + pio);
>  }
>  
> +static u8 via_udma_filter(ide_drive_t *drive)
> +{
> +	char *m = (char *)&drive->id[ATA_ID_PROD];
> +
> +	/*
> +	 * Restrict UDMA for Transcend flash cards.
> +	 * On VIA 33, UDMA locks up. On VIA 133, it works. I can't test other
> +	 * controllers.
> +	 */
> +	if (!memcmp(m, "TS", 2) && strstr(m, "SSD") &&
> +	    drive->hwif->ultra_mask == ATA_UDMA2)
> +		return 0;
> +
> +	return drive->hwif->ultra_mask;
> +}
> +
>  static struct via_isa_bridge *via_config_find(struct pci_dev **isa)
>  {
>  	struct via_isa_bridge *via_config;
> @@ -372,6 +388,7 @@ static const struct ide_port_ops via_por
>  	.set_pio_mode		= via_set_pio_mode,
>  	.set_dma_mode		= via_set_drive,
>  	.cable_detect		= via82cxxx_cable_detect,
> +	.udma_filter		= via_udma_filter,
>  };
>  
>  static const struct ide_port_info via82cxxx_chipset __devinitdata = {
