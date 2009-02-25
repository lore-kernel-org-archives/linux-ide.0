From: "Norman Diamond" <n0diamond@yahoo.co.jp>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Thu, 26 Feb 2009 06:18:48 +0900
Message-ID: <DF79A3D50A1548A2A22EEFD769318266@DIAMOND8600>
References: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600> <26917692A9574F3A9363ED5253B42D2F@DIAMOND8600> <49A570DB.8090401@rtr.ca> <200902252035.05347.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp03.mail.tnz.yahoo.co.jp ([203.216.246.66]:39779 "HELO
	smtp03.mail.tnz.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755676AbZBYVTI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 16:19:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 25 February 2009, Mark Lord wrote:
>> Norman Diamond wrote:
>> ..
>>> Does anyone know when this bug was added?  2.6.19 is too old for my
>>> needs, but the range 2.6.24 to 2.6.26 might be OK if they had taskfiles
>>> working.
>>> Maybe I should look for a Slax version that had a kernel from 2.6.24 or
>>> so, since I can probably customize it in a single day by now.  But if
>>> the bug was already present in 2.6.24 then it would be a waste of time.
>>
>> Heh.. the question could be more like, does anyone know which few kernels
>> that HDIO_DRIVE_TASKFILE ever worked completely on?  :)

I don't need an answer to that ^~^  2.6.19 had it working well enough for my
program, but didn't have drivers for some chipsets.

>> I know I have to patch drivers/ide rather heavily to get a working,
>> reliable HDIO_DRIVE_TASKFILE on it.
>>
>> Much better is to move to libata, and use ATA_16 with SG_IO, for a
>> standard, working way of doing this kind of stuff.
>
> While SG_IO is definitely better way to go submitting your
> HDIO_DRIVE_TASKFILE patches wouldn't hurt...

Especially since my SG_IO code already works[*] with SATA controllers, I
sure would like to use it with ATA, but I couldn't find a way to persuade
Slax to use libata for ATA controllers.  Does anyone have suggestions?

Meanwhile I also can't help wondering, if Mark Lord has patched drivers/ide
to make it work, why has he delayed submitting the patches?

With my immense expertise, I only needed a few hours to find where the limit
of 65536 bytes is explained in documentation so that users will know not to
use HDIO_DRIVE_TASKFILE with some nonsense buffer size like 131072.
I forgot which document where a pair of if statements document that fact, 
but the filename ended in .c.  Of course this does beat Windows where we 
don't get to see that kind of documentation at all.  Anyway, I wouldn't dare 
patch that stuff unless I'd been working on it for say at least a week ^~^

[* Wait a minute.  My SG_IO code already worked in which kernel version, and
now I have to test if it still works now.  Arrrrrgggggghhhhhh.]

--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
