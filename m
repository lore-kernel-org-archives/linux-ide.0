From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix on MacBook4,1: fail to startup in a certain situation
Date: Thu, 29 May 2008 09:23:30 +0900
Message-ID: <483DF782.1050208@gmail.com>
References: <20080528075106.F2C3D29C127@m02-blue.in.shared-server.net>	<20080528075747.A18A5114160@m03-blue.in.shared-server.net>	<483D1429.3080804@gmail.com>	<20080528092117.4A5177080E8@m04-blue.in.shared-server.net>	<483D6AF4.8000502@gmail.com> <20080528225338.5FB121E0868@m06-blue.in.shared-server.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040808080603010509020905"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:15737 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbYE2AXg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 20:23:36 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3791086rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 17:23:36 -0700 (PDT)
In-Reply-To: <20080528225338.5FB121E0868@m06-blue.in.shared-server.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MATSUBAYASHI 'Shaolin' Kohji <shaolin@rhythmaning.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040808080603010509020905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

MATSUBAYASHI 'Shaolin' Kohji wrote:
> Unfortunately no...
> With this patch, booting will stop during the execution of
> the following lines (in ata_piix.c: piix_init_sidpr()):
> 
>         if (pci_resource_start(pdev, PIIX_SIDPR_BAR) == 0 ||
>             pci_resource_len(pdev, PIIX_SIDPR_BAR) != PIIX_SIDPR_LEN)
>                 return;
> 
> which might suggest this is not ata_piix related problem I'm afraid...
> 
> Again, please note if I keep the AC adapter plugged to MacBook,
> there is no such problem happening. It happens only when running with battery.

Hmmm.. That really doesn't make much sense.  Can you please try the
attached one just in case?

Thanks.

-- 
tejun

--------------040808080603010509020905
Content-Type: text/x-patch;
 name="ata_piix-apple-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ata_piix-apple-1.patch"

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a9027b8..6c2e907 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -251,6 +251,7 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* Mobile SATA Controller IDE (ICH8M), Apple */
 	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata },
+	{ 0x8086, 0x2828, 0x106b, 0x00a1, 0, 0, ich8m_apple_sata },
 	/* SATA Controller IDE (ICH9) */
 	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (ICH9) */
@@ -526,7 +527,7 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich8m_apple_sata] =
 	{
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
+		.flags		= PIIX_SATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,

--------------040808080603010509020905--
