From: "Norman Diamond" <n0diamond@yahoo.co.jp>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Sun, 1 Mar 2009 09:58:06 +0900
Message-ID: <BB2D271BB5CF41EF91FCE9D3A0A1F2BB@DIAMOND8600>
References: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600> <26917692A9574F3A9363ED5253B42D2F@DIAMOND8600> <49A570DB.8090401@rtr.ca> <200902252035.05347.bzolnier@gmail.com> <DF79A3D50A1548A2A22EEFD769318266@DIAMOND8600> <49A5C9A5.20005@rtr.ca> <B2BE4BF16058416F88555755CB1823DF@DIAMOND8600> <49A8AC1A.1000900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp09.mail.tnz.yahoo.co.jp ([203.216.226.137]:25096 "HELO
	smtp09.mail.tnz.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755187AbZCABFD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Feb 2009 20:05:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Robert Hancock wrote:
> Norman Diamond wrote:
>> [attribution stolen:]
>>
>>> Libata should be used for any new setup that doesn't have a strict 
>>> legacy requirement now.
>>
>> 90% agreed.  However, I've read that libata will never support add-on IDE 
>> boards.
>
> Huh? It already does support most or all that one is likely to see..

That is good news then.

Last week when searching for articles about Slax and libata, I found various 
postings about methods that temporarily worked but no longer (for example 
there used to be a kernel boot parameter for the combined mode of some Intel 
chipsets, and there used to be a parameter to disable probing by 
ide_generic).  While not finding a way to get a particular chipset to be 
recognized as /dev/sda instead of /dev/hda, I also found other articles 
explaining various limitations of libata.  Some said that SATA is the 
priority for libata as it should be, but PATA was low priority with just 
enough effort to get it working with common legacy IDE controllers, and 
add-on IDE boards were zero priority.  My troubles last week were with 
notebook PCs that didn't have add-on IDE cards, but I will also have to 
support add-on IDE cards.

If anyone here knows how to put libata in control of chipsets that could be 
claimed by either libata or legacy ide, please say.  As mentioned I found 
various postings by others that temporarily worked but no longer.  It was 
kind of reassuring to see my program operate correctly under Slax 6.0.3 with 
my slight modification to Slax's config kernel 2.6.24.3 to enable 
taskfiles -- and then heartbreaking to see ordinary programs get 1.5 
megabytes per second to the hard drive. 

--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
