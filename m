From: Thomas Jackowski <aXe@hadiko.de>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Sat, 25 Apr 2009 12:22:52 +0200
Message-ID: <49F2E47C.5010803@hadiko.de>
References: <49D4A232.3090504@hadiko.de> <49DE39E2.7070505@kernel.org> <49E847A3.9070100@hadiko.de> <49EAE746.4040303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.rz.uni-karlsruhe.de ([129.13.185.218]:42880 "EHLO
	smtp2.rz.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbZDYKW5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Apr 2009 06:22:57 -0400
Received: from postamt.hadiko.de ([2001:638:204:10:21b:21ff:fe22:d9c2] helo=[IPv6:2001:638:204:10:21b:21ff:fe22:d9c2])
	by nce3.hadiko.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lxf25-0007kg-ER
	for linux-ide@vger.kernel.org; Sat, 25 Apr 2009 12:22:53 +0200
In-Reply-To: <49EAE746.4040303@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hey,

some additional information (2.6.26-1) and ata_piix:
[653158.828848] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
[653158.828856] ata3.00: cmd e5/00:00:00:00:00/00:00:00:00:00/00 tag 0
[653158.828857]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 
0x4 (timeout)
[653158.828860] ata3.00: status: { DRDY }
[653158.828868] ata3: hard resetting link
[653159.331110] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[653159.355648] ata3.00: configured for UDMA/133
[653159.355666] ata3: EH complete
[653159.371885] sd 2:0:0:0: [sde] 1953523055 512-byte hardware sectors 
(1000204 MB)
[653159.374081] sd 2:0:0:0: [sde] Write Protect is off
[653159.374081] sd 2:0:0:0: [sde] Mode Sense: 00 3a 00 00
[653159.390212] sd 2:0:0:0: [sde] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA

I tried 2.6.29 and I had no outputs in kernel.log with AHCI and w/o NCQ. 
But my system still had hiccups (system hangs for a second) so I am not 
sure if there was just no output to kernel.log (due using debian 
unstable kernel with eventually mysterious options).

I will observe this and report if any error occurs again.

Bye Thomas

Tejun Heo wrote:
> Hello,
> 
> Thomas Jackowski wrote:
>> yes this was AHCI. NCQ was enabled. I forgot to mention kernel version:
>> 2.6.26-1-amd64 (Debian Lenny)
> 
> Can you please try 2.6.29?
> 
>> So here is my test:
>> Enabled AHCI in BIOS.
>>
>> [    0.000000] Command line: root=/dev/md1 ro libata.force=noncq
>> [    0.000000] Kernel command line: root=/dev/md1 ro libata.force=noncq
>> [...]
>> [    3.237941] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps
>> 0x3f impl SATA mode
>> [    3.238000] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo
>> pmp pio slum part
>>
>> Ah, NCQ still activated.
>> /sys/block/sdc/device/queue_depth shows 31.
>>
>> I guess NCQ still activated even with libata.force=noncq ?
> 
> Well, if the module is loaded from initrd, you need to jump through
> some loops to get the parameter passed to libata.ko.  You can also
> disable NCQ by echoing 1 to queue_depth.
> 
>> Now here is my second test: Disabled AHCI in BIOS.
>>
>> ata_piix is used now. Did some IO, can't force any freezes.
>>
>> In the meantime I found topics like this:
>> http://forums.seagate.com/stx/board/message?board.id=ata_drives&thread.id=2879&view=by_date_ascending&page=1
>>
>> This looks like a firmware bug. I think I should contact Seagate ;) or
>> any other ideas?
> 
> Hmmm... please verify with ahci w/o NCQ.  If that works fine too,
> please go ahead and contact Seagate.
> 
> Thanks.
> 
