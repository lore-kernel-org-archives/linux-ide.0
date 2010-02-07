From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH 02/10] drivers/ata: Fix continuation line formats
Date: Sun, 7 Feb 2010 18:10:20 +0300
Message-ID: <20100207181020.21d8c9b4@realm>
References: <cover.1265095093.git.joe@perches.com>
	<12d39ac4f14bfe82a02b4ee246d183b48988fe12.1265095094.git.joe@perches.com>
	<4B69B0A0.2040701@teksavvy.com>
	<4B69B182.9040400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:58573 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904Ab0BGPQH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Feb 2010 10:16:07 -0500
Received: by ewy28 with SMTP id 28so1626632ewy.28
        for <linux-ide@vger.kernel.org>; Sun, 07 Feb 2010 07:16:04 -0800 (PST)
In-Reply-To: <4B69B182.9040400@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Joe Perches <joe@perches.com>
Cc: Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org

Hello,
Thanks for attention and fix. For me Joe's fix is fine. 
But if you would prefer one-line version:

diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 41c94b1..7ce9595 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -153,8 +153,7 @@ static void pata_at91_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	/* Compute ATA timing and set it to SMC */
 	ret = ata_timing_compute(adev, adev->pio_mode, &timing, 1000, 0);
 	if (ret) {
-		dev_warn(ap->dev, "Failed to compute ATA timing %d, \
-				set PIO_0 timing\n", ret);
+		dev_warn(ap->dev, "Failed to compute ATA timing %d, set PIO_0 timing\n", ret);
 		set_smc_timing(ap->dev, info, &initial_timing);
 	} else {
 		set_smc_timing(ap->dev, info, &timing);


> > Joe Perches wrote:
> >> String constants that are continued on subsequent lines with \
> >> are not good.
> >>
> >> Signed-off-by: Joe Perches <joe@perches.com>
> >> ---
> >> drivers/ata/pata_at91.c | 4 ++--
> >> 1 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> >> index 41c94b1..d222c0d 100644
> >> --- a/drivers/ata/pata_at91.c
> >> +++ b/drivers/ata/pata_at91.c
> >> @@ -153,8 +153,8 @@ static void pata_at91_set_piomode(struct
> >> ata_port *ap, struct ata_device *adev)
> >> /* Compute ATA timing and set it to SMC */
> >> ret = ata_timing_compute(adev, adev->pio_mode, &timing, 1000, 0);
> >> if (ret) {
> >> - dev_warn(ap->dev, "Failed to compute ATA timing %d, \
> >> - set PIO_0 timing\n", ret);
> >> + dev_warn(ap->dev, "Failed to compute ATA timing %d, set PIO_0
> >> timing\n",
> >> + ret);
> > ..
> >
> > NAK. Just stick the ret); part onto the same line and be done with
> > it.
> 
> Agreed...
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



