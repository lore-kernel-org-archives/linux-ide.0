From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: [git patches] libata updates - (improve post-reset
 device ready test) regression
Date: Fri, 09 May 2008 11:57:18 +0900
Message-ID: <4823BD8E.40109@gmail.com>
References: <20080506154847.GA15299@havoc.gtf.org> <20080507145616.GA2210@gentoox2.trippelsdorf.de> <48231DAF.7070900@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758882AbYEIC5m@vger.kernel.org>
In-Reply-To: <48231DAF.7070900@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, marc.c.dionne@gmail.com, dl9pf@gmx.de, bug-track@fisher-privat.net, sitsofe@yahoo.com
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Markus Trippelsdorf wrote:
>>> Tejun Heo (12):
>>>       libata: improve post-reset device ready test
>>
>> This commit (78ab88f04f44bed566d51dce0c7cbfeff6449a06) causes a long
>> boot delay with my onboard Promise controller. It seems like libata
>> probes for a nonexisting PATA drive...
>>
>> ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 18
>> scsi0 : sata_promise
>> scsi1 : sata_promise
>> scsi2 : sata_promise
>> ata1: SATA max UDMA/133 mmio m4096@0xfb600000 port 0xfb600200 irq 18
>> ata2: SATA max UDMA/133 mmio m4096@0xfb600000 port 0xfb600280 irq 18
>> ata3: PATA max UDMA/133 mmio m4096@0xfb600000 port 0xfb600300 irq 18
>> ata1: SATA link down (SStatus 0 SControl 300)
>> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata2.00: ATA-7: SAMSUNG HD753LJ, 1AA01109, max UDMA7
>> ata2.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 0/32)
>> ata2.00: configured for 
>> UDMA/133                                                                                          
>> ata3: link is slow to respond, please be patient (ready=0)
>> ata3: device not ready (errno=-16), forcing hardreset
>> ata3: link is slow to respond, please be patient (ready=0)
>> ata3: SRST failed (errno=-16)
>> ata3: link is slow to respond, please be patient (ready=0)
>> ata3: SRST failed (errno=-16)
>> ata3: link is slow to respond, please be patient (ready=0)
>> ata3: SRST failed (errno=-16)
>>   - Last output repeated twice -
>> ata3: reset failed, giving up
> 
> Does the attached patch fix things?
> 
> It basically reverts the patch, while still maintaining the 
> consolidation.  It looks like that status evaluation is not as universal 
> as believed.

This means that we need to make custom readiness tests for controllers 
using 0x77 or 0x7f.  Eeeek... Both groups of controllers are behaving in 
incorrect way.  Controllers shouldn't use 0x77 or 0x7f for either busy 
or ready states - it's invalid for both, yet, some use the 77/7f for 
busy while others use them for ready state.  Great.  :-(

Jeff, can you please revert 78ab88f04f44bed566d51dce0c7cbfeff6449a06 for 
now?  I'll post updated patch.

Markus, Alexey, Marc, which controllers are you using?

Thanks.

-- 
tejun
