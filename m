From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATA DMA problem leading to kernel panic on reading movie DVDs
Date: Tue, 19 May 2009 23:11:21 +0200
Message-ID: <200905192311.22310.bzolnier@gmail.com>
References: <20090517091224.GA8280@wanza.invalid> <20090519182928.GA8172@wanza.invalid> <200905192131.00168.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:64169 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZESVOl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 17:14:41 -0400
In-Reply-To: <200905192131.00168.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Lottermoser <Martin.Lottermoser@t-online.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Tuesday 19 May 2009 21:30:59 Bartlomiej Zolnierkiewicz wrote:

[...]

> > The offer for testing patches remains open :-).
> 
> We will get there. ;-)
> 
> I've reproduced the problem and I'm testing the fix currently...

The following patch should fix OOPS w/ vanilla 2.6.30-rc6 and 40-wire cable:

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix OOPS during ide-cd error recovery

On Tuesday 19 May 2009 20:29:28 Martin Lottermoser wrote:

>   hdc: cdrom_decode_status: error=0x40 <3>{ LastFailedSense=0x04 }
>   ide: failed opcode was: unknown
>   hdc: DMA disabled
>   ------------[ cut here ]------------
>   kernel BUG at drivers/ide/ide-io.c:872!

It is possible for ide-cd to ignore ide_error()'s return value under
some circumstances.  Workaround it in ide_intr() and ide_timer_expiry()
by checking if there is a device/port reset pending currently.

Reported-by: Martin Lottermoser <Martin.Lottermoser@t-online.de>
Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
in the longer-term ide-cd should be fixed to not do such things
(too invasive for 2.6.30 and 2.6.29)

 drivers/ide/ide-io.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -696,7 +696,7 @@ void ide_timer_expiry (unsigned long dat
 		}
 		spin_lock_irq(&hwif->lock);
 		enable_irq(hwif->irq);
-		if (startstop == ide_stopped) {
+		if (startstop == ide_stopped && hwif->polling == 0) {
 			ide_unlock_port(hwif);
 			plug_device = 1;
 		}
@@ -868,7 +868,7 @@ irqreturn_t ide_intr (int irq, void *dev
 	 * same irq as is currently being serviced here, and Linux
 	 * won't allow another of the same (on any CPU) until we return.
 	 */
-	if (startstop == ide_stopped) {
+	if (startstop == ide_stopped && hwif->polling == 0) {
 		BUG_ON(hwif->handler);
 		ide_unlock_port(hwif);
 		plug_device = 1;

