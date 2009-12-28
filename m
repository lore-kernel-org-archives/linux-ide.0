From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCH 0/3] AHCI updates: Marvell AHCI PATA works; pata_marvell
 fate?
Date: Sun, 27 Dec 2009 19:26:30 -0500
Message-ID: <4B37FB36.1040603@fastmail.fm>
References: <20090417023949.GA14469@havoc.gtf.org> <loom.20091227T054252-842@post.gmane.org> <4B37D713.4070407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52061 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751113AbZL1A0c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Dec 2009 19:26:32 -0500
In-Reply-To: <4B37D713.4070407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On 12/27/2009 04:52 PM, Robert Hancock wrote:
> On 12/26/2009 11:13 PM, Raman Gupta wrote:
>> I used "fio surface-scan" for my test (is that a good way to
>> test this?) and I found no regressions from the stock Fedora 12
>> kernel 2.6.31.6-166.fc12.x86_64. However, I was hoping the latest
>> libata-dev branch resolved this issue:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=549981
>>
>> It did not. I continue to get the same error as described in my
>> bugzilla report with libata-dev.
>
> I wouldn't expect any bug fixes to be in that branch, it's just a code
> reorganization.

Ok. It looked to me like it contained various fixes plus the code 
reorg on top of a very recent kernel version (2.6.33-rc1). Is there 
another branch to test that is more likely to contain bug fixes that 
may solve my problem? I trolled around git.kernel.org and didn't see any.

>  From your last post on the Bugzilla report, it looks like all 3 drives
> basically stopped talking to the point they wouldn't respond to IDENTIFY
> commands. That seems really strange to me. You mentioned you were doing
> a surface scan at the time, which presumably would involve all disks
> being accessed simultaneously.

Yes, all drives were being access simultaneously, as they are part of 
a 4-disk md RAID-5 array.

However, note that I can make the "exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen" happen even with the RAID array stopped and no 
filesystems mounted. All I have to do is run the smartctl -a /dev/sdd 
command (sdd is attached to the Marvell controller) repeatedly until 
this exception occurs:

Dec 27 18:59:30 x kernel: ata6.00: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
Dec 27 18:59:30 x kernel: ata6.00: cmd 
ec/00:01:00:00:00/00:00:00:00:00/00 tag 0 pio 512 in
Dec 27 18:59:30 x kernel:         res 
40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
Dec 27 18:59:30 x kernel: ata6.00: status: { DRDY }
Dec 27 18:59:30 x kernel: ata6: hard resetting link
Dec 27 18:59:30 x kernel: ata6: SATA link up 3.0 Gbps (SStatus 123 
SControl 300)
Dec 27 18:59:30 x kernel: ata6.00: configured for UDMA/133
Dec 27 18:59:30 x kernel: ata6: EH complete

Usually 10-15 executions is sufficient to replicate the issue.

> I'd have a good look at the hardware on that system, specifically
> the power supply. We've seen a number of cases where running
> multiple HDs on a system can trigger such problems with SATA links
> because of voltage sags (even momentary). HDs draw much higher peak
> power under certain conditions than when idle so such problems may
> not be obvious unless you stress multiple drives at once.

I used a multimeter to monitor the 5v and 12v output from the power 
supply for about two minutes, while the RAID array was under load, and 
didn't see the needle budge. Also note that I have three drives on the 
ICH7 controller and they have demonstrated no problems, nor has any 
other hardware in the system. I guess it could be a problem with the 
Marvell controller on this motherboard. I hope not.

> I'm not sure if that's related to the SMART issue you were seeing or not..

The timing is certainly suspicious. For now, given that I don't see 
any obvious hardware problems, I'm assuming the IDENTIFY error is 
related to the previous exception. If the primary issue can be solved 
then I'll retest to make sure the IDENTIFY error doesn't occur 
independently.

Is there some debugging I can turn on to get more information?

Cheers,
Raman
