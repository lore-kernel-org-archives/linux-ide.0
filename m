From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ide: add support for CFA specified transfer modes
Date: Sat, 07 Mar 2009 19:50:09 +0300
Message-ID: <49B2A5C1.8090409@ru.mvista.com>
References: <200903032034.49372.sshtylyov@ru.mvista.com> <200903071723.26150.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57584 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755333AbZCGQtj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Mar 2009 11:49:39 -0500
In-Reply-To: <200903071723.26150.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, stf_xl@wp.pl

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>Add support for the CompactFlash specific PIO modes 5/6 and MWDMA modes 3/4.

> Thanks for picking this up.

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>---
>>This patch is against the current pata-2.6 series. Since there were no PIO5
>>capable hard drives produced and you also need 66 MHz input clock to actually
>>get the difference WRT the setup timing programmed, I decided to simply replace
>>the old non-standard PIO mode 5 timings with CFA specified ones.
>>Phew, hopefully I haven't overlooked anything -- quite a lot had to be changed.

> It looks fine overall, few comments below.

>>@@ -389,6 +389,8 @@ int ide_config_drive_speed(ide_drive_t *
>> 	id[ATA_ID_UDMA_MODES]  &= ~0xFF00;
>> 	id[ATA_ID_MWDMA_MODES] &= ~0x0F00;
>> 	id[ATA_ID_SWDMA_MODES] &= ~0x0F00;
>>+	if (ata_id_is_cfa(id))
>>+		id[ATA_ID_CFA_MODES] &= ~0x0F30;

> Shouldn't the mask be ~0x0FC0 here?

    Oops, indeed. :-<

>>@@ -90,6 +93,10 @@ u16 ide_pio_cycle_time(ide_drive_t *driv
>> 		/* conservative "downgrade" for all pre-ATA2 drives */
>> 		if (pio < 3 && cycle < t->cycle)
>> 			cycle = 0; /* use standard timing */
>>+
>>+		/* IORDY must be ignored for CF specific PIO modes */
>>+		if (pio > 4 && ata_id_is_cfa(id))
>>+			cycle = 0; /* use standard timing */

> This comment seems out of place for the code dealing with cycle timing.

> When it comes to IORDY I recalled that some host drivers already support
> "harddisk" PIO5 so they may need to be updated to not force IORDY setting
> (seems like at least sl82c105.c is affected).

    I thought I have taken care of this with the generic code... the need for 
the driver-level CF specific changes looks iffy as not all these drivers ever 
drive CF. I need to think about it... won't be the part of this patch in any case.

>>@@ -79,7 +79,10 @@ u8 ide_get_best_pio_mode(ide_drive_t *dr
>> 		}
>> 
>> 		if (id[ATA_ID_FIELD_VALID] & 2) {	      /* ATA2? */
>>-			if (ata_id_has_iordy(id)) {
>>+			if (ata_id_is_cfa(id) && (id[ATA_ID_CFA_MODES] & 7))
>>+				pio_mode = 4 + min_t(int, 2,
>>+						     id[ATA_ID_CFA_MODES] & 7);
>>+			else if (ata_id_has_iordy(id)) {

> Shouldn't this happen independently of id[ATA_ID_FIELD_VALID] & 2 value?

    Not really. Support for PIO modes 5 and 6 means support for all the lower 
modes too.

WBR, Sergei
