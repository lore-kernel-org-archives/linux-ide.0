From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix on MacBook4,1: fail to startup in a certain situation
Date: Thu, 29 May 2008 15:09:13 +0900
Message-ID: <483E4889.1070501@gmail.com>
References: <20080528075106.F2C3D29C127@m02-blue.in.shared-server.net>	<20080528075747.A18A5114160@m03-blue.in.shared-server.net>	<483D1429.3080804@gmail.com>	<20080528092117.4A5177080E8@m04-blue.in.shared-server.net>	<483D6AF4.8000502@gmail.com>	<20080528225338.5FB121E0868@m06-blue.in.shared-server.net>	<483DF782.1050208@gmail.com>	<20080529011256.60F8ECC0F2@m01-blue.in.shared-server.net>	<483E0AAE.9000307@gmail.com> <20080529034139.A766529C0D5@m02-blue.in.shared-server.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040702060708080703070807"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:28982 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYE2GJT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 02:09:19 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3931019rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 23:09:18 -0700 (PDT)
In-Reply-To: <20080529034139.A766529C0D5@m02-blue.in.shared-server.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MATSUBAYASHI 'Shaolin' Kohji <shaolin@rhythmaning.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040702060708080703070807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks for verifying.

MATSUBAYASHI 'Shaolin' Kohji wrote:
> At Thu, 29 May 2008 10:45:18 +0900,
> Tejun Heo wrote:
>> With the patch applied, control should never reach either of the above
>> two lines.  Can you please double check?
> 
> I applied the following patch to check where the booting stops at
> 
> 
> --- drivers/ata/ata_piix.c.orig	2008-05-29 12:26:18.000000000 +0900
> +++ drivers/ata/ata_piix.c	2008-05-29 12:20:19.000000000 +0900
> @@ -251,6 +251,7 @@
>  	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>  	/* Mobile SATA Controller IDE (ICH8M), Apple */
>  	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata },
> +	{ 0x8086, 0x2828, 0x106b, 0x00a1, 0, 0, ich8m_apple_sata },

This should make your controller to use type ich8m_apple_sata.

>  	/* SATA Controller IDE (ICH9) */
>  	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>  	/* SATA Controller IDE (ICH9) */
> @@ -526,7 +527,7 @@
>  
>  	[ich8m_apple_sata] =
>  	{
> -		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
> +		.flags		= PIIX_SATA_FLAGS,
>  		.pio_mask	= 0x1f,	/* pio0-4 */
>  		.mwdma_mask	= 0x07, /* mwdma0-2 */
>  		.udma_mask	= ATA_UDMA6,

Which doesn't have PIIX_FLAG_SIDPR set.

> @@ -1360,6 +1361,8 @@
>  	if (!(host->ports[0]->flags & PIIX_FLAG_SIDPR))
>  		return;

And triggers this condition and return.

> +dev_printk(KERN_INFO, &pdev->dev, "PASSED: checking PIIX_FLAG_SIDPR\n");
> +
>  	if (pci_resource_start(pdev, PIIX_SIDPR_BAR) == 0 ||
>  	    pci_resource_len(pdev, PIIX_SIDPR_BAR) != PIIX_SIDPR_LEN)
>  		return;

So, it shouldn't get here.  Strange.  Ah... Crap.  Now I see it.
Generic entry for 2828 is above ich8m_apple_sata entry.  I wonder how
this ever worked.  Here's the updated patch.  This is without the SIDPR
change.  If this doesn't work please remove PIIX_FLAG_SIDPR from
ich8m_apple_sata entry and see whether that helps.

Thanks.

-- 
tejun

--------------040702060708080703070807
Content-Type: text/x-patch;
 name="ata_piix-apple-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ata_piix-apple-2.patch"

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a9027b8..02d6efe 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -247,10 +247,11 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller 2 IDE (ICH8) */
 	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* Mobile SATA Controller IDE (ICH8M) */
-	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* Mobile SATA Controller IDE (ICH8M), Apple */
 	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata },
+	{ 0x8086, 0x2828, 0x106b, 0x00a1, 0, 0, ich8m_apple_sata },
+	/* Mobile SATA Controller IDE (ICH8M) */
+	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (ICH9) */
 	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (ICH9) */

--------------040702060708080703070807--
