Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D11328B6
	for <linux-ide@vger.kernel.org>; Thu, 23 Jan 2025 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649189; cv=none; b=JTAVD7AU446tol4YzaExtU1j32ktsjc8By4R3TGTDBh4nm0r7zbzDxballmdFISgKTfAKCmrAOODHb7d9mlyuMTrhGL7gt0Qk5mhdwPLqgNdC2XefdS9LPsFxT17AuSaUlXdUUO5O/gk3M9XJMRs0kibiNT+2VR/GDhwriaeVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649189; c=relaxed/simple;
	bh=pUPrlrlZhKi+HzPjESVXRPXtmt8XkN47jFW5d0/Xu2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJKJQ0Y1dPH8tzNACGxCKmUoHRE2fIHI1P1MUBipnc2DetsOsp1hd4apCWd4pBVKpvqdw0SJIHpcTL63BbJKNeW2WfkVh4dOBGpRXJok3YN8SquSLgcX3zZs02eRM42K4ByA0jAZvzcX3nJc9ry53OMkj8Q9M1nUQn04tNWRMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=ekJ4YS1I; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="ekJ4YS1I"
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 023D4BD09B;
	Thu, 23 Jan 2025 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1737649185;
	bh=pUPrlrlZhKi+HzPjESVXRPXtmt8XkN47jFW5d0/Xu2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ekJ4YS1IJpawiRtsV4wT4YJQ2Mvqd2QkgsssNIjMD4bvgQepAVtxHnWxB1aQODfCX
	 UKZSwaeye7hKG6OKiD+A4n44xFgEPa8xWYop89RI//y3u7XqScEtFvf+im9p+OY8wG
	 5WGVdfOEjq2wGpZd/bnei+liifPTCwMFcPKNDPQs=
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 6A8C32C0173;
	Thu, 23 Jan 2025 16:19:44 +0000 (GMT)
Message-ID: <2bb1510c-c42f-468b-a8cb-70603bee846b@philpem.me.uk>
Date: Thu, 23 Jan 2025 16:19:44 +0000
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
Cc: linux-ide@vger.kernel.org
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen> <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
 <Z3-_dt0m_2UrtKon@ryzen> <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
 <Z4pdD1Z2mJnF7N3O@ryzen>
Content-Language: en-GB
From: Philip Pemberton <lists@philpem.me.uk>
In-Reply-To: <Z4pdD1Z2mJnF7N3O@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niklas,

I've reproduced the issue on an Intel based board (an Asus ROG Rampage 
Formula with a Q

I tested with the following Debian kernels --

vmlinuz-6.10.11+bpo-686-pae   (bookworm)
vmlinuz-6.1.0-30-686-pae      (bookworm)
vmlinuz-5.10.0-0.deb10.30-686 (buster)
vmlinuz-4.19.0-27-686-pae     (buster)

This is with no libata related options on the kernel command line:

[    0.062948] Kernel command line: 
BOOT_IMAGE=boot/vmlinuz-4.19.0-27-686-pae root=/dev/nfs 
nfsroot=10.0.0.32:/mnt/zfs/debian-nfs-boot,rw ip=dhcp 
initrd=boot/initrd.img-4.19.0-27-686-pae

Here is the output from the 4.19 kernel when it tries to initialise the 
Zip drive:

> [    2.549684] scsi host0: ahci
> [    2.550052] scsi host1: ahci
> [    2.550260] scsi host2: ahci
> [    2.550474] scsi host3: ahci
> [    2.550692] scsi host4: ahci
> [    2.550905] scsi host5: ahci
> [    2.551061] ata1: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffe900 irq 26
> [    2.551133] ata2: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffe980 irq 26
> [    2.551204] ata3: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffea00 irq 26
> [    2.551275] ata4: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffea80 irq 26
> [    2.551346] ata5: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffeb00 irq 26
> [    2.551417] ata6: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffeb80 irq 26
> [    2.863069] ata1: SATA link down (SStatus 0 SControl 300)
> [    3.041029] firewire_core 0000:05:03.0: created device fw0: GUID 001e8c0000b2df93, S400
> [    3.175068] ata2: SATA link down (SStatus 0 SControl 300)
> [    3.648939] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    3.651027] ata3.00: ATA-8: WDC WD1001FALS-00E3A0, 05.01D05, max UDMA/133
> [    3.651084] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    3.653455] ata3.00: configured for UDMA/133
> [    3.653693] scsi 2:0:0:0: Direct-Access     ATA      WDC WD1001FALS-0 1D05 PQ: 0 ANSI: 5
> [    4.128939] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    4.135599] ata4.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max PIO3, CDB intr
> [    4.135671] ata4.00: applying bridge limits
> [    4.142464] ata4.00: configured for PIO3
> [    9.216983] ata4.00: qc timeout (cmd 0xa0)
> [    9.217040] ata4.00: failed to clear UNIT ATTENTION (err_mask=0x5)
> [    9.692938] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    9.706493] ata4.00: configured for PIO3
> [   14.848995] ata4.00: qc timeout (cmd 0xa0)
> [   14.849051] ata4.00: failed to clear UNIT ATTENTION (err_mask=0x5)
> [   14.849107] ata4.00: limiting speed to PIO2
> [   15.324938] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   15.338347] ata4.00: configured for PIO2
> [   20.480928] ata4.00: qc timeout (cmd 0xa0)
> [   20.480984] ata4.00: failed to clear UNIT ATTENTION (err_mask=0x5)
> [   20.481039] ata4.00: disabled
> [   20.956939] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

The messages are the same (albeit with different timings) on every 
kernel up to and including 6.10.11+bpo-686-pae.

I can try and go back earlier if it would help.

If it helps any (see my previous message for more), the ata_piix driver 
on an Intel ICH5 Northbridge + 82801EB Southbridge (Aopen EZ65 board) 
seems to work fine on the exact same kernels (literally the same binaries).

32/64 bit seems not to be a contributing factor as the AMD B550 machine 
is fully 64-bit (userspace and kernel) and boots via UEFI.

Thanks,
Phil.


On 17/01/2025 13:37, Niklas Cassel wrote:
> Hello Philip,
> 
> On Thu, Jan 09, 2025 at 03:31:05PM +0000, Philip Pemberton wrote:
>> (Repeating myself here, ata4 / ata_port=4 is the DVD drive; ata_port=3 is
>> the Zip drive)
>>
>> There's quite a lot on the ATA buses, so if it helps --
>>    ata1: Samsung 860 SSD
>>    ata2: WD 500GB mechanical hard drive
>>    ata3: Spare port / Zip drive
>>    ata4: DVD writer
>>    ata5: Not used
>>    ata6: Not used
>>
>> There are a couple of SATA disks and a SAS tape drive on an LSI SAS card but
>> they seem to go through the "scsi" and "mpt2sas" driver route.
>>
>>
>>> Note that for ATAPI, it also looks like your SATA driver needs special support.
>>> See e.g. libahci.c which does a bunch of extra stuff if it is an ATAPI device,
>>> e.g.:
>>> https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libahci.c#L1699-L1702
>>> https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libahci.c#L1638-L1643
>>>
>>> Same for the libata-sff driver:
>>> https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L2672-L2684
>>> https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L295-L297
>>> https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L687-L715
>>>
>>>
>>> Which SATA driver are you using?
>>
>> It looks like it's "ahci" or "libahci".
>>
>>
>>> Are you saying that it does come up and work eventually?
>>>
>>> When we see the "disable device" print, it is usually a sign that we have
>>> given up, and thus remove the device.
>>
>> No, it tries to connect three times, then gives up and disables the device.
> 
> Unfortunately, so far I do not think that we have enough information to
> do much about this issue.
> 
> We know that the "SATA-to-PATA adatper + Zip drive" combo worked on some
> other PC (that might have used another SATA HBA) with an ancient kernel.
> 
> I think my first recommendation would be to try to build an ancient kernel
> on your current PC, and see if the same "SATA-to-PATA adatper + Zip drive"
> combo then works. If it does work, then I think the best bet is to use
> PCI passthrough and do an git bisection (which can be automated).
> 
> Or, do the opposite, see if the latest kernel with other PC still handles
> the Zip drive properly, if it doesn't, then perhaps the best thing is to
> to the bisection on this other PC.
> 
> You could look at this guide for inspiration:
> https://github.com/floatious/qemu-bisect-doc
> 
> 
> Kind regards,
> Niklas
> 

-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
