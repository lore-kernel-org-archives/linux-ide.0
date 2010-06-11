From: "MadLoisae@gmx.net" <MadLoisae@gmx.net>
Subject: Re: Fwd: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
 - "dead" harddisc until reboot
Date: Fri, 11 Jun 2010 20:04:15 +0200
Message-ID: <4C127A9F.5070005@gmx.net>
References: <4C114285.8050201@gmx.net> <4C118A1B.3040206@gmail.com>
Reply-To: MadLoisae@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43107 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754925Ab0FKSEU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Jun 2010 14:04:20 -0400
In-Reply-To: <4C118A1B.3040206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: MadLoisae@gmx.net, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello Robert,

at this time I have not tried other UDMA-modes - the controller is 
udma133 able, the flashcard is udma66-able and the harddisc is (limited 
by the 44pin cable) udma44-able. with legacy ATA I also use UDMA66 / 
UDMA44-modes.

but perhaps this logs are another step in the right direction: my last 
libata-crash looked like this:

ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata2.01: BMDMA stat 0x65
ata2.01: failed command: READ DMA
ata2.01: cmd c8/00:08:9f:03:41/00:00:00:00:00/f6 tag 0 dma 4096 in
         res 00/00:08:9f:03:41/00:00:00:00:00/f6 Emask 0x2 (HSM violation)
ata2: soft resetting link
ata2.00: FORCE: xfer_mask set to udma4
ata2.01: FORCE: xfer_mask set to udma3
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/44
ata2.00: FORCE: xfer_mask set to udma4
ata2.01: FORCE: xfer_mask set to udma3
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/44
ata2: EH complete

until yet I have legacy-ata-logs found the look like the same - or at 
least crap:

hdd: ide_dma_sff_timer_expiry: DMA status (0x61)
hdd: dma_intr: status=0x7f { DriveReady DeviceFault SeekComplete 
DataRequest CorrectedError Index Error }
hdd: dma_intr: error=0x7f { DriveStatusError UncorrectableError 
SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, 
LBAsect=8830587504648, sector=209806663
hdd: possibly failed opcode: 0x25
hdc: DMA disabled
hdd: DMA disabled
ide1: reset: success

the logged LBAsect and also the logged sector are not existent on this 
drive - but they are neither a harddisc-failure not a filesystem-failure 
- this must be an ugly bug in this chipset or maybe just a 
communication-problem between controller and harddisc. I have already 
changed cabeling, harddisc (three times in the meanwhile! On my actual 
drive I did already with dd a complete write - there were neither logged 
from kernel bad sectors nor smart does show any pending sectors or 
reallocated sectors - the harddisc has no problem), compact flash (also 
three times, already another manufacturer - the flash is currently two 
month old, I will not belive that it is damaged, altough i did only 
read-only tests), memory (altough I've tested it several times with 
memtest) - if there is a hardware-failure it can only be the 
IDE-controller which I cannot check.

my idea: libata is not able to handle this issue in a way 
legacy-ide-driver did - as logged the channel got reset, both drives are 
from now on in PIO-mode, but i can manually set them to DMA again and it 
works "as good" as before. with libata I am sure this were another 
reset-reason. Libata seems to force always UDMA-mode after the reset - 
is there a possibility to workaround?

genereally the DMA-behaviour is from legacy-IDE much better in my 
opinion: it's possible to set with hdparm in userspace the DMA-mode. 
libata des not offer such a possibility, does it? So I have no 
possibility to control or change the behaviour after boot, I have to 
hope that the fallback-mechanism is good enough...

also I saw "harmless" IDE-communication-problems:

hdd: ide_dma_sff_timer_expiry: DMA status (0x61)
hdd: DMA timeout error
hdd: dma timeout error: status=0x80 { Busy }
hdd: possibly failed opcode: 0x25
hdc: DMA disabled
hdd: DMA disabled
ide1: reset: success

also after this reset I just enabled DMA, the machine is still running, 
no reset necessary. What would libata do?

any ideas? i am really desperate in the meanwhile. :'-(

thanks!
Alois

Robert Hancock wrote:
> On 06/10/2010 01:52 PM, MadLoisae@gmx.net wrote:
>> Hi there,
>>
>> actually I am using kernel 2.6.34, up to now I was in every (stable)
>> release since 2.6.30 affected by this issue.
>> Today I have reactivated legacy, regrettably deprecated parallel ATA
>> support and have disabled libata. Its a shame, libata is much faster
>> (about 20% faster I/O measureable) and more forward-looking, but it is
>> not a real alternative if it crashes continuous but not reproduceable on
>> via-chipsets (google for this, the web is filled of this issue!). I
>> know, via chipsets are not very good, but shouldn't we try to make it
>> better (or at least best as possible) with newer drivers instead of 
>> worse?
>> I hope legacy ATA support won't be removed soon from the kernel 
>> sources ...
>>
>> I like trying out a lot, but if the response is so thin it does not make
>> fun just looking at the same issue with the same messages again and
>> again not able to do anything beside looking at it and resetting the box
>> afterwards ...
>
> Have you tried limiting the speed to UDMA2? If that helps then it 
> could be that the motherboard circuitry, etc. isn't suitable for 
> faster speeds.
>
> Random timeouts are unfortunately quite hard to debug since there's so 
> many problems that can cause them but the symptoms are the same: could 
> be that there was an error on the bus that caused something to stall, 
> an interrupt got lost somehow, etc. Or maybe the timing of device 
> access is somehow different and thus more likely to trigger whatever 
> the cause is. There also seem to be a fair number of bugs in these IDE 
> chipsets that the driver has to work around, could be there is one 
> missing in the libata version..
>

