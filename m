From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: hdparm-9.2 now available: w/ DCO and firmware support
Date: Tue, 4 Nov 2008 16:04:11 -0500
Message-ID: <87f94c370811041304r1ad54bd9tee4c2b7de4cb873f@mail.gmail.com>
References: <490F4030.5030709@rtr.ca>
	 <87f94c370811041001ucd76d27lc948c553ad2a381e@mail.gmail.com>
	 <49108F96.8010902@rtr.ca>
	 <87f94c370811041023s3de41ec9o66614bf3f0fdb63c@mail.gmail.com>
	 <49109EDE.1020803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.240]:7286 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbYKDVEO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 16:04:14 -0500
Received: by hs-out-0708.google.com with SMTP id 4so1681732hsl.5
        for <linux-ide@vger.kernel.org>; Tue, 04 Nov 2008 13:04:12 -0800 (PST)
In-Reply-To: <49109EDE.1020803@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Nov 4, 2008 at 2:13 PM, Mark Lord <liml@rtr.ca> wrote:
> Greg Freemyer wrote:
>>
>> On Tue, Nov 4, 2008 at 1:08 PM, Mark Lord <liml@rtr.ca> wrote:
>
> ..
>>>
>>> Mmm.. never thought about that much before now,
>>> but DCO is a nifty way to hide much of a drive from prying eyes.
>>> Eg. Use DCO to restrict the drive to LBA28 accessible sectors
>>> and also turn off LBA48 support, and then a lot of space becomes
>>> "hidden".
>>> Until now!
>>
>> Yeah, combine that with some HPA shenanigans and you can create two
>> complete disk partition layouts on one drive.
>>
>> ie. Two partition tables, the normal partition table for the first 128
>> GiB is in sector 1.  The partition table for the rest of the disk is
>> at sector 128 GiB + 1.  Then use DCO to totally hide the upper section
>> of the drive.
>>
>> When you want access, use DCO commands to expose it, and then HPA
>> commands to make only the sectors beyond 128 GiB accessible.
>
> ..
>
> Now that one has me stumped.  The only HPA commands I know of,
> permit setting only the maximum-LBA, not the minimum.
> Or is this a newish ATA9 (or last-minute ATA8) sort of thing ?
> ..
>>
>> to the end of the disk, then issue a "hpa swap" command.  That will
>> hide the first 128 GiB and expose the rest of the disk.
>
> ..
>
> Yeah.. what's this "hpa swap" ?  Possibly a vendor-specific op, perhaps?
>
> Cheers
>
Mark,

I don't know the details, but I have a DOS program called "setoff"
that is about 10 years old that I have tested on at least a couple
LBA-28 drives and it works.  I doubt it works on LBA-48, but who
knows.

More comments after the readme quote

>>  From the Readme
=========================================

SETOFF - This program will offset the numbering of sectors in the drive to a new
starting sector, the location of the new starting sector is the
starting sector of an existing HPA. Basically SETOFF will tell the
drive that has a HPA on it to make the HPA visible as the normal drive
area and place the normal drive area as a HPA. It switches the HPA and
normal drive area with each other.

Example of SETOFF use;

SETOFF - Shows help screen

SETOFF 0 0 1 - This will engage sector off set on the Master drive on
the Primary IDE port

For example, say you have a drive with 12,000,000 (6Gbytes) sectors.
You have a HPA that starts at sector 8,000,000. This would give you a
drive that has 4Gbytes of user space and a HPA of 2Gbytes. Your
computer would only see a 4Gbyte drive when it boots up. Remember the
HPA is not seen by the computer normally. You could then use SETOFF to
make the 2Gbyte HPA the user space and the 4 Gbyte user space would
become the HPA. Great way to hide stuff isn't it.
---
Ok that's it. Any questions call or email me.
I have a Power Point that covers all of this rather well for classes
and an exercise to use as well.

MarkMenz@usa.net  or (916) 983-0348

===========
Mark Menz used to make his software available under restricted
circumstances.  I don't remember what the restrictions are.  Possibly
he just charged for them.  Or they may have been Law Enforcement only.

If you want to talk to him and the above contact info is bad, I'm sure
we can find him for you.  I believe his more recent products
(hardware) are described at www.MyKeyTech.com

HTH
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
