From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 12:53:18 -0500
Message-ID: <200801291253.18586.gene.heskett@gmail.com>
References: <200801272122.21823.gene.heskett@gmail.com>
 <200801291212.03910.gene.heskett@gmail.com> <479F6314.6090906@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:55839 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbYA2SrQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 13:47:16 -0500
In-reply-to: <479F6314.6090906@garzik.org>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Florian Attenberger <valdyn@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Tuesday 29 January 2008, Jeff Garzik wrote:
>Gene Heskett wrote:
>> On Tuesday 29 January 2008, Jeff Garzik wrote:
>>> Gene Heskett wrote:
>>>> Does anyone know why my dvdwriter isn't being assigned a '/dev/sdx'
>>>> number when dmesg says its found ok at ata2.00?  I've turned on an
>>>> option that says something about using the bios for device access this
>>>> build, but I'll be surprised if that's it. :)
>>>
>>> I think you mean /dev/scdx not /dev/sdx.  Make sure you have the 'sr'
>>> driver compiled and load (CONFIG_BLK_DEV_SR).
>>
>> That menu item COULD be moved, I don't have any REAL scsi stuff, so I
>> didn't look there.  My bad, with help from hiding it like that. :-)
>>
>>> The bios-for-dev-access thing definitely won't help, and may hurt (by
>>> taking over the device you wanted to test).
>>
>> Ok, if BLK_DEV_SR fails, I'll take that back out.  I'm heating the room
>> making kernels here. :)
>
>I can say with 100% certainty that 'sr' is required in order to use your
>dvd writer with libata.  :)
>
>	Jeff

And as usual, you are 100% correct, thanks.

And now back to our regularly scheduled testing for 'exception Emask' 
errors. :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Main's Law:
	For every action there is an equal and opposite government program.
