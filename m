From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/8] ide: add ide_set_irq() inline helper
Date: Tue, 08 Jul 2008 13:13:09 +0400
Message-ID: <48732FA5.4090003@ru.mvista.com>
References: <200711290104.21376.bzolnier@gmail.com> <48723A9B.6030309@ru.mvista.com> <48724BB0.3080008@ru.mvista.com> <200807072005.42187.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5753 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752768AbYGHJND (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Jul 2008 05:13:03 -0400
In-Reply-To: <200807072005.42187.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>

Bartlomiej Zolnierkiewicz wrote:

>>>   We're getting "ide0: unexpected interrupt, status=0x58, count=1" with 
>>>palm_bk3710 driver when running hdparm with option -X. That interrupt 
>>>has beenidentidied to occur while ide_driveid_update() waits for non-BSY 
>>>status polling the alt. status reg.  After looking at the code there, I 
>>>couldn't help wondering why I never saw that before with any other 
>>>controller since the code looked like it was bound to produce the 
>>>unexpected interrupts -- unless I'm missing something?..

>>     Ah, I know why: unexpected_intr() just is never called for PCI chips. 
>>Here's an related excerpt from ide_intr():

>>#ifdef CONFIG_BLK_DEV_IDEPCI
>>                 if (hwif->chipset != ide_pci)
>>#endif  /* CONFIG_BLK_DEV_IDEPCI */
>>                 {
>>                         /*
>>                          * Probably not a shared PCI interrupt,
>>                          * so we can safely try to do something about it:
>>                          */
>>                         unexpected_intr(irq, hwgroup);
>>#ifdef CONFIG_BLK_DEV_IDEPCI
>>                 } else {
>>                         /*
>>                          * Whack the status register, just in case
>>                          * we have a leftover pending IRQ.
>>                          */
>>                         (void) hwif->INB(hwif->io_ports.status_addr);
>>#endif /* CONFIG_BLK_DEV_IDEPCI */

> Yes, we may consider removing #ifdef-s and always calling unexpected_intr()
> (ide_driveid_update() needs fixing first though).

    I think these changes are orthogonal, i.e. the message won't pop up on PCI 
IDE chips whether #ifdef's are removed or not.

> Thanks,
> Bart

MBR, Sergei
