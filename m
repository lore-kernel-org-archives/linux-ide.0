From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] siimage: PIO mode setup fixes
Date: Wed, 04 Jul 2007 22:59:13 +0400
Message-ID: <468BEE01.1050102@ru.mvista.com>
References: <200706232004.08914.bzolnier@gmail.com> <200706300012.12394.bzolnier@gmail.com> <468BC7D2.2030901@ru.mvista.com> <200707042059.31567.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33002 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756112AbXGDS5R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 14:57:17 -0400
In-Reply-To: <200707042059.31567.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>>>* Add sil_tuneproc() wrapper for siimage_tuneproc() which also sets
>>>>> PIO mode on the device.

>>>>   Planning on the global prefix change? :-)

>>>Yep.

>>    Well, it didn't work out with 'ata_'... ;-)

> Because of bad libata taking over our precioussssss namespace... ;-)

    Thievessss! 8-)

> Fortunately pata_sil680 driver uses "sil680_" prefix.

    We'll make Coxsss pay. 8-)

>>>>   Note that PIO setup keeps being somewhat borken IODRY-wise even with this
>>>>patch as sil_tune_pio() only controls taskfile IORDY sampling -- the Right
>>>>Thing could only be done via speedproc() method...

>>>After rehashing the datasheet I see the source of the issue:

>>>IORDY is controlled in two registers and moreover it is always enabled
>>>if MDMA or UDMA transfer modes are selected.

>>    Yeah. I drafted some patch for pata_sil.c but Alan fixed it first and in a 
>>more simple way -- libata calls PIO/DMA setting methods in the strict 
>>sequence, and that allowed to bypass some checks...

> I fail to see how this helps in this case, care to explain?

    The whole reason for that resetproc() ceases to exist, no? At least that's 
what I was able to grasp from looing at the older versions... And it's mean to 
reset both channels just to be able to downgrade from UDMA to MWDMA (not a 
thing routinely done anyway), so this needs to go.
    Well, I'm seeing that it's also called from the ide_dma_timeout() and even 
ide_dma_lostirq() methods; not sure how much necessary it is -- at least for 
the latter case this seems just wrong...

>>>+	/* cheat for now and use the docs */
>>>+	speedp = data_speed[pio];
>>>+	speedt = tf_speed[tf_pio];
>>>+
>>> 	if (hwif->mmio) {
>>> 		hwif->OUTW(speedp, addr);
>>> 		hwif->OUTW(speedt, tfaddr);
>>> 		/* Now set up IORDY */
>>>-		if(mode_wanted == 3 || mode_wanted == 4)
>>>+		if (pio > 2)

>>    Not tf_pio? This IORDY bit is for taskfile accesses...

> Would this be really OK (tf_pio takes minimum PIO mode)?

    Well, probably not -- a slow mate drive could force IORDY disabled this 
way... So, just 'pio' seems more correct.

> Thanks,
> Bart

MBR, Sergei
