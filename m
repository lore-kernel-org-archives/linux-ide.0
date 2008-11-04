From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: hdparm-9.2 now available: w/ DCO and firmware support
Date: Tue, 4 Nov 2008 13:23:12 -0500
Message-ID: <87f94c370811041023s3de41ec9o66614bf3f0fdb63c@mail.gmail.com>
References: <490F4030.5030709@rtr.ca>
	 <87f94c370811041001ucd76d27lc948c553ad2a381e@mail.gmail.com>
	 <49108F96.8010902@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:6646 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbYKDSXO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 13:23:14 -0500
Received: by an-out-0708.google.com with SMTP id d40so319130and.1
        for <linux-ide@vger.kernel.org>; Tue, 04 Nov 2008 10:23:12 -0800 (PST)
In-Reply-To: <49108F96.8010902@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Nov 4, 2008 at 1:08 PM, Mark Lord <liml@rtr.ca> wrote:
> Greg Freemyer wrote:
>>
>> On Mon, Nov 3, 2008 at 1:17 PM, Mark Lord <liml@rtr.ca> wrote:
>>>
>>> hdparm v9.2 is now available from sourceforge.
>>>
>>>       http://sourceforge.net/projects/hdparm/
>>>
>>> New since v8.9 are:
>>>
>>> 1. Support for Device Configuration Overlay (DCO),
>>>  with the --dco-identify, --dco-freeze, and --dco-restore flags.
>>>  DCO is a feature set that enables vendors/OEMs to disable/hide
>>>  certain drive features (eg. NCQ, LBA48, ..) for whatever reason
>>>  (eg. compatibility with a specific b0rked BIOS).
>>>  This release of hdparm can display/reset DCO, but not selectively
>>>  disable features yet.
>
> ..
>>
>> I'm very happy to see the DCO support go in.
>>
>> There is a small army of "Computer Forensic" examiners which do their
>> forensic imaging via Linux and I'm sure many will feel the same.
>
> ..
>
> Mmm.. never thought about that much before now,
> but DCO is a nifty way to hide much of a drive from prying eyes.
> Eg. Use DCO to restrict the drive to LBA28 accessible sectors
> and also turn off LBA48 support, and then a lot of space becomes "hidden".
> Until now!

Yeah, combine that with some HPA shenanigans and you can create two
complete disk partition layouts on one drive.

ie. Two partition tables, the normal partition table for the first 128
GiB is in sector 1.  The partition table for the rest of the disk is
at sector 128 GiB + 1.  Then use DCO to totally hide the upper section
of the drive.

When you want access, use DCO commands to expose it, and then HPA
commands to make only the sectors beyond 128 GiB accessible.

FYI: I don't know if hdparm supports doing that via HPA, but there are
tools that do.  Basically you put a HPA area in place from 128 GiB +1
to the end of the disk, then issue a "hpa swap" command.  That will
hide the first 128 GiB and expose the rest of the disk.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
