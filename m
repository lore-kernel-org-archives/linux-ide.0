From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Fri, 28 Mar 2008 10:57:13 +0900
Message-ID: <47EC5079.5020105@gmail.com>
References: <12066128663306-git-send-email-htejun@gmail.com> <47EBAE2B.8070102@rtr.ca> <47EBB09F.9070607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:13002 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbYC1B5V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 21:57:21 -0400
Received: by an-out-0708.google.com with SMTP id d31so10294and.103
        for <linux-ide@vger.kernel.org>; Thu, 27 Mar 2008 18:57:21 -0700 (PDT)
In-Reply-To: <47EBB09F.9070607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hello, Mark.

Mark Lord wrote:
> Speaking of which.. these are all WRITEs.
> 
> In 18 years of IDE/ATA development,
> I have *never* seen a hard disk drive report a WRITE error.
>
> Which makes sense, if you think about it -- it's rewriting the sector
> with new ECC info, so it *should* succeed.  The only case where it won't,
> is if the sector has been marked as "bad" internally, and the drive is
> too dumb to try anyways after it runs out of remap space.
> 
> In which case we've already lost data, and taking more than a hundred
> and twenty seconds isn't going to make a serious difference.

Yeah, the disk must be knee deep in shit to report WRITE failure.  I
don't really expect the code to be exercised often but was mainly trying
fill the loophole in libata error handling as this type of behavior is
what the spec requires on FLUSH errors.

I didn't add global timeout because retries are done iff the drive is
reporting progress.

1. Drives genuinely deep in shit and getting lots of WRITE errors would
report different sectors on each FLUSH and we NEED to keep retrying.
That's what the spec requires and the FLUSH could be from shutdown and
if so that would be the drive's last chance to write data to the drive.

2. There are other issues causing the command to fail (e.g. timeout, HSM
violation or somesuch).  This is the case EH can take a really long time
if it keeps retrying but the posted code doesn't retry if this is the case.

3. The drive is crazy and reporting errors for no good reason.  Unless
the drive is really anti-social and raise such error condition only
after tens of seconds, this shouldn't take too long.  Also, if LBA
doesn't change for each retry, the tries count is halved.

So, I think the code should be safe.  Do you still think we need a
global timeout?  It is easy to add.  I'm just not sure whether we need
it or not.

> Mmm.. anyone got a spare modern-ish drive to risk destroying?
> Say, one of the few still-functioning DeathStars, or an buggy-NCQ Maxtor ?
> 
> If so, it might be fun to try and produce a no-more-remaps scenario on it.
> One could use "hdparm --make-bad-sector" to corrupt a few hundred/thousand
> sectors in a row (sequentially numbered).
>
> Then loop and attempt to read from them individually with "hdparm
> --read-sector"
> (should fail on all, but it might force the drive to remap them).
> 
> Then finally try and write back to them with "hdparm --write-sector",
> and see if a WRITE ERROR is ever reported.  Maybe time the individual
> WRITEs
> to see if any of them take more than a few milliseconds.
> 
> Perhaps try this whole thing with/without the write cache enabled.
> 
> Mmm...

Heh... :-)

-- 
tejun
