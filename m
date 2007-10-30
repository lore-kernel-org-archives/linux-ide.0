From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: blacklisting ST3500630AS as not able to do NCQ
Date: Tue, 30 Oct 2007 13:59:12 +0300
Message-ID: <47270E80.2080304@msgid.tls.msk.ru>
References: <1993911428.20071007225627@coral.dnsalias.org> <47257A4A.1000806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:24284 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623AbXJ3K7S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 06:59:18 -0400
In-Reply-To: <47257A4A.1000806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: diego torres <dtorres@coral.dnsalias.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> diego torres wrote:
>> Hi there,
>>
>> This seagate drive ST3500630AS is being recognized as NCQ capable by
>> hdparm, and has the default queue_depth of 31, so i think it should
>> work ok. But there are some problems when using smartmontools (for
>> example in short test mode) as seen in dmesg:
>>
>> ata2.00: exception Emask 0x2 SAct 0x9 SErr 0x0 action 0x2 frozen
>> ata2.00: (spurious completions during NCQ issue=0x0 SAct=0x9 FIS=004040a1:00000004)
>> ata2.00: cmd 61/08:00:f4:28:4e/00:00:00:00:00/40 tag 0 cdb 0x0 data 4096 out
>>          res 40/00:00:f4:28:4e/00:00:00:00:00/40 Emask 0x2 (HSM violation)
>> ata2.00: cmd 61/08:18:dc:c8:d7/00:00:00:00:00/40 tag 3 cdb 0x0 data 4096 out
>>          res 40/00:00:f4:28:4e/00:00:00:00:00/40 Emask 0x2 (HSM violation)
>> ata2: soft resetting port
>> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata2.00: configured for UDMA/133
>> ata2: EH complete
>> sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
>> sd 1:0:0:0: [sdb] Write Protect is off
>> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>
>> All this problems dissapear when setting queue_depth to 1.
>>
>> After cheking the seagate website, there is no mention to NCQ in the
>> spec sheet of this drive, although there are models tagged as using
>> NCQ interface, for example ST3500620AS
> 
> How reproducible is the problem?

A good question.

We too has - not the same but similar - drives here, which shows pretty
similar behavior.

ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: ST3250620NS, 3.AEG, max UDMA/133
ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)

(those are 250Gb drives, not 500Gb as Diego have, but they're
from the same model line).  Later on:

ata1.00: exception Emask 0x2 SAct 0x8 SErr 0x0 action 0x2 frozen
ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x8 FIS=004040a1:00000004)
ata1.00: cmd 61/08:18:02:98:d8/00:00:00:00:00/40 tag 3 cdb 0x0 data 4096 out
         res 40/00:20:6a:72:d8/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

and so on and so on.

The thing is that I haven't seen this behavior with previous kernel.
I upgraded from 2.6.20-i686 to 2.6.22-x86-64 (from kernel.org), and
started seeing those messages.  I'm not sure if it's new kernel
version or 32 vs 64 bits issue.

The machine is our main production server, so I can't test it right
now - have to wait till some spare evening...

/mjt
