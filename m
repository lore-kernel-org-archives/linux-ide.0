From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: ICH4-M ACPI Error
Date: Wed, 16 Aug 2006 03:40:23 -0400
Message-ID: <44E2CBE7.6080906@PicturesInMotion.net>
References: <44E2B4A1.1030901@PicturesInMotion.net> <44E2B776.7080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta8.srv.hcvlny.cv.net ([167.206.4.203]:42297 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750981AbWHPHkR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Aug 2006 03:40:17 -0400
Received: from [192.168.1.102] (ool-4351c743.dyn.optonline.net [67.81.199.67])
 by mta8.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTP id <0J42004P3YLA7E11@mta8.srv.hcvlny.cv.net> for
 linux-ide@vger.kernel.org; Wed, 16 Aug 2006 03:39:10 -0400 (EDT)
In-reply-to: <44E2B776.7080109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org



Tejun Heo wrote:
> Lee Trager wrote:
>> Hey I've been having this problem for awhile on my laptop(IBM Thinkpad
>> T40) and have no been able to figure out how to fix it. It seems that
>> when ever I resume my laptop from suspend(from hard drive or RAM) my
>> dmesg is filled with this and I am unable to do anything that requires
>> access to the hard drive.
>>
>> ide: failed opcode was: unknown
>> hda: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
>> hda: task_out_intr: error=0x10 { SectorIdNotFound }, LBAsect=74853287,
>> sector=74853287
>>
>> I checked the drive with the IBM hardware analysis tools as well as the
>> Hitachi Drive Fitness extended test and both say the drive is fine. What
>> is strange is that according to hdparm my drive only has 72037362
>> sectors while this error is on sector 74853287.
>>
>> This error happens with and without wireless, DMA, and alsa. The kernel
>> option in ATA/ATAPI/MFM/RLL support named IDEDISK_MULTI_MODE does not
>> fix the error. I have also tested this with the mainline kernel, supend2
>> sources, gentoo sources, and the Knoppix boot disc and this error
>> happens on all of them. I talked to one of the suspend2 developers and
>> he said that the problem is with my IDE driver not properly waking the
>> drive up. Could someone please help me?
>>
>> Here is some system information
>>
>> Distribution: Gentoo 2006.0
>> Laptop: IBM Thinkpad T40
>> IDE Controller: Intel Corporation 82801DBM (ICH4-M) IDE Controller
>> (rev 01)
>> Harddrive: Hitachi IC25N040ATCS05-0
>> Software Environment:
>> GLIBC: 2.4
>> GCC: 4.1.1
>> Kernel: Gentoo-sources-2.6.17-r5(although I tried with a number of other
>> sources as stated above)
>
> Can you try 2.6.18-rc4?
>
Nope, same thing in 2.6.18-rc4.
