From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: sata_promise SATA300TX4 "intermittent problems"
Date: Thu, 08 Mar 2007 17:26:37 +0100
Message-ID: <45F0393D.80301@how.dk>
References: <45EECD12.1000506@how.dk> <17903.7366.875191.751728@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepc.post.tele.dk ([195.41.46.237]:38156 "EHLO
	pfepc.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbXCHQ0k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 11:26:40 -0500
In-Reply-To: <17903.7366.875191.751728@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Hi Mikael,

Thanks for the reply, I've commented below:

Mikael Pettersson wrote:
> SErr 0x01380000 would indicate:
> transport state transmission error (bit 24)
> CRC error (bit 21)
> disparity error (bit 20) [whatever that is]
> 10b_to_8b decoding error (bit 19)
> 
> I.e., serious transmission issues.

:-)

> > [52849.930755] pdc_error_intr: port_status 0x00001000 serror 0x00000000
> > [52849.930880] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
> > frozen
> > [52849.930883] ata2.00: (port_status 0x00001000)
> 
> "host bus timeout error" (bit 12).
> I wonder why SError was clear now.

I can't say - this whole ata thing is much too complex for me ;-)

> > I would be very happy to help debug this issue. Any suggestions on what 
> > I should try next?
> 
> Well, at the moment I have only one possible cure: to forcibly
> limit 3Gbps drives to 1.5Gbps operation, as the patch below does.

I haven't tried your 1.5Gbps patch (yet). But I have been running more 
tests on my experiment system with the kernels I have handy. My 
procedure is as follows:

1. power cycle
2. boot selected kernel
3. start dd if=/dev/sdx of=/dev/null bs=1M for x=a,b,c,d
4. wait until one fails
5. record dmesg output

So far here are my results:

2.6.18.1 fails (in 25 minutes)
2.6.19   fails (in 4 minutes)
2.6.19.2 fails (in 5 minutes)
2.6.20.1 fails (in 48 minutes)
2.6.21-rc2+p (with additional patches) doesn't fail

This is very consistent. 2.6.21-rc2+p has been tested for more than 10 
hours without a hickup :-)

In the above tests it is always ata3 or ata4 (sdc or sdd) which fails.

Another strange thing which happens on 2.6.21-rc2+p but not the other 
kernels: using smartctl -a -d ata while dd is running gives errors (I 
also mentioned this in my first mail, but wasn't sure then):

[11046.005178] pdc_error_intr: port_status 0x00001000 serror 0x00000000
[11046.005286] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[11046.005374] ata4.00: (port_status 0x00001000)
[11046.005383] ata4.00: cmd 25/00:00:00:3b:a0/00:01:27:00:00/e0 tag 0 
cdb 0x0 data 131072 in
[11046.005385]          res 50/00:00:ff:3b:a0/00:00:00:00:00/e0 Emask 
0x4 (timeout)
[11046.313769] ata4: soft resetting port
[11046.469806] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[11046.496254] pdc_error_intr: port_status 0x00001000 serror 0x00000000
[11046.496580] ata4.00: failed to set xfermode (err_mask=0x104)
[11046.496585] ata4: failed to recover some devices, retrying in 5 secs
[11051.495393] ata4: hard resetting port
[11051.971276] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[11052.005267] ata4.00: configured for UDMA/133
[11052.005285] ata4: EH complete
[11052.042615] SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
[11052.051769] sdd: Write Protect is off
[11052.051778] sdd: Mode Sense: 00 3a 00 00
[11052.059455] SCSI device sdd: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[11052.066354] SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
[11052.070822] sdd: Write Protect is off
[11052.070830] sdd: Mode Sense: 00 3a 00 00
[11052.073297] SCSI device sdd: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA

Then it recovers and dd continues :-)

Note that using smartctl this way on the other kernels does not show 
this problem!

> On one of my test machines (an old UltraSPARC), a SATA300 TX2plus
> with a Seagate 3Gbps drive (don't have the model number handy),
> will quickly experience "DMA S/G overrun" errors during an fsck
> of a large but clean ext3 partition. With the patch below things
> work solidly on that particular machine. OTOH, on another test
> machine (a 440BX chipset Intel PIII), the same card/cable/disk
> combination works flawlessly at 3Gbps. Mysterious.

My feeling is this is not caused by 1.5Gbps or 3.0Gbps operation.

I was thinking about adding the speed selections jumpers on the 
harddrives, but so far I'm not touching the system as I don't want 
hardware problems (e.g. a loose cable) disturbing the test results. I'll 
stick to replacing software.

My next test will be a plain 2.6.21rc2. Then I'll apply the patches one 
by one.

One thought is this could be a bug/race condition which only shows under 
certain lucky circumstances - maybe the robustness of 2.6.21-rc2+p is 
due to local-apic not being enabled or some other subtle kernel build thing?

Any suggestion on what I could do to help track this down is much 
appreciated?

Best regards,

Peter Favrholdt

