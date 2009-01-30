From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Seagate disk freeze for 30 seconds then comes back (RecovComm
 10B8B)
Date: Thu, 29 Jan 2009 19:07:48 -0500
Message-ID: <498244D4.4060903@tmr.com>
References: <alpine.LFD.2.00.0901271739400.2013@mail.embedromix.ro> <20090128153141.GC26064@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:32976 "EHLO partygirl.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754476AbZA3AIE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 19:08:04 -0500
In-Reply-To: <20090128153141.GC26064@csclub.uwaterloo.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "Catalin(ux) M. BOIE" <catab@embedromix.ro>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Lennart Sorensen wrote:
> On Wed, Jan 28, 2009 at 11:30:42AM +0200, Catalin(ux) M. BOIE wrote:
>> I have a ST9160821AS drive, firmware 3.BHE, and I experience some seldom 
>> problems with it. It is in a HP 6715s HP laptop, kernel 2.6.27.5.
>>
>> The error message is:
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x80002 action 0x6 frozen
>> ata1: SError: { RecovComm 10B8B }
>> ata1.00: cmd ca/00:f8:11:b8:38/00:00:00:00:00/ec tag 0 dma 126976 out
>> res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata1.00: status: { DRDY }
>> ata1: hard resetting link
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
>> ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
>> ata1.00: configured for UDMA/100
>> ata1: EH complete
>> sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
>> sd 0:0:0:0: [sda] Write Protect is off
>> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
>> support DPO or FUA
>>
>> When it happens, the system freezes for around 30 seconds.
>>
>> Seagate told me that there is no firmware update for this drive.
>>
>> Please, let me know if it is a software issue.
> 
> This sounds like a very widely known and discussed firmware problem.  It
> happens with Linux, Windows, and Mac OS X, as well as various NAS boxes.
> It is seagate's fault.  Of course I had only seen it mentioned for the
> 500GB, 750GB, 1TB and 1.5TB drives.  Somehow yours seems like it should
> be a different series, but then again why should a firmware bug not be
> duplicated on all their drives.
> 
Would you expect that firmware would be shared between old tech laptop drives 
and desktop/server drives? Particularly since the laptop drive was built before 
any of the 7200.11 drives?

I think this is a very unlikely part of the problem. Certainly the drive might 
be dying or other hardware issue.

> One discussion is here: http://techreport.com/discussions.x/15863
> 
> Seriously annoying for raid users of course when a drive falls out of
> the raid for no good reason.
> 
> 
> I seem to recall some people had found that if you disabled some part of
> the drive caching the problem seemed to go away (as did a lot of the
> drive's performance of course).
> 


-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
