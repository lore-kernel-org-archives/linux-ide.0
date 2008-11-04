From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: hdparm-9.2 now available: w/ DCO and firmware support
Date: Tue, 4 Nov 2008 16:55:25 -0500
Message-ID: <87f94c370811041355n43ed46f3p13749ac0ec8f9c99@mail.gmail.com>
References: <490F4030.5030709@rtr.ca>
	 <87f94c370811041001ucd76d27lc948c553ad2a381e@mail.gmail.com>
	 <49108F96.8010902@rtr.ca>
	 <87f94c370811041023s3de41ec9o66614bf3f0fdb63c@mail.gmail.com>
	 <49109EDE.1020803@rtr.ca>
	 <87f94c370811041304r1ad54bd9tee4c2b7de4cb873f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:31725 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbYKDVz1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 16:55:27 -0500
Received: by an-out-0708.google.com with SMTP id d40so367165and.1
        for <linux-ide@vger.kernel.org>; Tue, 04 Nov 2008 13:55:25 -0800 (PST)
In-Reply-To: <87f94c370811041304r1ad54bd9tee4c2b7de4cb873f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Nov 4, 2008 at 4:04 PM, Greg Freemyer <greg.freemyer@gmail.com> wrote:
> On Tue, Nov 4, 2008 at 2:13 PM, Mark Lord <liml@rtr.ca> wrote:
>> Greg Freemyer wrote:
>>>
>>> On Tue, Nov 4, 2008 at 1:08 PM, Mark Lord <liml@rtr.ca> wrote:
>>
>> ..
>>>>
>>>> Mmm.. never thought about that much before now,
>>>> but DCO is a nifty way to hide much of a drive from prying eyes.
>>>> Eg. Use DCO to restrict the drive to LBA28 accessible sectors
>>>> and also turn off LBA48 support, and then a lot of space becomes
>>>> "hidden".
>>>> Until now!
>>>
>>> Yeah, combine that with some HPA shenanigans and you can create two
>>> complete disk partition layouts on one drive.
>>>
>>> ie. Two partition tables, the normal partition table for the first 128
>>> GiB is in sector 1.  The partition table for the rest of the disk is
>>> at sector 128 GiB + 1.  Then use DCO to totally hide the upper section
>>> of the drive.
>>>
>>> When you want access, use DCO commands to expose it, and then HPA
>>> commands to make only the sectors beyond 128 GiB accessible.
>>
>> ..
>>
>> Now that one has me stumped.  The only HPA commands I know of,
>> permit setting only the maximum-LBA, not the minimum.
>> Or is this a newish ATA9 (or last-minute ATA8) sort of thing ?
>> ..
>>>
>>> to the end of the disk, then issue a "hpa swap" command.  That will
>>> hide the first 128 GiB and expose the rest of the disk.
>>
>> ..
>>
>> Yeah.. what's this "hpa swap" ?  Possibly a vendor-specific op, perhaps?
>>
>> Cheers
>>
> Mark,
>
> I don't know the details,

<snip>

I got curious.  It is in a 7 or 8 year old spec.

T13
1407DT

>From Draft 5:  (http://www.t13.org/Documents/UploadedDocuments/project/d1407r5-Address-Offset.doc)

3.	Address Offset Mode operation

3.1	Enable/Disable Address Offset Mode

In devices that support the Address Offset feature, the SET FEATURES
subcommand 09h Enable Address Offset Mode, offsets address Cylinder 0,
Head 0, Sector 1, LBA 0, to the start of the non-volatile protected
area established using the SET MAX ADDRESS Command.

The Address Offset condition is cleared by the SET FEATURES subcommand
89h Disable Address Offset Mode,  a hardware reset or a power-on
reset.

If Reverting to Power on Defaults has been enabled by a SET FEATURES
command, it is cleared by software reset as well.

Upon entering the Address Offset mode the capacity of the drive
returned in the Identify device data is the size of the former
protected area. A subsequent SET MAX ADDRESS command using the address
returned by the  READ NATIVE MAX ADDRESS command allows access to the
entire drive. Addresses wrap so the entire drive remains addressable
(see figure 1).

If a non-volatile reserved area has not been established before the
device receives a SET FEATURES Enable Address Offset Mode command, the
command fails with Abort error status.

The Disable Address Offset Mode removes the address offset and sets
the size of the drive reported by the IDENTIFY DEVICE command back to
the size specified in the last non-volatile SET MAX ADDRESS command.

3.2	IDENTIFY DEVICE

IDENTIFY DEVICE word 83 bit 07, if set to one, indicates the device
supports the Address Offset Mode. IDENTIFY DEVICE word 86 bit 07, if
set to one, indicates the device is in Address Offset Mode.

3.3	SET MAX ADDRESS

Issuing the SET MAX ADDRESS command with bit 0 in the Sector Count
register set to one is not valid when the device is in Address Offset
Mode.

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
