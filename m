From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH ide-dev-2.6] sata_sil: Mod15Write workaround
Date: Sat, 26 Mar 2005 07:33:14 +0900
Message-ID: <424491AA.7000907@gmail.com>
References: <20050316041752.GA6435@htj.dyndns.org> <4243BAC3.1050308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.201]:7687 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261862AbVCYWdW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Mar 2005 17:33:22 -0500
Received: by wproxy.gmail.com with SMTP id 68so893591wra
        for <linux-ide@vger.kernel.org>; Fri, 25 Mar 2005 14:33:19 -0800 (PST)
In-Reply-To: <4243BAC3.1050308@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, kanniball@zmail.pt, david@industrialstrengthsolutions.com

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>>  Hello, Jeff.
>>
>>  I've finished the sata_sil workaround.  It turned out that libata
>> already has all the hooks needed.  Although I had to twist things a
>> bit, the workaround is completely contained inside sata_sil driver.
>>
>>  The new work-around doesn't limit max sectors 15.  All read requests
>> and write requests <= 15 sectors are processed as-is.  Write requests
>> larger than 15 sectors are iterated inside the sata_sil driver using
>> the ops->qc_prep and qc->complete_fn hooks.  The work-around doesn't
>> map/unmap on each iteration, it just manipulates mapped sg table and
>> thus the PRD entries.
>>
>>  I've been running tests (repeated mke2fs and bonnie) several hours
>> from yesterday and it hasn't caused any problem yet.  Read performance
>> is now unhampered.  Write performance doesn't look very good, but it's
>> still much better.  I'm having difficult time remembering results but
>> on ext2, I think the write performance was better (compared to other
>> controllers, in ratio).  If you have a siimage controller and seagate
>> drives with this problem, please don't hesitate benchmarking.
>>
>>  Also, I think it would be very helpful if we can find out what the
>> Windows driver is doing to work around Mod15Write.  As now we can
>> split write requests at will without affecting upper layers, we can
>> easily replicate how they perform writes if we only know it.  So,
>> here are things I think might help.
>>
>>  * Benchmarking new workaround.  I think there should be tools better
>>    suited for this purpose than bonnie.
>>  * Benchmarking Mod15Write affected drives' read/write performance on
>>    affected siimage controllers and on other controllers on Windows.
>>  * Finding out how Windows splits write requests on affected drives.
>>    The best way would be Silicon Image coming out of the closet and
>>    tells us what they did with their Windows driver, but that doesn't
>>    seem likely.  So, if somebody has the right equipment and time,
>>    please come forward and shed some light here.
>>
>>  These sil3112/3114 controllers are way too common and so are 7200.7
>> Seagate drives.  I was shopping for a sata add-in card last week and
>> couldn't find any product which matches the price point of these sil
>> controllers and ended up buying one, even knowing about the Mod15Write
>> problem.  So, I think it would be great if we can get this thing to
>> work as fast as on Windows.  So, some inputs, please.  :-)
>>
>>  Bonnie benchmark results follow and then the patch.  Per-char results
>> on P3 800 are capped by cpu, ignore them.
>>
>>  The first one is the original sata_sil driver with max_sectors==15
>> work-around.  The second one is with the new work-around, and the last
>> one is on another machine with via controller.  I got confused about
>> the mount point so I'm not sure if it was a 3120026 or 3200822, but
>> either way, you can see the write performance is way better.
> 
> 
> 
> General comments:
> 
> 1) I do think this is a hack :)  ...

  It surely is. :-)

> 2) ... but your argument "sil3112 is way too common" is correct, and 
> very persuasive.
> 
> 3) I'm worried about the future, when the qc-complete callback will be 
> used for things like multi-step emulation of SCSI commands.

  Although I can't really say much until the actual thing is 
implemented, IMHO, it shouldn't be very difficult to modify sata_sil to 
fit.  Except for inner iteration, the end result isn't different to 
libata layer.

> 4) You really want to stress test multiple ports at once.  fsx is a good 
> stress tester, as is badblocks.

  ATM, unfortunately, I don't have two SATA drives for testing purpose. 
  But I'll try hammering the driver with fsx on single port when I get time.

> So #3 is really my only big worry with this patch.  Oh, and it would 
> need to see a lot of testing (perhaps in libata-dev) before deployment.

  Sure.

  Oh, and, in the workaround, I've forgot to restore the sgtable to the 
original state before finishing iteration.  I'll post updated version soon.

  Thanks.

-- 
tejun

