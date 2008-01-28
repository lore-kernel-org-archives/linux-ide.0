From: "dusty@gmx.li" <dusty@gmx.li>
Subject: Re: libata pm
Date: Mon, 28 Jan 2008 10:31:58 -0000 (UTC)
Message-ID: <51861.82.140.47.248.1201516318.squirrel@ssl.cavemail.org>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>      
    <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>      
    <479BC34D.2000007@gmail.com>   
    <49407.82.140.63.93.1201397926.squirrel@ssl.cavemail.org>
    <49713.82.140.63.93.1201462475.squirrel@ssl.cavemail.org>
    <479D2D3C.4050102@gmail.com>
Reply-To: dusty@gmx.li
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavemail.org ([62.75.189.85]:48466 "EHLO mail.cavemail.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbYA1KcK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 05:32:10 -0500
In-Reply-To: <479D2D3C.4050102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: dusty@gmx.li, linux-ide@vger.kernel.org

Hello,

Am Mo, 28.01.2008, 01:17, schrieb Tejun Heo:
> Hello,
>
>
> dusty@gmx.li wrote:
>> With one, two and three drives on the pm I got no errors, so I tried to
>>  change the power supply. I got two power supplies for the 16
>> harddrives and the second one (with all Maxtor drives and the first pm)
>> was failing. After changing the power supply all problems where gone.
>> Sorry for the
>> confusion.
>
> It's amazing that, in SATA, PSU-problem-verified / PSU-problem-suggested
> ratio is significant.  I don't think this ever was the case with PATA. SATA
> link seems much more susceptible to power quality and allows hooking up
> whole lot of drives.
>
>
>> The only remaining issue is that some sata links are only working with
>> 1.5
>> gbps and I can't figure out why. (ata3,4,5,6.x are the Maxtor drives and
>>  ata7,8,9,10.x are the Samsung ones)
>>
>
> Hmm... That's how the hardware negotiated transfer rate w/ each other.
> SControl is telling the hardware that there's no speed limit and to go
> as high as it can but somehow 3.0Gbps negotiation failed and the link speed
> is limited to 1.5Gbps for some of the ports.  Is the result always the
> same?  What happens if you swap drives between ports?  Also, if you have
> an extra PSU lying around, can you hook it up with some of the drives such
> that the load is more distributed.
>
> Oh.. Another note on PSU.  I don't know whether this still holds for
> more recent ones but mid-to-high range multi-lane PSUs sometimes have
> lesser juice on 12v rail available for disks than low cost single lane
> PSUs.  This is because high power 12v lanes are allocated to power video
> cards and disks can only pull power from (usually) single weak 12v lane.
>
> Thanks.
>
>
> --
> tejun
>
>

Shuffling the drives did not change anything to the linkspeed of the 3
ports running with 1.5 Gbps. Looks like the problem is port-related.
The first PSU (Multilane) offers (measured) 12,20 V on both lanes. This
falls during read/write access on all drives attached down to 12,10 V.
The second PSU (Singlelane) offers (measured) 11,75 V. This doesn't change
during read/write access on all drives attached. I tested the second PSU
without anything attached and it still offered 11,75 V.

I will try to add another PSU this evening and remeasure.
Currently the whole machine needs about 350W.
The PSUs are Targan 500W (Multilane - 2x12V 10A) and Noname 350W
(Singlelane - 1x12V 10A) so this 'should' be enough...

This night i copied the backup back to the first raid (the Maxtor drives)
without any error but during the transfer i got this on the second
(mounted but unused) raid:
ata10.00: failed to read SCR 1 (Emask=0x40)
ata10.01: failed to read SCR 1 (Emask=0x40)
ata10.02: failed to read SCR 1 (Emask=0x40)
ata10.03: failed to read SCR 1 (Emask=0x40)
ata10.04: failed to read SCR 1 (Emask=0x40)
ata10.05: failed to read SCR 1 (Emask=0x40)
ata10.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.02: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 1 cdb 0x0 data 0
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata10.02: status: { DRDY }
ata10.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.15: hard resetting link
ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.00: hard resetting link
ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.01: hard resetting link
ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.02: hard resetting link
ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.03: hard resetting link
ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.04: hard resetting link
ata10.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.05: hard resetting link
ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.00: configured for UDMA/100
ata10.01: configured for UDMA/100
ata10.02: configured for UDMA/100
ata10.03: configured for UDMA/100
ata10.04: configured for UDMA/100
ata10: EH complete
sd 9:0:0:0: [sdp] 976773168 512-byte hardware sectors (500108 MB)
sd 9:0:0:0: [sdp] Write Protect is off
sd 9:0:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:1:0:0: [sdq] 976773168 512-byte hardware sectors (500108 MB)
sd 9:1:0:0: [sdq] Write Protect is off
sd 9:1:0:0: [sdq] Mode Sense: 00 3a 00 00
sd 9:1:0:0: [sdq] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:2:0:0: [sdr] 976773168 512-byte hardware sectors (500108 MB)
sd 9:2:0:0: [sdr] Write Protect is off
sd 9:2:0:0: [sdr] Mode Sense: 00 3a 00 00
sd 9:2:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:3:0:0: [sds] 976773168 512-byte hardware sectors (500108 MB)
sd 9:3:0:0: [sds] Write Protect is off
sd 9:3:0:0: [sds] Mode Sense: 00 3a 00 00
sd 9:3:0:0: [sds] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:4:0:0: [sdt] 976773168 512-byte hardware sectors (500108 MB)
sd 9:4:0:0: [sdt] Write Protect is off
sd 9:4:0:0: [sdt] Mode Sense: 00 3a 00 00
sd 9:4:0:0: [sdt] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:0:0:0: [sdp] 976773168 512-byte hardware sectors (500108 MB)
sd 9:0:0:0: [sdp] Write Protect is off
sd 9:0:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:1:0:0: [sdq] 976773168 512-byte hardware sectors (500108 MB)
sd 9:1:0:0: [sdq] Write Protect is off
sd 9:1:0:0: [sdq] Mode Sense: 00 3a 00 00
sd 9:1:0:0: [sdq] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:2:0:0: [sdr] 976773168 512-byte hardware sectors (500108 MB)
sd 9:2:0:0: [sdr] Write Protect is off
sd 9:2:0:0: [sdr] Mode Sense: 00 3a 00 00
sd 9:2:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:3:0:0: [sds] 976773168 512-byte hardware sectors (500108 MB)
sd 9:3:0:0: [sds] Write Protect is off
sd 9:3:0:0: [sds] Mode Sense: 00 3a 00 00
sd 9:3:0:0: [sds] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:4:0:0: [sdt] 976773168 512-byte hardware sectors (500108 MB)
sd 9:4:0:0: [sdt] Write Protect is off
sd 9:4:0:0: [sdt] Mode Sense: 00 3a 00 00
sd 9:4:0:0: [sdt] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata10.00: failed to read SCR 1 (Emask=0x40)
ata10.01: failed to read SCR 1 (Emask=0x40)
ata10.02: failed to read SCR 1 (Emask=0x40)
ata10.03: failed to read SCR 1 (Emask=0x40)
ata10.04: failed to read SCR 1 (Emask=0x40)
ata10.05: failed to read SCR 1 (Emask=0x40)
ata10.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.02: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 1 cdb 0x0 data 0
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata10.02: status: { DRDY }
ata10.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.03: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 3 cdb 0x0 data 0
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata10.03: status: { DRDY }
ata10.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.15: hard resetting link
ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.00: hard resetting link
ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.01: hard resetting link
ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.02: hard resetting link
ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.03: hard resetting link
ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.04: hard resetting link
ata10.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.05: hard resetting link
ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.00: configured for UDMA/100
ata10.01: configured for UDMA/100
ata10.02: configured for UDMA/100
ata10.03: configured for UDMA/100
ata10.04: configured for UDMA/100
ata10: EH complete
sd 9:0:0:0: [sdp] 976773168 512-byte hardware sectors (500108 MB)
sd 9:0:0:0: [sdp] Write Protect is off
sd 9:0:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:1:0:0: [sdq] 976773168 512-byte hardware sectors (500108 MB)
sd 9:1:0:0: [sdq] Write Protect is off
sd 9:1:0:0: [sdq] Mode Sense: 00 3a 00 00
sd 9:1:0:0: [sdq] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:2:0:0: [sdr] 976773168 512-byte hardware sectors (500108 MB)
sd 9:2:0:0: [sdr] Write Protect is off
sd 9:2:0:0: [sdr] Mode Sense: 00 3a 00 00
sd 9:2:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:3:0:0: [sds] 976773168 512-byte hardware sectors (500108 MB)
sd 9:3:0:0: [sds] Write Protect is off
sd 9:3:0:0: [sds] Mode Sense: 00 3a 00 00
sd 9:3:0:0: [sds] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:4:0:0: [sdt] 976773168 512-byte hardware sectors (500108 MB)
sd 9:4:0:0: [sdt] Write Protect is off
sd 9:4:0:0: [sdt] Mode Sense: 00 3a 00 00
sd 9:4:0:0: [sdt] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:0:0:0: [sdp] 976773168 512-byte hardware sectors (500108 MB)
sd 9:0:0:0: [sdp] Write Protect is off
sd 9:0:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:1:0:0: [sdq] 976773168 512-byte hardware sectors (500108 MB)
sd 9:1:0:0: [sdq] Write Protect is off
sd 9:1:0:0: [sdq] Mode Sense: 00 3a 00 00
sd 9:1:0:0: [sdq] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:2:0:0: [sdr] 976773168 512-byte hardware sectors (500108 MB)
sd 9:2:0:0: [sdr] Write Protect is off
sd 9:2:0:0: [sdr] Mode Sense: 00 3a 00 00
sd 9:2:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:3:0:0: [sds] 976773168 512-byte hardware sectors (500108 MB)
sd 9:3:0:0: [sds] Write Protect is off
sd 9:3:0:0: [sds] Mode Sense: 00 3a 00 00
sd 9:3:0:0: [sds] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:4:0:0: [sdt] 976773168 512-byte hardware sectors (500108 MB)
sd 9:4:0:0: [sdt] Write Protect is off
sd 9:4:0:0: [sdt] Mode Sense: 00 3a 00 00
sd 9:4:0:0: [sdt] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA



