Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDEA21517A
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435201; cv=none; b=Hn/c5IfmmDkVBbg/hTVcGLR0Ba6AYA5Ae7tmlqNed+Z59OHbSaGzPF4VWHuzBitJAw8m7+6stVUyD1f/sBMJmsLGkOJ80PoHZ7Lf35ClawgkG4zb0a/yGJg9rWzP6DBf3rYUZ9jJgRwgENYcO+gBRKb+VBlvZBWT/rMGMYEJ0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435201; c=relaxed/simple;
	bh=N/uEicBOb+OFt6N9NbQAA5bg0P92buQcke6bFTTJjaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPKIMKP5Wq6UQgMOf0n+MG320rAnlYJE9sx/KZLWzoxkJs70GDToMiH0Xjnye7T0CUQ419wbIIpJ9YSFM0QjUo4shBVeowg8S+uMsf9lHOgprp/eP6LSOuBaiXbs/QURbnTvJxbvecKfVLsr7hnFI2pPQOFr5lgrUYgawAqBXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=DkxWkB8y; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="DkxWkB8y"
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 4B2E4BD152;
	Thu,  9 Jan 2025 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1736435194;
	bh=N/uEicBOb+OFt6N9NbQAA5bg0P92buQcke6bFTTJjaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DkxWkB8yMoZx9bECkJsMT6PeP2UC3jBmuAgIN7CJWnN58WiAB+SmnpEP6VIRwrhp2
	 SNdYB9mQJyJjZp5+Rptl2yBxxvRZYKPYPtfOLvxVBflPo4xiVlqzTzHdSbkJnkS1df
	 6ptwzPgnQo8tso1cfVGVwOi7MuU43NzdZhYbrzOg=
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id AD0412C022F;
	Thu,  9 Jan 2025 15:06:33 +0000 (GMT)
Message-ID: <b06afdf0-9fec-41cb-8dcb-346e33214409@philpem.me.uk>
Date: Thu, 9 Jan 2025 15:06:33 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear UNIT
 ATTENTION"
To: Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen> <0d1ec6ec-1938-419d-90ff-d4faf2ebaea6@suse.de>
 <8d8be593-51c5-4029-b310-a0d9082f5eaa@philpem.me.uk> <Z3_NjZyXSL9ymjIF@ryzen>
Content-Language: en-GB
From: Philip Pemberton <lists@philpem.me.uk>
In-Reply-To: <Z3_NjZyXSL9ymjIF@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/01/2025 13:22, Niklas Cassel wrote:
> On Thu, Jan 09, 2025 at 11:33:11AM +0000, Philip Pemberton wrote:
>> On 09/01/2025 07:17, Hannes Reinecke wrote:
>>> Which makes me wonder: does the SATA-to-PATA support ATAPI? It has been
>>> removed from recent ATA specifications, so there's a chance the bridge
>>> simply doesn't implement it ...
>>
>> It seems to -- if I use the SATA-to-PATA adapter to put the drive in the
>> Knoppix PC, the Zip drive works fine.
> 
> Which SATA-to-PATA adapter are you using?

I've tried two, listed in the OP.

One is a Startech PATA2SATA3 which uses a Sunplus SPIF223A chip
The other is a cheap unbranded one from ebay. Even the converter chip is 
unbranded! It says "IDE/SATA DOF B77CSOF41" on the chip.


> Perhaps that computer (which was running a v3.x kernel) is using a different
> SATA controller/driver, which has better ATAPI support?

Could be.

I just tried a CD-ROM drive on the unbranded adapter, on the machine 
running Mint. It was detected fine:

[81482.308980] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[81482.336950] ata3.00: FORCE: horkage modified (atapi_dmadir)
[81482.336955] ata3.00: FORCE: horkage modified (dump_id)
[81482.336958] ata3.00: FORCE: horkage modified (nodmalog)
[81482.336959] ata3.00: FORCE: horkage modified (noncq)
[81482.336969] ata3.00: ATAPI: TSSTcorpCD/DVDW TS-H552L, 0614, max 
UDMA/33, DMADIR
[81482.336973] ata3.00: applying bridge limits
[81482.336975] ata3.00: FORCE: xfer_mask set to pio0
[81482.379528] ata3.00: dumping IDENTIFY data, class=3 may_fallback=1 
tried_spinup=0
[81482.379536] 00000000: 85c0 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379540] 00000010: 0000 0000 2020 2020 2020 2020 2020 2020  .... 

[81482.379543] 00000020: 2020 2020 2020 2020 0000 0000 0000 3036 
  ......60
[81482.379546] 00000030: 3134 2020 2020 5453 5354 636f 7270 4344  41 
STTSocprDC
[81482.379549] 00000040: 2f44 5644 5720 5453 2d48 3535 324c 2020  D/DV 
WSTH-55L2
[81482.379552] 00000050: 2020 2020 2020 2020 2020 2020 2020 0000 
        ..
[81482.379554] 00000060: 0000 0f00 0000 0200 0200 0006 0000 0000 
................
[81482.379557] 00000070: 0000 0000 0000 0000 0000 0000 0000 0407 
................
[81482.379560] 00000080: 0003 0078 0078 00e3 0078 0000 0000 0000 
..x.x...x.......
[81482.379563] 00000090: 0000 0000 0000 0000 0002 0000 0000 0000 
................
[81482.379566] 000000a0: 0000 0000 0000 4000 4000 0000 0000 4000 
.......@.@.....@
[81482.379568] 000000b0: 0007 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379571] 000000c0: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379574] 000000d0: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379577] 000000e0: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379579] 000000f0: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379582] 00000100: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379585] 00000110: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379588] 00000120: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379591] 00000130: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379593] 00000140: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379596] 00000150: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379599] 00000160: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379602] 00000170: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379604] 00000180: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379607] 00000190: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379610] 000001a0: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379613] 000001b0: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379615] 000001c0: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379618] 000001d0: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379621] 000001e0: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379624] 000001f0: 0000 0000 0000 0000 0000 0000 0000 0000 
................
[81482.379632] ata3.00: configured for PIO0
[81482.473195] scsi 2:0:0:0: CD-ROM            TSSTcorp CD/DVDW TS-H552L 
0614 PQ: 0 ANSI: 5
[81482.603033] sr 2:0:0:0: [sr1] scsi3-mmc drive: 8x/40x writer cd/rw 
xa/form2 cdda tray
[81482.644073] sr 2:0:0:0: Attached scsi CD-ROM sr1
[81482.644195] sr 2:0:0:0: Attached scsi generic sg12 type 5

The disc mounted and read fine too.

Given that it works with the TSST DVD drive - I think it's safe to say 
the incompatibility is related specifically to the Zip drive, not ATAPI 
in general.


> Do you have the:
> [ 4465.218535] ata3.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max
> PIO3, CDB intr, DMADIR
> [ 4465.225787] ata3.00: configured for PIO0
> 
> prints from that other PC running v3.x kernel?

It's not particularly interesting -- just the drive being detected and 
configured.

[    1.413561] ata1.00: FORCE: horkage modified (noncq)
[    1.413587] ata1.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max 
PIO3, CDB intr
[    1.413593] ata1.00: applying bridge limits
[    1.426990] ata1.00: configured for PIO3
[    1.433652] scsi 0:0:0:0: Direct-Access     IOMEGA   ZIP 100 
12.A PQ: 0 ANSI: 5
[    1.434333] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.436371] scsi 1:0:0:0: CD-ROM            ATAPI    iHAS124   B 
AL0S PQ: 0 ANSI: 5
[    1.437890] sd 0:0:0:0: [sda] Attached SCSI removable disk


> E.g. DMADIR can be automatically detected, if it is needed based on the
> returned data in the IDENTIFY PACKET response, see:
> https://www.mail-archive.com/linux-ide@vger.kernel.org/msg16469.html
> https://www.spinics.net/lists/linux-ide/msg01514.html
> 
> The DMADIR print will only be there if we send an explicit DMA direction
> with each command.
> 
> It would be interesting to see if it was there on your older kernel.

I don't see any mention of DMADIR.


> Also your device seems to only indicate support for PIO3, thus we see it
> being configured for PIO. Thus, it seems that you are using PIO instead
> of DMA. I think that DMADIR only matters when using a DMA mode and not PIO.
> 
> Forcing DMADIR=1 when your device only supports PIO, feels wrong to me,
> but perhaps I am missing something. Also, why is your device only being
> configured for PIO0 when it seems to support up to PIO3 speeds? Bug?

No, I forced the mode to PIO0 (slowest mode) - see the kernel command 
line I included in my previous message. It included a libata.force 
command which set NONCQ, DMADIR and PIO0.

I wanted to rule out issues on the PATA side of things once I found out 
about the timing bug the drives have on VIA PATA controllers.

It's not like Zip drives are particularly fast anyway - usually about 
500kbytes/sec. PIO Mode 0 (3.3MB/s) is more than fast enough, but I 
guess going as far as PIO Mode 3 (11.1MB/s) reduces transfer latency. At 
only 500KB/s it needs all the help it can get...


> E.g. my print when using QEMU + ATAPI:
> [    0.647370] ata2: SATA max UDMA/133 abar m4096@0xfebd2000 port 0xfebd2180 irq 90 lpm-pol 0
> [    0.966896] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    0.971060] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [    0.971818] ata2.00: applying bridge limits
> [    0.972918] ata2.00: configured for UDMA/100
> shows that the device supports up to UDMA/100, and later we also see that
> we configure it for that speed.

The TSST can do UDMA/33 according to its datasheet, so I could remove 
the libata.force line from my kernel command line and re-test if you 
wanted to know how the adapter handled UDMA.

Thanks for the details on command tracing - I'll try that in a moment 
and report back.

Thanks.
-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
