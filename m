From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil boot failure with 2.6.35
Date: Mon, 23 Aug 2010 12:28:14 +0200
Message-ID: <4C724D3E.50404@kernel.org>
References: <4C6EC878020000780001146D@vpn.id2.novell.com> <4C6ED603.9020602@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41727 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531Ab0HWKdW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2010 06:33:22 -0400
In-Reply-To: <4C6ED603.9020602@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jan Beulich <JBeulich@novell.com>, jgarzik@redhat.com, linux-ide@vger.kernel.org

Hello,

On 08/20/2010 09:22 PM, Jeff Garzik wrote:
> On 08/20/2010 12:24 PM, Jan Beulich wrote:
>> on one of my systems (the only one with that sort of controller) boot
>> fails with .35 due to an identify failure for the drive that has the root
>> partition (and others):
>>
>> libata version 3.00 loaded.
>> sata_sil 0000:00:12.0: version 2.4
>> sata_sil 0000:00:12.0: enabling device (0005 ->  0007)
>>    alloc irq_desc for 22 on node -1
>>    alloc kstat_irqs on node -1
>> sata_sil 0000:00:12.0: PCI INT A ->  GSI 22 (level, low) ->  IRQ 22
>> scsi0 : sata_sil
>> scsi1 : sata_sil
>> ata1: SATA max UDMA/100 mmio m512@0xc0000000 tf 0xc0000080 irq 22
>> ata2: SATA max UDMA/100 mmio m512@0xc0000000 tf 0xc00000c0 irq 22
>> input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input1
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata1.00: NODEV after polling detection
>> ata2: SATA link down (SStatus 0 SControl 300)
>>
>> With some debugging printk-s added I found that "status" as passed
>> from ata_sff_pio_task() to ata_sff_hsm_move() is 0x50 (instead of
>> the expected 0x58), and I also found that adding a certain delay
>> at the top of ata_sff_pio_task() for just the very first invocation
>> makes the problem go away: putting udelay(400) there works,
>> while udelay(300) isn't sufficient.
>>
>> 2.6.34.x is working fine.
>>
>> The controller is reported as
>>
>> 00:12.0 IDE interface [0101]: ATI Technologies Inc IXP SB400 Serial ATA Controller [1002:4379]
>>
>> Thanks for any hints towards debugging or resolving this problem.
> 
> sata_sil has been stable for a while, for most people.  The only post-2.6.34 major changes to sata_sil's operations are the SFF/BMDMA separation changes, AFAICT.
> 
> Unfortunately, that's a very large patch series, with no easy "try to revert <this>" point.  Is there any chance you can bisect this?

This apparently is not an isolated case.

  https://bugzilla.kernel.org/show_bug.cgi?id=16606

For some reason, the NODEV detection is getting triggered spuriously
which is really strange given that that part of code has been *really*
stable for very long time now.  Jan, can you please apply the
following patch and attach the kernel log?

  https://bugzilla.kernel.org/attachment.cgi?id=27513

Thanks.

-- 
tejun
