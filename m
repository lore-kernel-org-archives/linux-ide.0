From: Christof Warlich <christof@warlich.name>
Subject: Re: "EXT3-fs error" after resume from s2ram
Date: Wed, 08 Jul 2009 08:41:41 +0200
Message-ID: <4A543FA5.1090608@warlich.name>
References: <4A4771FD.1020207@warlich.name> <4A480859.5010206@gmail.com> <4A48C799.2010102@warlich.name> <4A495C2D.1040706@gmail.com> <4A49A49C.10104@warlich.name> <4A4C42E2.6030305@gmail.com> <4A51C929.5010909@warlich.name> <4A52931D.5070109@gmail.com> <4A52F39A.1030704@warlich.name> <4A5311C7.1020507@warlich.name> <4A535973.9090206@gmail.com> <4A5388EA.7030503@warlich.name> <4A53DA88.5080703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58531 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754808AbZGHGlp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jul 2009 02:41:45 -0400
In-Reply-To: <4A53DA88.5080703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

Robert Hancock schrieb:
> On 07/07/2009 11:42 AM, Christof Warlich wrote:
>> Hmm - that doen't seem to fix it :-(:
>>
>> After the reboot, fdisk still reports 137.4GB, and dmesg now contains
>> the line:
>>
>> ata1.00: device aborted resize (268435456 -> 312581808), skipping HPA
>> handling
>>
>> instead of
>>
>> ata1.00: HPA detected: current 268435456, native 312581808
>>
>> that we have seen without the libata.ignore_hpa=1 kernel command line
>> option.
>>
>> After s2ram -f -p, I still see the EXT3-fs error on resume. Is it worth
>> to take another log from this suspend /resume cycle?
>
> Hmm, so we tried to disable the HPA and enable the entire disk 
> capacity, but the drive refused. But it somehow ends up in the HPA 
> disabled state upon resume. According to the ATA spec, the drive will 
> refuse SET MAX ADDRESS EXT commands after one has already been 
> executed upon power-on or reset. That suggests that the BIOS is 
> applying the HPA on bootup, but not on resume.
>
> Is there a BIOS update available for this machine?
Updating the BIOS was the first thing I did when I got the machine, 
maybe two month ago. And only after that update suspend to disk began to 
work at least.

What about doing it the other way round: Forcing the kernel to apply the 
HPA on resume? Whitout knowing if this is possible at all with 
reasonable effort, it would bring us in sync having the HPA enabled for 
both bootup and resume, right?
The only drawback would be that we stay having only the 128GiB available.

I'd assume that Windows XP may do it this way, as suspend to ram does 
work there and it also only sees the 128GiB.
