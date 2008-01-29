From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 11:36:42 -0500
Message-ID: <200801291136.42612.gene.heskett@gmail.com>
References: <200801272122.21823.gene.heskett@gmail.com>
 <200801291004.12565.gene.heskett@gmail.com> <479F507A.1030203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:43714 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbYA2Qgo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 11:36:44 -0500
In-reply-to: <479F507A.1030203@rtr.ca>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Florian Attenberger <valdyn@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Tuesday 29 January 2008, Mark Lord wrote:
>Gene Heskett wrote:
>>..
>> Does anyone know why my dvdwriter isn't being assigned a '/dev/sdx' number
>> when dmesg says its found ok at ata2.00?  I've turned on an option that
>> says something about using the bios for device access this build, but I'll
>> be surprised if that's it. :)
>
>..
>
>It should show up as /dev/scd0 or something very similar.

Tisn't.  Darnit.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
clock speed
