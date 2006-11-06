From: Tejun Heo <htejun@gmail.com>
Subject: Re: Supported chipsets with sata_sil24?
Date: Mon, 06 Nov 2006 23:10:51 +0900
Message-ID: <454F426B.5000709@gmail.com>
References: <fnjo4zvd52iy.1rdumsth8vh91$.dlg@40tude.net> <454D27EB.1070907@gmail.com> <pv5ttji1w0qr$.1ftk6q36he52r.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:30599 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753182AbWKFOLJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Nov 2006 09:11:09 -0500
Received: by ug-out-1314.google.com with SMTP id m3so890225ugc
        for <linux-ide@vger.kernel.org>; Mon, 06 Nov 2006 06:11:07 -0800 (PST)
In-Reply-To: <pv5ttji1w0qr$.1ftk6q36he52r.dlg@40tude.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jwoznack@d-a-s.com
Cc: linux-ide@vger.kernel.org

John Woznack wrote:
> On Sun, 05 Nov 2006 08:53:15 +0900, Tejun Heo wrote:
> 
>> John Woznack wrote:
>>> Out of curiosity, which Silicon Image chipsets are supported by the
>>> sata_sil24 driver? (3124/3132 obviously,but what about 3512, 3112, 3531,
>>> and 3726?)
>> sata_sil24	: 3124, 3132, 3131, 3531
>> sata_sil	: 3112, 3114, 3512 and some other variants
>>
>> 3726 and 4726 are port multipliers and supported by pending PMP patchset.
> 
> Thanks Tejun. Just what I was looking for.
> 
> After checking out http://linux-ata.org/driver-status.html, I've got Just a
> few more questions: 
> 
> 1. The sata_sil24 shows it supports NCQ. Out of curiosity, how can I tell
> if it's using NCQ? 

It will say something like the following.

   ata1.00: ATA-7, max UDMA7, 312581808 sectors: LBA48 NCQ (depth 31/32)

If your controller doesn't support NCQ, it will say 0/32.  ATM, libata 
caps max supported commands to 31, so you'll see 31/32 for NCQ capable 
drives.

> 2. The sata_sil24 and sata_sil drivers support suspend. Can you explain
> this in more detail? (Like, is it always on or do I have to enable it? Can
> I set the idle timeout-to-suspend somehow? etc.)

If the power management is turned on, those are turned on automatically.

-- 
tejun
