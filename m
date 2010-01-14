From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend SSD
Date: Thu, 14 Jan 2010 16:49:13 +0100
Message-ID: <201001141649.13073.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com> <20091026121804.3789c4c0@lxorguk.ukuu.org.uk> <Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:38057 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338Ab0ANRCP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 12:02:15 -0500
Received: by ey-out-2122.google.com with SMTP id 4so435388eyf.5
        for <linux-ide@vger.kernel.org>; Thu, 14 Jan 2010 09:02:14 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thursday 05 November 2009 02:25:21 am Mikulas Patocka wrote:
> Hi
> 
> Here is another patch for SSD for VIA UDMA33. Alan, please backport it 
> into libata.
> 
> Mikulas
> 
> ---
> 
> Don't use UDMA on VIA UDMA33 controller with Transcend SSD
> 
> The computer locks up if Transcend SSD runs in any of UDMA modes.
> It doesn't lockup with different brand SSD, so this is specific to Transcend.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

FWIW the following modified version of your patch is now in my atang tree:

From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] via82cxxx: don't use UDMA on VIA UDMA33 controller with Transcend SSD

Don't use UDMA on VIA UDMA33 controller with Transcend SSD.

The computer locks up if Transcend SSD runs in any of UDMA modes.
It doesn't lockup with different brand SSD, so this is specific to Transcend.

bzolnier:
- limit it to VT82C586A/B + TS64GSSD25-M (per commit 10734fc) for now
- add warning message

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/via82cxxx.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: b/drivers/ide/via82cxxx.c
===================================================================
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -195,6 +195,24 @@ static void via_set_pio_mode(ide_drive_t
 	via_set_drive(drive, XFER_PIO_0 + pio);
 }
 
+static u8 via_udma_filter(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct pci_dev *dev = to_pci_dev(hwif->dev);
+	struct ide_host *host = pci_get_drvdata(dev);
+	struct via82cxxx_dev *vdev = host->host_priv;
+	char *m = (char *)&drive->id[ATA_ID_PROD];
+
+	if (vdev->via_config->id == PCI_DEVICE_ID_VIA_82C586_0 &&
+	    strcmp(m, "TS64GSSD25-M") == 0) {
+		printk(KERN_WARNING "%s: disabling UDMA mode due to reported "
+			"lockups with this device.\n", drive->name);
+		return 0;
+	}
+
+	return hwif->ultra_mask;
+}
+
 static struct via_isa_bridge *via_config_find(struct pci_dev **isa)
 {
 	struct via_isa_bridge *via_config;
@@ -372,6 +390,7 @@ static const struct ide_port_ops via_por
 	.set_pio_mode		= via_set_pio_mode,
 	.set_dma_mode		= via_set_drive,
 	.cable_detect		= via82cxxx_cable_detect,
+	.udma_filter		= via_udma_filter,
 };
 
 static const struct ide_port_info via82cxxx_chipset __devinitdata = {
