From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: Drives missing at boot
Date: Sat, 3 Jul 2010 16:15:53 -0400
Message-ID: <201007031615.53693.gene.heskett@gmail.com>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com> <AANLkTimVJEO-yF3GZ2ghX6DNPuAu-A-MNNO9x8Q1EpRc@mail.gmail.com> <4C2F9292.708@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36918 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab0GCUP5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jul 2010 16:15:57 -0400
Received: by gwj21 with SMTP id 21so313965gwj.19
        for <linux-ide@vger.kernel.org>; Sat, 03 Jul 2010 13:15:56 -0700 (PDT)
In-Reply-To: <4C2F9292.708@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Saturday 03 July 2010, Stan Hoeppner wrote:
>Mark Knecht put forth on 7/3/2010 2:21 PM:
>> Note two things:
>>
>> 1) All the drives are always reported by BIOS at boot time. Now, that
>> doesn't guarantee that the drives spin up. It may only mean they can
>> be read by BIOS, but they are there as far as I can tell. They show up
>> in the boot screens and in BIOS itself if I drop in to play with
>> settings.
>
>I missed that.  I thought I read it was both.  My bad.
>
>> QUESTION: There are some settings in BIOS for delaying the drive. (Or
>> something. I'm using the machine and not in BIOS) There were settings
>> from 0 to 35 seconds if I remember correctly. Possibly I should try
>> setting each drive to a different value to different value to stagger
>> power up?
>
>If that PSU meets published specs you shouldn't need delayed spin up with
>those 5 drives.
>
>> If you need more info or have other ideas please let me know.
>
>Your answers here should have pretty much eliminated hardware issues as
> the cause, unless that particular mobo has BIOS or other issues I'm
> unaware of.
>
I would not trust the PSU just because it has a 'name' brand on it.  One of 
them in particular, and a popular one too, seems designed to work for not 
more than 20 minutes more than the warranty period, and in 2 instances here 
at the old farts home, has sagged to less than 4.8 volts on the 5 volt line 
well short of the usually 1 year warranty.  I have a no-name el cheapo psu 
here, 350 watt rated, with a 90 day warranty, that has been reliably 
starting 4 HD's in this box for almost 3 years now.  Put a digital meter on 
both the 12 volt and 5 volt lines, and verify that the first reading you get 
from turning it on is at least 11.75 volts for the 12 volt line, and not 
less than 4.95 volts on the 5 volt line, as measured at the 4 pin drive 
power connector.  Anything less is grounds to at least try a fresher supply.

>I've found it's always best to ask about hardware with this kind of report
>just to eliminate possibilities.  All that gear is good quality stuff.  If
> the problem is due to hardware, it's because one of your components is
> defective, but we don't see evidence of that at this point.
>
>Also, TTBOMK, if a SATA drive motor doesn't spin up, the drive firmware
> won't report the drive as ready upstream, thus the BIOS won't list the
> drive.

And quite likely that any spinup delays are probably not considered by the 
bios anyway.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yes, it is written.  Good shall always destroy evil.
		-- Sirah the Yang, "The Omega Glory", stardate unknown
