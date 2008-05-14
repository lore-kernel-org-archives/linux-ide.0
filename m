From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: sata_sx4 vs. Promise SX4060
Date: Wed, 14 May 2008 22:36:12 +0200
Message-ID: <482B4D3C.1000605@gmail.com>
References: <fvvkbr$h60$1@ger.gmane.org> <48246A92.2010501@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55453 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbYENUgb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 16:36:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JwNi3-0006nt-9v
	for linux-ide@vger.kernel.org; Wed, 14 May 2008 20:36:23 +0000
Received: from d83-183-214-201.cust.tele2.se ([83.183.214.201])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 14 May 2008 20:36:23 +0000
Received: from lasse.makholm by d83-183-214-201.cust.tele2.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 14 May 2008 20:36:23 +0000
In-Reply-To: <48246A92.2010501@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Lasse Makholm wrote:
[SNIP]
>> While I do know my way around Linux, C and a debugger, I'm still 
>> pretty blank when it comes ATA stuff... So any tips on where to go 
>> from here would highly appreciated...
> 
> Well, the hardware programming guide for SX4 is available at
> http://gkernel.sourceforge.net/specs/promise/

Cool! I've been chewing through a lot of this stuff over the past few 
days and I'm least starting to get some idea of what I'm messing with... :-)

I also browsed through your documentation on libata but it's still hard 
for me to grasp the information without having more of an overview of 
how it all works... I'm hoping that Essential Linux Device Drivers can 
help me out there but my copy hasn't arrived yet... :-)

> Can you post "lspci -vvv" entry for this device?  I'm betting that the 
> SX4060 BIOS information is merely echoing what is in the PCI BARs for 
> the PCI device.

Certainly...

00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20621 (FastTrak
S150 SX4/FastTrak SX4000 lite) (rev 01)
	Subsystem: Promise Technology, Inc. PDC20621 (FastTrak S150
SX4/FastTrak SX4000 lite)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at ed00 [size=256]
	Region 2: I/O ports at ec00 [size=256]
	Region 3: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Region 4: Memory at fe800000 (32-bit, non-prefetchable) [size=32K]
	Expansion ROM at fe700000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Looks like your assumption was correct...

As far as I understand it, the 64 MB on the DIMM is accessed one 32 KB 
page at a time through the area at fe800000. Is that correct?

> You could try commenting out the DIMM init stuff in the driver 
> completely, on the hope that BIOS configured it properly.

I tried adding an msleep_interruptible(10) for every MB written in the 
initialization loop and that seems to work pretty well... It still 
puzzles me a bit that the problem is there at all though... Is it 
reasonable that it takes so long to write those 64 MB?

By the way, is msleep_interruptible() always safe to call?

I was wondering why the init stuff is there at all... Is it to ensure 
that content of the SDRAM is aligned with the parity bits?

What exactly does this do:

	/* DIMM Initialization Select/Enable (bit 18/19) */
	data &= (~(1<<18));
	data |= (1<<19);
	writel(data, mmio + PDC_SDRAM_CONTROL);

I couldn't find any details about it in the PDC20621 programming guides, 
so I assume it's some basic memory-related knowledge that I don't have...

I also tried writing some test patterns into the memory in the init 
loop, reading them back out and comparing to the original (using 
pdc20621_put_to_dimm() and pdc20621_get_from_dimm())

u32 patterns[10] = {
	0xffffffff, 0xff00ff00, 0x00ff00ff, 0xf0f0f0f0, 0x0f0f0f0f,
	0xcccccccc, 0x33333333, 0xaaaaaaaa, 0x55555555, 0x00000000,
};

for (j = 0; j < 10; j++) {
	tmp = patterns[j];
	pdc20621_put_to_dimm(host, (void *) &tmp, addr, sizeof(u32));
	pdc20621_get_from_dimm(host, (void *) &tmp, addr, sizeof(u32));
	if (tmp != patterns[j])
		VPRINTK("Ouch! Addr 0x%08x: 0x%08x != 0x%08x\n",
			addr, tmp, patterns[j]);
}

...but that miserably failed... I suspect I'm missing something here... 
Any hints?

Why is a writel() always(?) followed by readl() by the way? Google 
hasn't been able to tell me that so far...

All commands (as opposed to just block transfers) are always copied to 
the onboard DIMM before being sent to an ATA port, correct?

The ATA_CMD_SET_FEATURES command still seems to be the main problem though:

[ 1115.001429] ata5.00: qc timeout (cmd 0xef)
[ 1115.001434] ata5.00: failed to set xfermode (err_mask=0x4)
[ 1115.001437] ata5.00: disabled

The error mask is AC_ERR_ATA_BUS but I don't have much of a clue as to 
why that happens yet...

> I've been the one getting Promise to release docs, but it's a slow 
> process that (literally) has taken years.
> 
> However, that said, they _do_ respond and _are_ interested.  You might 
> try promise_linux@promise.com and point out that the existing SX4 docs 
> are publicly released at http://gkernel.sourceforge.net/specs/promise/ 
> with the blessing of Chi and Sam @ Promise.

That's really good news. I think I'll poke around some more and try to 
get a feel for what I'm doing before I start bothering the nice folks at 
Promise though. But I'll definitely get in touch with you if/when I 
decide to write them...

>>  * Is it a correct assumption that the sata_sx4 driver knows nothing the
>>    various array configurations and that it will always just see 4
>>    independent drives, regardless of what arrays have been configured in
>>    the BIOS?
> 
> Correct.

...and is it then also correct that said knowledge about array configs 
is/belongs in the dmraid stuff?

>>  * Also, is there any (easy) way to choke debug output from some ATA
>>    devices, while keeping it for others? Apart from grep... :-)
> 
> Alas, not at present.
> 
> There is a half-finished infrastructure in libata, but messages need to 
> be moved over to it (ap->msg_enable).

OK. I might look into that... Is it lightyears from usable or would it 
be worth looking into?

>> I'd be happy to put in some time and effort in moving this forward but 
>> I probably won't make much progress need some pointers from some 
>> ATA-gurus...
> 
> If you are looking for generic ATA programming information, 
> http://ata.wiki.kernel.org/index.php/Developer_Resources tries to give 
> the basics.  Even if there is a broken link, you can usually google for 
> a filename to find a bazillion copies of the spec in question.

Ah, thanks... Nice to meet you, 900+ page ATA spec! :-)

Anyway, I've (again) been googling high and low in search of basic 
"bootstrapping" knowledge about this stuff and now that I've found at 
least some of it (I now know what a PRD is - yay!), I'm thinking that it 
could be helpful to others...

Would be an idea maybe to create a page or two on ata.wiki.kernel.org 
with e.g. terminology and other basic stuff?

/Lasse

