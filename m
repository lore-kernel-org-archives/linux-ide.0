From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: "EXT3-fs error" after resume from s2ram
Date: Tue, 07 Jul 2009 17:30:16 -0600
Message-ID: <4A53DA88.5080703@gmail.com>
References: <4A4771FD.1020207@warlich.name> <4A480859.5010206@gmail.com> <4A48C799.2010102@warlich.name> <4A495C2D.1040706@gmail.com> <4A49A49C.10104@warlich.name> <4A4C42E2.6030305@gmail.com> <4A51C929.5010909@warlich.name> <4A52931D.5070109@gmail.com> <4A52F39A.1030704@warlich.name> <4A5311C7.1020507@warlich.name> <4A535973.9090206@gmail.com> <4A5388EA.7030503@warlich.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:1140 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757424AbZGGX26 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Jul 2009 19:28:58 -0400
In-Reply-To: <4A5388EA.7030503@warlich.name>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christof Warlich <christof@warlich.name>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

On 07/07/2009 11:42 AM, Christof Warlich wrote:
> Robert Hancock schrieb:
>> On 07/07/2009 03:13 AM, Christof Warlich wrote:
>>> Christof Warlich schrieb:
>>>> Do you think I can fix the issue and circumvent the BIOS by passing
>>>> the real geomerty of the drive as kernel boot parameters? This may
>>>> also have the nice side effect that I could utilize the full capacity
>>>> of the drive. I'll definitly do some experiments in this direction and
>>>> let you know immediately if I succeed. Please let me know if this may
>>>> be a waste of time or if you know an appropriate fix.
>>> I retried with the boot parameter hda=16383,16,63 according to the
>>> values that I got from fdisk, but without success. Anyway, I would have
>>> expected that the kernel may have had a way to set the LBA48 geometry
>>> instead of CHS, but it looks like I'm on the wrong track here...
>>
>> That's an old IDE parameter, not a libata one, and 160GB is way too
>> large to be settable using CHS. What you likely want to do is pass the
>> ignore_hpa=1 option to libata when it's loaded - either
>> libata.ignore_hpa=1 on kernel command line, or in /etc/modprobe.conf
>> if it's a module (how exactly to do this depends on your
>> distribution). That way the protected area on the disk will get
>> disabled and you can use the full capacity.
> Hmm - that doen't seem to fix it :-(:
>
> After the reboot, fdisk still reports 137.4GB, and dmesg now contains
> the line:
>
> ata1.00: device aborted resize (268435456 -> 312581808), skipping HPA
> handling
>
> instead of
>
> ata1.00: HPA detected: current 268435456, native 312581808
>
> that we have seen without the libata.ignore_hpa=1 kernel command line
> option.
>
> After s2ram -f -p, I still see the EXT3-fs error on resume. Is it worth
> to take another log from this suspend /resume cycle?

Hmm, so we tried to disable the HPA and enable the entire disk capacity, 
but the drive refused. But it somehow ends up in the HPA disabled state 
upon resume. According to the ATA spec, the drive will refuse SET MAX 
ADDRESS EXT commands after one has already been executed upon power-on 
or reset. That suggests that the BIOS is applying the HPA on bootup, but 
not on resume.

Is there a BIOS update available for this machine?
