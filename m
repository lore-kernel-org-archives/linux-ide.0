From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [RFC] ata/core: don't enable the interrupt while activating
 the host
Date: Wed, 7 Apr 2010 09:52:49 +0200
Message-ID: <20100407075249.GA6619@Chamillionaire.breakpoint.cc>
References: <20100311220417.GA16022@Chamillionaire.breakpoint.cc>
 <4BAAAEA1.9040906@kernel.org>
 <20100325220421.GA1051@Chamillionaire.breakpoint.cc>
 <4BABF7CE.6060908@kernel.org>
 <20100406094535.GA30917@Chamillionaire.breakpoint.cc>
 <4BBB0641.3040500@ru.mvista.com>
 <4BBBADFA.10903@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:53788 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751013Ab0DGHww (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2010 03:52:52 -0400
Content-Disposition: inline
In-Reply-To: <4BBBADFA.10903@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org

* Tejun Heo | 2010-04-07 06:56:10 [+0900]:

>On 04/06/2010 07:00 PM, Sergei Shtylyov wrote:
>>> ata_sff_check_status() does not report ATA_DRQ set so I don't know why
>>> the interrupt is comming.
>> 
>>   Perhaps the drive incorrectly triggers interrupt on setting the nIEN
>> bit -- some drives are known to do this; there is a blacklist of such
>> drives in the IDE core so that it avoids setting nIEN bit for them.
>
>Arghh.... that stinks.  Maybe we should port the list over?  What is
>the ATA device in question here?

[    1.257000] ata1.00: ATA-6: WDC WD1600PB-98FBA0, 15.05R15, max UDMA/100
[    1.264000] ata1.00: 312581808 sectors, multi 0: LBA48
[    1.269000] ata1.01: ATAPI: HL-DT-ST DVDRAM GSA-4081B, A100, max UDMA/33
[    1.335000] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600PB-98F 15.0 PQ: 0 ANSI: 5
[    1.387000] scsi 0:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4081B A100 PQ: 0 ANSI: 5

I try to unplug them later and see if the problem goes away once there
is no device.
I'm not really convinced that this the fault of the device. I just
booted the kernel that worked yesterday and I ended up in "no body
carred" irq storm. Hard reset, the same kernel and it worked. Two
reboots later and I had the "nobody cared" again. So I guess that the
irq line is active in every case but if the device (or the CPU) is fast
enough then I don't notice it. Later (after the first command or so) it
seems to get normal and issue the interrupt only if required.

Sebastian
