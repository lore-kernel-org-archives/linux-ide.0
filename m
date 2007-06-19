From: Vasily Averin <vvs@sw.ru>
Subject: Re: VIA VT6420: SATA disconnects
Date: Tue, 19 Jun 2007 15:14:04 +0400
Message-ID: <4677BA7C.1060704@sw.ru>
References: <46569341.4020801@sw.ru> <465694E4.9020601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:28728 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755833AbXFSLOq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jun 2007 07:14:46 -0400
In-Reply-To: <465694E4.9020601@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, j.e.van.grootheest@caiway.nl, devel@openvz.org

Jeff Garzik wrote:
> Vasily Averin wrote:
>> Jeff, Tejun,
>>
>> Our RHEL5-based OpenVZ linux kernel reports about SATA-related issues:
>> VIA VT6420 SATA RAID Controller on MSI motherboard, x86_64 kernel based on latest RHEL5 kernel,
>> On booting hardware initialized properly and all works fine some time, but then it detects timeout and disables devices. We have replaced SATA cables, but issue didn't go away and still present.
>>
>> I've googled and found similair bugreport in linux-ide@
>> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg06011.html
>>
>> Are you know something about this issue? I've seen that you have fixed SATA reset procedure recently, probably this issue was fixed already?
> 
> RHEL5 SATA is unfortunately way out of date :(  The next RHEL5 update 
> should include a boatload of fixes.
> 
> Try running the latest upstream kernel (2.6.21.3 or 2.6.22-rc2-git7), 
> and see if the problem is reproducible.

I've reproduced this issue. But on this kernel EH works well and node is still alive:

Linux version 2.6.22-rc4 (vvs@vvs.work.ve) (gcc version 3.4.6 20060404 (Red Hat 3.4.6-3)) #1 SMP Fri Jun 8 14:32:01 MSD 2007
...

hda: lost interrupt
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ca/00:78:30:1a:24/00:00:00:00:00/e2 tag 0 cdb 0x0 data 61440 out
         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ATA: abnormal status 0x7F on port 0x000000000001c007
ATA: abnormal status 0x7F on port 0x000000000001c007
ata1.00: qc timeout (cmd 0x27)
ata1.00: ata_hpa_resize 1: sectors = 156301488, hpa_sectors = 0
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ATA: abnormal status 0x7F on port 0x000000000001c007
ATA: abnormal status 0x7F on port 0x000000000001c007
ata1.00: qc timeout (cmd 0x27)
ata1.00: ata_hpa_resize 1: sectors = 156301488, hpa_sectors = 0
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/133:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ATA: abnormal status 0x7F on port 0x000000000001c007
ATA: abnormal status 0x7F on port 0x000000000001c007
ata1.00: qc timeout (cmd 0x27)
ata1.00: ata_hpa_resize 1: sectors = 156301488, hpa_sectors = 0
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH complete
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

You can find some additional details in bug #8650
http://bugzilla.kernel.org/show_bug.cgi?id=8650
 
thank you,
	Vasily Averin
