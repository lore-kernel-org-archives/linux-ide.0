From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/6] pata_sis: Implement MWDMA for the UDMA 133 capable chips
Date: Mon, 7 Dec 2009 16:53:46 +0100
Message-ID: <200912071653.46222.bzolnier@gmail.com>
References: <20091130132005.27236.77890.stgit@localhost.localdomain> <200912071605.28364.bzolnier@gmail.com> <200912071636.32030.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41516 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbZLGPyo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 10:54:44 -0500
Received: by ewy19 with SMTP id 19so605825ewy.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Dec 2009 07:54:50 -0800 (PST)
In-Reply-To: <200912071636.32030.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

On Monday 07 December 2009 04:36:31 pm Bartlomiej Zolnierkiewicz wrote:
> On Monday 07 December 2009 04:05:28 pm Bartlomiej Zolnierkiewicz wrote:
> > On Monday 07 December 2009 02:26:00 pm Sergei Shtylyov wrote:
> > > Hello.
> > > 
> > > Alan Cox wrote:
> > > 
> > > > Bartlomiej pointed out that while this got fixed in the old driver whoever
> > > > did it didn't port it across.
> > > 
> > > > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > > 
> > > [...]

One more thing:

@@ -479,13 +527,12 @@ static void sis_133_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 	if (reg54 & 0x40000000)
 		port = 0x70;
 	port += (8 * ap->port_no) +  (4 * adev->devno);
-
 	pci_read_config_dword(pdev, port, &t1);
 
 	if (adev->dma_mode < XFER_UDMA_0) {
-		t1 &= ~0x00000004;
-		/* FIXME: need data sheet to add MWDMA here. Also lacking on
-		   ide/pci driver */
+		speed = mwdma_clip_to_pio(adev);
+		sis_133_do_piomode(ap, adev, speed);
+		t1 &= ~4;	/* UDMA off */
 	} else {
 		speed = adev->dma_mode - XFER_UDMA_0;
 		/* if & 8 no UDMA133 - need info for ... */

This way of doing things results in under-clocked timings for MWDMA0 mode,
(they're not the same as ones for PIO0 mode), old driver gets it correctly.

--
Bartlomiej Zolnierkiewicz
