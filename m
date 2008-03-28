From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Fri, 28 Mar 2008 09:36:58 -0400
Message-ID: <47ECF47A.2040508@emc.com>
References: <12066128663306-git-send-email-htejun@gmail.com> <47EBAE2B.8070102@rtr.ca> <47EBB09F.9070607@rtr.ca> <47EC5079.5020105@gmail.com> <47EC58F6.3070601@rtr.ca>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:19813 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbYC1Nj7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 09:39:59 -0400
In-Reply-To: <47EC58F6.3070601@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Mark Lord wrote:
> Tejun Heo wrote:
>> Hello, Mark.
>>
>> Mark Lord wrote:
>>> Speaking of which.. these are all WRITEs.
>>>
>>> In 18 years of IDE/ATA development,
>>> I have *never* seen a hard disk drive report a WRITE error.
>>>
>>> Which makes sense, if you think about it -- it's rewriting the sector
>>> with new ECC info, so it *should* succeed.  The only case where it 
>>> won't,
>>> is if the sector has been marked as "bad" internally, and the drive is
>>> too dumb to try anyways after it runs out of remap space.
>>>
>>> In which case we've already lost data, and taking more than a hundred
>>> and twenty seconds isn't going to make a serious difference.
>>
>> Yeah, the disk must be knee deep in shit to report WRITE failure.  I
>> don't really expect the code to be exercised often but was mainly trying
>> fill the loophole in libata error handling as this type of behavior is
>> what the spec requires on FLUSH errors.
>>
>> I didn't add global timeout because retries are done iff the drive is
>> reporting progress.
>>
>> 1. Drives genuinely deep in shit and getting lots of WRITE errors would
>> report different sectors on each FLUSH and we NEED to keep retrying.
>> That's what the spec requires and the FLUSH could be from shutdown and
>> if so that would be the drive's last chance to write data to the drive.
>>
>> 2. There are other issues causing the command to fail (e.g. timeout, HSM
>> violation or somesuch).  This is the case EH can take a really long time
>> if it keeps retrying but the posted code doesn't retry if this is the 
>> case.
>>
>> 3. The drive is crazy and reporting errors for no good reason.  Unless
>> the drive is really anti-social and raise such error condition only
>> after tens of seconds, this shouldn't take too long.  Also, if LBA
>> doesn't change for each retry, the tries count is halved.
>>
>> So, I think the code should be safe.  Do you still think we need a
>> global timeout?  It is easy to add.  I'm just not sure whether we need
>> it or not.
> ..
> 
> With EH becoming more and more capable and complex,
> a global deadline for FLUSH looks like a reasonable thing.
> People who have no backups can leave it at the default "near-infinity" 
> setting
> that is there now, and folks with RAID1 (or better) can set it to a much 
> shorter number -- so that their system-recovery reboot doesn't take 3 hours
> to get past the FLUSH_CACHE on the failing drive.  :)
> 
> Cheers

I think that is a really important knob to have. Not just for RAID 
systems, but we use the FLUSH_CACHE on systems without barriers mainly 
when we power down & do the unmounts, etc.

If you hit a bad block during power down of a laptop, I can image that 
have a worst case of (30?) seconds is infinitely better than multiple 
minutes ;-)

ric
