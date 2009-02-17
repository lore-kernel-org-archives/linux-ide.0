From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] atiixp: missing parentheses?
Date: Tue, 17 Feb 2009 16:37:54 +0100
Message-ID: <499AD9D2.4040500@gmail.com>
References: <499AB75F.6060709@gmail.com> <499AC8E2.60406@ru.mvista.com> <499AC92D.50108@ru.mvista.com> <200902171610.11528.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f167.google.com ([209.85.218.167]:39121 "EHLO
	mail-bw0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbZBQPh4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Feb 2009 10:37:56 -0500
Received: by bwz11 with SMTP id 11so2114432bwz.13
        for <linux-ide@vger.kernel.org>; Tue, 17 Feb 2009 07:37:54 -0800 (PST)
In-Reply-To: <200902171610.11528.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 17 February 2009, Sergei Shtylyov wrote:
>> I wrote:
>>
>>>> This looks odd, is below what was intended? note that timing_shift can
>>>> only be 16, 8 or 0. Maybe intended was 24, 16, 8 or 0? then we should do:
>>>    Looking at the libata driver, yes, it should be 0, 8, 16, and 24.
>>>> int timing_shift = ((drive->dn & 2) ? 16 : 0) + ((drive->dn & 1) ? 0 : 
>>>> 8);

>>>    Why didn't you add parens around the first ?: then? They are surely 
>>> needed.

I was unsure what was intended so I chose to keep semantics, but wanted to
show the oddity. Thankfully you were able to clarify that it's a bug.

>>     Oh, actually, timing_shift = (drive->dn ^ 1) * 8.
> 
> Yes, this way we'll get the correct:
> 
> 8 0 24 16
> 
> instead of the current
> 
> 8 0 16 16


> 
> [ Luckily after DMA timings gets programmed for the third device to
>   offset 16 they get overwritten with DMA timings for fourth device.
> 
>   Since BIOS should program DMA timings for the third device all
>   should work fine till suspend/resume... ] 
> 
> Roel, please fix the patch and resubmit.
> 
> Thanks,
> Bart
I am not sure what to write for the changelog, so I kept your remarks.
Feel free to change them if necessary.
--------------------------->8-------------8<------------------------------
DMA timings were incorrect. this way we'll get the correct:

8 0 24 16 

instead of the current

8 0 16 16

Luckily after DMA timings get programmed for the third device to
offset 16 they get overwritten with DMA timings for fourth device.

Since BIOS should program DMA timings for the third device all
should work fine till suspend/resume...

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/ide/atiixp.c b/drivers/ide/atiixp.c
index b2735d2..ecd1e62 100644
--- a/drivers/ide/atiixp.c
+++ b/drivers/ide/atiixp.c
@@ -52,7 +52,7 @@ static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	struct pci_dev *dev = to_pci_dev(drive->hwif->dev);
 	unsigned long flags;
-	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
+	int timing_shift = (drive->dn ^ 1) * 8;
 	u32 pio_timing_data;
 	u16 pio_mode_data;
 
@@ -85,7 +85,7 @@ static void atiixp_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	struct pci_dev *dev = to_pci_dev(drive->hwif->dev);
 	unsigned long flags;
-	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
+	int timing_shift = (drive->dn ^ 1) * 8;
 	u32 tmp32;
 	u16 tmp16;
 	u16 udma_ctl = 0;


