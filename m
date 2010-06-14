From: "alois.klingler@chello.at" <alois.klingler@chello.at>
Subject: Re: Fwd: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
 	- "dead" harddisc until reboot
Date: Mon, 14 Jun 2010 18:06:46 +0200
Message-ID: <4C165396.1020701@chello.at>
References: <4C114285.8050201@gmx.net>	<4C118A1B.3040206@gmail.com>	<4C127A9F.5070005@gmx.net> <AANLkTikhGHS6CkWJvxIbTxLWl6xDrfuttowtGLdzu8Ht@mail.gmail.com>
Reply-To: alois.klingler@chello.at
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fep27.mx.upcmail.net ([62.179.121.47]:30999 "EHLO
	fep27.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab0FNQZz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jun 2010 12:25:55 -0400
In-Reply-To: <AANLkTikhGHS6CkWJvxIbTxLWl6xDrfuttowtGLdzu8Ht@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: MadLoisae@gmx.net, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello Robert,

Robert Hancock wrote:
> On Fri, Jun 11, 2010 at 12:04 PM, MadLoisae@gmx.net <MadLoisae@gmx.net> wrote:
>   
>> Hello Robert,
>>
>> at this time I have not tried other UDMA-modes - the controller is udma133
>> able, the flashcard is udma66-able and the harddisc is (limited by the 44pin
>> cable) udma44-able. with legacy ATA I also use UDMA66 / UDMA44-modes.
>>     
>
> If it's a 40-pin cable, the max is UDMA33, not UDMA44. What happens if
> you force UDMA33 on both devices?
>
>   
yes it's a 40pin-cable to the 2.5" harddisc - i have now limited the 
speed to it to UDMA33, the CF-card is not attached to a limiting cable 
so I assume I can use there UDMA66?
With legacy-IDE I never hat problems using UDMA44 on this drive.
>> but perhaps this logs are another step in the right direction: my last
>> libata-crash looked like this:
>>
>> ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>> ata2.01: BMDMA stat 0x65
>> ata2.01: failed command: READ DMA
>> ata2.01: cmd c8/00:08:9f:03:41/00:00:00:00:00/f6 tag 0 dma 4096 in
>>        res 00/00:08:9f:03:41/00:00:00:00:00/f6 Emask 0x2 (HSM violation)
>>     
>
> This one complained because the bits in the status register read from
> the drive don't seem to make any sense (specifically none are set,
> when DRDY should be).
>
>   
>> ata2: soft resetting link
>> ata2.00: FORCE: xfer_mask set to udma4
>> ata2.01: FORCE: xfer_mask set to udma3
>> ata2.00: configured for UDMA/66
>> ata2.01: configured for UDMA/44
>> ata2.00: FORCE: xfer_mask set to udma4
>> ata2.01: FORCE: xfer_mask set to udma3
>> ata2.00: configured for UDMA/66
>> ata2.01: configured for UDMA/44
>> ata2: EH complete
>>     
>
> Does it resume operation after this?
>   
No, the machine was dead - after this messages normally my partitions 
get mounted ro, ext3/ext4 journaling is aborted and a lot of "bad 
sectors" are logged in dmesg. Then the only possibility is to power off 
/ power on or use sysrq-trigger to "reboot" it - but not always a 
console is open so normally I have to power off / on.
>   
>> until yet I have legacy-ata-logs found the look like the same - or at least
>> crap:
>>
>> hdd: ide_dma_sff_timer_expiry: DMA status (0x61)
>> hdd: dma_intr: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest
>> CorrectedError Index Error }
>> hdd: dma_intr: error=0x7f { DriveStatusError UncorrectableError
>> SectorIdNotFound TrackZeroNotFound AddrMarkNotFound },
>> LBAsect=8830587504648, sector=209806663
>> hdd: possibly failed opcode: 0x25
>> hdc: DMA disabled
>> hdd: DMA disabled
>> ide1: reset: success
>>
>> the logged LBAsect and also the logged sector are not existent on this drive
>> - but they are neither a harddisc-failure not a filesystem-failure - this
>> must be an ugly bug in this chipset or maybe just a communication-problem
>> between controller and harddisc. I have already changed cabeling, harddisc
>> (three times in the meanwhile! On my actual drive I did already with dd a
>> complete write - there were neither logged from kernel bad sectors nor smart
>> does show any pending sectors or reallocated sectors - the harddisc has no
>> problem), compact flash (also three times, already another manufacturer -
>> the flash is currently two month old, I will not belive that it is damaged,
>> altough i did only read-only tests), memory (altough I've tested it several
>> times with memtest) - if there is a hardware-failure it can only be the
>> IDE-controller which I cannot check.
>>
>> my idea: libata is not able to handle this issue in a way legacy-ide-driver
>> did - as logged the channel got reset, both drives are from now on in
>> PIO-mode, but i can manually set them to DMA again and it works "as good" as
>> before. with libata I am sure this were another reset-reason. Libata seems
>> to force always UDMA-mode after the reset - is there a possibility to
>> workaround?
>>
>> genereally the DMA-behaviour is from legacy-IDE much better in my opinion:
>> it's possible to set with hdparm in userspace the DMA-mode. libata des not
>> offer such a possibility, does it? So I have no possibility to control or
>> change the behaviour after boot, I have to hope that the fallback-mechanism
>> is good enough...
>>     
>
> libata doesn't currently offer a mechanism to control the DMA setting
> from userspace, no.
>
> It does seem like you're having some rather major communication
> problems on the bus - the error below seems to indicate that the DMA
> transfer stalled:
>
>   
Has libata not a fallback-mechanism to speak with the drive again?
Nevertheless I am again on libata with UDMA33 and I am trying if this 
helps. Thanks.
>> also I saw "harmless" IDE-communication-problems:
>>
>> hdd: ide_dma_sff_timer_expiry: DMA status (0x61)
>> hdd: DMA timeout error
>> hdd: dma timeout error: status=0x80 { Busy }
>> hdd: possibly failed opcode: 0x25
>> hdc: DMA disabled
>> hdd: DMA disabled
>> ide1: reset: success
>>
>> also after this reset I just enabled DMA, the machine is still running, no
>> reset necessary. What would libata do?
>>
>> any ideas? i am really desperate in the meanwhile. :'-(
>>
>> thanks!
>> Alois
