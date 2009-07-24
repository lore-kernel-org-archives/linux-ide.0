From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Drive tester
Date: Thu, 23 Jul 2009 23:34:39 -0600
Message-ID: <4A6947EF.1020103@gmail.com>
References: <9b0a5b990907162309j2ff4f872v47b18be74c7eeab9@mail.gmail.com>	 <23E65EE4544D484CBE73B588E192C6D612D3108FF0@sc-vexch3.marvell.com>	 <87f94c370907231431p470874bax1155b88895cd97d5@mail.gmail.com>	 <23E65EE4544D484CBE73B588E192C6D612D301CCCD@sc-vexch3.marvell.com> <87f94c370907231531r291ccadaude79a848a4a09286@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:42856 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZGXFc0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Jul 2009 01:32:26 -0400
Received: by an-out-0708.google.com with SMTP id d40so1796883and.1
        for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2009 22:32:26 -0700 (PDT)
In-Reply-To: <87f94c370907231531r291ccadaude79a848a4a09286@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Bill Weiler <weilerb@marvell.com>, Kernelnewbies <kernelnewbies@nl.linux.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 07/23/2009 04:31 PM, Greg Freemyer wrote:
> cc'ing: linux-ide@vger.kernel.org
>
> maybe they can help
>
> On Thu, Jul 23, 2009 at 6:12 PM, Bill Weiler<weilerb@marvell.com>  wrote:
>>
>> ________________________________________
>> From: Greg Freemyer [greg.freemyer@gmail.com]
>> Sent: Thursday, July 23, 2009 2:31 PM
>> To: Bill Weiler
>> Cc: Kernelnewbies
>> Subject: Re: Drive tester
>>
>> On Wed, Jul 22, 2009 at 7:55 PM, Bill Weiler<weilerb@marvell.com>  wrote:
>>> I wanted to make an Application that could send scripted SCSI and SATA
>>> commands to my drives. I have found my Fedora Linux to be too complex to
>>> control the drives in this way. I have looked at minimal Linux but I think
>>> this would have the same problem. Is there an easier Open Source OS, or an
>>> embedded PC Linux that would be easier to modify?
>> Bill,
>>
>> For sata drives, have you looked at the SG_IO interface?
>>
>> That is how hdparm interfaces with the kernel.  I know it sends a lot
>> of low level ATA commands to the drive from user space.  I think most
>> use the SG_IO interface.  How much simpler can it get?
>>
>> strace hdparm may give you an education as to how simple it is.

The best way to issue arbitrary ATA commands is likely to issue them as 
ATA pass-through SCSI commands using SG_IO, yes.

>>
>> fyi: I believe the kernel looks for dangerous ata commands and blocks
>> them.  But I think those are the types of commands that cause data
>> loss.  Not sure what the criteria is.

If you're running as unprivileged user I believe we block things like 
could do things like brick the drive such as uploading firmware, etc. 
However, if you have read-write access to the device node you can still 
read and write sectors anywhere on the disk. A few commands are blocked 
even for root users, like SET FEATURES - XFER MODE as it will screw up 
the mode configuration, but it's mostly fair game.

>>
>> I have studied hdparm and the SG_IO interface and delved into the scsi drivers and ata drivers.
>>
>> For example, I wanted to script a single NCQ and a single NCQ write. A normal read(fd,buf,4096) does 1 NCQ read but a write(fd,buf,4096) does dozens of NCQ reads before doing the 1 NCQ write. How do I get rid of these reads?

Try opening the device node with O_DIRECT. That will prevent pagecache 
effects from changing the IO pattern. However, you can't get less than 
page-size (4K granularity) on requests, for that you'll need to issue 
SCSI or ATA commands directly.

>>
>> Also, I need to do soft and hard resets and these are not exposed.

Indeed, there's no way currently to trigger these other than as part of 
error handling (i.e. command errors, hotplug operations, etc.) There's 
likely no reason it couldn't be added, but obviously nobody's needed it 
enough to bother so far..
