From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend SSD
Date: Wed, 12 Oct 2011 16:38:09 +0200
Message-ID: <201110121638.09605.bzolnier@gmail.com>
References: <20091117.043002.224755438.davem@davemloft.net> <20111011.150504.1435090249037873103.davem@davemloft.net> <20111011203950.44b714d0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47912 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab1JLOim (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 10:38:42 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so809970eye.19
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2011 07:38:42 -0700 (PDT)
In-Reply-To: <20111011203950.44b714d0@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, mpatocka@redhat.com, linux-ide@vger.kernel.org

Alan Cox wrote:

> On Tue, 11 Oct 2011 15:05:04 -0400 (EDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Date: Tue, 11 Oct 2011 19:12:01 +0200
> > 
> > > Still valid for 3.1.  Dave, ping?
> > 
> > Feedback given and changes requested/required, patch was not updated
> > and resubmitted by the author:
> > 
> > http://patchwork.ozlabs.org/patch/38764/
> 
> The last state on this I saw it seemd that exactly one person had seen it
> on exactly one machine ? Has that changed ?

No, you're right here.

Here is updated patch:

From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] via82cxxx: don't use UDMA on VIA UDMA33 controller with Transcend SSD

Don't use UDMA on VIA UDMA33 controller with Transcend SSD.

The computer locks up if Transcend SSD runs in any of UDMA modes.
It doesn't lockup with different brand SSD, so this is specific to Transcend.

bzolnier:
- limit it to VT82C586A/B + TS64GSSD25-M (per commit 10734fc ("pata_via:
  Blacklist some combinations of Transcend Flash and via")) for now
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
@@ -220,6 +220,24 @@ static void via_set_pio_mode(ide_hwif_t
 	via_set_drive(hwif, drive);
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
@@ -401,6 +419,7 @@ static const struct ide_port_ops via_por
 	.set_pio_mode		= via_set_pio_mode,
 	.set_dma_mode		= via_set_drive,
 	.cable_detect		= via82cxxx_cable_detect,
+	.udma_filter		= via_udma_filter,
 };
 
 static const struct ide_port_info via82cxxx_chipset __devinitdata = {
