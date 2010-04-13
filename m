From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [RFC] ata/core: don't enable the interrupt while activating
 the host
Date: Tue, 13 Apr 2010 16:38:12 +0200
Message-ID: <20100413143812.GB21999@Chamillionaire.breakpoint.cc>
References: <20100311220417.GA16022@Chamillionaire.breakpoint.cc>
 <4BAAAEA1.9040906@kernel.org>
 <20100325220421.GA1051@Chamillionaire.breakpoint.cc>
 <4BABF7CE.6060908@kernel.org>
 <20100406094535.GA30917@Chamillionaire.breakpoint.cc>
 <4BBB0641.3040500@ru.mvista.com>
 <4BBBADFA.10903@kernel.org>
 <20100407075249.GA6619@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:55556 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752133Ab0DMOiR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Apr 2010 10:38:17 -0400
Content-Disposition: inline
In-Reply-To: <20100407075249.GA6619@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Tejun Heo <tj@kernel.org>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org

* Sebastian Andrzej Siewior | 2010-04-07 09:52:49 [+0200]:

>>>   Perhaps the drive incorrectly triggers interrupt on setting the nIEN
>>> bit -- some drives are known to do this; there is a blacklist of such
>>> drives in the IDE core so that it avoids setting nIEN bit for them.
>>
>>Arghh.... that stinks.  Maybe we should port the list over?  What is
>>the ATA device in question here?
>
>[    1.257000] ata1.00: ATA-6: WDC WD1600PB-98FBA0, 15.05R15, max UDMA/100
>[    1.264000] ata1.00: 312581808 sectors, multi 0: LBA48
>[    1.269000] ata1.01: ATAPI: HL-DT-ST DVDRAM GSA-4081B, A100, max UDMA/33
>[    1.335000] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600PB-98F 15.0 PQ: 0 ANSI: 5
>[    1.387000] scsi 0:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4081B A100 PQ: 0 ANSI: 5
>
>I try to unplug them later and see if the problem goes away once there
>is no device.
This is odd:
- a different HD & CD-ROM => seems to work
- just this CD-ROM => IRQ storm
- just the HD => 
 [    6.109000] ata1: link is slow to respond, please be patient (ready=0)
 [   11.113000] ata1: device not ready (errno=-16), forcing hardreset
 [   16.319000] ata1: link is slow to respond, please be patient (ready=0)
 [   21.170000] ata1: SRST failed (errno=-16)
 [   26.374000] ata1: link is slow to respond, please be patient (ready=0)
 [   31.174000] ata1: SRST failed (errno=-16)
 [   36.378000] ata1: link is slow to respond, please be patient (ready=0)
- this HD nad other CD-ROM => seems to work

The "odd" HD seems to work on X86 however the boot process gets delayed
by like 30 seconds. The CD-ROM seems not show any side effects.

So I fixed this problem by replacing the HD. Thanks for the pointers :)

Sebastian
