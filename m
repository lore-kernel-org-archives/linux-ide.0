From: Tejun Heo <htejun@gmail.com>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Thu, 7 Dec 2006 10:25:46 +0900
Message-ID: <20061207012546.GA15219@htj.dyndns.org>
References: <456CB72A.3010004@local.se> <456CDB06.40806@gmail.com> <457704BA.7090001@local.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:31035 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937917AbWLGBZy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2006 20:25:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so324726uga
        for <linux-ide@vger.kernel.org>; Wed, 06 Dec 2006 17:25:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <457704BA.7090001@local.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonas Lundgren <jonas@local.se>
Cc: linux-ide@vger.kernel.org

On Wed, Dec 06, 2006 at 06:58:18PM +0100, Jonas Lundgren wrote:
> Here's the relevant part, if you want the whole dmesg look at:
> http://pastebin.ca/269581
> 
[--snip--]
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

EH went okay although your harddrive is responding sluggishly.

> > 1. swap the two.  you'll probably have to dance a little bit with boot
> > loader but md should handle that fine once the kernel is loaded.  does
> > the errors persist?  on which device do they occur?  do they follow the
> > drive or stay on the mobo port?
>
> It follows the drive. (Hardware problem?)

Yeap, probably.

[--snip--]
> I guess it could only be a hardware problem since the error follows the
> drive, and both the drives are identical, so it can't be a firmware
> problem. Correct me if I'm wrong.

Firmware?  Could be a firmware bug on the drive but not
controller/driver problem.

[--snip--]
>   9 Power_On_Hours          0x0032   076   076   000    Old_age   Always
>       -       18117

That's two year's worth of spinning.  I wouldn't be surprised if the
drive gives out.

> 196 Reallocated_Event_Count 0x0032   001   001   000    Old_age   Always
>       -       639

And quite some number of reallocations.  Reallocation itself doesn't
necessarily indicate critical condition but if you've got 639 of them,
you gotta throw that thing away.

-- 
tejun
