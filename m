From: Ansgar Knappheide <ansgar.knappheide@gmx.de>
Subject: Re: 2.6.24-rc2 displays incorrect DVD description
Date: Fri, 23 Nov 2007 11:17:34 +0100
Message-ID: <4746A8BE.8030703@gmx.de>
References: <1354.72.205.227.110.1194986901.squirrel@www.tuxsoft.com> <20071123003557.36a126bd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753425AbXKWKRl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 05:17:41 -0500
In-Reply-To: <20071123003557.36a126bd.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: steve@tuxsoft.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Andrew Morton schrieb:
> (cc linux-ide)
>
> On Tue, 13 Nov 2007 15:48:21 -0500 (EST) steve@tuxsoft.com wrote:
>
>   
>> For example, 2.6.23.1:
>>
>> Linux version 2.6.23.1 (root@jupiter) (gcc version 4.2.2) #1 SMP PREEMPT
>> Fri Oct 26 13:09:09 CDT 2007
>> kernel: hdd: HP DVD Writer 1040d, ATAPI CD/DVD-ROM drive
>> kernel: hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache,
>> UDMA(66)
>>
>> and
>>
>> 2.6.24-rc2:
>>
>> Linux version 2.6.24-rc2 (ironman@jupiter) (gcc version 4.2.2) #1 SMP
>> PREEMPT Fri Nov 9 20:41:37 CST 2007
>> kernel: hdd: HP DVD Writer 1040d, ATAPI CD/DVD-ROM drive
>> kernel: hdd: ATAPI 126X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache,
>> UDMA(66)
>>
>> The drive seems to work correctly, reading and writing just fine.  I just
>> happened to notice this and thought I'd pass it along.
>>
>> One other odd thing while looking through the logs, 2.6.23.1 has also
>> reported the drive as follows:
>>
>> Linux version 2.6.23.1 (root@jupiter) (gcc version 4.2.2) #1 SMP PREEMPT
>> Fri Oct 26 13:09:09 CDT 2007
>> kernel: hdd: HP DVD Writer 1040d, ATAPI CD/DVD-ROM drive
>> kernel: hdd: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache,
>> UDMA(66)
>>
>> Any idea what is going on here?  It's being reported as 48X, 126X, and 32X.
>>
>>     
>
>   
If it's only the speed value in the description, perhaps you had 
different medias (no medium, CD-ROM, DVD-VIDEO, CD-R, CD-RW, ...) on 
this bootups in your drive, I have seen this changed speed value 
depending on insert medium in the past on some Liteon or Samsung drive.

MBR
Ansgar Knappheide
