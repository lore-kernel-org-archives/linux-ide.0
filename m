From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] hpt366: UltraDMA filtering for SATA cards
Date: Sat, 11 Aug 2007 19:45:13 +0400
Message-ID: <46BDD989.6060202@ru.mvista.com>
References: <200708060008.38077.sshtylyov@ru.mvista.com> <200708090008.10352.bzolnier@gmail.com> <46BCAA85.3070905@ru.mvista.com> <200708102316.09960.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:60997 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755237AbXHKPnE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Aug 2007 11:43:04 -0400
In-Reply-To: <200708102316.09960.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: rah@bash.sh, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>Index: linux-2.6/drivers/ide/pci/hpt366.c
>>>>===================================================================
>>>>--- linux-2.6.orig/drivers/ide/pci/hpt366.c
>>>>+++ linux-2.6/drivers/ide/pci/hpt366.c

[...]

>>>>+	case HPT372 :
>>>>+	case HPT372A:
>>>>+	case HPT372N:
>>>>+	case HPT374 :
>>>>+		/*
>>>>+		 * Check for SATA drive by verifying that the word 93 is 0 and
>>>>+		 * the drive is ATA-5 or higher compatible.
>>>>+		 */
>>>>+		if (id->hw_config == 0 && (id->major_rev_num & 0x7fe0))

>>>Same check as in ide-iops.c::eighty_ninty_three().
>>>Would make sense to add ide_id_is_sata_dev() inline to <linux/ide.h>.

>>    Actually, libata already has ata_id_is_sata() defined in <linux/ata.h> but 
>>it takes <const u16 *> argument.

> If we can use this one instead it would be even better.

    Only by wrapping it up with the argument typecast. :-)
That function calls another inline, ata_id_major_version() which is quite 
clumsy and useless for this case (does a bit scan in the word 80), so 
introducing our own may be better...

>>>>+			return 0x71;
>>>>+		/* fall thru */
>>>>	default:
>>>>		return 0x7f;

>>>HPT371[N]/HPT302[N] will use the default mask which is correct but adds
>>>hidden dependency on HPT*_ALLOW_ATA_133 being always defined as "1".

>>    No, it doesn't since all this will be AND'ed with & hwif->udma_mask... But 
>>wait, ide_rate_filter has the different code, it just sets mask to the result 
>>of the udma_filter() method... I wonder which code is correct? :-O

> I bet that you are looking at vanilla kernel which currently misses

    Of course.

>  101 files changed, 1880 insertions(+), 2828 deletions(-)

> please look at -mm or IDE quilt tree instead. :)

    Looking...

> ide_rate_filter() happily uses ide_find_dma_mode() nowadays (however this
> hpt366 patch is for vanilla kernel which doesn't have the needed changes).

>>>IMO all HPT*_ALLOW_ATA* defines should just go away...

>>    I think it's still worth to keep 'em alive for the possible blacklist 
>>additions.

> No strong feelings about these defines but I think that they actually make
> the code less readable and also more complex because they control _both_
> DPLL used (through controlling max_ultra) and the maximum UDMA mask.

    That's because the maximum UDMA mask depends on the DPLL frequency...

> Moreover they are _compile_ time options so for testing purposes we may
> as well ask user to change UDMA mask etc.

    ... and UltraDMA/100 is *not* reachable with 66 MHz clock (it will have to 
use the same timings as UltraDMA/66 -- so changing the mask only is just not 
enough.
    Now you can hopefully see that these #define's as they are now exist for a 
good reason... :-)

>>>Also now that ->udma_filter is always present the initial hwif->ultra_mask
>>>doesn't matter so as well we may set it to ATA_UDMA6 (0x7f) and cleanup
>>>struct hpt_info (by removing max_ultra after fixing init_chipset_hpt366()
>>>to use info->chip_type >= HPT374 check instead),

>>    It's all interesting but you've missed one aspect -- this will make the 
>>kernel larger while the current code keeps all this logic in the init.text 
>>section.

> We won't be adding a single line of new code:

> - the current ->udma_filter implementation does everything needed already

    Not really. It will return 0x7f for chipset not supporting it

> - in init_chipset_hpt366() we simply would replace

> 		if (info->max_ultra > 6)

    Actually,( info->max_ultra == 6)

>   with

> 		if (info->chip_type >= HPT374)

    This is just wrong -- HPT374 does not tolarate 66 MHz clock.  You probably 
meant HPT372 (or >)?

>   (this change depends on the current HPT3xx enums order
>    and on removal HPT*_ALLOW_ATA* defines)

    Heh, how about doing this (pardon for the bad... er, sed language):

	default:
		return s/0x71/drive->hwif->ultra_mask/;

without all any changes that you've proposed and being done with that fix? :-)

> I wouldn't be surprised if we actually _decrease_ the driver size a bit
> (in addition to removal of ~35 LOC).

    Decrasing .init.text section's width doesn't buy you much.

>>>init_setup_hpt366() and hpt366_chipsets[] (by removing udma_mask).

>>    I'll think about it in my copious free time (I have plenty of time spent 
>>offline now indeed :-)...

> :-)

    Unfortunately, it's being spent off-PC too.

>>>>@@ -1229,25 +1241,24 @@ static unsigned int __devinit init_chips
>>>>
>>>>static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
>>>>{
>>>>-	struct pci_dev	*dev		= hwif->pci_dev;
>>>>-	struct hpt_info *info		= pci_get_drvdata(dev);
>>>>-	int serialize			= HPT_SERIALIZE_IO;
>>>>-	u8  scr1 = 0, ata66		= hwif->channel ? 0x01 : 0x02;
>>>>-	u8  chip_type			= info->chip_type;
>>>>-	u8  new_mcr, old_mcr 		= 0;
>>>>+	struct pci_dev	*dev	= hwif->pci_dev;
>>>>+	struct hpt_info *info	= pci_get_drvdata(dev);
>>>>+	int serialize		= HPT_SERIALIZE_IO;
>>>>+	u8  scr1 = 0, ata66	= hwif->channel ? 0x01 : 0x02;
>>>>+	u8  chip_type		= info->chip_type;
>>>>+	u8  new_mcr, old_mcr	= 0;
>>>>
>>>>	/* Cache the channel's MISC. control registers' offset */
>>>>-	hwif->select_data		= hwif->channel ? 0x54 : 0x50;
>>>>+	hwif->select_data	= hwif->channel ? 0x54 : 0x50;
>>>>
>>>>-	hwif->tuneproc			= &hpt3xx_tune_drive;
>>>>-	hwif->speedproc			= &hpt3xx_tune_chipset;
>>>>-	hwif->quirkproc			= &hpt3xx_quirkproc;
>>>>-	hwif->intrproc			= &hpt3xx_intrproc;
>>>>-	hwif->maskproc			= &hpt3xx_maskproc;
>>>>-	hwif->busproc			= &hpt3xx_busproc;
>>>>+	hwif->tuneproc		= &hpt3xx_tune_drive;
>>>>+	hwif->speedproc		= &hpt3xx_tune_chipset;
>>>>+	hwif->quirkproc		= &hpt3xx_quirkproc;
>>>>+	hwif->intrproc		= &hpt3xx_intrproc;
>>>>+	hwif->maskproc		= &hpt3xx_maskproc;
>>>>+	hwif->busproc		= &hpt3xx_busproc;
>>>>
>>>>-	if (chip_type <= HPT370A)
>>>>-		hwif->udma_filter	= &hpt3xx_udma_filter;
>>>>+	hwif->udma_filter	= &hpt3xx_udma_filter;

>>>Uh, the only real change here consists of the three lines above, the rest
>>>is just a noise caused by removal of one tab.

>>>Such changes are really not worth it - in this case it caused rejects in
>>>two patches from IDE quilt tree which I had to fix manually.

>>    I hope now that you've fixed it, I may leave this part intact? ;-)

> Iff you base the new patch on top of IDE quilt tree otherwise I'll have
> to fix it _again_. ;-)

    I hope you haven't forgotten the basic rule: "the fixes come first"? :-)
    And why fix it again, if I'm not going to drop that part?
    I just felt your pain going thru the (already obsolete) series and fixing 
the rejects -- not only due to my patches... my patchutils are outdated. :-/

> Thanks,
> Bart

MBR, Sergei

