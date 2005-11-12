From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 corruption details
Date: Sat, 12 Nov 2005 11:59:04 +0900
Message-ID: <43755A78.3040005@gmail.com>
References: <20051110071736.23747.qmail@science.horizon.com>	 <43730C55.7030808@gmail.com>	 <87f94c370511100615u1eba1baai9d91df8ad2556510@mail.gmail.com>	 <43735C19.4040402@gmail.com> <4373843E.2030308@gmail.com>	 <87f94c370511101234v7a20c0daic907c41ccc61482c@mail.gmail.com> <87f94c370511111649j41d1832dhe7820376f96059a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:2736 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751031AbVKLC7M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2005 21:59:12 -0500
Received: by zproxy.gmail.com with SMTP id 13so799710nzn
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2005 18:59:11 -0800 (PST)
In-Reply-To: <87f94c370511111649j41d1832dhe7820376f96059a1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux@horizon.com, linux-ide@vger.kernel.org

Greg Freemyer wrote:
> On 11/10/05, Greg Freemyer <greg.freemyer@gmail.com> wrote:
> 
>>On 11/10/05, Tejun Heo <htejun@gmail.com> wrote:
>>
>>>Tejun Heo wrote:
>>>
>>>>Greg Freemyer wrote:
>>>>
>>>>
>>>>>On 11/10/05, Tejun Heo <htejun@gmail.com> wrote:
>>>>>
>>>>>
>>>>>>Hello, there.
>>>>>>
>>>>>>I'll soon try to tackle this one.  However, I currently have only one
>>>>>>3124 controller and one harddisk to hook to that controller, so I cannot
>>>>>>reproduce your setup over here.  Here are things that I think might help
>>>>>>in diagnosing the problem.
>>>>>>
>>>>>>* Trying other drivers
>>>>>>       * Trying the original driver.  I'll port the original driver
>>>>>>         from sii to the current tree and post the patch.
>>>>>>       * Performing similar test under Windows.
>>>>>>
>>>>>>* Ruling out disk problem
>>>>>>       * Trying other harddisks.  All harddisk drives perform error
>>>>>>         detection/correction when data are read from the media, but
>>>>>>         ruling out the possibility would still be helpful.
>>>>>>
>>>>>>* If you have log of failed sectors, finding patterns will be helpful.
>>>>>> If the errors occur at random places, it's likely that we have
>>>>>> controller/driver issues.  If errors are localized over multiple runs,
>>>>>> maybe the disk is at fault.
>>>>>>
>>>>>>--
>>>>>>tejun
>>>>>
>>>>>Tejun,
>>>>>
>>>>>I assume you saw my e-mail that with a 3112 and a single SATA drive we
>>>>>were seeing corruption as well.  That being the case I think you
>>>>>should first verify that corruption is not occuring in the single SATA
>>>>>drive case.
>>>>>
>>>>>Our test was to create a bunch of 2 GB files on a PATA drive.
>>>>>
>>>>>We simply used a drive with real data as the source of our test files.
>>>>>ie. IIRC: cd test_dir; dd if=/dev/hde conv=noerror,sync | split -b 2000m
>>>>>
>>>>>Then we calculated the md5 of all the 2 GB pieces.  All of this done
>>>>>in a pure PATA setup.
>>>>>
>>>>>Then we connected a SATA drive to a 3112 and simply copied the files
>>>>>from the PATA drive to the SATA drive and verified the md5 values.  We
>>>>>found corruption in 1 - 3% of the files copied.
>>>>>
>>>>>FYI: The above are all very common steps for a computer forensic
>>>>>examine, thus we found this issue in our attempts to qualify the 3112
>>>>>as part of our forensic equipment.  We have not tested since 2.6.11
>>>>>and that was with a SUSE kernel.
>>>>>
>>>>
>>>>Hi,
>>>>
>>>>I'll run single drive test on sil3112 tonight, but can you please try
>>>>2.6.14?  IIRC, there have been some PCI FIFO setting change.  Hmmm..
>>>>oh.. it was the following commit.
>>>>
>>>>---
>>>>$ git-cat-file commit e1dd23a0012c3929737798fda9fede0e783f4ff3
>>>>tree c7f808b6433ef1015f55418e7f11f432943bdefd
>>>>parent 5273a00d9c763108397658d440618f7ac3e40f83
>>>>author Jens Axboe <axboe@suse.de> 1118228545 +0200
>>>>committer Jeff Garzik <jgarzik@pobox.com> 1118300782 -0400
>>>>
>>>>[PATCH] sata_sil: Fix FIFO PCI Bus Arbitration kernel oops
>>>>
>>>>Correct this.
>>>>---
>>>>
>>>>Jens, is it possible that above change fixes data corruption?
>>>>
>>>
>>>Greg, first pass of 'badblocks -t random -v -w' on 100G partion of 160G
>>>disk just finished without any error.  This is samsung hd160jj drive on
>>>sil3112 controller.  I'll let badblocks run thorough the night and
>>>perform file copy & md5sum test tomorrow.  But my hunch is that there is
>>>no common data corruption problem with sil3112.  It's just in too
>>>wide-spread use to have such data corruption problem with so few reportings.
>>>
>>>What exact controller/disk did you use?  Care to retest your setup with
>>>2.6.14?
>>>
>>>--
>>>tejun
>>>
>>
>>Tejun
>>
>>The corruption I was seeing was on the order of a few bytes per 100
>>GB.  I'm not sure that most users would realize they were having
>>problems with that small of an error rate.
>>
>>I'm not sure what the OPs error rate was, but maybe he can tell us.
>>
>>I will attempt to retest with 2.6.14 vanilla.  Not sure if that will
>>be today or tomorrow.
>>
>>I don't have the old disk any more, but I will report what I use this time.
>>
>>I also have a CoolGear SATA to USB bridge, so if corruption is still
>>occuring I can retry the process with a USB connection to the
>>computer.  http://www.cooldrives.com/seatatousb20.html   If that works
>>it should rule out the Drive.
>>
>>Thanks for taking the time.
>>
>>Greg
>>--
>>Greg Freemyer
>>The Norcross Group
>>Forensics for the 21st Century
>>
> 
> 
> Tejun,
> 
> Success report:
> 
> I did a 80 GB test copy with 2.6.14.1 and a Maxtor 80GB SATA drive and
> a 3112A.  I had 3 drives connected to my server, one PATA for booting,
> one PATA for to hold the source data, and the SATA drive.  Let me know
> if you want want details about the setup.
> 
> I found no corruption.  Given that my error rate was very low it is
> possible that the corruption simply did not happen, but for now I'm
> assuming my earlier issues were either a disk problem or a kernel
> issue that was resolved by the latest kernel.
> 
> I'm going to continue to test this setup.  I'll report any problems I find.
> 

Hi, Greg.

I also have been continuing corruption test on 3112 during last two 
days.  It's being performed on 100GB partition of a 160GB harddisk 
(samsung hd160jj).  Nine passes of 'badblocks -t random -v -w /dev/sdb2' 
succeeded without any problem.  To replicate your test, I created a 4GB 
random file by dd'ing from /dev/urandom in a separate IDE disk and 
copied it to the partition 24times (24 different files of course), then 
I md5sum'd all copied files twice.  This test succeeded five times 
without any problem, and it's in the sixth run now.

Above badblocks and file copy tests amount to about 1.4TB of writes and 
1.9TB of reads without any data corruption.

Let me know how your test turns out.

Thanks.

-- 
tejun
