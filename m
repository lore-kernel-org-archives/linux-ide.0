From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 7/9] convert disk flush functions to use REQ_DRIVE_TASKFILE
Date: Tue, 01 Mar 2005 00:12:11 +0900
Message-ID: <422334CB.4010408@gmail.com>
References: <Pine.GSO.4.58.0502241545041.13534@mion.elka.pw.edu.pl> <20050227045125.GA25723@htj.dyndns.org> <200502271739.16076.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.199]:2467 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261634AbVB1PMh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2005 10:12:37 -0500
Received: by wproxy.gmail.com with SMTP id 68so933385wri
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2005 07:12:37 -0800 (PST)
In-Reply-To: <200502271739.16076.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 27 February 2005 05:51, Tejun Heo wrote:
> 
>> Hello, Bartlomiej,
>>
>>On Thu, Feb 24, 2005 at 03:45:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
>>
>>>Original patch from Tejun Heo <htejun@gmail.com>,
>>>ported over recent IDE changes by me.
>>>
>>>* teach ide_tf_get_address() about CHS
>>
>> IMHO, as patch #4 moves LBA/CHS selection into taskfile, I think
>>using taskfile->device to determine whether LBA or CHS is used instead
>>of drive->select makes more sense.
>>
>>
>>>* use ide_tf_get_address() and remove ide_get_error_location()
>>
>> IIRC, error responses for WIN_FLUSH_CACHE is in CHS if the LBA bit in
>>the device register is zero; likewise, in LBA if the LBA bit is one.
>>I don't know if drives can change the LBA bit when posting error
>>result.  The original code reads back the device register on error to
>>determine whether to interpret the error response in CHS or LBA.
>>(ATA/ATAPI-6 isn't clear on this issue.  Is ATA/ATAPI-7 updated?)
> 
> 
> The thing is that LBA bit is marked as "na" for FLUSH CACHE
> in all ATA/ATAPI drafts that I've seen.
> 

  Yeah, and nothing is mentioned about the LBA bit in the normal output 
description even though the lcyl, hcyl.. registers are described to be 
in either form of CHS or LBA.  Strange...

> 
>> This change combined with patch #2/#5 can make error address
>>calculation wrong on LBA28 drives.  I think setting the LBA bit in the
>>device register according to the drive's addressing mode in
>>ide_task_init_flush() and use taskfile->device in ide_tf_get_address()
>>should fix the problem.
> 
> 
> I will change the code to set LBA bit, it shouldn't hurt. :-)

  IMHO, there can be cases where just setting the LBA bit isn't enough. 
  Theoretically, drives can report CHS and clear the LBA bit in the 
device register even when the LBA bit was set when the command was 
issued.  Maybe the intention of the original code was to handle 
something like this?

-- 
tejun

