From: rgheck <rgheck@bobjweil.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 11:50:17 -0500
Message-ID: <479F5949.4090906@bobjweil.com>
References: <200801272122.21823.gene.heskett@gmail.com> <200801281413.21347.gene.heskett@gmail.com> <20080129074127.5699afcf.valdyn@gmail.com> <200801291004.12565.gene.heskett@gmail.com> <479F507A.1030203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:59478
	"EHLO QMTA07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759633AbYA2QuU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 11:50:20 -0500
In-Reply-To: <479F507A.1030203@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Gene Heskett <gene.heskett@gmail.com>, Florian Attenberger <valdyn@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Gene Heskett wrote:
>> ..
>> Does anyone know why my dvdwriter isn't being assigned a '/dev/sdx' 
>> number when dmesg says its found ok at ata2.00?  I've turned on an 
>> option that says something about using the bios for device access 
>> this build, but I'll be surprised if that's it. :)
> ..
>
> It should show up as /dev/scd0 or something very similar.
>
Does it appear as /dev/sr0? Try ll /dev/s* and see what you get.

Anyway, these /dev/ entries are produced by udev, not by libata.

rh

