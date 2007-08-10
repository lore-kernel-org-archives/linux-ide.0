From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] hpt366: UltraDMA filtering for SATA cards
Date: Fri, 10 Aug 2007 22:12:21 +0400
Message-ID: <46BCAA85.3070905@ru.mvista.com>
References: <200708060008.38077.sshtylyov@ru.mvista.com> <200708090008.10352.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56740 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755364AbXHJSKL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Aug 2007 14:10:11 -0400
In-Reply-To: <200708090008.10352.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: rah@bash.sh, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>The Marvell bridge chips used on HighPoint SATA cards do not seem to support
>>the UltraDMA modes 1, 2, and 3 (as well as any MWDMA modes), so the driver
>>needs to account for this in the udma_filter() method.  In order to achieve
>>that, do the following changes:

>>- install the method for all chips, not only HPT36x/370 (improve code formatting
>>  by killing an extra tabs while at it);

>>- add to the end of the 'switch' statement in hpt3xx_udma_filter() case for
>>  HPT372[AN] and HPT374 chips upon which the SATA cards are based and check
>>  there whether we're dealing with SATA drive (by looking at words 80 and 93
>>  of the drive's identify data), reorder HPT370[A] cases for consistency...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied but

>> drivers/ide/pci/hpt366.c |   75 ++++++++++++++++++++++++++---------------------
>> 1 files changed, 43 insertions(+), 32 deletions(-)

>>Index: linux-2.6/drivers/ide/pci/hpt366.c
>>===================================================================
>>--- linux-2.6.orig/drivers/ide/pci/hpt366.c
>>+++ linux-2.6/drivers/ide/pci/hpt366.c
[...]
>>@@ -517,29 +517,17 @@ static int check_in_drive_list(ide_drive
>> }
>> 
>> /*
>>- *	Note for the future; the SATA hpt37x we must set
>>- *	either PIO or UDMA modes 0,4,5
>>+ * The Marvell bridge chips used on the HighPoint SATA cards do not seem
>>+ * to support the UltraDMA modes 1, 2, and 3 -- as well as any MWDMA modes
>>+ * (that we should start filtering out once the IDE core allows that).
>>  */
>>-
>> static u8 hpt3xx_udma_filter(ide_drive_t *drive)
>> {
>> 	struct hpt_info *info	= pci_get_drvdata(HWIF(drive)->pci_dev);
>>+	struct hd_driveid *id	= drive->id;
>> 	u8 mask;
>> 
>> 	switch (info->chip_type) {

> HPT374/HPT372[NA] case could be added here so re-ordering wouldn't be needed.

    I did that on purpose -- to keep an alphanumeric ordering. ;-)

>>@@ -551,6 +539,30 @@ static u8 hpt3xx_udma_filter(ide_drive_t
>> 		    check_in_drive_list(drive, bad_ata66_3))
>> 			mask = 0x07;
>> 		break;
>>+	case HPT370:
>>+		if (!HPT370_ALLOW_ATA100_5 ||
>>+		    check_in_drive_list(drive, bad_ata100_5))
>>+			mask = 0x1f;
>>+		else
>>+			mask = 0x3f;

> ATA_UDMA* defines should be used if you insist on re-ordering

    OK, recasting...

>>+	case HPT372 :
>>+	case HPT372A:
>>+	case HPT372N:
>>+	case HPT374 :
>>+		/*
>>+		 * Check for SATA drive by verifying that the word 93 is 0 and
>>+		 * the drive is ATA-5 or higher compatible.
>>+		 */
>>+		if (id->hw_config == 0 && (id->major_rev_num & 0x7fe0))

> Same check as in ide-iops.c::eighty_ninty_three().
> Would make sense to add ide_id_is_sata_dev() inline to <linux/ide.h>.

    Actually, libata already has ata_id_is_sata() defined in <linux/ata.h> but 
it takes <const u16 *> argument.

>>+			return 0x71;
>>+		/* fall thru */
>> 	default:
>> 		return 0x7f;

> HPT371[N]/HPT302[N] will use the default mask which is correct but adds
> hidden dependency on HPT*_ALLOW_ATA_133 being always defined as "1".

    No, it doesn't since all this will be AND'ed with & hwif->udma_mask... But 
wait, ide_rate_filter has the different code, it just sets mask to the result 
of the udma_filter() method... I wonder which code is correct? :-O

> IMO all HPT*_ALLOW_ATA* defines should just go away...

    I think it's still worth to keep 'em alive for the possible blacklist 
additions.

> Also now that ->udma_filter is always present the initial hwif->ultra_mask
> doesn't matter so as well we may set it to ATA_UDMA6 (0x7f) and cleanup
> struct hpt_info (by removing max_ultra after fixing init_chipset_hpt366()
> to use info->chip_type >= HPT374 check instead),

    It's all interesting but you've missed one aspect -- this will make the 
kernel larger while the current code keeps all this logic in the init.text 
section.

> init_setup_hpt366() and hpt366_chipsets[] (by removing udma_mask).

    I'll think about it in my copious free time (I have plenty of time spent 
offline now indeed :-)...

>>@@ -1229,25 +1241,24 @@ static unsigned int __devinit init_chips
>> 
>> static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
>> {
>>-	struct pci_dev	*dev		= hwif->pci_dev;
>>-	struct hpt_info *info		= pci_get_drvdata(dev);
>>-	int serialize			= HPT_SERIALIZE_IO;
>>-	u8  scr1 = 0, ata66		= hwif->channel ? 0x01 : 0x02;
>>-	u8  chip_type			= info->chip_type;
>>-	u8  new_mcr, old_mcr 		= 0;
>>+	struct pci_dev	*dev	= hwif->pci_dev;
>>+	struct hpt_info *info	= pci_get_drvdata(dev);
>>+	int serialize		= HPT_SERIALIZE_IO;
>>+	u8  scr1 = 0, ata66	= hwif->channel ? 0x01 : 0x02;
>>+	u8  chip_type		= info->chip_type;
>>+	u8  new_mcr, old_mcr	= 0;
>> 
>> 	/* Cache the channel's MISC. control registers' offset */
>>-	hwif->select_data		= hwif->channel ? 0x54 : 0x50;
>>+	hwif->select_data	= hwif->channel ? 0x54 : 0x50;
>> 
>>-	hwif->tuneproc			= &hpt3xx_tune_drive;
>>-	hwif->speedproc			= &hpt3xx_tune_chipset;
>>-	hwif->quirkproc			= &hpt3xx_quirkproc;
>>-	hwif->intrproc			= &hpt3xx_intrproc;
>>-	hwif->maskproc			= &hpt3xx_maskproc;
>>-	hwif->busproc			= &hpt3xx_busproc;
>>+	hwif->tuneproc		= &hpt3xx_tune_drive;
>>+	hwif->speedproc		= &hpt3xx_tune_chipset;
>>+	hwif->quirkproc		= &hpt3xx_quirkproc;
>>+	hwif->intrproc		= &hpt3xx_intrproc;
>>+	hwif->maskproc		= &hpt3xx_maskproc;
>>+	hwif->busproc		= &hpt3xx_busproc;
>> 
>>-	if (chip_type <= HPT370A)
>>-		hwif->udma_filter	= &hpt3xx_udma_filter;
>>+	hwif->udma_filter	= &hpt3xx_udma_filter;

> Uh, the only real change here consists of the three lines above, the rest
> is just a noise caused by removal of one tab.

> Such changes are really not worth it - in this case it caused rejects in
> two patches from IDE quilt tree which I had to fix manually.

    I hope now that you've fixed it, I may leave this part intact? ;-)

> Thanks,
> Bart

MBR, Sergei
