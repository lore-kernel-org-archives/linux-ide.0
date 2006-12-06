From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Wed, 6 Dec 2006 18:45:10 +0000
Message-ID: <f4527be0612061045sb90c25m1e39ad3e8f15c099@mail.gmail.com>
References: <456CB72A.3010004@local.se> <456CDB06.40806@gmail.com>
	 <457704BA.7090001@local.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:50966 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937101AbWLFSpM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2006 13:45:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so230220uga
        for <linux-ide@vger.kernel.org>; Wed, 06 Dec 2006 10:45:11 -0800 (PST)
In-Reply-To: <457704BA.7090001@local.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jonas@local.se
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On 12/6/06, Jonas Lundgren <jonas@local.se> wrote:
> Tejun Heo wrote:
> [--snip--]
>
> >> IF the system does recover, I start getting
> >> the extremly low disk write speeds that I reported above, and only a
> >> reboot will get the performance back to regular.
> >
> > Please full dmesg after your computer got really slow.  I suspect libata
> > decided to switch to PIO mode.
> Here's the relevant part, if you want the whole dmesg look at:
> http://pastebin.ca/269581
>
> [--snip--]
> [82048.255126] can't create port
> [85055.578172] reiser4[unrar(30787)]: disable_write_barrier
> (fs/reiser4/wander.c:234)[zam-1055]:
> [85055.578174] NOTICE: md5 does not support write barriers, using
> synchronous write instead.
> [87825.501998] can't create port
> [89520.019538] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> frozen
> [89520.019545] ata2.00: cmd c8/00:08:fe:68:df/00:00:00:00:00/e1 tag 0
> data 4096 in
> [89520.019547]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [89520.322292] ata2: soft resetting port
> [89527.515891] ata2: port is slow to respond, please be patient (Status
> 0xd0)
> [89550.457913] ata2: port failed to respond (30 secs, Status 0xd0)
> [89550.457917] ata2: softreset failed (device not ready)
> [89550.457921] ata2: softreset failed, retrying in 5 secs
> [89555.454103] ata2: hard resetting port
> [89562.799693] ata2: port is slow to respond, please be patient (Status
> 0x80)
> [89585.740239] ata2: port failed to respond (30 secs, Status 0x80)
> [89585.740242] ata2: COMRESET failed (device not ready)
> [89585.740245] ata2: hardreset failed, retrying in 5 secs
> [89590.736978] ata2: hard resetting port
> [89598.081854] ata2: port is slow to respond, please be patient (Status
> 0x80)
> [89617.604742] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [89617.611034] ata2.00: configured for UDMA/100
> [89617.611042] ata2: EH complete
> [89617.623426] SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
> [89617.633551] sdb: Write Protect is off
> [89617.633553] sdb: Mode Sense: 00 3a 00 00
> [89617.637765] SCSI device sdb: write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
>
> >
> >> I don't know what causes it, but most of the times when I've gotten it
> >> my system has been under heavy load (compiling, downloading torrents in
> >> 11mb/sec etc). Please let me know if you want any additional info, want
> >> me to try something out, or whatever. My recent hardware upgrade for
> >> around $1200 (to a core2duo system, i965 mobo) is just going to waste
> >> because of this problem. :/
> >
> > Heh, nice machine you got there.  When you look at the dmesg, do the
> > error messages occur only on one of the two drives?  Or are both
> > affected?  If only one is affected,
> >
> > 1. swap the two.  you'll probably have to dance a little bit with boot
> > loader but md should handle that fine once the kernel is loaded.  does
> > the errors persist?  on which device do they occur?  do they follow the
> > drive or stay on the mobo port?
> It follows the drive. (Hardware problem?)
>
> >
> > 2. try different cable / port.  if you change port, again, you need to
> > dance w/ boot loader.  who's carrying the error messages with it?
> Read above.
>
> >
> > 3. try different power plug from different power lane.
> I've got a really good power supply, wich can handle max 560W on the +12
> / -12 V rail alone.
>
> >
> >> I just got so glad when I saw the post of this on linux-ide, I've been
> >> searching like crazy to find another person having the same problem (and
> >> possibly a solution) for the past 2-3 weeks or so.
> >
> > My first guess is frequent transmission errors.  Please report the test
> > results.  Thanks.
> >
>
> I guess it could only be a hardware problem since the error follows the
> drive, and both the drives are identical, so it can't be a firmware
> problem. Correct me if I'm wrong.
>
> I just checked the smart status, and the drive passes, but it seems like
> it's going down though, on the other hand I might misread the results.
>
> smartctl -d ata -A /dev/sdb
> smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
>
> === START OF READ SMART DATA SECTION ===
> SMART Attributes Data Structure revision number: 16
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
> UPDATED  WHEN_FAILED RAW_VALUE
>   1 Raw_Read_Error_Rate     0x000b   200   200   051    Pre-fail  Always
>       -       0
>   3 Spin_Up_Time            0x0007   113   111   021    Pre-fail  Always
>     -       4875
>   4 Start_Stop_Count        0x0032   100   100   040    Old_age   Always
>       -       237
>   5 Reallocated_Sector_Ct   0x0033   153   153   140    Pre-fail  Always
>       -       747
>   7 Seek_Error_Rate         0x000b   100   253   051    Pre-fail  Always
>       -       0
>   9 Power_On_Hours          0x0032   076   076   000    Old_age   Always
>       -       18117
>  10 Spin_Retry_Count        0x0013   100   100   051    Pre-fail  Always
>       -       0
>  11 Calibration_Retry_Count 0x0013   100   100   051    Pre-fail  Always
>       -       0
>  12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always
>       -       228
> 194 Temperature_Celsius     0x0022   117   108   000    Old_age   Always
>       -       33
> 196 Reallocated_Event_Count 0x0032   001   001   000    Old_age   Always
>       -       639
> 197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always
>       -       0
> 198 Offline_Uncorrectable   0x0012   200   200   000    Old_age   Always
>       -       0
> 199 UDMA_CRC_Error_Count    0x000a   200   253   000    Old_age   Always
>       -       0
> 200 Multi_Zone_Error_Rate   0x0009   200   179   051    Pre-fail
> Offline      -       0
>
>
> The "Reallocated_Sector_Ct" and "Reallocated_Event_Count" worries me..
> Should I be worried?

Yes, they are a sign that the drive is wearing out!

Andy

> --
> -Jonas
>
> Name:   Jonas Lundgren
> ICQ#:   52064961
> Mail:   jonas@local.se
> IRC:    neon / neonman @ EFnet, Undernet, Quakenet, freenode
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
