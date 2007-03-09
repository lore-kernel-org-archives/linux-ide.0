From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: sata_promise SATA300TX4 "intermittent problems"
Date: Fri, 09 Mar 2007 08:29:24 +0100
Message-ID: <45F10CD4.1070201@how.dk>
References: <45EECD12.1000506@how.dk>    <17903.7366.875191.751728@alkaid.it.uu.se> <45F0393D.80301@how.dk>    <45F0FE4C.7060901@how.dk> <40739.194.237.142.21.1173423710.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:49884 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993060AbXCIH33 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 02:29:29 -0500
In-Reply-To: <40739.194.237.142.21.1173423710.squirrel@ncircle.nullnet.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomi Orava <Tomi.Orava@ncircle.nullnet.fi>
Cc: linux-ide@vger.kernel.org

Hi Tomi,

My experiences are in accordance with yours:

1) it doesn't matter if IO-APIC is enabled or not.

2) using Mikaels "patch bundle" the channel may die then recovers ok. 
(This can be triggered by using smartctl when loaded).

3) It is never the first port that dies. It seems to be always number 3 
or 4.

If you dare, then try using smartctl -d ata -a on your disks and observe 
dmesg output :-) Every now and then smartctl will "kill the channel" 
which will then recover ok.

However, smartctl does not show this behaviour using just the 1.5Gbps 
patch. Running at 1.5Gbps seems to fix the problem - no hickups whatsoever.

Best regards,

Peter

Tomi Orava wrote:
> I've now been running with 2.6.21-rc2-git1 + Mikaels original "patch
> bundle" for 7 days without hangs! The machine has 2 Seagate 7200.7 disks
> and 2 Seagate 7200.10 (in 3.0Gps mode) with Promise Sata300TX4. The system
> does spit the following messages whenever there is load (no hickups user
> noticiable hickups however):
> 
> Mar  4 03:51:13 alderan kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr
> 0x0 action 0x0
> Mar  4 03:51:13 alderan kernel: ata4.00: cmd
> 25/00:00:3f:0e:a8/00:04:09:00:00/e0 tag 0 cdb 0x0 data 524288 in
> Mar  4 03:51:13 alderan kernel:          res
> 50/00:00:3e:12:a8/00:00:09:00:00/e0 Emask 0x1 (device error)
> Mar  4 03:51:13 alderan kernel: ata4.00: configured for UDMA/133
> Mar  4 03:51:13 alderan kernel: ata4: EH complete
> Mar  4 03:51:13 alderan kernel: SCSI device sdd: 976773168 512-byte hdwr
> sectors (500108 MB)
> Mar  4 03:51:13 alderan kernel: sdd: Write Protect is off
> Mar  4 03:51:13 alderan kernel: SCSI device sdd: write cache: enabled,
> read cache: enabled, doesn't support DPO or FUA
> 
> I have io-apic enabled, Asus A7V880 (Via KT880-chipset).
> In the past, when ever one of the disks failed, it _never_ was
> the first disk on the linux system (although I don't remember if it was
> connected to promise-cards first port as the ports are still numbered in
> some very pecualiar way under linux).
> 
> Regards,
> Tomi Orava

