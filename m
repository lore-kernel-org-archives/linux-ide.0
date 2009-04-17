From: Thomas Jackowski <aXe@hadiko.de>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Fri, 17 Apr 2009 11:10:59 +0200
Message-ID: <49E847A3.9070100@hadiko.de>
References: <49D4A232.3090504@hadiko.de> <49DE39E2.7070505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.rz.uni-karlsruhe.de ([129.13.185.217]:41985 "EHLO
	smtp1.rz.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbZDQJLE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2009 05:11:04 -0400
Received: from postamt.hadiko.de ([2001:638:204:10:21b:21ff:fe22:d9c2] helo=[IPv6:2001:638:204:10:21b:21ff:fe22:d9c2])
	by nce3.hadiko.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Luk69-0007cY-EF
	for linux-ide@vger.kernel.org; Fri, 17 Apr 2009 11:11:01 +0200
In-Reply-To: <49DE39E2.7070505@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

yes this was AHCI. NCQ was enabled. I forgot to mention kernel version:
2.6.26-1-amd64 (Debian Lenny)

So here is my test:
Enabled AHCI in BIOS.

[    0.000000] Command line: root=/dev/md1 ro libata.force=noncq
[    0.000000] Kernel command line: root=/dev/md1 ro libata.force=noncq
[...]
[    3.237941] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 
0x3f impl SATA mode
[    3.238000] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo 
pmp pio slum part

Ah, NCQ still activated.
/sys/block/sdc/device/queue_depth shows 31.

I guess NCQ still activated even with libata.force=noncq ?


Now here is my second test:
Disabled AHCI in BIOS.

ata_piix is used now. Did some IO, can't force any freezes.


In the meantime I found topics like this:
http://forums.seagate.com/stx/board/message?board.id=ata_drives&thread.id=2879&view=by_date_ascending&page=1

This looks like a firmware bug. I think I should contact Seagate ;) or 
any other ideas?

Bye



Tejun Heo wrote:
> Hello,
> 
> Thomas Jackowski wrote:
>> This is /dev/sdc. /dev/sdd and /dev/sde is the same model with the same
>> Firmware. I'm using a RAID5 on these 3 HDDs.
>> Because of the Seagate Firmware Bug I had to upgrade the firmware from
>> 'SD15' to 'SD1A'. The upgrade was successful.
>>
>> Before the upgrade there were no problems, after the upgrade I have
>> trouble like this:
> ...
>> [14144.875931] ata4.00: cmd ec/00:01:00:00:00/00:00:00:00:00/00 tag 0
> 
> Timeout on IDENTIFY.
> 
>> [507139.744602] ata5.00: cmd e5/00:00:00:00:00/00:00:00:00:00/00 tag 0
>> [507453.049519] ata4.00: cmd e5/00:00:00:00:00/00:00:00:00:00/00 tag 0
> 
> and two timeouts on CHK_POWER.
> 
> ahci, right?  Given that the problem appeared after firmware update,
> it seems to indicate firmware problem.  Does libata.force=noncq make
> any difference?
> 
