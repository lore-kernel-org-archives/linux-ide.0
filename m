From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/64] pata_ali: cleanup ali_set_piomode()
Date: Mon, 18 Jan 2010 19:16:15 +0100
Message-ID: <201001181916.15161.bzolnier@gmail.com>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171412.14623.94854.sendpatchset@localhost> <20100118174602.47f8ec24@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:40385 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab0ARSXe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 13:23:34 -0500
In-Reply-To: <20100118174602.47f8ec24@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 18 January 2010 06:46:02 pm Alan Cox wrote:
> On Mon, 18 Jan 2010 18:14:12 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_ali: cleanup ali_set_piomode()
> > 
> > Merge ali_fifo_control() calls.
> 
> This also changes the behaviour. The old driver, reference code and old
> IDE driver (at least at the time I did pata_ali) all did the fifo off
> case, then the mode change, then the FIFO on case.

Well, the old IDE driver (both at the time you did pata_ali and currently)
did it the way this patch does and unfortunately I'm not familiar with
the reference code (I worry that it may be available under NDA only)..

> I don't see why it should matter but it ought to be noted in the changelog

Indeed, though this should be quite obvious from looking at the patch
(below for reference) and the lack of my usual "no functionality changes"
note..

---
 drivers/ata/pata_ali.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: b/drivers/ata/pata_ali.c
===================================================================
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -222,12 +222,9 @@ static void ali_set_piomode(struct ata_p
 	}
 
 	/* PIO FIFO is only permitted on ATA disk */
-	if (adev->class != ATA_DEV_ATA)
-		ali_fifo_control(ap, adev, 0x00);
-	ali_program_modes(ap, adev, &t, 0);
-	if (adev->class == ATA_DEV_ATA)
-		ali_fifo_control(ap, adev, 0x05);
+	ali_fifo_control(ap, adev, (adev->class == ATA_DEV_ATA) ? 0x05 : 0x00);
 
+	ali_program_modes(ap, adev, &t, 0);
 }
 
 /**
