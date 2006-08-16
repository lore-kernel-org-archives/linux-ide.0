From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: ICH4-M ACPI Error
Date: Wed, 16 Aug 2006 04:13:01 -0400
Message-ID: <44E2D38D.1060200@PicturesInMotion.net>
References: <44E2B4A1.1030901@PicturesInMotion.net>
 <44E2B776.7080109@gmail.com> <44E2C82A.3040802@PicturesInMotion.net>
 <44E2CB82.8050100@gmail.com> <44E2CBD5.9000307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta8.srv.hcvlny.cv.net ([167.206.4.203]:20798 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750760AbWHPIMz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Aug 2006 04:12:55 -0400
Received: from [192.168.1.102] (ool-4351c743.dyn.optonline.net [67.81.199.67])
 by mta8.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTP id <0J43004H803O7E21@mta8.srv.hcvlny.cv.net> for
 linux-ide@vger.kernel.org; Wed, 16 Aug 2006 04:11:48 -0400 (EDT)
In-reply-to: <44E2CBD5.9000307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



Tejun Heo wrote:
> [resending as reply to add linux-ide back, please don't drop cc list]
>
> Tejun Heo wrote:
>> Lee Trager wrote:
>>> Tejun Heo wrote:
>>>> Lee Trager wrote:
>>>>> Hey I've been having this problem for awhile on my laptop(IBM
>>>>> Thinkpad
>>>>> T40) and have no been able to figure out how to fix it. It seems that
>>>>> when ever I resume my laptop from suspend(from hard drive or RAM) my
>>>>> dmesg is filled with this and I am unable to do anything that
>>>>> requires
>>>>> access to the hard drive.
>>>>>
>>>>> ide: failed opcode was: unknown
>>>>> hda: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
>>>>> hda: task_out_intr: error=0x10 { SectorIdNotFound },
>>>>> LBAsect=74853287,
>>>>> sector=74853287
>>
>> Ah... it was the IDE driver, sorry.  You can try using Alan Cox's
>> libata pata drivers patch which is included in recent -mm trees. 
>> With the patch, libata ata_piix driver can drive the controller
>> instead of ide and it has better error handling.
>>
>> Be warned that the drive will come up as /dev/sda instead of /dev/hda
>> and it currently doesn't disable host protected area unlike IDE, so
>> your disk can be messed up.
Isn't libata for SATA drivers? My drive is an IDE. Also I'm worried
about using something that could mess up my drive when this is going to
be used for school next month and I need something that can sleep as
well as reliable.
